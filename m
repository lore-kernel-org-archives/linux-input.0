From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 6/6] Input: pm8xxx-vib: add support for pm8916's vibrator
Date: Fri, 31 Mar 2017 12:15:38 -0400
Message-ID: <20170331161538.11657-6-damien.riegel@savoirfairelinux.com>
References: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:36864 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933127AbdCaQQk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 12:16:40 -0400
In-Reply-To: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>

Add pm8xxx_regs for this PMIC and the device tree match table entry.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 drivers/input/misc/Kconfig           |  2 +-
 drivers/input/misc/pm8xxx-vibrator.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 5b6c52210d20..79d0be9885c5 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -143,7 +143,7 @@ config INPUT_PM8941_PWRKEY
 
 config INPUT_PM8XXX_VIBRATOR
 	tristate "Qualcomm PM8XXX vibrator support"
-	depends on MFD_PM8XXX
+	depends on MFD_PM8XXX || MFD_SPMI_PMIC
 	select INPUT_FF_MEMLESS
 	help
 	  This option enables device driver support for the vibrator
diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 803bc75d5531..96d18a300e7a 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -43,6 +43,15 @@ static struct pm8xxx_regs pm8058_regs = {
 	.drv_en_manual_mask = 0xfc,
 };
 
+static struct pm8xxx_regs pm8916_regs = {
+	.enable_addr = 0x46,
+	.enable_mask = BIT(7),
+	.drv_addr = 0x41,
+	.drv_mask = 0x1F,
+	.drv_shift = 0,
+	.drv_en_manual_mask = 0,
+};
+
 /**
  * struct pm8xxx_vib - structure to hold vibrator data
  * @vib_input_dev: input device supporting force feedback
@@ -258,6 +267,7 @@ static SIMPLE_DEV_PM_OPS(pm8xxx_vib_pm_ops, pm8xxx_vib_suspend, NULL);
 static const struct of_device_id pm8xxx_vib_id_table[] = {
 	{ .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
 	{ .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
+	{ .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
-- 
2.12.0

