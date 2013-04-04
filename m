From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 1/2] input: touchscreen: atmel_mxt_ts: Add support for voltage
 regulator
Date: Thu, 04 Apr 2013 18:14:25 +0200
Message-ID: <1365092066-31753-2-git-send-email-t.figa@samsung.com>
References: <1365092066-31753-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:27085 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762838Ab3DDQOl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Apr 2013 12:14:41 -0400
In-reply-to: <1365092066-31753-1-git-send-email-t.figa@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, jy0922.shim@samsung.com, kyungmin.park@samsung.com, Tomasz Figa <t.figa@samsung.com>

This patch removes the voltage field from platform data of the
atmel_mxt_ts driver and replaces it with regulator support.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-nuri.c           | 29 ++++++++++++++++++++++++++++-
 arch/arm/mach-exynos/mach-universal_c210.c | 29 ++++++++++++++++++++++++++++-
 arch/arm/mach-s5pv210/mach-goni.c          | 28 +++++++++++++++++++++++++++-
 drivers/input/touchscreen/atmel_mxt_ts.c   | 25 ++++++++++++++++++++-----
 include/linux/i2c/atmel_mxt_ts.h           |  1 -
 5 files changed, 103 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 1ea7973..98be36c 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -77,6 +77,7 @@ enum fixed_regulator_id {
 	FIXED_REG_ID_CAM_A28V,
 	FIXED_REG_ID_CAM_12V,
 	FIXED_REG_ID_CAM_VT_15V,
+	FIXED_REG_ID_TSP_2_8V,
 };
 
 static struct s3c2410_uartcfg nuri_uartcfgs[] __initdata = {
@@ -332,6 +333,32 @@ static struct i2c_board_info i2c1_devs[] __initdata = {
 };
 
 /* TSP */
+static struct regulator_consumer_supply tsp_fixed_consumer =
+	REGULATOR_SUPPLY("vdd", "3-004a");
+
+static struct regulator_init_data tsp_fixed_voltage_init_data = {
+	.constraints		= {
+		.name		= "TSP_2.8V",
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &tsp_fixed_consumer,
+};
+
+static struct fixed_voltage_config tsp_fixed_voltage_config = {
+	.supply_name		= "TSP_VDD",
+	.microvolts		= 2800000,
+	.gpio			= -EINVAL,
+	.init_data		= &tsp_fixed_voltage_init_data,
+};
+
+static struct platform_device tsp_fixed_voltage = {
+	.name			= "reg-fixed-voltage",
+	.id			= FIXED_REG_ID_TSP_2_8V,
+	.dev			= {
+		.platform_data	= &tsp_fixed_voltage_config,
+	},
+};
+
 static struct mxt_platform_data mxt_platform_data = {
 	.x_line			= 18,
 	.y_line			= 11,
@@ -339,7 +366,6 @@ static struct mxt_platform_data mxt_platform_data = {
 	.y_size			= 600,
 	.blen			= 0x1,
 	.threshold		= 0x28,
-	.voltage		= 2800000,		/* 2.8V */
 	.orient			= MXT_DIAGONAL_COUNTER,
 	.irqflags		= IRQF_TRIGGER_FALLING,
 };
@@ -1303,6 +1329,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s3c_device_wdt,
 	&s3c_device_timer[0],
 	&s5p_device_ehci,
+	&tsp_fixed_voltage,
 	&s3c_device_i2c3,
 	&i2c9_gpio,
 	&s3c_device_adc,
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 497fcb7..2dbae3d 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -561,6 +561,7 @@ enum fixed_regulator_id {
 	FIXED_REG_ID_CAM_S_IF,
 	FIXED_REG_ID_CAM_I_CORE,
 	FIXED_REG_ID_CAM_VT_DIO,
+	FIXED_REG_ID_TSP_2_8V,
 };
 
 static struct regulator_consumer_supply hdmi_fixed_consumer =
@@ -603,6 +604,32 @@ static struct i2c_board_info i2c5_devs[] __initdata = {
 };
 
 /* I2C3 (TSP) */
+static struct regulator_consumer_supply tsp_fixed_consumer =
+	REGULATOR_SUPPLY("vdd", "3-004a");
+
+static struct regulator_init_data tsp_fixed_voltage_init_data = {
+	.constraints		= {
+		.name		= "TSP_2.8V",
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &tsp_fixed_consumer,
+};
+
+static struct fixed_voltage_config tsp_fixed_voltage_config = {
+	.supply_name		= "TSP_VDD",
+	.microvolts		= 2800000,
+	.gpio			= -EINVAL,
+	.init_data		= &tsp_fixed_voltage_init_data,
+};
+
+static struct platform_device tsp_fixed_voltage = {
+	.name			= "reg-fixed-voltage",
+	.id			= FIXED_REG_ID_TSP_2_8V,
+	.dev			= {
+		.platform_data	= &tsp_fixed_voltage_config,
+	},
+};
+
 static struct mxt_platform_data qt602240_platform_data = {
 	.x_line		= 19,
 	.y_line		= 11,
@@ -610,7 +637,6 @@ static struct mxt_platform_data qt602240_platform_data = {
 	.y_size		= 480,
 	.blen		= 0x11,
 	.threshold	= 0x28,
-	.voltage	= 2800000,		/* 2.8V */
 	.orient		= MXT_DIAGONAL,
 	.irqflags	= IRQF_TRIGGER_FALLING,
 };
@@ -1065,6 +1091,7 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s3c_device_hsmmc2,
 	&s3c_device_hsmmc3,
 	&s3c_device_i2c0,
+	&tsp_fixed_voltage,
 	&s3c_device_i2c3,
 	&s3c_device_i2c5,
 	&s5p_device_i2c_hdmiphy,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 3a38f7b..71a38be 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -238,6 +238,32 @@ static void __init goni_radio_init(void)
 }
 
 /* TSP */
+static struct regulator_consumer_supply tsp_fixed_consumer =
+	REGULATOR_SUPPLY("vdd", "2-004a");
+
+static struct regulator_init_data tsp_fixed_voltage_init_data = {
+	.constraints		= {
+		.name		= "TSP_2.8V",
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &tsp_fixed_consumer,
+};
+
+static struct fixed_voltage_config tsp_fixed_voltage_config = {
+	.supply_name		= "TSP_VDD",
+	.microvolts		= 2800000,
+	.gpio			= -EINVAL,
+	.init_data		= &tsp_fixed_voltage_init_data,
+};
+
+static struct platform_device tsp_fixed_voltage = {
+	.name			= "reg-fixed-voltage",
+	.id			= 3,
+	.dev			= {
+		.platform_data	= &tsp_fixed_voltage_config,
+	},
+};
+
 static struct mxt_platform_data qt602240_platform_data = {
 	.x_line		= 17,
 	.y_line		= 11,
@@ -245,7 +271,6 @@ static struct mxt_platform_data qt602240_platform_data = {
 	.y_size		= 480,
 	.blen		= 0x21,
 	.threshold	= 0x28,
-	.voltage	= 2800000,              /* 2.8V */
 	.orient		= MXT_DIAGONAL,
 	.irqflags	= IRQF_TRIGGER_FALLING,
 };
@@ -889,6 +914,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_usb_hsotg,
 	&samsung_device_keypad,
 	&s3c_device_i2c1,
+	&tsp_fixed_voltage,
 	&s3c_device_i2c2,
 	&wm8994_fixed_voltage0,
 	&wm8994_fixed_voltage1,
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 59aa240..de708ff 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -19,6 +19,7 @@
 #include <linux/i2c/atmel_mxt_ts.h>
 #include <linux/input/mt.h>
 #include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 /* Version */
@@ -247,6 +248,7 @@ struct mxt_message {
 struct mxt_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
+	struct regulator *regulator;
 	char phys[64];		/* device physical location */
 	const struct mxt_platform_data *pdata;
 	struct mxt_object *object_table;
@@ -720,13 +722,14 @@ static void mxt_handle_pdata(struct mxt_data *data)
 			MXT_TOUCH_YRANGE_MSB, (pdata->y_size - 1) >> 8);
 
 	/* Set touchscreen voltage */
-	if (pdata->voltage) {
-		if (pdata->voltage < MXT_VOLTAGE_DEFAULT) {
-			voltage = (MXT_VOLTAGE_DEFAULT - pdata->voltage) /
+	if (!IS_ERR(data->regulator)) {
+		int reg_voltage = regulator_get_voltage(data->regulator);
+		if (reg_voltage < MXT_VOLTAGE_DEFAULT) {
+			voltage = (MXT_VOLTAGE_DEFAULT - reg_voltage) /
 				MXT_VOLTAGE_STEP;
 			voltage = 0xff - voltage + 1;
 		} else
-			voltage = (pdata->voltage - MXT_VOLTAGE_DEFAULT) /
+			voltage = (reg_voltage - MXT_VOLTAGE_DEFAULT) /
 				MXT_VOLTAGE_STEP;
 
 		mxt_write_object(data, MXT_SPT_CTECONFIG_T28,
@@ -1151,6 +1154,13 @@ static int mxt_probe(struct i2c_client *client,
 
 	input_dev->name = (data->is_tp) ? "Atmel maXTouch Touchpad" :
 					  "Atmel maXTouch Touchscreen";
+
+	data->regulator = devm_regulator_get(&client->dev, "vdd");
+	if (!IS_ERR(data->regulator)) {
+		regulator_enable(data->regulator);
+		msleep(100);
+	}
+
 	snprintf(data->phys, sizeof(data->phys), "i2c-%u-%04x/input0",
 		 client->adapter->nr, client->addr);
 
@@ -1170,7 +1180,7 @@ static int mxt_probe(struct i2c_client *client,
 
 	error = mxt_initialize(data);
 	if (error)
-		goto err_free_mem;
+		goto err_disable_regulator;
 
 	__set_bit(EV_ABS, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
@@ -1253,6 +1263,9 @@ err_free_irq:
 	free_irq(client->irq, data);
 err_free_object:
 	kfree(data->object_table);
+err_disable_regulator:
+	if (!IS_ERR(data->regulator))
+		regulator_disable(data->regulator);
 err_free_mem:
 	input_free_device(input_dev);
 	kfree(data);
@@ -1267,6 +1280,8 @@ static int mxt_remove(struct i2c_client *client)
 	free_irq(data->irq, data);
 	input_unregister_device(data->input_dev);
 	kfree(data->object_table);
+	if (!IS_ERR(data->regulator))
+		regulator_disable(data->regulator);
 	kfree(data);
 
 	return 0;
diff --git a/include/linux/i2c/atmel_mxt_ts.h b/include/linux/i2c/atmel_mxt_ts.h
index 99e379b..03cb0c7 100644
--- a/include/linux/i2c/atmel_mxt_ts.h
+++ b/include/linux/i2c/atmel_mxt_ts.h
@@ -39,7 +39,6 @@ struct mxt_platform_data {
 	unsigned int y_size;
 	unsigned int blen;
 	unsigned int threshold;
-	unsigned int voltage;
 	unsigned char orient;
 	unsigned long irqflags;
 	bool is_tp;
-- 
1.8.1.5

