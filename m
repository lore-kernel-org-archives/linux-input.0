From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V1 03/10] Input: da9061: onkey driver
Date: Thu, 6 Oct 2016 09:43:30 +0100
Message-ID: <56f388c16fa95da1b211a2980cfc2add736b5f46.1475743411.git.stwiss.opensource@diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1475743411.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Support for the DA9061 onkey is added into the DA9063 onkey driver.

The of_device_id match array is expanded to support "dlg,da9061-onkey" as a
valid .compatible string. A new chip configuration register map listed in
da9061_regs is added and linked to this device tree compatible string in
the .data section.

Copyright header is updated to add DA9061 in its description and the module
description macro is extended to include DA9061.

Kconfig is updated to reflect support for DA9061/62/63.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

Dmitry,

The DA9063 onkey driver is modified to support the DA9061 onkey.
Because of earlier work with DA9062 it is a simple matter to extend this
for DA9061 by adding a new compatible string and register mapping.
  { .compatible = "dlg,da9061-onkey", .data = &da9061_regs },

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 drivers/input/misc/Kconfig        |  7 ++++---
 drivers/input/misc/da9063_onkey.c | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index efb0ca8..57cc9c2 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -613,11 +613,12 @@ config INPUT_DA9055_ONKEY
 	  will be called da9055_onkey.
 
 config INPUT_DA9063_ONKEY
-	tristate "Dialog DA9062/63 OnKey"
+	tristate "Dialog DA9063/62/61 OnKey"
 	depends on MFD_DA9063 || MFD_DA9062
 	help
-	  Support the ONKEY of Dialog DA9063 and DA9062 Power Management ICs
-	  as an input device capable of reporting the power button status.
+	  Support the ONKEY of Dialog DA9063, DA9062 and DA9061 Power
+	  Management ICs as an input device capable of reporting the
+	  power button status.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called da9063_onkey.
diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index bb863e0..60c29cd 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -1,5 +1,5 @@
 /*
- * OnKey device driver for DA9063 and DA9062 PMICs
+ * OnKey device driver for DA9063, DA9062 and DA9061 PMICs
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
  *
  * This program is free software; you can redistribute it and/or
@@ -82,9 +82,25 @@ static const struct da906x_chip_config da9062_regs = {
 	.name = "da9062-onkey",
 };
 
+static const struct da906x_chip_config da9061_regs = {
+	/* REGS */
+	.onkey_status = DA9062AA_STATUS_A,
+	.onkey_pwr_signalling = DA9062AA_CONTROL_B,
+	.onkey_fault_log = DA9062AA_FAULT_LOG,
+	.onkey_shutdown = DA9062AA_CONTROL_F,
+	/* MASKS */
+	.onkey_nonkey_mask = DA9062AA_NONKEY_MASK,
+	.onkey_nonkey_lock_mask = DA9062AA_NONKEY_LOCK_MASK,
+	.onkey_key_reset_mask = DA9062AA_KEY_RESET_MASK,
+	.onkey_shutdown_mask = DA9062AA_SHUTDOWN_MASK,
+	/* NAMES */
+	.name = "da9061-onkey",
+};
+
 static const struct of_device_id da9063_compatible_reg_id_table[] = {
 	{ .compatible = "dlg,da9063-onkey", .data = &da9063_regs },
 	{ .compatible = "dlg,da9062-onkey", .data = &da9062_regs },
+	{ .compatible = "dlg,da9061-onkey", .data = &da9061_regs },
 	{ },
 };
 
@@ -149,13 +165,13 @@ static void da9063_poll_on(struct work_struct *work)
 			 * and then send shutdown command
 			 */
 			dev_dbg(&onkey->input->dev,
-				"Sending SHUTDOWN to DA9063 ...\n");
+				"Sending SHUTDOWN to PMIC ...\n");
 			error = regmap_write(onkey->regmap,
 					     config->onkey_shutdown,
 					     config->onkey_shutdown_mask);
 			if (error)
 				dev_err(&onkey->input->dev,
-					"Cannot SHUTDOWN DA9063: %d\n",
+					"Cannot SHUTDOWN PMIC: %d\n",
 					error);
 		}
 	}
@@ -300,6 +316,6 @@ static struct platform_driver da9063_onkey_driver = {
 module_platform_driver(da9063_onkey_driver);
 
 MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
-MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063 and DA9062");
+MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063, DA9062 and DA9061");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DA9063_DRVNAME_ONKEY);
-- 
end-of-patch for PATCH V1
