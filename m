From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V3 2/3] onkey: da9063: Add DA9062 OnKey capability to DA9063
 OnKey driver
Date: Thu, 23 Jul 2015 17:17:41 +0100
Message-ID: <f19a7c030420b70c08bf7c20be043383558a91cf.1437668261.git.stwiss.opensource@diasemi.com>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.148]:48330 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753752AbbGWQXt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 12:23:49 -0400
In-Reply-To: <cover.1437668261.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, S Twiss <stwiss.opensource@diasemi.com>
Cc: David Dajun Chen <david.chen@diasemi.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>

From: S Twiss <stwiss.opensource@diasemi.com>

Add DA9062 OnKey support into the existing DA9063 OnKey driver component by
using generic access tables for common register and bit mask definitions.

The following change will add generic register and bit mask support to the
DA9063 OnKey.

The following alterations have been made to the DA9063 OnKey:

- Addition of a da906x_chip_config structure to hold all
  generic registers and bitmasks for this type of OnKey component.
- Addition of an struct of_device_id table for DA9063 and DA9062
  defaults
- Refactoring functions to use struct da9063_onkey accesses to generic
  registers/masks instead of using defines from registers.h
- Re-work of da9063_onkey_probe() to use of_match_node() and
  dev_get_regmap() to provide initialisation of generic registers and
  masks and access to regmap

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Changes in V3:
 - No change
Changes in V2:
 - Altered Kconfig to use the line "Dialog DA9062/63 OnKey"
 - Rename of da9063_compatible_onkey_regmap to da906x_chip_config
 - char *name changed to const char *name
 - Rename struct da9063_compatible_onkey {} back to struct da9063_onkey

This patch applies against linux-next and next-20150708 


 drivers/input/misc/Kconfig        |   8 +--
 drivers/input/misc/da9063_onkey.c | 129 ++++++++++++++++++++++++++++++--------
 2 files changed, 108 insertions(+), 29 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index d4f0a81..2610cfa 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -611,11 +611,11 @@ config INPUT_DA9055_ONKEY
 	  will be called da9055_onkey.
 
 config INPUT_DA9063_ONKEY
-	tristate "Dialog DA9063 OnKey"
-	depends on MFD_DA9063
+	tristate "Dialog DA9062/63 OnKey"
+	depends on MFD_DA9063 || MFD_DA9062
 	help
-	  Support the ONKEY of Dialog DA9063 Power Management IC as an
-	  input device reporting power button statue.
+	  Support the ONKEY of Dialog DA9063 and DA9062 Power Management ICs
+	  as an input device capable for reporting the power button status.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called da9063_onkey.
diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index f577585..8eb697d 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -1,5 +1,5 @@
 /*
- * OnKey device driver for DA9063
+ * OnKey device driver for DA9063 and DA9062 PMICs
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
  *
  * This program is free software; you can redistribute it and/or
@@ -24,36 +24,96 @@
 #include <linux/mfd/da9063/core.h>
 #include <linux/mfd/da9063/pdata.h>
 #include <linux/mfd/da9063/registers.h>
+#include <linux/mfd/da9062/core.h>
+#include <linux/mfd/da9062/registers.h>
+
+struct da906x_chip_config {
+	/* REGS */
+	int onkey_status;
+	int onkey_pwr_signalling;
+	int onkey_fault_log;
+	int onkey_shutdown;
+	/* MASKS */
+	int onkey_nonkey_mask;
+	int onkey_nonkey_lock_mask;
+	int onkey_key_reset_mask;
+	int onkey_shutdown_mask;
+	/* NAMES */
+	const char *name;
+};
 
 struct da9063_onkey {
-	struct da9063 *hw;
 	struct delayed_work work;
 	struct input_dev *input;
 	struct device *dev;
+	struct regmap *regmap;
+	const struct da906x_chip_config *config;
+	char phys[32];
 	bool key_power;
 };
 
+static const struct da906x_chip_config da9063_regs = {
+	/* REGS */
+	.onkey_status = DA9063_REG_STATUS_A,
+	.onkey_pwr_signalling = DA9063_REG_CONTROL_B,
+	.onkey_fault_log = DA9063_REG_FAULT_LOG,
+	.onkey_shutdown = DA9063_REG_CONTROL_F,
+	/* MASKS */
+	.onkey_nonkey_mask = DA9063_NONKEY,
+	.onkey_nonkey_lock_mask = DA9063_NONKEY_LOCK,
+	.onkey_key_reset_mask = DA9063_KEY_RESET,
+	.onkey_shutdown_mask = DA9063_SHUTDOWN,
+	/* NAMES */
+	.name = DA9063_DRVNAME_ONKEY,
+};
+
+static const struct da906x_chip_config da9062_regs = {
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
+	.name = "da9062-onkey",
+};
+
+static const struct of_device_id da9063_compatible_reg_id_table[] = {
+	{ .compatible = "dlg,da9063-onkey", .data = &da9063_regs },
+	{ .compatible = "dlg,da9062-onkey", .data = &da9062_regs },
+	{ },
+};
+
 static void da9063_poll_on(struct work_struct *work)
 {
-	struct da9063_onkey *onkey = container_of(work, struct da9063_onkey,
-						  work.work);
+	struct da9063_onkey *onkey = container_of(work,
+						struct da9063_onkey,
+						work.work);
+	const struct da906x_chip_config *config = onkey->config;
 	unsigned int val;
 	int fault_log = 0;
 	bool poll = true;
 	int error;
 
 	/* Poll to see when the pin is released */
-	error = regmap_read(onkey->hw->regmap, DA9063_REG_STATUS_A, &val);
+	error = regmap_read(onkey->regmap,
+			    config->onkey_status,
+			    &val);
 	if (error) {
 		dev_err(onkey->dev,
 			"Failed to read ON status: %d\n", error);
 		goto err_poll;
 	}
 
-	if (!(val & DA9063_NONKEY)) {
-		error = regmap_update_bits(onkey->hw->regmap,
-					   DA9063_REG_CONTROL_B,
-					   DA9063_NONKEY_LOCK, 0);
+	if (!(val & config->onkey_nonkey_mask)) {
+		error = regmap_update_bits(onkey->regmap,
+					   config->onkey_pwr_signalling,
+					   config->onkey_nonkey_lock_mask,
+					   0);
 		if (error) {
 			dev_err(onkey->dev,
 				"Failed to reset the Key Delay %d\n", error);
@@ -70,15 +130,16 @@ static void da9063_poll_on(struct work_struct *work)
 	 * If the fault log KEY_RESET is detected, then clear it
 	 * and shut down the system.
 	 */
-	error = regmap_read(onkey->hw->regmap,
-			    DA9063_REG_FAULT_LOG, &fault_log);
+	error = regmap_read(onkey->regmap,
+			    config->onkey_fault_log,
+			    &fault_log);
 	if (error) {
 		dev_warn(&onkey->input->dev,
 			 "Cannot read FAULT_LOG: %d\n", error);
-	} else if (fault_log & DA9063_KEY_RESET) {
-		error = regmap_write(onkey->hw->regmap,
-				     DA9063_REG_FAULT_LOG,
-				     DA9063_KEY_RESET);
+	} else if (fault_log & config->onkey_key_reset_mask) {
+		error = regmap_write(onkey->regmap,
+				     config->onkey_fault_log,
+				     config->onkey_key_reset_mask);
 		if (error) {
 			dev_warn(&onkey->input->dev,
 				 "Cannot reset KEY_RESET fault log: %d\n",
@@ -88,10 +149,10 @@ static void da9063_poll_on(struct work_struct *work)
 			 * and then send shutdown command
 			 */
 			dev_dbg(&onkey->input->dev,
-				 "Sending SHUTDOWN to DA9063 ...\n");
-			error = regmap_write(onkey->hw->regmap,
-					     DA9063_REG_CONTROL_F,
-					     DA9063_SHUTDOWN);
+				"Sending SHUTDOWN to DA9063 ...\n");
+			error = regmap_write(onkey->regmap,
+					     config->onkey_shutdown,
+					     config->onkey_shutdown_mask);
 			if (error)
 				dev_err(&onkey->input->dev,
 					"Cannot SHUTDOWN DA9063: %d\n",
@@ -107,11 +168,14 @@ err_poll:
 static irqreturn_t da9063_onkey_irq_handler(int irq, void *data)
 {
 	struct da9063_onkey *onkey = data;
+	const struct da906x_chip_config *config = onkey->config;
 	unsigned int val;
 	int error;
 
-	error = regmap_read(onkey->hw->regmap, DA9063_REG_STATUS_A, &val);
-	if (onkey->key_power && !error && (val & DA9063_NONKEY)) {
+	error = regmap_read(onkey->regmap,
+			    config->onkey_status,
+			    &val);
+	if (onkey->key_power && !error && (val & config->onkey_nonkey_mask)) {
 		input_report_key(onkey->input, KEY_POWER, 1);
 		input_sync(onkey->input);
 		schedule_delayed_work(&onkey->work, 0);
@@ -139,9 +203,15 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
 	struct da9063_pdata *pdata = dev_get_platdata(da9063->dev);
 	struct da9063_onkey *onkey;
+	const struct of_device_id *match;
 	int irq;
 	int error;
 
+	match = of_match_node(da9063_compatible_reg_id_table,
+			      pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
+
 	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_onkey),
 			     GFP_KERNEL);
 	if (!onkey) {
@@ -149,8 +219,14 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	onkey->config = match->data;
 	onkey->dev = &pdev->dev;
-	onkey->hw = da9063;
+
+	onkey->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!onkey->regmap) {
+		dev_err(&pdev->dev, "Parent regmap unavailable.\n");
+		return -ENXIO;
+	}
 
 	if (pdata)
 		onkey->key_power = pdata->key_power;
@@ -165,8 +241,10 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	onkey->input->name = DA9063_DRVNAME_ONKEY;
-	onkey->input->phys = DA9063_DRVNAME_ONKEY "/input0";
+	onkey->input->name = onkey->config->name;
+	snprintf(onkey->phys, sizeof(onkey->phys), "%s/input0",
+		 onkey->config->name);
+	onkey->input->phys = onkey->phys;
 	onkey->input->dev.parent = &pdev->dev;
 
 	if (onkey->key_power)
@@ -216,11 +294,12 @@ static struct platform_driver da9063_onkey_driver = {
 	.probe	= da9063_onkey_probe,
 	.driver	= {
 		.name	= DA9063_DRVNAME_ONKEY,
+		.of_match_table = da9063_compatible_reg_id_table,
 	},
 };
 module_platform_driver(da9063_onkey_driver);
 
 MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
-MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063");
+MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063 and DA9062");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DA9063_DRVNAME_ONKEY);
-- 
end-of-patch for PATCH V3

