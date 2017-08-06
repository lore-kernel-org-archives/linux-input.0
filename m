From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v5 05/12] Input: wm97xx: split out touchscreen registering
Date: Sun,  6 Aug 2017 23:36:06 +0200
Message-ID: <20170806213613.5600-6-robert.jarzmik@free.fr>
References: <20170806213613.5600-1-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:27727 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdHFVg3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 6 Aug 2017 17:36:29 -0400
In-Reply-To: <20170806213613.5600-1-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

wm97xx-core does several things in it initialization :
 - touchscreen input device setup
 - battery device creation

As the wm97xx is actually a multi-function device handling an audio
codec, a touchscreen, a gpio block and an ADC, reshape the probing to
isolate what is truly input/touchscreen specific from the remaining
part.

This is only code shuffling, there is no functional change.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
Since v1:
 - took into account Charles's comment
---
 drivers/input/touchscreen/wm97xx-core.c | 196 +++++++++++++++++++-------------
 1 file changed, 115 insertions(+), 81 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index c9d1c91e1887..39869ffdc4fa 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -581,27 +581,85 @@ static void wm97xx_ts_input_close(struct input_dev *idev)
 		wm->codec->acc_enable(wm, 0);
 }
 
-static int wm97xx_probe(struct device *dev)
+static int wm97xx_register_touch(struct wm97xx *wm)
 {
-	struct wm97xx *wm;
-	struct wm97xx_pdata *pdata = dev_get_platdata(dev);
-	int ret = 0, id = 0;
+	struct wm97xx_pdata *pdata = dev_get_platdata(wm->dev);
+	int ret;
 
-	wm = kzalloc(sizeof(struct wm97xx), GFP_KERNEL);
-	if (!wm)
+	wm->input_dev = devm_input_allocate_device(wm->dev);
+	if (wm->input_dev == NULL)
 		return -ENOMEM;
-	mutex_init(&wm->codec_mutex);
 
-	wm->dev = dev;
-	dev_set_drvdata(dev, wm);
-	wm->ac97 = to_ac97_t(dev);
+	/* set up touch configuration */
+	wm->input_dev->name = "wm97xx touchscreen";
+	wm->input_dev->phys = "wm97xx";
+	wm->input_dev->open = wm97xx_ts_input_open;
+	wm->input_dev->close = wm97xx_ts_input_close;
+
+	__set_bit(EV_ABS, wm->input_dev->evbit);
+	__set_bit(EV_KEY, wm->input_dev->evbit);
+	__set_bit(BTN_TOUCH, wm->input_dev->keybit);
+
+	input_set_abs_params(wm->input_dev, ABS_X, abs_x[0], abs_x[1],
+			     abs_x[2], 0);
+	input_set_abs_params(wm->input_dev, ABS_Y, abs_y[0], abs_y[1],
+			     abs_y[2], 0);
+	input_set_abs_params(wm->input_dev, ABS_PRESSURE, abs_p[0], abs_p[1],
+			     abs_p[2], 0);
+
+	input_set_drvdata(wm->input_dev, wm);
+	wm->input_dev->dev.parent = wm->dev;
+
+	ret = input_register_device(wm->input_dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * register our extended touch device (for machine specific
+	 * extensions)
+	 */
+	wm->touch_dev = platform_device_alloc("wm97xx-touch", -1);
+	if (!wm->touch_dev) {
+		ret = -ENOMEM;
+		goto touch_err;
+	}
+	platform_set_drvdata(wm->touch_dev, wm);
+	wm->touch_dev->dev.parent = wm->dev;
+	wm->touch_dev->dev.platform_data = pdata;
+	ret = platform_device_add(wm->touch_dev);
+	if (ret < 0)
+		goto touch_reg_err;
+
+	return 0;
+touch_reg_err:
+	platform_device_put(wm->touch_dev);
+touch_err:
+	input_unregister_device(wm->input_dev);
+	wm->input_dev = NULL;
+
+	return ret;
+}
+
+static void wm97xx_unregister_touch(struct wm97xx *wm)
+{
+	platform_device_unregister(wm->touch_dev);
+	input_unregister_device(wm->input_dev);
+	wm->input_dev = NULL;
+}
+
+static int _wm97xx_probe(struct wm97xx *wm)
+{
+	int id = 0;
+
+	mutex_init(&wm->codec_mutex);
+	dev_set_drvdata(wm->dev, wm);
 
 	/* check that we have a supported codec */
 	id = wm97xx_reg_read(wm, AC97_VENDOR_ID1);
 	if (id != WM97XX_ID1) {
-		dev_err(dev, "Device with vendor %04x is not a wm97xx\n", id);
-		ret = -ENODEV;
-		goto alloc_err;
+		dev_err(wm->dev,
+			"Device with vendor %04x is not a wm97xx\n", id);
+		return -ENODEV;
 	}
 
 	wm->id = wm97xx_reg_read(wm, AC97_VENDOR_ID2);
@@ -629,8 +687,7 @@ static int wm97xx_probe(struct device *dev)
 	default:
 		dev_err(wm->dev, "Support for wm97%02x not compiled in.\n",
 			wm->id & 0xff);
-		ret = -ENODEV;
-		goto alloc_err;
+		return -ENODEV;
 	}
 
 	/* set up physical characteristics */
@@ -644,79 +701,58 @@ static int wm97xx_probe(struct device *dev)
 	wm->gpio[4] = wm97xx_reg_read(wm, AC97_GPIO_STATUS);
 	wm->gpio[5] = wm97xx_reg_read(wm, AC97_MISC_AFE);
 
-	wm->input_dev = input_allocate_device();
-	if (wm->input_dev == NULL) {
-		ret = -ENOMEM;
-		goto alloc_err;
-	}
-
-	/* set up touch configuration */
-	wm->input_dev->name = "wm97xx touchscreen";
-	wm->input_dev->phys = "wm97xx";
-	wm->input_dev->open = wm97xx_ts_input_open;
-	wm->input_dev->close = wm97xx_ts_input_close;
-
-	__set_bit(EV_ABS, wm->input_dev->evbit);
-	__set_bit(EV_KEY, wm->input_dev->evbit);
-	__set_bit(BTN_TOUCH, wm->input_dev->keybit);
-
-	input_set_abs_params(wm->input_dev, ABS_X, abs_x[0], abs_x[1],
-			     abs_x[2], 0);
-	input_set_abs_params(wm->input_dev, ABS_Y, abs_y[0], abs_y[1],
-			     abs_y[2], 0);
-	input_set_abs_params(wm->input_dev, ABS_PRESSURE, abs_p[0], abs_p[1],
-			     abs_p[2], 0);
+	return wm97xx_register_touch(wm);
+}
 
-	input_set_drvdata(wm->input_dev, wm);
-	wm->input_dev->dev.parent = dev;
+static void wm97xx_remove_battery(struct wm97xx *wm)
+{
+	platform_device_unregister(wm->battery_dev);
+}
 
-	ret = input_register_device(wm->input_dev);
-	if (ret < 0)
-		goto dev_alloc_err;
+static int wm97xx_add_battery(struct wm97xx *wm,
+			      struct wm97xx_batt_pdata *pdata)
+{
+	int ret;
 
-	/* register our battery device */
 	wm->battery_dev = platform_device_alloc("wm97xx-battery", -1);
-	if (!wm->battery_dev) {
-		ret = -ENOMEM;
-		goto batt_err;
-	}
+	if (!wm->battery_dev)
+		return -ENOMEM;
+
 	platform_set_drvdata(wm->battery_dev, wm);
-	wm->battery_dev->dev.parent = dev;
-	wm->battery_dev->dev.platform_data = pdata ? pdata->batt_pdata : NULL;
+	wm->battery_dev->dev.parent = wm->dev;
+	wm->battery_dev->dev.platform_data = pdata;
 	ret = platform_device_add(wm->battery_dev);
-	if (ret < 0)
-		goto batt_reg_err;
+	if (ret)
+		platform_device_put(wm->battery_dev);
 
-	/* register our extended touch device (for machine specific
-	 * extensions) */
-	wm->touch_dev = platform_device_alloc("wm97xx-touch", -1);
-	if (!wm->touch_dev) {
-		ret = -ENOMEM;
-		goto touch_err;
-	}
-	platform_set_drvdata(wm->touch_dev, wm);
-	wm->touch_dev->dev.parent = dev;
-	wm->touch_dev->dev.platform_data = pdata;
-	ret = platform_device_add(wm->touch_dev);
+	return ret;
+}
+
+static int wm97xx_probe(struct device *dev)
+{
+	struct wm97xx *wm;
+	int ret;
+	struct wm97xx_pdata *pdata = dev_get_platdata(dev);
+
+	wm = devm_kzalloc(dev, sizeof(struct wm97xx), GFP_KERNEL);
+	if (!wm)
+		return -ENOMEM;
+
+	wm->dev = dev;
+	wm->ac97 = to_ac97_t(dev);
+
+	ret =  _wm97xx_probe(wm);
+	if (ret)
+		return ret;
+
+	ret = wm97xx_add_battery(wm, pdata ? pdata->batt_pdata : NULL);
 	if (ret < 0)
-		goto touch_reg_err;
+		goto batt_err;
 
 	return ret;
 
- touch_reg_err:
-	platform_device_put(wm->touch_dev);
- touch_err:
-	platform_device_del(wm->battery_dev);
- batt_reg_err:
-	platform_device_put(wm->battery_dev);
- batt_err:
-	input_unregister_device(wm->input_dev);
-	wm->input_dev = NULL;
- dev_alloc_err:
-	input_free_device(wm->input_dev);
- alloc_err:
-	kfree(wm);
-
+batt_err:
+	wm97xx_unregister_touch(wm);
 	return ret;
 }
 
@@ -724,10 +760,8 @@ static int wm97xx_remove(struct device *dev)
 {
 	struct wm97xx *wm = dev_get_drvdata(dev);
 
-	platform_device_unregister(wm->battery_dev);
-	platform_device_unregister(wm->touch_dev);
-	input_unregister_device(wm->input_dev);
-	kfree(wm);
+	wm97xx_remove_battery(wm);
+	wm97xx_unregister_touch(wm);
 
 	return 0;
 }
-- 
2.11.0

