From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/3] Input: misc - Use __maybe_unused instead of ifdef around
 suspend/resume
Date: Wed, 29 Oct 2014 14:18:28 +0900
Message-ID: <000501cff337$c5f23750$51d6a5f0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:65504 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbaJ2FSR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Oct 2014 01:18:17 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NE600AJNXEA3V70@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Wed, 29 Oct 2014 14:18:10 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use __maybe_unused instead of ifdef guards around suspend/resume
functions, in order to increase build coverage and fix build warnings.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/misc/88pm860x_onkey.c   |    6 ++----
 drivers/input/misc/ad714x-i2c.c       |    6 ++----
 drivers/input/misc/ad714x-spi.c       |    6 ++----
 drivers/input/misc/adxl34x-i2c.c      |    6 ++----
 drivers/input/misc/adxl34x-spi.c      |    6 ++----
 drivers/input/misc/drv260x.c          |    6 ++----
 drivers/input/misc/drv2667.c          |    6 ++----
 drivers/input/misc/gp2ap002a00f.c     |    6 ++----
 drivers/input/misc/kxtj9.c            |    6 ++----
 drivers/input/misc/max77693-haptic.c  |    6 ++----
 drivers/input/misc/max8925_onkey.c    |    6 ++----
 drivers/input/misc/max8997_haptic.c   |    4 +---
 drivers/input/misc/palmas-pwrbutton.c |    6 ++----
 drivers/input/misc/pm8xxx-vibrator.c  |    4 +---
 drivers/input/misc/pmic8xxx-pwrkey.c  |    6 ++----
 drivers/input/misc/pwm-beeper.c       |    6 +++---
 drivers/input/misc/sirfsoc-onkey.c    |    4 +---
 drivers/input/misc/twl4030-vibra.c    |    6 ++----
 drivers/input/misc/twl6040-vibra.c    |    4 +---
 19 files changed, 35 insertions(+), 71 deletions(-)

diff --git a/drivers/input/misc/88pm860x_onkey.c b/drivers/input/misc/88pm860x_onkey.c
index 220ce0f..3cbd1b3 100644
--- a/drivers/input/misc/88pm860x_onkey.c
+++ b/drivers/input/misc/88pm860x_onkey.c
@@ -112,8 +112,7 @@ static int pm860x_onkey_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pm860x_onkey_suspend(struct device *dev)
+static int __maybe_unused pm860x_onkey_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
@@ -122,7 +121,7 @@ static int pm860x_onkey_suspend(struct device *dev)
 		chip->wakeup_flag |= 1 << PM8607_IRQ_ONKEY;
 	return 0;
 }
-static int pm860x_onkey_resume(struct device *dev)
+static int __maybe_unused pm860x_onkey_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
@@ -131,7 +130,6 @@ static int pm860x_onkey_resume(struct device *dev)
 		chip->wakeup_flag &= ~(1 << PM8607_IRQ_ONKEY);
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(pm860x_onkey_pm_ops, pm860x_onkey_suspend, pm860x_onkey_resume);
 
diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index e0f5225..189bdc8 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -13,17 +13,15 @@
 #include <linux/pm.h>
 #include "ad714x.h"
 
-#ifdef CONFIG_PM_SLEEP
-static int ad714x_i2c_suspend(struct device *dev)
+static int __maybe_unused ad714x_i2c_suspend(struct device *dev)
 {
 	return ad714x_disable(i2c_get_clientdata(to_i2c_client(dev)));
 }
 
-static int ad714x_i2c_resume(struct device *dev)
+static int __maybe_unused ad714x_i2c_resume(struct device *dev)
 {
 	return ad714x_enable(i2c_get_clientdata(to_i2c_client(dev)));
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(ad714x_i2c_pm, ad714x_i2c_suspend, ad714x_i2c_resume);
 
diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index 3a90b71..a79e50b 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -16,17 +16,15 @@
 #define AD714x_SPI_CMD_PREFIX      0xE000   /* bits 15:11 */
 #define AD714x_SPI_READ            BIT(10)
 
-#ifdef CONFIG_PM_SLEEP
-static int ad714x_spi_suspend(struct device *dev)
+static int __maybe_unused ad714x_spi_suspend(struct device *dev)
 {
 	return ad714x_disable(spi_get_drvdata(to_spi_device(dev)));
 }
 
-static int ad714x_spi_resume(struct device *dev)
+static int __maybe_unused ad714x_spi_resume(struct device *dev)
 {
 	return ad714x_enable(spi_get_drvdata(to_spi_device(dev)));
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(ad714x_spi_pm, ad714x_spi_suspend, ad714x_spi_resume);
 
diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index 416f47d..470bfd6 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -105,8 +105,7 @@ static int adxl34x_i2c_remove(struct i2c_client *client)
 	return adxl34x_remove(ac);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int adxl34x_i2c_suspend(struct device *dev)
+static int __maybe_unused adxl34x_i2c_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adxl34x *ac = i2c_get_clientdata(client);
@@ -116,7 +115,7 @@ static int adxl34x_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int adxl34x_i2c_resume(struct device *dev)
+static int __maybe_unused adxl34x_i2c_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adxl34x *ac = i2c_get_clientdata(client);
@@ -125,7 +124,6 @@ static int adxl34x_i2c_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(adxl34x_i2c_pm, adxl34x_i2c_suspend,
 			 adxl34x_i2c_resume);
diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
index 76dc067..da6e76b 100644
--- a/drivers/input/misc/adxl34x-spi.c
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -94,8 +94,7 @@ static int adxl34x_spi_remove(struct spi_device *spi)
 	return adxl34x_remove(ac);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int adxl34x_spi_suspend(struct device *dev)
+static int __maybe_unused adxl34x_spi_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct adxl34x *ac = spi_get_drvdata(spi);
@@ -105,7 +104,7 @@ static int adxl34x_spi_suspend(struct device *dev)
 	return 0;
 }
 
-static int adxl34x_spi_resume(struct device *dev)
+static int __maybe_unused adxl34x_spi_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct adxl34x *ac = spi_get_drvdata(spi);
@@ -114,7 +113,6 @@ static int adxl34x_spi_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(adxl34x_spi_pm, adxl34x_spi_suspend,
 			 adxl34x_spi_resume);
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index cab87f5..a364e10 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -639,8 +639,7 @@ static int drv260x_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int drv260x_suspend(struct device *dev)
+static int __maybe_unused drv260x_suspend(struct device *dev)
 {
 	struct drv260x_data *haptics = dev_get_drvdata(dev);
 	int ret = 0;
@@ -672,7 +671,7 @@ out:
 	return ret;
 }
 
-static int drv260x_resume(struct device *dev)
+static int __maybe_unused drv260x_resume(struct device *dev)
 {
 	struct drv260x_data *haptics = dev_get_drvdata(dev);
 	int ret = 0;
@@ -702,7 +701,6 @@ out:
 	mutex_unlock(&haptics->input_dev->mutex);
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(drv260x_pm_ops, drv260x_suspend, drv260x_resume);
 
diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
index 0f43758..a021744 100644
--- a/drivers/input/misc/drv2667.c
+++ b/drivers/input/misc/drv2667.c
@@ -406,8 +406,7 @@ static int drv2667_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int drv2667_suspend(struct device *dev)
+static int __maybe_unused drv2667_suspend(struct device *dev)
 {
 	struct drv2667_data *haptics = dev_get_drvdata(dev);
 	int ret = 0;
@@ -436,7 +435,7 @@ out:
 	return ret;
 }
 
-static int drv2667_resume(struct device *dev)
+static int __maybe_unused drv2667_resume(struct device *dev)
 {
 	struct drv2667_data *haptics = dev_get_drvdata(dev);
 	int ret = 0;
@@ -464,7 +463,6 @@ out:
 	mutex_unlock(&haptics->input_dev->mutex);
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(drv2667_pm_ops, drv2667_suspend, drv2667_resume);
 
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index de21e31..0ac176d 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -225,8 +225,7 @@ static int gp2a_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int gp2a_suspend(struct device *dev)
+static int __maybe_unused gp2a_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gp2a_data *dt = i2c_get_clientdata(client);
@@ -244,7 +243,7 @@ static int gp2a_suspend(struct device *dev)
 	return retval;
 }
 
-static int gp2a_resume(struct device *dev)
+static int __maybe_unused gp2a_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gp2a_data *dt = i2c_get_clientdata(client);
@@ -261,7 +260,6 @@ static int gp2a_resume(struct device *dev)
 
 	return retval;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(gp2a_pm, gp2a_suspend, gp2a_resume);
 
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index d708478..6e29349 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -615,8 +615,7 @@ static int kxtj9_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int kxtj9_suspend(struct device *dev)
+static int __maybe_unused kxtj9_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct kxtj9_data *tj9 = i2c_get_clientdata(client);
@@ -631,7 +630,7 @@ static int kxtj9_suspend(struct device *dev)
 	return 0;
 }
 
-static int kxtj9_resume(struct device *dev)
+static int __maybe_unused kxtj9_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct kxtj9_data *tj9 = i2c_get_clientdata(client);
@@ -646,7 +645,6 @@ static int kxtj9_resume(struct device *dev)
 	mutex_unlock(&input_dev->mutex);
 	return retval;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(kxtj9_pm_ops, kxtj9_suspend, kxtj9_resume);
 
diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 7b1fde9..1b12d77 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -310,8 +310,7 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int max77693_haptic_suspend(struct device *dev)
+static int __maybe_unused max77693_haptic_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct max77693_haptic *haptic = platform_get_drvdata(pdev);
@@ -324,7 +323,7 @@ static int max77693_haptic_suspend(struct device *dev)
 	return 0;
 }
 
-static int max77693_haptic_resume(struct device *dev)
+static int __maybe_unused max77693_haptic_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct max77693_haptic *haptic = platform_get_drvdata(pdev);
@@ -336,7 +335,6 @@ static int max77693_haptic_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(max77693_haptic_pm_ops,
 			 max77693_haptic_suspend, max77693_haptic_resume);
diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc/max8925_onkey.c
index 3809618..11d0d37 100644
--- a/drivers/input/misc/max8925_onkey.c
+++ b/drivers/input/misc/max8925_onkey.c
@@ -133,8 +133,7 @@ static int max8925_onkey_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int max8925_onkey_suspend(struct device *dev)
+static int __maybe_unused max8925_onkey_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct max8925_onkey_info *info = platform_get_drvdata(pdev);
@@ -148,7 +147,7 @@ static int max8925_onkey_suspend(struct device *dev)
 	return 0;
 }
 
-static int max8925_onkey_resume(struct device *dev)
+static int __maybe_unused max8925_onkey_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct max8925_onkey_info *info = platform_get_drvdata(pdev);
@@ -161,7 +160,6 @@ static int max8925_onkey_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(max8925_onkey_pm_ops, max8925_onkey_suspend, max8925_onkey_resume);
 
diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index a363ebb..980437a 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -378,8 +378,7 @@ static int max8997_haptic_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int max8997_haptic_suspend(struct device *dev)
+static int __maybe_unused max8997_haptic_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct max8997_haptic *chip = platform_get_drvdata(pdev);
@@ -388,7 +387,6 @@ static int max8997_haptic_suspend(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(max8997_haptic_pm_ops, max8997_haptic_suspend, NULL);
 
diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index f505ac3..2c4d6ca 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -260,7 +260,6 @@ static int palmas_pwron_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 /**
  * palmas_pwron_suspend() - suspend handler
  * @dev:	power button device
@@ -269,7 +268,7 @@ static int palmas_pwron_remove(struct platform_device *pdev)
  *
  * Return: 0
  */
-static int palmas_pwron_suspend(struct device *dev)
+static int __maybe_unused palmas_pwron_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct palmas_pwron *pwron = platform_get_drvdata(pdev);
@@ -290,7 +289,7 @@ static int palmas_pwron_suspend(struct device *dev)
  *
  * Return: 0
  */
-static int palmas_pwron_resume(struct device *dev)
+static int __maybe_unused palmas_pwron_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct palmas_pwron *pwron = platform_get_drvdata(pdev);
@@ -300,7 +299,6 @@ static int palmas_pwron_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(palmas_pwron_pm,
 			 palmas_pwron_suspend, palmas_pwron_resume);
diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 6a915ba..e5266cd 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -199,8 +199,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pm8xxx_vib_suspend(struct device *dev)
+static int __maybe_unused pm8xxx_vib_suspend(struct device *dev)
 {
 	struct pm8xxx_vib *vib = dev_get_drvdata(dev);
 
@@ -209,7 +208,6 @@ static int pm8xxx_vib_suspend(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(pm8xxx_vib_pm_ops, pm8xxx_vib_suspend, NULL);
 
diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index c91e3d3..2899945 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -53,8 +53,7 @@ static irqreturn_t pwrkey_release_irq(int irq, void *_pwr)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pmic8xxx_pwrkey_suspend(struct device *dev)
+static int __maybe_unused pmic8xxx_pwrkey_suspend(struct device *dev)
 {
 	struct pmic8xxx_pwrkey *pwrkey = dev_get_drvdata(dev);
 
@@ -64,7 +63,7 @@ static int pmic8xxx_pwrkey_suspend(struct device *dev)
 	return 0;
 }
 
-static int pmic8xxx_pwrkey_resume(struct device *dev)
+static int __maybe_unused pmic8xxx_pwrkey_resume(struct device *dev)
 {
 	struct pmic8xxx_pwrkey *pwrkey = dev_get_drvdata(dev);
 
@@ -73,7 +72,6 @@ static int pmic8xxx_pwrkey_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(pm8xxx_pwr_key_pm_ops,
 		pmic8xxx_pwrkey_suspend, pmic8xxx_pwrkey_resume);
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 8ef288e..93f640a 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -144,8 +144,7 @@ static int pwm_beeper_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pwm_beeper_suspend(struct device *dev)
+static int __maybe_unused pwm_beeper_suspend(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
@@ -155,7 +154,7 @@ static int pwm_beeper_suspend(struct device *dev)
 	return 0;
 }
 
-static int pwm_beeper_resume(struct device *dev)
+static int __maybe_unused pwm_beeper_resume(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
@@ -170,6 +169,7 @@ static int pwm_beeper_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(pwm_beeper_pm_ops,
 			 pwm_beeper_suspend, pwm_beeper_resume);
 
+#ifdef CONFIG_PM_SLEEP
 #define PWM_BEEPER_PM_OPS (&pwm_beeper_pm_ops)
 #else
 #define PWM_BEEPER_PM_OPS NULL
diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index fed5102..151f169 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -179,8 +179,7 @@ static int sirfsoc_pwrc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sirfsoc_pwrc_resume(struct device *dev)
+static int __maybe_unused sirfsoc_pwrc_resume(struct device *dev)
 {
 	struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(dev);
 	struct input_dev *input = pwrcdrv->input;
@@ -196,7 +195,6 @@ static int sirfsoc_pwrc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(sirfsoc_pwrc_pm_ops, NULL, sirfsoc_pwrc_resume);
 
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 960ef2a..c802c4a 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -157,8 +157,7 @@ static void twl4030_vibra_close(struct input_dev *input)
 }
 
 /*** Module ***/
-#ifdef CONFIG_PM_SLEEP
-static int twl4030_vibra_suspend(struct device *dev)
+static int __maybe_unused twl4030_vibra_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct vibra_info *info = platform_get_drvdata(pdev);
@@ -169,12 +168,11 @@ static int twl4030_vibra_suspend(struct device *dev)
 	return 0;
 }
 
-static int twl4030_vibra_resume(struct device *dev)
+static int __maybe_unused twl4030_vibra_resume(struct device *dev)
 {
 	vibra_disable_leds();
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(twl4030_vibra_pm_ops,
 			 twl4030_vibra_suspend, twl4030_vibra_resume);
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 6d26eec..190fdef 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -236,8 +236,7 @@ static void twl6040_vibra_close(struct input_dev *input)
 	mutex_unlock(&info->mutex);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int twl6040_vibra_suspend(struct device *dev)
+static int __maybe_unused twl6040_vibra_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct vibra_info *info = platform_get_drvdata(pdev);
@@ -251,7 +250,6 @@ static int twl6040_vibra_suspend(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(twl6040_vibra_pm_ops, twl6040_vibra_suspend, NULL);
 
-- 
1.7.9.5


