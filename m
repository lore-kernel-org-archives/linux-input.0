From: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Subject: [PATCH] touchscreen: mms114: add support for mms152
Date: Mon, 18 Dec 2017 23:49:33 +1100
Message-ID: <20171218124933.1803-1-simon@lineageos.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

MMS152 has no configuration registers, but the packet format used in
interrupts is identical to mms114.

Signed-off-by: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
---
 .../bindings/input/touchscreen/mms114.txt          |  8 ++--
 drivers/input/touchscreen/mms114.c                 | 55 +++++++++++++++++++---
 include/linux/platform_data/mms114.h               |  6 +++
 3 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
index 89d4c56c5671..733411020ced 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
@@ -1,15 +1,15 @@
-* MELFAS MMS114 touchscreen controller
+* MELFAS MMS114/MMS152 touchscreen controller
 
 Required properties:
-- compatible: must be "melfas,mms114"
+- compatible: "melfas,mms114" for MMS114, or "melfas,mms152" for MMS152
 - reg: I2C address of the chip
 - interrupts: interrupt to which the chip is connected
 - x-size: horizontal resolution of touchscreen
 - y-size: vertical resolution of touchscreen
 
 Optional properties:
-- contact-threshold:
-- moving-threshold:
+- contact-threshold: only with "melfas,mms114"
+- moving-threshold: only with "melfas,mms114"
 - x-invert: invert X axis
 - y-invert: invert Y axis
 
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index e5eeb6311f7d..d01f36442788 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/i2c.h>
 #include <linux/input/mt.h>
 #include <linux/interrupt.h>
@@ -33,6 +34,9 @@
 #define MMS114_INFOMATION		0x10
 #define MMS114_TSP_REV			0xF0
 
+#define MMS152_FW_REV			0xE1
+#define MMS152_COMPAT_GROUP		0xF2
+
 /* Minimum delay time is 50us between stop and start signal of i2c */
 #define MMS114_I2C_DELAY		50
 
@@ -251,12 +255,27 @@ static int mms114_get_version(struct mms114_data *data)
 	u8 buf[6];
 	int error;
 
-	error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
-	if (error < 0)
-		return error;
+	switch (data->pdata->type) {
+	case TYPE_MMS152:
+		error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
+		if (error < 0)
+			return error;
+		buf[3] = i2c_smbus_read_byte_data(data->client,
+			MMS152_COMPAT_GROUP);
+		if (buf[3] < 0)
+			return buf[3];
+		dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x, Compat group: %c\n",
+				buf[0], buf[1], buf[2], buf[3]);
+		break;
+	case TYPE_MMS114:
+		error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
+		if (error < 0)
+			return error;
 
-	dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
-		 buf[0], buf[1], buf[3]);
+		dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
+			 buf[0], buf[1], buf[3]);
+		break;
+	}
 
 	return 0;
 }
@@ -271,6 +290,11 @@ static int mms114_setup_regs(struct mms114_data *data)
 	if (error < 0)
 		return error;
 
+	if (data->pdata->type == TYPE_MMS152) {
+		/* MMS152 has no configuration or power on registers */
+		return 0;
+	}
+
 	error = mms114_set_active(data, true);
 	if (error < 0)
 		return error;
@@ -391,6 +415,8 @@ static struct mms114_platform_data *mms114_parse_dt(struct device *dev)
 		return NULL;
 	}
 
+	pdata->type = (enum mms_type)of_device_get_match_data(dev);
+
 	if (of_property_read_u32(np, "x-size", &pdata->x_size)) {
 		dev_err(dev, "failed to get x-size property\n");
 		return NULL;
@@ -411,6 +437,7 @@ static struct mms114_platform_data *mms114_parse_dt(struct device *dev)
 	if (of_find_property(np, "y-invert", NULL))
 		pdata->y_invert = true;
 
+
 	return pdata;
 }
 #else
@@ -456,7 +483,15 @@ static int mms114_probe(struct i2c_client *client,
 	data->input_dev = input_dev;
 	data->pdata = pdata;
 
-	input_dev->name = "MELFAS MMS114 Touchscreen";
+	switch (pdata->type) {
+	case TYPE_MMS114:
+		input_dev->name = "MELFAS MMS114 Touchscreen";
+		break;
+	case TYPE_MMS152:
+		input_dev->name = "MELFAS MMS152 Touchscreen";
+		break;
+	}
+
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 	input_dev->open = mms114_input_open;
@@ -569,7 +604,13 @@ MODULE_DEVICE_TABLE(i2c, mms114_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id mms114_dt_match[] = {
-	{ .compatible = "melfas,mms114" },
+	{
+		.compatible = "melfas,mms114",
+		.data = (void *)TYPE_MMS114,
+	}, {
+		.compatible = "melfas,mms152",
+		.data = (void *)TYPE_MMS152,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mms114_dt_match);
diff --git a/include/linux/platform_data/mms114.h b/include/linux/platform_data/mms114.h
index 5722ebfb2738..58e4c463bf0c 100644
--- a/include/linux/platform_data/mms114.h
+++ b/include/linux/platform_data/mms114.h
@@ -10,6 +10,11 @@
 #ifndef __LINUX_MMS114_H
 #define __LINUX_MMS114_H
 
+enum mms_type {
+	TYPE_MMS114,
+	TYPE_MMS152,
+};
+
 struct mms114_platform_data {
 	unsigned int x_size;
 	unsigned int y_size;
@@ -17,6 +22,7 @@ struct mms114_platform_data {
 	unsigned int moving_threshold;
 	bool x_invert;
 	bool y_invert;
+	enum mms_type type;
 
 	void (*cfg_pin)(bool);
 };
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
