From: Mark Brown <broonie@kernel.org>
Subject: Applied "Input: wm97xx: add new AC97 bus support" to
	the asoc tree
Date: Tue, 19 Sep 2017 17:11:15 +0100
Message-ID: <E1duL7D-0004kS-M6@debutante>
References: <1477510907-23495-10-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1477510907-23495-10-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-input@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org

The patch

   Input: wm97xx: add new AC97 bus support

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ae9d1b5fbd7b7ee1c2d2f62a7cee3c0455e06f94 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Wed, 13 Sep 2017 21:37:18 +0200
Subject: [PATCH] Input: wm97xx: add new AC97 bus support

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/input/touchscreen/Kconfig       |  2 +-
 drivers/input/touchscreen/wm97xx-core.c | 56 ++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 64b30fe273fd..176b1a74b2b7 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -727,7 +727,7 @@ config TOUCHSCREEN_WM831X
 
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
2.14.1
