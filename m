From: Jingkui Wang <jkwang@google.com>
Subject: [PATCH v2] drivers: Update drv260x driver
Date: Fri,  9 Dec 2016 13:45:26 -0800
Message-ID: <1481319926-47706-1-git-send-email-jkwang@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Dan Murphy <dmurphy@ti.com>, Jingkui Wang <jkwang@google.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Update driver drv260x to use generic device properties
Remove platform data and corresponding header file

Signed-off-by: Jingkui Wang <jkwang@google.com>
---
Changes in v2:
- Delete unused header file

 drivers/input/misc/drv260x.c                | 43 ++++++-----------------------
 include/linux/platform_data/drv260x-pdata.h | 28 -------------------
 2 files changed, 8 insertions(+), 63 deletions(-)
 delete mode 100644 include/linux/platform_data/drv260x-pdata.h

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 2adfd86c..4f448ba 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -19,7 +19,6 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -27,7 +26,6 @@
 #include <linux/regulator/consumer.h>
 
 #include <dt-bindings/input/ti-drv260x.h>
-#include <linux/platform_data/drv260x-pdata.h>
 
 #define DRV260X_STATUS		0x0
 #define DRV260X_MODE		0x1
@@ -468,52 +466,39 @@ static const struct regmap_config drv260x_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
-#ifdef CONFIG_OF
-static int drv260x_parse_dt(struct device *dev,
+static int drv260x_read_device_property(struct device *dev,
 			    struct drv260x_data *haptics)
 {
-	struct device_node *np = dev->of_node;
 	unsigned int voltage;
 	int error;
 
-	error = of_property_read_u32(np, "mode", &haptics->mode);
+	error = device_property_read_u32(dev, "mode", &haptics->mode);
 	if (error) {
 		dev_err(dev, "%s: No entry for mode\n", __func__);
 		return error;
 	}
 
-	error = of_property_read_u32(np, "library-sel", &haptics->library);
+	error = device_property_read_u32(dev, "library-sel", &haptics->library);
 	if (error) {
 		dev_err(dev, "%s: No entry for library selection\n",
 			__func__);
 		return error;
 	}
 
-	error = of_property_read_u32(np, "vib-rated-mv", &voltage);
+	error = device_property_read_u32(dev, "vib-rated-mv", &voltage);
 	if (!error)
 		haptics->rated_voltage = drv260x_calculate_voltage(voltage);
 
-
-	error = of_property_read_u32(np, "vib-overdrive-mv", &voltage);
+	error = device_property_read_u32(dev, "vib-overdrive-mv", &voltage);
 	if (!error)
 		haptics->overdrive_voltage = drv260x_calculate_voltage(voltage);
 
 	return 0;
 }
-#else
-static inline int drv260x_parse_dt(struct device *dev,
-				   struct drv260x_data *haptics)
-{
-	dev_err(dev, "no platform data defined\n");
-
-	return -EINVAL;
-}
-#endif
 
 static int drv260x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	const struct drv260x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct drv260x_data *haptics;
 	int error;
 
@@ -524,21 +509,9 @@ static int drv260x_probe(struct i2c_client *client,
 	haptics->rated_voltage = DRV260X_DEF_OD_CLAMP_VOLT;
 	haptics->rated_voltage = DRV260X_DEF_RATED_VOLT;
 
-	if (pdata) {
-		haptics->mode = pdata->mode;
-		haptics->library = pdata->library_selection;
-		if (pdata->vib_overdrive_voltage)
-			haptics->overdrive_voltage = drv260x_calculate_voltage(pdata->vib_overdrive_voltage);
-		if (pdata->vib_rated_voltage)
-			haptics->rated_voltage = drv260x_calculate_voltage(pdata->vib_rated_voltage);
-	} else if (client->dev.of_node) {
-		error = drv260x_parse_dt(&client->dev, haptics);
-		if (error)
-			return error;
-	} else {
-		dev_err(&client->dev, "Platform data not set\n");
-		return -ENODEV;
-	}
+	error = drv260x_read_device_property(&client->dev, haptics);
+	if (error)
+		return error;
 
 
 	if (haptics->mode < DRV260X_LRA_MODE ||
diff --git a/include/linux/platform_data/drv260x-pdata.h b/include/linux/platform_data/drv260x-pdata.h
deleted file mode 100644
index 0a03b09..0000000
--- a/include/linux/platform_data/drv260x-pdata.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Platform data for DRV260X haptics driver family
- *
- * Author: Dan Murphy <dmurphy@ti.com>
- *
- * Copyright:   (C) 2014 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
-
-#ifndef _LINUX_DRV260X_PDATA_H
-#define _LINUX_DRV260X_PDATA_H
-
-struct drv260x_platform_data {
-	u32 library_selection;
-	u32 mode;
-	u32 vib_rated_voltage;
-	u32 vib_overdrive_voltage;
-};
-
-#endif
-- 
2.6.6
