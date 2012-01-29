From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH v2 1/1][INCREMENTAL] Input: cyttsp - Fixes to clean-up patch
Date: Sun, 29 Jan 2012 16:21:27 +0100
Message-ID: <1327850487-16324-1-git-send-email-javier@dowhile0.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33240 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab2A2PV1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 10:21:27 -0500
Received: by wics10 with SMTP id s10so2745296wic.19
        for <linux-input@vger.kernel.org>; Sun, 29 Jan 2012 07:21:26 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>

This is patch fixes three bugs in Dmitry's last cleanup patch.

1- The hardware tracking ids are stored in the ids array and the information for
   each contact is obtained calling cyttsp_get_tch() with an index. In the clean-up
   patch the value of the tracking id was used instead of the contact index.

2- The generic cyttsp_probe() function now calls cyttsp_power_on() that has to send
   a ttsp command, so the access:

   struct device *dev ->  struct i2c_client *client ->  struct cyttsp *ts

   was made. Unfortunately i2c_set_clientdata() establish the i2c_client->cyttsp
   link after cyttsp_probe() returns causing a NULL pointer deference.
   This patch solves the issue by changing the read/write bus functions to receive
   a struct cyttsp pointer directly as an argument instead an struct device pointer
   as suggested by Dmitry Torokhov.

3- Since soft_reset() is called inside the probe function, enable_irq() should not be
   called since it wasn't disable before. Same applies to disable_irq() in the probe
   function since the irq is disabled inside soft_rest(). This fixes the warning about
   Unbalanced enable IRQ.

Also this patch removes the wakeup() platform function call since the device is
automatically waked up on the first access to an I2C or SPI bus memory address register.
The first calls fails but it wakes the device and only the second one succeeds. But
that is not an issue since the read function has a retry logic.
Anyway this hardware behavior is documented in the code to make it clear.

Javier Martinez Canillas (3):
      Input: cyttsp - Cypress TTSP capacitive multi-touch screen support
      Input: cyttsp - add support for Cypress TTSP touchscreen I2C bus interface
      Input: cyttsp - add support for Cypress TTSP touchscreen SPI bus interface

Dmitry Torokhov (1):
      Input: cyttsp - random edits

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 drivers/input/touchscreen/cyttsp_core.c |   26 +++++++++-----------------
 drivers/input/touchscreen/cyttsp_core.h |    6 ++++--
 drivers/input/touchscreen/cyttsp_i2c.c  |    9 ++++-----
 drivers/input/touchscreen/cyttsp_spi.c  |   28 ++++++++++++++--------------
 include/linux/input/cyttsp.h            |    1 -
 5 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index ff74a33..3ff9c2f 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -84,7 +84,7 @@ static int ttsp_read_block_data(struct cyttsp *ts, u8 command,
 	int tries;
 
 	for (tries = 0; tries < CY_NUM_RETRY; tries++) {
-		error = ts->bus_ops->read(ts->dev, command, length, buf);
+		error = ts->bus_ops->read(ts, command, length, buf);
 		if (!error)
 			return 0;
 
@@ -101,7 +101,7 @@ static int ttsp_write_block_data(struct cyttsp *ts, u8 command,
 	int tries;
 
 	for (tries = 0; tries < CY_NUM_RETRY; tries++) {
-		error = ts->bus_ops->write(ts->dev, command, length, buf);
+		error = ts->bus_ops->write(ts, command, length, buf);
 		if (!error)
 			return 0;
 
@@ -226,8 +226,6 @@ static int cyttsp_soft_reset(struct cyttsp *ts)
 	INIT_COMPLETION(ts->bl_ready);
 	ts->state = CY_BL_STATE;
 
-	enable_irq(ts->irq);
-
 	retval = ttsp_send_command(ts, CY_SOFT_RESET_MODE);
 	if (retval)
 		goto out;
@@ -305,7 +303,7 @@ static void cyttsp_report_tchdata(struct cyttsp *ts)
 	bitmap_zero(used, CY_MAX_ID);
 
 	for (i = 0; i < num_tch; i++) {
-		tch = cyttsp_get_tch(xy_data, ids[i]);
+		tch = cyttsp_get_tch(xy_data, i);
 
 		input_mt_slot(input, ids[i]);
 		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
@@ -424,16 +422,12 @@ static int cyttsp_enable(struct cyttsp *ts)
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
+       /*
+        * The device firmware can wake on an I2C or SPI memory slave address
+        * match. So just reading a register is sufficient to wake up the device
+        * The first read attempt will fail but it will wake it up making the
+        * second read attempt successful.
+        */
 	error = ttsp_read_block_data(ts, CY_REG_BASE,
 				     sizeof(ts->xy_data), &ts->xy_data);
 	if (error)
@@ -590,8 +584,6 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 	if (error)
 		goto err_free_irq;
 
-	disable_irq(ts->irq);
-
 	error = input_register_device(input_dev);
 	if (error) {
 		dev_err(ts->dev, "failed to register input device: %d\n",
diff --git a/drivers/input/touchscreen/cyttsp_core.h b/drivers/input/touchscreen/cyttsp_core.h
index b16582e..888fd1e 100644
--- a/drivers/input/touchscreen/cyttsp_core.h
+++ b/drivers/input/touchscreen/cyttsp_core.h
@@ -108,11 +108,13 @@ struct cyttsp_bootloader_data {
 	u8 cid_2;
 };
 
+struct cyttsp;
+
 struct cyttsp_bus_ops {
 	u16 bustype;
-	int (*write)(struct device *dev,
+	int (*write)(struct cyttsp *ts,
 		     u8 addr, u8 length, const void *values);
-	int (*read)(struct device *dev, u8 addr, u8 length, void *values);
+	int (*read)(struct cyttsp *ts, u8 addr, u8 length, void *values);
 };
 
 enum cyttsp_state {
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
index 6394c8e..c7110cc 100644
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -34,10 +34,10 @@
 
 #define CY_I2C_DATA_SIZE	128
 
-static int cyttsp_i2c_read_block_data(struct device *dev,
+static int cyttsp_i2c_read_block_data(struct cyttsp *ts,
 				      u8 addr, u8 length, void *values)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = to_i2c_client(ts->dev);
 	struct i2c_msg msgs[] = {
 		{
 			.addr = client->addr,
@@ -61,11 +61,10 @@ static int cyttsp_i2c_read_block_data(struct device *dev,
 	return retval != ARRAY_SIZE(msgs) ? -EIO : 0;
 }
 
-static int cyttsp_i2c_write_block_data(struct device *dev,
+static int cyttsp_i2c_write_block_data(struct cyttsp *ts,
 				       u8 addr, u8 length, const void *values)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct cyttsp *ts = i2c_get_clientdata(client);
+	struct i2c_client *client = to_i2c_client(ts->dev);
 	int retval;
 
 	ts->xfer_buf[0] = addr;
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index d404cd2..9db5f87 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -43,11 +43,10 @@
 #define CY_SPI_DATA_BUF_SIZE	(CY_SPI_CMD_BYTES + CY_SPI_DATA_SIZE)
 #define CY_SPI_BITS_PER_WORD	8
 
-static int cyttsp_spi_xfer(u8 op, struct device *dev,
-			   u8 reg, u8 *buf, int length)
+static int cyttsp_spi_xfer(struct cyttsp *ts,
+			   u8 op, u8 reg, u8 *buf, int length)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct cyttsp *ts = spi_get_drvdata(spi);
+	struct spi_device *spi = to_spi_device(ts->dev);
 	struct spi_message msg;
 	struct spi_transfer xfer[2];
 	u8 *wr_buf = &ts->xfer_buf[0];
@@ -56,7 +55,8 @@ static int cyttsp_spi_xfer(u8 op, struct device *dev,
 	int i;
 
 	if (length > CY_SPI_DATA_SIZE) {
-		dev_err(dev, "%s: length %d is too big.\n", __func__, length);
+		dev_err(ts->dev, "%s: length %d is too big.\n",
+			__func__, length);
 		return -EINVAL;
 	}
 
@@ -95,13 +95,13 @@ static int cyttsp_spi_xfer(u8 op, struct device *dev,
 		break;
 
 	default:
-		dev_err(dev, "%s: bad operation code=%d\n", __func__, op);
+		dev_err(ts->dev, "%s: bad operation code=%d\n", __func__, op);
 		return -EINVAL;
 	}
 
 	retval = spi_sync(spi, &msg);
 	if (retval < 0) {
-		dev_dbg(dev, "%s: spi_sync() error %d, len=%d, op=%d\n",
+		dev_dbg(ts->dev, "%s: spi_sync() error %d, len=%d, op=%d\n",
 			__func__, retval, xfer[1].len, op);
 
 		/*
@@ -114,13 +114,13 @@ static int cyttsp_spi_xfer(u8 op, struct device *dev,
 	if (rd_buf[CY_SPI_SYNC_BYTE] != CY_SPI_SYNC_ACK1 ||
 	    rd_buf[CY_SPI_SYNC_BYTE + 1] != CY_SPI_SYNC_ACK2) {
 
-		dev_dbg(dev, "%s: operation %d failed\n", __func__, op);
+		dev_dbg(ts->dev, "%s: operation %d failed\n", __func__, op);
 
 		for (i = 0; i < CY_SPI_CMD_BYTES; i++)
-			dev_dbg(dev, "%s: test rd_buf[%d]:0x%02x\n",
+			dev_dbg(ts->dev, "%s: test rd_buf[%d]:0x%02x\n",
 				__func__, i, rd_buf[i]);
 		for (i = 0; i < length; i++)
-			dev_dbg(dev, "%s: test buf[%d]:0x%02x\n",
+			dev_dbg(ts->dev, "%s: test buf[%d]:0x%02x\n",
 				__func__, i, buf[i]);
 
 		return -EIO;
@@ -129,16 +129,16 @@ static int cyttsp_spi_xfer(u8 op, struct device *dev,
 	return 0;
 }
 
-static int cyttsp_spi_read_block_data(struct device *dev,
+static int cyttsp_spi_read_block_data(struct cyttsp *ts,
 				      u8 addr, u8 length, void *data)
 {
-	return cyttsp_spi_xfer(CY_SPI_RD_OP, dev, addr, data, length);
+	return cyttsp_spi_xfer(ts, CY_SPI_RD_OP, addr, data, length);
 }
 
-static int cyttsp_spi_write_block_data(struct device *dev,
+static int cyttsp_spi_write_block_data(struct cyttsp *ts,
 				       u8 addr, u8 length, const void *data)
 {
-	return cyttsp_spi_xfer(CY_SPI_WR_OP, dev, addr, (void *)data, length);
+	return cyttsp_spi_xfer(ts, CY_SPI_WR_OP, addr, (void *)data, length);
 }
 
 static const struct cyttsp_bus_ops cyttsp_spi_bus_ops = {
diff --git a/include/linux/input/cyttsp.h b/include/linux/input/cyttsp.h
index 3cdd574..5af7c66 100644
--- a/include/linux/input/cyttsp.h
+++ b/include/linux/input/cyttsp.h
@@ -48,7 +48,6 @@ struct cyttsp_platform_data {
 	u8 act_intrvl;  /* Active refresh interval; ms */
 	u8 tch_tmout;   /* Active touch timeout; ms */
 	u8 lp_intrvl;   /* Low power refresh interval; ms */
-	int (*wakeup)(void);
 	int (*init)(void);
 	void (*exit)(void);
 	char *name;
-- 
1.7.7.6

