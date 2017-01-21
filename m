From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 13/13] Input: misc - drop empty remove functions
Date: Sat, 21 Jan 2017 10:46:05 -0800
Message-ID: <1485024365-3368-14-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51585 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdAUStK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 13:49:10 -0500
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-arm-kernel@lists.infradead.org, usrp-users@lists.ettus.com

Empty remove functions don't serve a useful purpose and can be removed.

Changes were made using the following coccinelle script.

@remove@
identifier p, removefn;
@@

  struct platform_driver p = {
    .remove = \(__exit_p(removefn)\|removefn\),
  };

@rrem depends on remove@
identifier remove.removefn;
@@

- removefn(...) {
- return 0;
- }

@depends on rrem@
identifier remove.p, remove.removefn;
@@

struct platform_driver p = {
- .remove = \(__exit_p(removefn)\|removefn\),
};

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/e3x0-button.c     | 6 ------
 drivers/input/misc/hisi_powerkey.c   | 6 ------
 drivers/input/misc/pmic8xxx-pwrkey.c | 6 ------
 drivers/input/misc/retu-pwrbutton.c  | 6 ------
 drivers/input/misc/sirfsoc-onkey.c   | 6 ------
 5 files changed, 30 deletions(-)

diff --git a/drivers/input/misc/e3x0-button.c b/drivers/input/misc/e3x0-button.c
index 1e50314db1ab..e956cf1d273f 100644
--- a/drivers/input/misc/e3x0-button.c
+++ b/drivers/input/misc/e3x0-button.c
@@ -124,11 +124,6 @@ static int e3x0_button_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int e3x0_button_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id e3x0_button_match[] = {
 	{ .compatible = "ettus,e3x0-button", },
@@ -144,7 +139,6 @@ static struct platform_driver e3x0_button_driver = {
 		.pm	= &e3x0_button_pm_ops,
 	},
 	.probe		= e3x0_button_probe,
-	.remove		= e3x0_button_remove,
 };
 
 module_platform_driver(e3x0_button_driver);
diff --git a/drivers/input/misc/hisi_powerkey.c b/drivers/input/misc/hisi_powerkey.c
index baa81dccfc1f..dee6245f38d7 100644
--- a/drivers/input/misc/hisi_powerkey.c
+++ b/drivers/input/misc/hisi_powerkey.c
@@ -120,17 +120,11 @@ static int hi65xx_powerkey_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi65xx_powerkey_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver hi65xx_powerkey_driver = {
 	.driver = {
 		.name = "hi65xx-powerkey",
 	},
 	.probe = hi65xx_powerkey_probe,
-	.remove  = hi65xx_powerkey_remove,
 };
 module_platform_driver(hi65xx_powerkey_driver);
 
diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index c75be2dd00e7..73323b0c72c1 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -438,11 +438,6 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pmic8xxx_pwrkey_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static const struct of_device_id pm8xxx_pwr_key_id_table[] = {
 	{ .compatible = "qcom,pm8058-pwrkey", .data = &pm8058_pwrkey_shutdown },
 	{ .compatible = "qcom,pm8921-pwrkey", .data = &pm8921_pwrkey_shutdown },
@@ -452,7 +447,6 @@ MODULE_DEVICE_TABLE(of, pm8xxx_pwr_key_id_table);
 
 static struct platform_driver pmic8xxx_pwrkey_driver = {
 	.probe		= pmic8xxx_pwrkey_probe,
-	.remove		= pmic8xxx_pwrkey_remove,
 	.shutdown	= pmic8xxx_pwrkey_shutdown,
 	.driver		= {
 		.name	= "pm8xxx-pwrkey",
diff --git a/drivers/input/misc/retu-pwrbutton.c b/drivers/input/misc/retu-pwrbutton.c
index 30b459b6b344..64023ac08e2b 100644
--- a/drivers/input/misc/retu-pwrbutton.c
+++ b/drivers/input/misc/retu-pwrbutton.c
@@ -76,14 +76,8 @@ static int retu_pwrbutton_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int retu_pwrbutton_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver retu_pwrbutton_driver = {
 	.probe		= retu_pwrbutton_probe,
-	.remove		= retu_pwrbutton_remove,
 	.driver		= {
 		.name	= "retu-pwrbutton",
 	},
diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index a2ed0e4fcd0b..4fd038d476a3 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -172,11 +172,6 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sirfsoc_pwrc_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static int __maybe_unused sirfsoc_pwrc_resume(struct device *dev)
 {
 	struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(dev);
@@ -198,7 +193,6 @@ static SIMPLE_DEV_PM_OPS(sirfsoc_pwrc_pm_ops, NULL, sirfsoc_pwrc_resume);
 
 static struct platform_driver sirfsoc_pwrc_driver = {
 	.probe		= sirfsoc_pwrc_probe,
-	.remove		= sirfsoc_pwrc_remove,
 	.driver		= {
 		.name	= "sirfsoc-pwrc",
 		.pm	= &sirfsoc_pwrc_pm_ops,
-- 
2.7.4

