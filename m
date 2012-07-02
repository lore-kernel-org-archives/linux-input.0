From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] input: Request threaded-only IRQs with IRQF_ONESHOT
Date: Mon,  2 Jul 2012 13:44:20 +0200
Message-ID: <1341229460-23732-1-git-send-email-lars@metafoo.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out-137.synserver.de ([212.40.185.137]:1033 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750770Ab2GBLko (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Jul 2012 07:40:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabien Marteau <fabien.marteau@armadeus.com>, HeungJun Kim <riverful.kim@samsung.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, Bo Shen <voice.shen@atmel.com>, Sriramakrishnan <srk@ti.com>, Kyle Manna <kyle.manna@fuel7.com>, Cyril Chemparathy <cyril@ti.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Alan Cox <alan@linux.intel.com>, Jianchun Bian <jcbian@pixcir.com.cn>, Aaro Koskinen <aaro.koskinen@nokia.com>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Since commit 1c6c69525b ("genirq: Reject bogus threaded irq requests") threaded
IRQs without a primary handler need to be requested with IRQF_ONESHOT, otherwise
the request will fail. This patch adds the IRQF_ONESHOT to IIO drivers where it
is missing. Not modified by this patch are those drivers where the requested IRQ
will always be a nested IRQ (e.g. because it's part of an MFD), since for this
special case IRQF_ONESHOT is not required to be specified when requesting the
IRQ.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/input/joystick/as5011.c             |    6 ++++--
 drivers/input/keyboard/mcs_touchkey.c       |    3 ++-
 drivers/input/keyboard/mpr121_touchkey.c    |    2 +-
 drivers/input/keyboard/qt1070.c             |    3 ++-
 drivers/input/keyboard/tca6416-keypad.c     |    3 ++-
 drivers/input/keyboard/tca8418_keypad.c     |    2 +-
 drivers/input/keyboard/tnetv107x-keypad.c   |    8 ++++----
 drivers/input/misc/ad714x.c                 |    6 +++---
 drivers/input/misc/dm355evm_keys.c          |    3 ++-
 drivers/input/touchscreen/ad7879.c          |    2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c    |    3 ++-
 drivers/input/touchscreen/bu21013_ts.c      |    4 ++--
 drivers/input/touchscreen/cy8ctmg110_ts.c   |    3 ++-
 drivers/input/touchscreen/intel-mid-touch.c |    2 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c   |    2 +-
 drivers/input/touchscreen/tnetv107x-ts.c    |    2 +-
 drivers/input/touchscreen/tsc2005.c         |    3 ++-
 17 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 3063464..ef887c3 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -281,7 +281,9 @@ static int __devinit as5011_probe(struct i2c_client *client,
 
 	error = request_threaded_irq(as5011->button_irq,
 				     NULL, as5011_button_interrupt,
-				     IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				     IRQF_TRIGGER_RISING |
+				     IRQF_TRIGGER_FALLING |
+				     IRQF_ONESHOT,
 				     "as5011_button", as5011);
 	if (error < 0) {
 		dev_err(&client->dev,
@@ -295,7 +297,7 @@ static int __devinit as5011_probe(struct i2c_client *client,
 
 	error = request_threaded_irq(as5011->axis_irq, NULL,
 				     as5011_axis_interrupt,
-				     plat_data->axis_irqflags,
+				     plat_data->axis_irqflags | IRQF_ONESHOT,
 				     "as5011_joystick", as5011);
 	if (error) {
 		dev_err(&client->dev,
diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
index 64a0ca4..a6a851d 100644
--- a/drivers/input/keyboard/mcs_touchkey.c
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -178,7 +178,8 @@ static int __devinit mcs_touchkey_probe(struct i2c_client *client,
 	}
 
 	error = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
-			IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			client->dev.driver->name, data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
 		goto err_free_mem;
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index caa218a..7613f1c 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -248,7 +248,7 @@ static int __devinit mpr_touchkey_probe(struct i2c_client *client,
 
 	error = request_threaded_irq(client->irq, NULL,
 				     mpr_touchkey_interrupt,
-				     IRQF_TRIGGER_FALLING,
+				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				     client->dev.driver->name, mpr121);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index 0b7b2f8..a0770a2 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -201,7 +201,8 @@ static int __devinit qt1070_probe(struct i2c_client *client,
 	msleep(QT1070_RESET_TIME);
 
 	err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
-		IRQF_TRIGGER_NONE, client->dev.driver->name, data);
+		IRQF_TRIGGER_NONE | IRQF_ONESHOT,
+		client->dev.driver->name, data);
 	if (err) {
 		dev_err(&client->dev, "fail to request irq\n");
 		goto err_free_mem;
diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 3afea3f..dcc5088 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -278,7 +278,8 @@ static int __devinit tca6416_keypad_probe(struct i2c_client *client,
 
 		error = request_threaded_irq(chip->irqnum, NULL,
 					     tca6416_keys_isr,
-					     IRQF_TRIGGER_FALLING,
+					     IRQF_TRIGGER_FALLING |
+					     IRQF_ONESHOT,
 					     "tca6416-keypad", chip);
 		if (error) {
 			dev_dbg(&client->dev,
diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 5f87b28..893869b 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -360,7 +360,7 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
 		client->irq = gpio_to_irq(client->irq);
 
 	error = request_threaded_irq(client->irq, NULL, tca8418_irq_handler,
-				     IRQF_TRIGGER_FALLING,
+				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				     client->name, keypad_data);
 	if (error) {
 		dev_dbg(&client->dev,
diff --git a/drivers/input/keyboard/tnetv107x-keypad.c b/drivers/input/keyboard/tnetv107x-keypad.c
index a4a445f..4c34f21 100644
--- a/drivers/input/keyboard/tnetv107x-keypad.c
+++ b/drivers/input/keyboard/tnetv107x-keypad.c
@@ -227,15 +227,15 @@ static int __devinit keypad_probe(struct platform_device *pdev)
 		goto error_clk;
 	}
 
-	error = request_threaded_irq(kp->irq_press, NULL, keypad_irq, 0,
-				     dev_name(dev), kp);
+	error = request_threaded_irq(kp->irq_press, NULL, keypad_irq,
+				     IRQF_ONESHOT, dev_name(dev), kp);
 	if (error < 0) {
 		dev_err(kp->dev, "Could not allocate keypad press key irq\n");
 		goto error_irq_press;
 	}
 
-	error = request_threaded_irq(kp->irq_release, NULL, keypad_irq, 0,
-				     dev_name(dev), kp);
+	error = request_threaded_irq(kp->irq_release, NULL, keypad_irq,
+				     IRQF_ONESHOT, dev_name(dev), kp);
 	if (error < 0) {
 		dev_err(kp->dev, "Could not allocate keypad release key irq\n");
 		goto error_irq_release;
diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index 0ac75bb..fcc3b5d 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -1163,9 +1163,9 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 	}
 
 	error = request_threaded_irq(ad714x->irq, NULL, ad714x_interrupt_thread,
-				plat_data->irqflags ?
-					plat_data->irqflags : IRQF_TRIGGER_FALLING,
-				"ad714x_captouch", ad714x);
+				(plat_data->irqflags ?
+					plat_data->irqflags : IRQF_TRIGGER_FALLING) |
+				IRQF_ONESHOT, "ad714x_captouch", ad714x);
 	if (error) {
 		dev_err(dev, "can't allocate irq %d\n", ad714x->irq);
 		goto err_unreg_dev;
diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm355evm_keys.c
index 35083c6..c6c0d53 100644
--- a/drivers/input/misc/dm355evm_keys.c
+++ b/drivers/input/misc/dm355evm_keys.c
@@ -213,7 +213,8 @@ static int __devinit dm355evm_keys_probe(struct platform_device *pdev)
 	/* REVISIT:  flush the event queue? */
 
 	status = request_threaded_irq(keys->irq, NULL, dm355evm_keys_irq,
-			IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), keys);
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			dev_name(&pdev->dev), keys);
 	if (status < 0)
 		goto fail2;
 
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e2482b4..bd4eb42 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -597,7 +597,7 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 			AD7879_TMR(ts->pen_down_acc_interval);
 
 	err = request_threaded_irq(ts->irq, NULL, ad7879_irq,
-				   IRQF_TRIGGER_FALLING,
+				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				   dev_name(dev), ts);
 	if (err) {
 		dev_err(dev, "irq %d busy?\n", ts->irq);
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 42e6450..25b9ed3 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1149,7 +1149,8 @@ static int __devinit mxt_probe(struct i2c_client *client,
 		goto err_free_object;
 
 	error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
-			pdata->irqflags, client->dev.driver->name, data);
+			pdata->irqflags | IRQF_ONESHOT,
+			client->dev.driver->name, data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
 		goto err_free_object;
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index f2d03c0..df35177 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -509,8 +509,8 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 	input_set_drvdata(in_dev, bu21013_data);
 
 	error = request_threaded_irq(pdata->irq, NULL, bu21013_gpio_irq,
-				     IRQF_TRIGGER_FALLING | IRQF_SHARED,
-				     DRIVER_TP, bu21013_data);
+				     IRQF_TRIGGER_FALLING | IRQF_SHARED |
+				     IRQF_ONESHOT, DRIVER_TP, bu21013_data);
 	if (error) {
 		dev_err(&client->dev, "request irq %d failed\n", pdata->irq);
 		goto err_cs_disable;
diff --git a/drivers/input/touchscreen/cy8ctmg110_ts.c b/drivers/input/touchscreen/cy8ctmg110_ts.c
index 237753a..464f1bf 100644
--- a/drivers/input/touchscreen/cy8ctmg110_ts.c
+++ b/drivers/input/touchscreen/cy8ctmg110_ts.c
@@ -251,7 +251,8 @@ static int __devinit cy8ctmg110_probe(struct i2c_client *client,
 	}
 
 	err = request_threaded_irq(client->irq, NULL, cy8ctmg110_irq_thread,
-				   IRQF_TRIGGER_RISING, "touch_reset_key", ts);
+				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				   "touch_reset_key", ts);
 	if (err < 0) {
 		dev_err(&client->dev,
 			"irq %d busy? error %d\n", client->irq, err);
diff --git a/drivers/input/touchscreen/intel-mid-touch.c b/drivers/input/touchscreen/intel-mid-touch.c
index 3cd7a83..cf29937 100644
--- a/drivers/input/touchscreen/intel-mid-touch.c
+++ b/drivers/input/touchscreen/intel-mid-touch.c
@@ -620,7 +620,7 @@ static int __devinit mrstouch_probe(struct platform_device *pdev)
 			     MRST_PRESSURE_MIN, MRST_PRESSURE_MAX, 0, 0);
 
 	err = request_threaded_irq(tsdev->irq, NULL, mrstouch_pendet_irq,
-				   0, "mrstouch", tsdev);
+				   IRQF_ONESHOT, "mrstouch", tsdev);
 	if (err) {
 		dev_err(tsdev->dev, "unable to allocate irq\n");
 		goto err_free_mem;
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 72f6ba3..953b4c1 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -165,7 +165,7 @@ static int __devinit pixcir_i2c_ts_probe(struct i2c_client *client,
 	input_set_drvdata(input, tsdata);
 
 	error = request_threaded_irq(client->irq, NULL, pixcir_ts_isr,
-				     IRQF_TRIGGER_FALLING,
+				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				     client->name, tsdata);
 	if (error) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
diff --git a/drivers/input/touchscreen/tnetv107x-ts.c b/drivers/input/touchscreen/tnetv107x-ts.c
index 7e74880..368d2c6c 100644
--- a/drivers/input/touchscreen/tnetv107x-ts.c
+++ b/drivers/input/touchscreen/tnetv107x-ts.c
@@ -297,7 +297,7 @@ static int __devinit tsc_probe(struct platform_device *pdev)
 		goto error_clk;
 	}
 
-	error = request_threaded_irq(ts->tsc_irq, NULL, tsc_irq, 0,
+	error = request_threaded_irq(ts->tsc_irq, NULL, tsc_irq, IRQF_ONESHOT,
 				     dev_name(dev), ts);
 	if (error < 0) {
 		dev_err(ts->dev, "Could not allocate ts irq\n");
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index b6adeae..5ce3fa8 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -650,7 +650,8 @@ static int __devinit tsc2005_probe(struct spi_device *spi)
 	tsc2005_stop_scan(ts);
 
 	error = request_threaded_irq(spi->irq, NULL, tsc2005_irq_thread,
-				     IRQF_TRIGGER_RISING, "tsc2005", ts);
+				     IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				     "tsc2005", ts);
 	if (error) {
 		dev_err(&spi->dev, "Failed to request irq, err: %d\n", error);
 		goto err_free_mem;
-- 
1.7.10

