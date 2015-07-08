From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH v3 4/9] extcon/input/mfd/power/regulator: max77693: Move state container to common header
Date: Wed,  8 Jul 2015 20:00:12 +0900
Message-ID: <1436353217-1141-5-git-send-email-k.kozlowski.k@gmail.com>
References: <1436353217-1141-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436353217-1141-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

This prepares for merging some of the drivers between max77693 and
max77843 so the child MFD driver can be attached to any parent MFD main
driver.

Move the state container to common header file. Additionally add
consistent 'i2c' prefixes to its members (of 'struct i2c_client' type).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-max77693.c     |  3 ++-
 drivers/input/misc/max77693-haptic.c |  1 +
 drivers/mfd/max77693.c               | 31 +++++++++++++------------
 drivers/power/max77693_charger.c     |  1 +
 drivers/regulator/max77693.c         |  1 +
 include/linux/mfd/max77693-common.h  | 44 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77693-private.h | 25 --------------------
 7 files changed, 65 insertions(+), 41 deletions(-)
 create mode 100644 include/linux/mfd/max77693-common.h

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 770db3a72a6a..08391b5c8e8f 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/mfd/max77693-common.h>
 #include <linux/extcon.h>
 #include <linux/regmap.h>
 #include <linux/irqdomain.h>
@@ -1077,7 +1078,7 @@ static int max77693_muic_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "allocate register map\n");
 	} else {
 		info->max77693->regmap_muic = devm_regmap_init_i2c(
-						info->max77693->muic,
+						info->max77693->i2c_muic,
 						&max77693_muic_regmap_config);
 		if (IS_ERR(info->max77693->regmap_muic)) {
 			ret = PTR_ERR(info->max77693->regmap_muic);
diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 39e930c10ebb..69a4e401fe24 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -25,6 +25,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/mfd/max77693-common.h>
 
 #define MAX_MAGNITUDE_SHIFT	16
 
diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
index cb14afa97e6f..07fdf35bb9a1 100644
--- a/drivers/mfd/max77693.c
+++ b/drivers/mfd/max77693.c
@@ -34,6 +34,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/mfd/max77693-common.h>
 #include <linux/regulator/machine.h>
 #include <linux/regmap.h>
 
@@ -193,22 +194,22 @@ static int max77693_i2c_probe(struct i2c_client *i2c,
 	} else
 		dev_info(max77693->dev, "device ID: 0x%x\n", reg_data);
 
-	max77693->muic = i2c_new_dummy(i2c->adapter, I2C_ADDR_MUIC);
-	if (!max77693->muic) {
+	max77693->i2c_muic = i2c_new_dummy(i2c->adapter, I2C_ADDR_MUIC);
+	if (!max77693->i2c_muic) {
 		dev_err(max77693->dev, "Failed to allocate I2C device for MUIC\n");
 		return -ENODEV;
 	}
-	i2c_set_clientdata(max77693->muic, max77693);
+	i2c_set_clientdata(max77693->i2c_muic, max77693);
 
-	max77693->haptic = i2c_new_dummy(i2c->adapter, I2C_ADDR_HAPTIC);
-	if (!max77693->haptic) {
+	max77693->i2c_haptic = i2c_new_dummy(i2c->adapter, I2C_ADDR_HAPTIC);
+	if (!max77693->i2c_haptic) {
 		dev_err(max77693->dev, "Failed to allocate I2C device for Haptic\n");
 		ret = -ENODEV;
 		goto err_i2c_haptic;
 	}
-	i2c_set_clientdata(max77693->haptic, max77693);
+	i2c_set_clientdata(max77693->i2c_haptic, max77693);
 
-	max77693->regmap_haptic = devm_regmap_init_i2c(max77693->haptic,
+	max77693->regmap_haptic = devm_regmap_init_i2c(max77693->i2c_haptic,
 					&max77693_regmap_haptic_config);
 	if (IS_ERR(max77693->regmap_haptic)) {
 		ret = PTR_ERR(max77693->regmap_haptic);
@@ -222,7 +223,7 @@ static int max77693_i2c_probe(struct i2c_client *i2c,
 	 * instance of MUIC device when irq of max77693 is initialized
 	 * before call max77693-muic probe() function.
 	 */
-	max77693->regmap_muic = devm_regmap_init_i2c(max77693->muic,
+	max77693->regmap_muic = devm_regmap_init_i2c(max77693->i2c_muic,
 					 &max77693_regmap_muic_config);
 	if (IS_ERR(max77693->regmap_muic)) {
 		ret = PTR_ERR(max77693->regmap_muic);
@@ -255,7 +256,7 @@ static int max77693_i2c_probe(struct i2c_client *i2c,
 				IRQF_ONESHOT | IRQF_SHARED |
 				IRQF_TRIGGER_FALLING, 0,
 				&max77693_charger_irq_chip,
-				&max77693->irq_data_charger);
+				&max77693->irq_data_chg);
 	if (ret) {
 		dev_err(max77693->dev, "failed to add irq chip: %d\n", ret);
 		goto err_irq_charger;
@@ -296,15 +297,15 @@ err_mfd:
 err_intsrc:
 	regmap_del_irq_chip(max77693->irq, max77693->irq_data_muic);
 err_irq_muic:
-	regmap_del_irq_chip(max77693->irq, max77693->irq_data_charger);
+	regmap_del_irq_chip(max77693->irq, max77693->irq_data_chg);
 err_irq_charger:
 	regmap_del_irq_chip(max77693->irq, max77693->irq_data_topsys);
 err_irq_topsys:
 	regmap_del_irq_chip(max77693->irq, max77693->irq_data_led);
 err_regmap:
-	i2c_unregister_device(max77693->haptic);
+	i2c_unregister_device(max77693->i2c_haptic);
 err_i2c_haptic:
-	i2c_unregister_device(max77693->muic);
+	i2c_unregister_device(max77693->i2c_muic);
 	return ret;
 }
 
@@ -315,12 +316,12 @@ static int max77693_i2c_remove(struct i2c_client *i2c)
 	mfd_remove_devices(max77693->dev);
 
 	regmap_del_irq_chip(max77693->irq, max77693->irq_data_muic);
-	regmap_del_irq_chip(max77693->irq, max77693->irq_data_charger);
+	regmap_del_irq_chip(max77693->irq, max77693->irq_data_chg);
 	regmap_del_irq_chip(max77693->irq, max77693->irq_data_topsys);
 	regmap_del_irq_chip(max77693->irq, max77693->irq_data_led);
 
-	i2c_unregister_device(max77693->muic);
-	i2c_unregister_device(max77693->haptic);
+	i2c_unregister_device(max77693->i2c_muic);
+	i2c_unregister_device(max77693->i2c_haptic);
 
 	return 0;
 }
diff --git a/drivers/power/max77693_charger.c b/drivers/power/max77693_charger.c
index 754879eb59f6..eb68d0572799 100644
--- a/drivers/power/max77693_charger.c
+++ b/drivers/power/max77693_charger.c
@@ -21,6 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/mfd/max77693-common.h>
 
 #define MAX77693_CHARGER_NAME				"max77693-charger"
 static const char *max77693_charger_model		= "MAX77693";
diff --git a/drivers/regulator/max77693.c b/drivers/regulator/max77693.c
index 236851ab575a..5b30dc42679c 100644
--- a/drivers/regulator/max77693.c
+++ b/drivers/regulator/max77693.c
@@ -30,6 +30,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/mfd/max77693-common.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regmap.h>
 
diff --git a/include/linux/mfd/max77693-common.h b/include/linux/mfd/max77693-common.h
new file mode 100644
index 000000000000..7da4cc38e982
--- /dev/null
+++ b/include/linux/mfd/max77693-common.h
@@ -0,0 +1,44 @@
+/*
+ * Common data shared between Maxim 77693 and 77843 drivers
+ *
+ * Copyright (C) 2015 Samsung Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_MFD_MAX77693_COMMON_H
+#define __LINUX_MFD_MAX77693_COMMON_H
+
+enum max77693_types {
+	TYPE_MAX77693_UNKNOWN,
+	TYPE_MAX77693,
+};
+
+/*
+ * Shared also with max77843.
+ */
+struct max77693_dev {
+	struct device *dev;
+	struct i2c_client *i2c;		/* 0xCC , PMIC, Charger, Flash LED */
+	struct i2c_client *i2c_muic;	/* 0x4A , MUIC */
+	struct i2c_client *i2c_haptic;	/* MAX77693: 0x90 , Haptic */
+
+	enum max77693_types type;
+
+	struct regmap *regmap;
+	struct regmap *regmap_muic;
+	struct regmap *regmap_haptic;	/* Only MAX77693 */
+
+	struct regmap_irq_chip_data *irq_data_led;
+	struct regmap_irq_chip_data *irq_data_topsys;
+	struct regmap_irq_chip_data *irq_data_chg; /* Only MAX77693 */
+	struct regmap_irq_chip_data *irq_data_muic;
+
+	int irq;
+};
+
+
+#endif /*  __LINUX_MFD_MAX77693_COMMON_H */
diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index e3c0afff38d3..8c4143c0c651 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -529,29 +529,4 @@ enum max77693_irq_muic {
 	MAX77693_MUIC_IRQ_NR,
 };
 
-enum max77693_types {
-	TYPE_MAX77693_UNKNOWN,
-	TYPE_MAX77693,
-};
-
-struct max77693_dev {
-	struct device *dev;
-	struct i2c_client *i2c;		/* 0xCC , PMIC, Charger, Flash LED */
-	struct i2c_client *muic;	/* 0x4A , MUIC */
-	struct i2c_client *haptic;	/* 0x90 , Haptic */
-
-	enum max77693_types type;
-
-	struct regmap *regmap;
-	struct regmap *regmap_muic;
-	struct regmap *regmap_haptic;
-
-	struct regmap_irq_chip_data *irq_data_led;
-	struct regmap_irq_chip_data *irq_data_topsys;
-	struct regmap_irq_chip_data *irq_data_charger;
-	struct regmap_irq_chip_data *irq_data_muic;
-
-	int irq;
-};
-
 #endif /*  __LINUX_MFD_MAX77693_PRIV_H */
-- 
2.1.4
