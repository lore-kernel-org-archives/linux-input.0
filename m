From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 06/18] video: backlight: add new locomo backlight driver
Date: Mon, 25 May 2015 14:41:41 +0300
Message-ID: <1432554113-26280-7-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432554113-26280-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Add new simple backlight driver - it cares only about PWM/frontlight
part of LoCoMo, it does not touch TFT settings and does not export TFT
power control.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/video/backlight/Kconfig     |   6 +-
 drivers/video/backlight/Makefile    |   2 +-
 drivers/video/backlight/locomo_bl.c | 153 ++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 4 deletions(-)
 create mode 100644 drivers/video/backlight/locomo_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 2d9923a..6c093e2 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -217,12 +217,12 @@ config BACKLIGHT_LM3533
 	  levels.
 
 config BACKLIGHT_LOCOMO
-	tristate "Sharp LOCOMO LCD/Backlight Driver"
-	depends on SHARP_LOCOMO
+	tristate "Sharp LOCOMO Backlight Driver"
+	depends on MFD_LOCOMO
 	default y
 	help
 	  If you have a Sharp Zaurus SL-5500 (Collie) or SL-5600 (Poodle) say y to
-	  enable the LCD/backlight driver.
+	  enable the backlight driver.
 
 config BACKLIGHT_OMAP1
 	tristate "OMAP1 PWL-based LCD Backlight"
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index d67073f..2de73d2 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3639)		+= lm3639_bl.o
-obj-$(CONFIG_BACKLIGHT_LOCOMO)		+= locomolcd.o
+obj-$(CONFIG_BACKLIGHT_LOCOMO)		+= locomo_bl.o
 obj-$(CONFIG_BACKLIGHT_LP855X)		+= lp855x_bl.o
 obj-$(CONFIG_BACKLIGHT_LP8788)		+= lp8788_bl.o
 obj-$(CONFIG_BACKLIGHT_LV5207LP)	+= lv5207lp.o
diff --git a/drivers/video/backlight/locomo_bl.c b/drivers/video/backlight/locomo_bl.c
new file mode 100644
index 0000000..cc60022
--- /dev/null
+++ b/drivers/video/backlight/locomo_bl.c
@@ -0,0 +1,153 @@
+/*
+ * Backlight control code for Sharp Zaurus SL-5500
+ *
+ * Copyright 2005 John Lenz <lenz-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org>
+ * Maintainer: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> (unless John wants to :-)
+ * GPL v2
+ *
+ * This driver assumes single CPU. That's okay, because collie is
+ * slightly old hardware, and no one is going to retrofit second CPU to
+ * old PDA.
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/locomo.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct locomo_bl {
+	struct regmap *regmap;
+	int current_intensity;
+	struct gpio_desc *fl_vr;
+};
+
+static const struct {
+	u16 duty, bpwf;
+	bool vr;
+} locomo_bl_pwm[] = {
+	{ 0, 161, false },
+	{ 117, 161, false },
+	{ 163, 148, false },
+	{ 194, 161, false },
+	{ 194, 161, true },
+};
+
+static int locomo_bl_set_intensity(struct backlight_device *bd)
+{
+	int intensity = bd->props.brightness;
+	struct locomo_bl *bl = dev_get_drvdata(&bd->dev);
+
+	if (bd->props.power != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (bd->props.state & BL_CORE_SUSPENDED)
+		intensity = 0;
+
+	gpiod_set_value(bl->fl_vr, locomo_bl_pwm[intensity].vr);
+
+	regmap_write(bl->regmap, LOCOMO_ALS, locomo_bl_pwm[intensity].bpwf);
+	usleep_range(100, 200);
+	regmap_write(bl->regmap, LOCOMO_ALD, locomo_bl_pwm[intensity].duty);
+	usleep_range(100, 200);
+	regmap_write(bl->regmap, LOCOMO_ALS, locomo_bl_pwm[intensity].bpwf |
+			LOCOMO_ALS_EN);
+
+	bl->current_intensity = intensity;
+	if (bd->props.state & BL_CORE_SUSPENDED)
+		regmap_write(bl->regmap, LOCOMO_ALS, 0x00);
+
+	return 0;
+}
+
+static int locomo_bl_get_intensity(struct backlight_device *bd)
+{
+	struct locomo_bl *bl = dev_get_drvdata(&bd->dev);
+
+	return bl->current_intensity;
+}
+
+static const struct backlight_ops locomo_bl_ops = {
+	.options	= BL_CORE_SUSPENDRESUME,
+	.get_brightness = locomo_bl_get_intensity,
+	.update_status  = locomo_bl_set_intensity,
+};
+
+static int locomo_bl_probe(struct platform_device *dev)
+{
+	struct backlight_properties props;
+	struct locomo_bl *bl;
+	struct backlight_device *locomo_bl_device;
+
+	bl = devm_kmalloc(&dev->dev, sizeof(struct locomo_bl), GFP_KERNEL);
+	if (!bl)
+		return -ENOMEM;
+
+	bl->regmap = dev_get_regmap(dev->dev.parent, NULL);
+	if (!bl->regmap)
+		return -ENODEV;
+
+	bl->fl_vr = devm_gpiod_get(&dev->dev, "flvr", GPIOD_OUT_LOW);
+	if (IS_ERR(bl->fl_vr))
+		return PTR_ERR(bl->fl_vr);
+
+	regmap_write(bl->regmap, LOCOMO_ALS, 0);
+	regmap_write(bl->regmap, LOCOMO_ALD, 0);
+
+	memset(&props, 0, sizeof(struct backlight_properties));
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = ARRAY_SIZE(locomo_bl_pwm) - 1;
+	props.brightness = props.max_brightness / 2;
+	locomo_bl_device = devm_backlight_device_register(&dev->dev,
+						"locomo-bl",
+						&dev->dev, bl,
+						&locomo_bl_ops, &props);
+
+	if (IS_ERR(locomo_bl_device))
+		return PTR_ERR(locomo_bl_device);
+
+	platform_set_drvdata(dev, locomo_bl_device);
+
+	/* Set up frontlight so that screen is readable */
+	backlight_update_status(locomo_bl_device);
+
+	return 0;
+}
+
+static void locomo_bl_shutdown(struct platform_device *dev)
+{
+	struct backlight_device *locomo_bl_device = platform_get_drvdata(dev);
+
+	locomo_bl_device->props.brightness = 0;
+	locomo_bl_device->props.power = 0;
+	locomo_bl_set_intensity(locomo_bl_device);
+}
+
+static int locomo_bl_remove(struct platform_device *dev)
+{
+	locomo_bl_shutdown(dev);
+
+	return 0;
+}
+
+static struct platform_driver locomo_bl_driver = {
+	.driver = {
+		.name	= "locomo-backlight",
+	},
+	.probe	= locomo_bl_probe,
+	.remove	= locomo_bl_remove,
+	/* Turn off bl on power off/reboot */
+	.shutdown = locomo_bl_shutdown,
+};
+
+module_platform_driver(locomo_bl_driver);
+
+MODULE_AUTHOR("John Lenz <lenz-hcNo3dDEHLuVc3sceRu5cw@public.gmane.org>");
+MODULE_AUTHOR("Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>");
+MODULE_DESCRIPTION("LoCoMo Backlight driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:locomo-backlight");
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
