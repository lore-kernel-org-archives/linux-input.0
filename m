From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: [PATCH v2 1/2] Input: TWL4030: add Force Feedback vibra
Date: Tue, 23 Feb 2010 16:27:58 +0200
Message-ID: <1266935279-331-1-git-send-email-ext-jari.vanhala@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53568 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab0BWO2H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2010 09:28:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jari Vanhala <ext-jari.vanhala@nokia.com>

TWL4030 Vibrator implemented via Force Feedback
interface. This uses MFD TWL4030 codec and own workqueue.

Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
---
 drivers/input/misc/Kconfig         |   11 ++
 drivers/input/misc/Makefile        |    1 +
 drivers/input/misc/twl4030-vibra.c |  297 ++++++++++++++++++++++++++++++++++++
 3 files changed, 309 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/twl4030-vibra.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 16ec523..399495a 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -204,6 +204,17 @@ config INPUT_TWL4030_PWRBUTTON
 	  To compile this driver as a module, choose M here. The module will
 	  be called twl4030_pwrbutton.
 
+config INPUT_TWL4030_VIBRA
+	tristate "Support for TWL4030 Vibrator"
+	depends on TWL4030_CORE
+	select TWL4030_CODEC
+	select INPUT_FF_MEMLESS
+	help
+	  This option enables support for TWL4030 Vibrator Driver.
+
+	  To compile this driver as a module, choose M here. The module will
+	  be called twl4030_vibra.
+
 config INPUT_UINPUT
 	tristate "User level driver support"
 	help
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index a8b8485..1ab002e 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
 obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
+obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_WINBOND_CIR)		+= winbond-cir.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
new file mode 100644
index 0000000..50f7537
--- /dev/null
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -0,0 +1,297 @@
+/*
+ * twl4030-vibra.c - TWL4030 Vibrator driver
+ *
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Written by Henrik Saari <henrik.saari@nokia.com>
+ * Updates by Felipe Balbi <felipe.balbi@nokia.com>
+ * Input by Jari Vanhala <ext-jari.vanhala@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+#include <linux/i2c/twl.h>
+#include <linux/mfd/twl4030-codec.h>
+#include <linux/input.h>
+#include <linux/spinlock.h>
+
+/* MODULE ID2 */
+#define LEDEN		0x00
+
+/* ForceFeedback */
+#define EFFECT_DIR_180_DEG	0x8000 /* range is 0 - 0xFFFF */
+
+struct vibra_info {
+	struct device		*dev;
+	struct input_dev	*input_dev;
+
+	struct workqueue_struct *workqueue;
+	struct work_struct	play_work;
+	spinlock_t		lock; /* for workqueue */
+
+	bool			enabled;
+	int			speed;
+	int			direction;
+
+	bool			coexist;
+};
+
+static void vibra_disable_leds(void)
+{
+	u8 reg;
+
+	/* Disable LEDA & LEDB, cannot be used with vibra (PWM) */
+	twl_i2c_read_u8(TWL4030_MODULE_LED, &reg, LEDEN);
+	reg &= ~0x03;
+	twl_i2c_write_u8(TWL4030_MODULE_LED, LEDEN, reg);
+}
+
+/* Powers H-Bridge and enables audio clk */
+static void vibra_enable(struct vibra_info *info)
+{
+	u8 reg;
+
+	twl4030_codec_enable_resource(TWL4030_CODEC_RES_POWER);
+
+	/* turn H-Bridge on */
+	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
+			&reg, TWL4030_REG_VIBRA_CTL);
+	twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+			 (reg | TWL4030_VIBRA_EN), TWL4030_REG_VIBRA_CTL);
+
+	twl4030_codec_enable_resource(TWL4030_CODEC_RES_APLL);
+
+	info->enabled = true;
+}
+
+static void vibra_disable(struct vibra_info *info)
+{
+	u8 reg;
+
+	/* Power down H-Bridge */
+	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
+			&reg, TWL4030_REG_VIBRA_CTL);
+	twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+			 (reg & ~TWL4030_VIBRA_EN), TWL4030_REG_VIBRA_CTL);
+
+	twl4030_codec_disable_resource(TWL4030_CODEC_RES_POWER);
+	twl4030_codec_disable_resource(TWL4030_CODEC_RES_APLL);
+
+	info->enabled = false;
+}
+
+static void vibra_play_work(struct work_struct *work)
+{
+	struct vibra_info *info = container_of(work,
+			struct vibra_info, play_work);
+	int dir;
+	int pwm;
+	u8 reg;
+
+	dir = info->direction;
+	pwm = info->speed;
+
+	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
+			&reg, TWL4030_REG_VIBRA_CTL);
+	if (pwm && (!info->coexist || !(reg & TWL4030_VIBRA_SEL))) {
+
+		if (!info->enabled)
+			vibra_enable(info);
+
+		/* set vibra rotation direction */
+		twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
+				&reg, TWL4030_REG_VIBRA_CTL);
+		reg = (dir) ? (reg | TWL4030_VIBRA_DIR) :
+			(reg & ~TWL4030_VIBRA_DIR);
+		twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+				 reg, TWL4030_REG_VIBRA_CTL);
+
+		/* set PWM, 1 = max, 255 = min */
+		twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+				 256 - pwm, TWL4030_REG_VIBRA_SET);
+	} else {
+		if (info->enabled)
+			vibra_disable(info);
+	}
+}
+
+/*** ForceFeedback ***/
+
+static int vibra_play(struct input_dev *dev, void *data,
+		      struct ff_effect *effect)
+{
+	struct vibra_info *info = data;
+
+	spin_lock(&info->lock);
+	if (!info->workqueue)
+		goto out;
+
+	info->speed = effect->u.rumble.strong_magnitude >> 8;
+	if (!info->speed)
+		info->speed = effect->u.rumble.weak_magnitude >> 9;
+	info->direction = effect->direction < EFFECT_DIR_180_DEG ? 0 : 1;
+	queue_work(info->workqueue, &info->play_work);
+out:
+	spin_unlock(&info->lock);
+	return 0;
+}
+
+/*** Module ***/
+#if CONFIG_PM
+static int twl4030_vibra_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct vibra_info *info = platform_get_drvdata(pdev);
+
+	if (info->enabled)
+		vibra_disable(info);
+
+	return 0;
+}
+
+static int twl4030_vibra_resume(struct device *dev)
+{
+	vibra_disable_leds();
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(twl4030_vibra_pm_ops,
+			 twl4030_vibra_suspend, twl4030_vibra_resume);
+#endif
+
+static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
+{
+	struct twl4030_codec_vibra_data *pdata = pdev->dev.platform_data;
+	struct vibra_info *info;
+	int ret;
+
+	if (!pdata) {
+		dev_dbg(&pdev->dev, "platform_data not available\n");
+		return -EINVAL;
+	}
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->dev = &pdev->dev;
+	info->enabled = false;
+	info->coexist = pdata->coexist ? true : false;
+
+	platform_set_drvdata(pdev, info);
+
+	info->workqueue = create_singlethread_workqueue("vibra");
+	if (info->workqueue == NULL) {
+		dev_err(&pdev->dev, "couldn't create workqueue\n");
+		ret = -ENOMEM;
+		goto err_kzalloc;
+	}
+	INIT_WORK(&info->play_work, vibra_play_work);
+	spin_lock_init(&info->lock);
+
+	info->input_dev = input_allocate_device();
+	if (info->input_dev == NULL) {
+		dev_err(&pdev->dev, "couldn't allocate input device\n");
+		ret = -ENOMEM;
+		goto err_workq;
+	}
+	input_set_drvdata(info->input_dev, info);
+
+	info->input_dev->name = "twl4030:vibrator";
+	info->input_dev->id.version = 1;
+	info->input_dev->dev.parent = pdev->dev.parent;
+	set_bit(FF_RUMBLE, info->input_dev->ffbit);
+
+	ret = input_register_device(info->input_dev);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev, "couldn't register input device\n");
+		goto err_ialloc;
+	}
+
+	ret = input_ff_create_memless(info->input_dev, info, vibra_play);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev, "couldn't register vibrator to FF\n");
+		goto err_ireg;
+	}
+
+	vibra_disable_leds();
+
+	return 0;
+err_ireg:
+	input_unregister_device(info->input_dev);
+	info->input_dev = NULL;
+err_ialloc:
+	input_free_device(info->input_dev);
+err_workq:
+	destroy_workqueue(info->workqueue);
+err_kzalloc:
+	kfree(info);
+	return ret;
+}
+
+static int __devexit twl4030_vibra_remove(struct platform_device *pdev)
+{
+	struct vibra_info *info = platform_get_drvdata(pdev);
+	struct workqueue_struct *wq;
+
+	spin_lock(&info->lock);
+	wq = info->workqueue;
+	info->workqueue = NULL;
+	spin_unlock(&info->lock);
+
+	cancel_work_sync(&info->play_work);
+	destroy_workqueue(wq);
+	if (info->enabled)
+		vibra_disable(info);
+	/* this also free ff-memless which (in turn) kfree info */
+	input_unregister_device(info->input_dev);
+
+	return 0;
+}
+
+static struct platform_driver twl4030_vibra_driver = {
+	.probe		= twl4030_vibra_probe,
+	.remove		= __devexit_p(twl4030_vibra_remove),
+	.driver		= {
+		.name	= "twl4030_codec_vibra",
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &twl4030_vibra_pm_ops,
+#endif
+	},
+};
+
+static int __init twl4030_vibra_init(void)
+{
+	return platform_driver_register(&twl4030_vibra_driver);
+}
+module_init(twl4030_vibra_init);
+
+static void __exit twl4030_vibra_exit(void)
+{
+	platform_driver_unregister(&twl4030_vibra_driver);
+}
+module_exit(twl4030_vibra_exit);
+
+MODULE_ALIAS("platform:twl4030_codec_vibra");
+
+MODULE_DESCRIPTION("TWL4030 Vibra driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nokia Corporation");
-- 
1.6.3.3

