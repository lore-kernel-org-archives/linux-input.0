From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 1/1][INCREMENTAL] Input: cyttsp - Fixes to clean-up patch
Date: Sun, 29 Jan 2012 06:53:50 +0100
Message-ID: <1327816430-19887-1-git-send-email-javier@dowhile0.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51879 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab2A2Fxu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 00:53:50 -0500
Received: by wgbed3 with SMTP id ed3so3417671wgb.1
        for <linux-input@vger.kernel.org>; Sat, 28 Jan 2012 21:53:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>

This is patch fixes two bugs in Dmitry's last cleanup patch.

1- The hardware tracking ids are stored in the ids array and the information for
   each contact is obtained calling cyttsp_get_tch() with an index. In the clean-up
   patch the value of the tracking id was used instead of the contact index.

2- i2c_set_clientdata() is called after the generic cyttsp_probe() function and
   this function calls cyttsp_power_on() that sends an ttsp command to the device
   and needs the client data before is set. The fix is to execute cyttsp_power_on
   inside the transport specific probe function (I2C, SPI) after the generic probe
   function is executed and the client data is set.

This patch is an incremental one to be applied on top of:

Javier Martinez Canillas (3):
      Input: cyttsp - Cypress TTSP capacitive multi-touch screen support
      Input: cyttsp - add support for Cypress TTSP touchscreen I2C bus interface
      Input: cyttsp - add support for Cypress TTSP touchscreen SPI bus interface

Dmitry Torokhov (1):
      Input: cyttsp - random edits

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 drivers/input/touchscreen/cyttsp_core.c |   25 +++++++++----------------
 drivers/input/touchscreen/cyttsp_core.h |    1 +
 drivers/input/touchscreen/cyttsp_i2c.c  |    5 ++++-
 drivers/input/touchscreen/cyttsp_spi.c  |    4 +++-
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index ff74a33..cee8c05 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -305,7 +305,7 @@ static void cyttsp_report_tchdata(struct cyttsp *ts)
 	bitmap_zero(used, CY_MAX_ID);
 
 	for (i = 0; i < num_tch; i++) {
-		tch = cyttsp_get_tch(xy_data, ids[i]);
+		tch = cyttsp_get_tch(xy_data, i);
 
 		input_mt_slot(input, ids[i]);
 		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
@@ -374,7 +374,7 @@ out:
 	return IRQ_HANDLED;
 }
 
-static int cyttsp_power_on(struct cyttsp *ts)
+int cyttsp_power_on(struct cyttsp *ts)
 {
 	int error;
 
@@ -419,21 +419,18 @@ static int cyttsp_power_on(struct cyttsp *ts)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cyttsp_power_on);
 
 static int cyttsp_enable(struct cyttsp *ts)
 {
 	int error;
 
-	// FIXME: Why do we need wakeup? The system is already woken up
-	// so I assume this is device wakeup. It should be generic, just
-	// like suspend is generic.
-	// Is there CY_FULL_POWER_MODE that is opposite to CY_LOW_POWER_MODE?
-	if (ts->pdata->wakeup) {
-		error = ts->pdata->wakeup();
-		if (error)
-			return error;
-	}
-
+	/*
+	 * The device firmware can wake on an I2C or SPI memory slave address
+	 * match. So just reading a register is sufficient to wake up the device
+	 * The first read attempt will fail but it will wake it up making the
+	 * second read attempt successful.
+	 */
 	error = ttsp_read_block_data(ts, CY_REG_BASE,
 				     sizeof(ts->xy_data), &ts->xy_data);
 	if (error)
@@ -586,10 +583,6 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 		goto err_platform_exit;
 	}
 
-	error = cyttsp_power_on(ts);
-	if (error)
-		goto err_free_irq;
-
 	disable_irq(ts->irq);
 
 	error = input_register_device(input_dev);
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index b16582e..ad7aaf0 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -141,6 +141,7 @@ struct cyttsp {
 struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 			    struct device *dev, int irq, size_t xfer_buf_size);
 void cyttsp_remove(struct cyttsp *ts);
+int cyttsp_power_on(struct cyttsp *ts);
 
 extern const struct dev_pm_ops cyttsp_pm_ops;
 
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 6394c8e..6e39b8b 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -86,6 +86,7 @@ static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
 	struct cyttsp *ts;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(&client->dev, "I2C functionality not Supported\n");
@@ -100,7 +101,9 @@ static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ts);
 
-	return 0;
+	ret = cyttsp_power_on(ts);
+
+	return ret;
 }
 
 static int __devexit cyttsp_i2c_remove(struct i2c_client *client)
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index d404cd2..bc26300 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -169,7 +169,9 @@ static int __devinit cyttsp_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, ts);
 
-	return 0;
+	error = cyttsp_power_on(ts);
+
+	return error;
 }
 
 static int __devexit cyttsp_spi_remove(struct spi_device *spi)
-- 
1.7.7.5

