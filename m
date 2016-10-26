From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 7/9] Input: wm97xx: split out touchscreen registering
Date: Wed, 26 Oct 2016 21:41:45 +0200
Message-ID: <1477510907-23495-8-git-send-email-robert.jarzmik@free.fr>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

wm97xx-core does several things in it initialization :
 - touchscreen input device setup
 - battery device creation

As the wm97xx is actually a multi-function device handling an audio
codec, a touchscreen, a gpio block and an ADC, reshape the probing to
isolate what is truly input/touchscreen specific from the remaining
part.

This is only code shuffling, there is no functional change.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/input/touchscreen/wm97xx-core.c | 193 ++++++++++++++++++--------------
 1 file changed, 112 insertions(+), 81 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 83cf11312fd9..50a110e2988b 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -581,27 +581,82 @@ static void wm97xx_ts_input_close(struct input_dev *idev)
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
+	/* register our extended touch device (for machine specific
+	 * extensions) */
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
+		dev_err(wm->dev, "Device with vendor %04x is not a wm97xx\n", id);
+		return -ENODEV;
 	}
 
 	wm->id = wm97xx_reg_read(wm, AC97_VENDOR_ID2);
@@ -629,8 +684,7 @@ static int wm97xx_probe(struct device *dev)
 	default:
 		dev_err(wm->dev, "Support for wm97%02x not compiled in.\n",
 			wm->id & 0xff);
-		ret = -ENODEV;
-		goto alloc_err;
+		return -ENODEV;
 	}
 
 	/* set up physical characteristics */
@@ -644,79 +698,58 @@ static int wm97xx_probe(struct device *dev)
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
+	platform_device_put(wm->battery_dev);
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
-	wm->battery_dev->dev.platform_data = pdata->batt_pdata;
+	wm->battery_dev->dev.parent = wm->dev;
+	wm->battery_dev->dev.platform_data = pdata;
 	ret = platform_device_add(wm->battery_dev);
-	if (ret < 0)
-		goto batt_reg_err;
+	if (ret)
+		wm97xx_remove_battery(wm);
 
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
+	ret = wm97xx_add_battery(wm, pdata->batt_pdata);
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
 
@@ -724,10 +757,8 @@ static int wm97xx_remove(struct device *dev)
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
2.1.4
