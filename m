From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH]  Input: colibri-vf50-ts - call iio_channel_release_all() in all error paths
Date: Sun, 14 Feb 2016 12:10:49 -0200
Message-ID: <1455459049-5690-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:32831 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbcBNOLA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Feb 2016 09:11:00 -0500
Received: by mail-qg0-f44.google.com with SMTP id b35so94725783qge.0
        for <linux-input@vger.kernel.org>; Sun, 14 Feb 2016 06:11:00 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: maitysanchayan@gmail.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

We need to make sure to call iio_channel_release_all() in all error
paths of the probe function.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Build-tested only.

 drivers/input/touchscreen/colibri-vf50-ts.c | 39 ++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/input/touchscreen/colibri-vf50-ts.c
index 69828d0..67f8a17 100644
--- a/drivers/input/touchscreen/colibri-vf50-ts.c
+++ b/drivers/input/touchscreen/colibri-vf50-ts.c
@@ -279,9 +279,8 @@ static int vf50_ts_probe(struct platform_device *pdev)
 
 	error = devm_add_action(dev, vf50_ts_channel_release, channels);
 	if (error) {
-		iio_channel_release_all(channels);
 		dev_err(dev, "Failed to register iio channel release action");
-		return error;
+		goto channel_release;
 	}
 
 	num_adc_channels = 0;
@@ -290,12 +289,15 @@ static int vf50_ts_probe(struct platform_device *pdev)
 
 	if (num_adc_channels != COLI_TOUCH_REQ_ADC_CHAN) {
 		dev_err(dev, "Inadequate ADC channels specified\n");
-		return -EINVAL;
+		error = -EINVAL;
+		goto channel_release;
 	}
 
 	touchdev = devm_kzalloc(dev, sizeof(*touchdev), GFP_KERNEL);
-	if (!touchdev)
-		return -ENOMEM;
+	if (!touchdev) {
+		error = -ENOMEM;
+		goto channel_release;
+	}
 
 	touchdev->pdev = pdev;
 	touchdev->channels = channels;
@@ -303,12 +305,13 @@ static int vf50_ts_probe(struct platform_device *pdev)
 	error = of_property_read_u32(dev->of_node, "vf50-ts-min-pressure",
 				 &touchdev->min_pressure);
 	if (error)
-		return error;
+		goto channel_release;
 
 	input = devm_input_allocate_device(dev);
 	if (!input) {
 		dev_err(dev, "Failed to allocate TS input device\n");
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto channel_release;
 	}
 
 	platform_set_drvdata(pdev, touchdev);
@@ -330,29 +333,31 @@ static int vf50_ts_probe(struct platform_device *pdev)
 	error = input_register_device(input);
 	if (error) {
 		dev_err(dev, "Failed to register input device\n");
-		return error;
+		goto channel_release;
 	}
 
 	error = vf50_ts_get_gpiod(dev, &touchdev->gpio_xp, "xp", GPIOD_OUT_LOW);
 	if (error)
-		return error;
+		goto channel_release;
 
 	error = vf50_ts_get_gpiod(dev, &touchdev->gpio_xm,
 				"xm", GPIOD_OUT_LOW);
 	if (error)
-		return error;
+		goto channel_release;
 
 	error = vf50_ts_get_gpiod(dev, &touchdev->gpio_yp, "yp", GPIOD_OUT_LOW);
 	if (error)
-		return error;
+		goto channel_release;
 
 	error = vf50_ts_get_gpiod(dev, &touchdev->gpio_ym, "ym", GPIOD_OUT_LOW);
 	if (error)
-		return error;
+		goto channel_release;
 
 	touchdev->pen_irq = platform_get_irq(pdev, 0);
-	if (touchdev->pen_irq < 0)
-		return touchdev->pen_irq;
+	if (touchdev->pen_irq < 0) {
+		error = touchdev->pen_irq;
+		goto channel_release;
+	}
 
 	error = devm_request_threaded_irq(dev, touchdev->pen_irq,
 					  NULL, vf50_ts_irq_bh, IRQF_ONESHOT,
@@ -360,10 +365,14 @@ static int vf50_ts_probe(struct platform_device *pdev)
 	if (error) {
 		dev_err(dev, "Failed to request IRQ %d: %d\n",
 			touchdev->pen_irq, error);
-		return error;
+		goto channel_release;
 	}
 
 	return 0;
+
+channel_release:
+	iio_channel_release_all(channels);
+	return error;
 }
 
 static const struct of_device_id vf50_touch_of_match[] = {
-- 
1.9.1

