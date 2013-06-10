From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] Input: tps6507x-ts - convert to polled input device infrastructure
Date: Sun,  9 Jun 2013 22:53:47 -0700
Message-ID: <1370843627-30823-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1370843627-30823-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:50761 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab3FJFxw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jun 2013 01:53:52 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so7060754pdj.28
        for <linux-input@vger.kernel.org>; Sun, 09 Jun 2013 22:53:51 -0700 (PDT)
In-Reply-To: <1370843627-30823-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: manishv.b@ti.com, davinci-linux-open-source@linux.davincidsp.com

There is no need to roll our own polling scheme when we already have
one implemented by the core.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tps6507x-ts.c | 126 ++++++++++++--------------------
 include/linux/mfd/tps6507x.h            |   1 -
 2 files changed, 48 insertions(+), 79 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index d3c2967..94cde2c 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/input.h>
+#include <linux/input-polldev.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/tps6507x.h>
 #include <linux/input/tps6507x-ts.h>
@@ -38,14 +39,12 @@ struct ts_event {
 };
 
 struct tps6507x_ts {
-	struct input_dev	*input_dev;
 	struct device		*dev;
+	struct input_polled_dev	*poll_dev;
+	struct tps6507x_dev	*mfd;
 	char			phys[32];
-	struct delayed_work	work;
 	struct ts_event		tc;
-	struct tps6507x_dev	*mfd;
 	u16			min_pressure;
-	unsigned long		poll_period;	/* ms */
 	bool			pendown;
 };
 
@@ -156,13 +155,11 @@ static s32 tps6507x_adc_standby(struct tps6507x_ts *tsc)
 	return ret;
 }
 
-static void tps6507x_ts_handler(struct work_struct *work)
+static void tps6507x_ts_poll(struct input_polled_dev *poll_dev)
 {
-	struct tps6507x_ts *tsc =  container_of(work,
-				struct tps6507x_ts, work.work);
-	struct input_dev *input_dev = tsc->input_dev;
+	struct tps6507x_ts *tsc = poll_dev->private;
+	struct input_dev *input_dev = poll_dev->input;
 	bool pendown;
-	int schd;
 	s32 ret;
 
 	ret = tps6507x_adc_conversion(tsc, TPS6507X_TSCMODE_PRESSURE,
@@ -206,62 +203,65 @@ static void tps6507x_ts_handler(struct work_struct *work)
 	}
 
 done:
-	/* always poll if not using interrupts */
-	schd = schedule_delayed_work(&tsc->work,
-				msecs_to_jiffies(tsc->poll_period));
-	if (!schd)
-		dev_err(tsc->dev, "re-schedule failed");
-
-	ret = tps6507x_adc_standby(tsc);
+	tps6507x_adc_standby(tsc);
 }
 
 static int tps6507x_ts_probe(struct platform_device *pdev)
 {
-	int error;
-	struct tps6507x_ts *tsc;
 	struct tps6507x_dev *tps6507x_dev = dev_get_drvdata(pdev->dev.parent);
-	struct touchscreen_init_data *init_data;
+	const struct tps6507x_board *tps_board;
+	const struct touchscreen_init_data *init_data;
+	struct tps6507x_ts *tsc;
+	struct input_polled_dev *poll_dev;
 	struct input_dev *input_dev;
-	struct tps6507x_board *tps_board;
-	int schd;
+	int error;
 
-	/**
+	/*
 	 * tps_board points to pmic related constants
 	 * coming from the board-evm file.
 	 */
-
-	tps_board = (struct tps6507x_board *)tps6507x_dev->dev->platform_data;
-
+	tps_board = dev_get_platdata(tps6507x_dev->dev);
 	if (!tps_board) {
 		dev_err(tps6507x_dev->dev,
 			"Could not find tps6507x platform data\n");
-		return -EIO;
+		return -ENODEV;
 	}
 
-	/**
+	/*
 	 * init_data points to array of regulator_init structures
 	 * coming from the board-evm file.
 	 */
-
 	init_data = tps_board->tps6507x_ts_init_data;
 
 	tsc = kzalloc(sizeof(struct tps6507x_ts), GFP_KERNEL);
 	if (!tsc) {
 		dev_err(tps6507x_dev->dev, "failed to allocate driver data\n");
-		error = -ENOMEM;
-		goto err0;
+		return -ENOMEM;
 	}
 
-	tps6507x_dev->ts = tsc;
 	tsc->mfd = tps6507x_dev;
 	tsc->dev = tps6507x_dev->dev;
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		dev_err(tsc->dev, "Failed to allocate input device.\n");
+	tsc->min_pressure = init_data ?
+			init_data->min_pressure : TPS_DEFAULT_MIN_PRESSURE;
+
+	snprintf(tsc->phys, sizeof(tsc->phys),
+		 "%s/input0", dev_name(tsc->dev));
+
+	poll_dev = input_allocate_polled_device();
+	if (!poll_dev) {
+		dev_err(tsc->dev, "Failed to allocate polled input device.\n");
 		error = -ENOMEM;
-		goto err1;
+		goto err_free_mem;
 	}
 
+	tsc->poll_dev = poll_dev;
+
+	poll_dev->private = tsc;
+	poll_dev->poll = tps6507x_ts_poll;
+	poll_dev->poll_interval = init_data ?
+			init_data->poll_period : TSC_DEFAULT_POLL_PERIOD;
+
+	input_dev = poll_dev->input;
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
@@ -270,72 +270,42 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_10BIT, 0, 0);
 
 	input_dev->name = "TPS6507x Touchscreen";
-	input_dev->id.bustype = BUS_I2C;
-	input_dev->dev.parent = tsc->dev;
-
-	snprintf(tsc->phys, sizeof(tsc->phys),
-		 "%s/input0", dev_name(tsc->dev));
 	input_dev->phys = tsc->phys;
-
-	dev_dbg(tsc->dev, "device: %s\n", input_dev->phys);
-
-	input_set_drvdata(input_dev, tsc);
-
-	tsc->input_dev = input_dev;
-
-	INIT_DELAYED_WORK(&tsc->work, tps6507x_ts_handler);
-
+	input_dev->dev.parent = tsc->dev;
+	input_dev->id.bustype = BUS_I2C;
 	if (init_data) {
-		tsc->poll_period = init_data->poll_period;
-		tsc->min_pressure = init_data->min_pressure;
 		input_dev->id.vendor = init_data->vendor;
 		input_dev->id.product = init_data->product;
 		input_dev->id.version = init_data->version;
-	} else {
-		tsc->poll_period = TSC_DEFAULT_POLL_PERIOD;
-		tsc->min_pressure = TPS_DEFAULT_MIN_PRESSURE;
 	}
 
 	error = tps6507x_adc_standby(tsc);
 	if (error)
-		goto err2;
+		goto err_free_polled_dev;
 
-	error = input_register_device(input_dev);
+	error = input_register_polled_device(poll_dev);
 	if (error)
-		goto err2;
-
-	schd = schedule_delayed_work(&tsc->work,
-				     msecs_to_jiffies(tsc->poll_period));
+		goto err_free_polled_dev;
 
-	if (!schd) {
-		dev_err(tsc->dev, "schedule failed");
-		goto err2;
-	 }
-	platform_set_drvdata(pdev, tps6507x_dev);
+	platform_set_drvdata(pdev, tsc);
 
 	return 0;
 
-err2:
-	cancel_delayed_work_sync(&tsc->work);
-	input_free_device(input_dev);
-err1:
+err_free_polled_dev:
+	input_free_polled_device(poll_dev);
+err_free_mem:
 	kfree(tsc);
-	tps6507x_dev->ts = NULL;
-err0:
 	return error;
 }
 
 static int tps6507x_ts_remove(struct platform_device *pdev)
 {
-	struct tps6507x_dev *tps6507x_dev = platform_get_drvdata(pdev);
-	struct tps6507x_ts *tsc = tps6507x_dev->ts;
-	struct input_dev *input_dev = tsc->input_dev;
-
-	cancel_delayed_work_sync(&tsc->work);
+	struct tps6507x_ts *tsc = platform_get_drvdata(pdev);
+	struct input_polled_dev *poll_dev = tsc->poll_dev;
 
-	input_unregister_device(input_dev);
+	input_unregister_polled_device(poll_dev);
+	input_free_polled_device(poll_dev);
 
-	tps6507x_dev->ts = NULL;
 	kfree(tsc);
 
 	return 0;
diff --git a/include/linux/mfd/tps6507x.h b/include/linux/mfd/tps6507x.h
index c923e48..c2ae569 100644
--- a/include/linux/mfd/tps6507x.h
+++ b/include/linux/mfd/tps6507x.h
@@ -163,7 +163,6 @@ struct tps6507x_dev {
 
 	/* Client devices */
 	struct tps6507x_pmic *pmic;
-	struct tps6507x_ts *ts;
 };
 
 #endif /*  __LINUX_MFD_TPS6507X_H */
-- 
1.8.1.4

