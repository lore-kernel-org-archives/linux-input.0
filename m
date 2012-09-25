From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] input: pwm-beeper: Add devicetree probing support
Date: Tue, 25 Sep 2012 09:15:51 +0200
Message-ID: <1348557351-12599-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45868 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab2IYHP5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Sep 2012 03:15:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Thierry Reding <thierry.reding@avionic-design.de>, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>

A very simple binding, the only property is the phandle to the PWM.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

changes since v1:

- first use new pwm API, if that fails, use legacy API
- add 'depends on PWM'

 Documentation/devicetree/bindings/input/pwm-beeper.txt |    7 +++++++
 drivers/input/misc/Kconfig                             |    2 +-
 drivers/input/misc/pwm-beeper.c                        |   12 +++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
new file mode 100644
index 0000000..7388b82
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
@@ -0,0 +1,7 @@
+* PWM beeper device tree bindings
+
+Registers a PWM device as beeper.
+
+Required properties:
+- compatible: should be "pwm-beeper"
+- pwms: phandle to the physical pwm device
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7c0f1ec..ff5dbd6 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -444,7 +444,7 @@ config INPUT_PCF8574
 
 config INPUT_PWM_BEEPER
 	tristate "PWM beeper support"
-	depends on HAVE_PWM
+	depends on HAVE_PWM || PWM
 	help
 	  Say Y here to get support for PWM based beeper devices.
 
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index fc84c8a..dfb3c50 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -75,7 +75,11 @@ static int __devinit pwm_beeper_probe(struct platform_device *pdev)
 	if (!beeper)
 		return -ENOMEM;
 
-	beeper->pwm = pwm_request(pwm_id, "pwm beeper");
+	beeper->pwm = pwm_get(&pdev->dev, NULL);
+	if (IS_ERR(beeper->pwm)) {
+		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
+		beeper->pwm = pwm_request(pwm_id, "pwm beeper");
+	}
 
 	if (IS_ERR(beeper->pwm)) {
 		error = PTR_ERR(beeper->pwm);
@@ -171,6 +175,11 @@ static SIMPLE_DEV_PM_OPS(pwm_beeper_pm_ops,
 #define PWM_BEEPER_PM_OPS NULL
 #endif
 
+static const struct of_device_id pwm_beeper_match[] = {
+	{ .compatible = "pwm-beeper", },
+	{ },
+};
+
 static struct platform_driver pwm_beeper_driver = {
 	.probe	= pwm_beeper_probe,
 	.remove = __devexit_p(pwm_beeper_remove),
@@ -178,6 +187,7 @@ static struct platform_driver pwm_beeper_driver = {
 		.name	= "pwm-beeper",
 		.owner	= THIS_MODULE,
 		.pm	= PWM_BEEPER_PM_OPS,
+		.of_match_table = pwm_beeper_match,
 	},
 };
 module_platform_driver(pwm_beeper_driver);
-- 
1.7.10.4

