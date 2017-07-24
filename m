From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v4 07/12] Input: wm97xx: add new AC97 bus support
Date: Mon, 24 Jul 2017 22:49:23 +0200
Message-ID: <20170724204928.29505-8-robert.jarzmik@free.fr>
References: <20170724204928.29505-1-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:37719 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755921AbdGXUuK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 16:50:10 -0400
In-Reply-To: <20170724204928.29505-1-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

This adds support for the new AC97 bus code, which discovers the devices
rather than uses platform data.

As part of this discovery, it enables a multi-function device wm97xx,
which supports touchscreen, battery, ADC and an audio codec. This patch
adds the code to bind the touchscreen "cell" as the touchscreen driver.

This was tested on the pxa architecture with a pxa270 + wm9713 + the
mioa701 touchscreen.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig       |  2 +-
 drivers/input/touchscreen/wm97xx-core.c | 56 ++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 033599777651..22257f3e1059 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -725,7 +725,7 @@ config TOUCHSCREEN_WM831X
 
 config TOUCHSCREEN_WM97XX
 	tristate "Support for WM97xx AC97 touchscreen controllers"
-	depends on AC97_BUS
+	depends on AC97_BUS || AC97_BUS_NEW
 	help
 	  Say Y here if you have a Wolfson Microelectronics WM97xx
 	  touchscreen connected to your system. Note that this option
diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 39869ffdc4fa..fd714ee881f7 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -44,6 +44,7 @@
 #include <linux/pm.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
+#include <linux/mfd/wm97xx.h>
 #include <linux/workqueue.h>
 #include <linux/wm97xx.h>
 #include <linux/uaccess.h>
@@ -766,6 +767,39 @@ static int wm97xx_remove(struct device *dev)
 	return 0;
 }
 
+static int wm97xx_mfd_probe(struct platform_device *pdev)
+{
+	struct wm97xx *wm;
+	struct wm97xx_platform_data *mfd_pdata = dev_get_platdata(&pdev->dev);
+	int ret;
+
+	wm = devm_kzalloc(&pdev->dev, sizeof(struct wm97xx), GFP_KERNEL);
+	if (!wm)
+		return -ENOMEM;
+
+	wm->dev = &pdev->dev;
+	wm->ac97 = mfd_pdata->ac97;
+
+	ret =  _wm97xx_probe(wm);
+	if (ret)
+		return ret;
+
+	ret = wm97xx_add_battery(wm, mfd_pdata->batt_pdata);
+	if (ret < 0)
+		goto batt_err;
+
+	return ret;
+
+batt_err:
+	wm97xx_unregister_touch(wm);
+	return ret;
+}
+
+static int wm97xx_mfd_remove(struct platform_device *pdev)
+{
+	return wm97xx_remove(&pdev->dev);
+}
+
 static int __maybe_unused wm97xx_suspend(struct device *dev)
 {
 	struct wm97xx *wm = dev_get_drvdata(dev);
@@ -862,21 +896,41 @@ EXPORT_SYMBOL_GPL(wm97xx_unregister_mach_ops);
 
 static struct device_driver wm97xx_driver = {
 	.name =		"wm97xx-ts",
+#ifdef CONFIG_AC97_BUS
 	.bus =		&ac97_bus_type,
+#endif
 	.owner =	THIS_MODULE,
 	.probe =	wm97xx_probe,
 	.remove =	wm97xx_remove,
 	.pm =		&wm97xx_pm_ops,
 };
 
+static struct platform_driver wm97xx_mfd_driver = {
+	.driver = {
+		.name =		"wm97xx-ts",
+		.pm =		&wm97xx_pm_ops,
+	},
+	.probe =	wm97xx_mfd_probe,
+	.remove =	wm97xx_mfd_remove,
+};
+
 static int __init wm97xx_init(void)
 {
-	return driver_register(&wm97xx_driver);
+	int ret;
+
+	ret = platform_driver_register(&wm97xx_mfd_driver);
+	if (ret)
+		return ret;
+
+	if (IS_BUILTIN(CONFIG_AC97_BUS))
+		ret =  driver_register(&wm97xx_driver);
+	return ret;
 }
 
 static void __exit wm97xx_exit(void)
 {
 	driver_unregister(&wm97xx_driver);
+	platform_driver_unregister(&wm97xx_mfd_driver);
 }
 
 module_init(wm97xx_init);
-- 
2.11.0

