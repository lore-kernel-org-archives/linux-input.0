From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 2/2] Input: pm8941-pwrkey: Introduce reboot mode support
Date: Fri, 26 May 2017 23:51:30 -0700
Message-ID: <20170527065130.3456-2-bjorn.andersson@linaro.org>
References: <20170527065130.3456-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170527065130.3456-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In some Qualcomm platforms the magic for informing LK which mode to
reboot into is stored in the PON_SOFT_RB_SPARE register. Register with
the reboot mode helpers to expose this to the user.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/input/misc/Kconfig         |  1 +
 drivers/input/misc/pm8941-pwrkey.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 3872488c3fd7..56552e16fab1 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -132,6 +132,7 @@ config INPUT_PCSPKR
 config INPUT_PM8941_PWRKEY
 	tristate "Qualcomm PM8941 power key support"
 	depends on MFD_SPMI_PMIC
+	select REBOOT_MODE
 	help
 	  Say Y here if you want support for the power key usually found
 	  on boards using a Qualcomm PM8941 compatible PMIC.
diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 18ad956454f1..c48be6dbaa78 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
+#include <linux/reboot-mode.h>
 #include <linux/regmap.h>
 
 #define PON_REV2			0x01
@@ -42,6 +43,7 @@
 #define PON_DBC_CTL			0x71
 #define  PON_DBC_DELAY_MASK		0x7
 
+#define PON_SOFT_RB_SPARE		0x8f
 
 struct pm8941_pwrkey {
 	struct device *dev;
@@ -52,8 +54,26 @@ struct pm8941_pwrkey {
 
 	unsigned int revision;
 	struct notifier_block reboot_notifier;
+
+	struct reboot_mode_driver reboot_mode;
 };
 
+static int pm8941_reboot_mode_write(struct reboot_mode_driver *reboot,
+				    unsigned int magic)
+{
+	struct pm8941_pwrkey *pwrkey = container_of(reboot, struct pm8941_pwrkey,
+						    reboot_mode);
+	int ret;
+
+	ret = regmap_update_bits(pwrkey->regmap,
+				 pwrkey->baseaddr + PON_SOFT_RB_SPARE,
+				 0xfc, magic << 2);
+	if (ret < 0)
+		dev_err(pwrkey->dev, "update reboot mode bits failed\n");
+
+	return ret;
+}
+
 static int pm8941_reboot_notify(struct notifier_block *nb,
 				unsigned long code, void *unused)
 {
@@ -256,6 +276,14 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	pwrkey->reboot_mode.dev = &pdev->dev;
+	pwrkey->reboot_mode.write = pm8941_reboot_mode_write;
+	error = devm_reboot_mode_register(&pdev->dev, &pwrkey->reboot_mode);
+	if (error) {
+		dev_err(&pdev->dev, "can't register reboot mode\n");
+		return error;
+	}
+
 	platform_set_drvdata(pdev, pwrkey);
 	device_init_wakeup(&pdev->dev, 1);
 
-- 
2.12.0
