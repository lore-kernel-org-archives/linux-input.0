From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/4] Input: mms114 - add support for mms152
Date: Wed, 24 Jan 2018 11:38:04 -0800
Message-ID: <20180124193804.155654-5-dmitry.torokhov@gmail.com>
References: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40024 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932458AbeAXTiP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 14:38:15 -0500
In-Reply-To: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Shields <simon@lineageos.org>, Andi Shyti <andi.shyti@samsung.com>
Cc: Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Simon Shields <simon@lineageos.org>

MMS152 has no configuration registers, but the packet format used in
interrupts is identical to mms114.

Signed-off-by: Simon Shields <simon@lineageos.org>
Patchwork-Id: 10125841
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../bindings/input/touchscreen/mms114.txt          |  6 +-
 drivers/input/touchscreen/mms114.c                 | 89 +++++++++++++++++-----
 2 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
index 8f9f9f38eff4a..2cd954051d299 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
@@ -1,7 +1,9 @@
-* MELFAS MMS114 touchscreen controller
+* MELFAS MMS114/MMS152 touchscreen controller
 
 Required properties:
-- compatible: must be "melfas,mms114"
+- compatible: should be one of:
+	- "melfas,mms114"
+	- "melfas,mms152"
 - reg: I2C address of the chip
 - interrupts: interrupt to which the chip is connected
 - touchscreen-size-x: See [1]
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 69e4288bf8aa3..06d4ce9a3e547 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/i2c.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
@@ -33,6 +34,9 @@
 #define MMS114_INFOMATION		0x10
 #define MMS114_TSP_REV			0xF0
 
+#define MMS152_FW_REV			0xE1
+#define MMS152_COMPAT_GROUP		0xF2
+
 /* Minimum delay time is 50us between stop and start signal of i2c */
 #define MMS114_I2C_DELAY		50
 
@@ -50,12 +54,18 @@
 #define MMS114_TYPE_TOUCHSCREEN		1
 #define MMS114_TYPE_TOUCHKEY		2
 
+enum mms_type {
+	TYPE_MMS114	= 114,
+	TYPE_MMS152	= 152,
+};
+
 struct mms114_data {
 	struct i2c_client	*client;
 	struct input_dev	*input_dev;
 	struct regulator	*core_reg;
 	struct regulator	*io_reg;
 	struct touchscreen_properties props;
+	enum mms_type		type;
 	unsigned int		contact_threshold;
 	unsigned int		moving_threshold;
 
@@ -241,12 +251,28 @@ static int mms114_get_version(struct mms114_data *data)
 	u8 buf[6];
 	int error;
 
-	error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
-	if (error < 0)
-		return error;
+	switch (data->type) {
+	case TYPE_MMS152:
+		error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
+		if (error)
+			return error;
+		buf[3] = i2c_smbus_read_byte_data(data->client,
+						  MMS152_COMPAT_GROUP);
+		if (buf[3] < 0)
+			return buf[3];
+		dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x, Compat group: %c\n",
+			 buf[0], buf[1], buf[2], buf[3]);
+		break;
+
+	case TYPE_MMS114:
+		error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
+		if (error)
+			return error;
 
-	dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
-		 buf[0], buf[1], buf[3]);
+		dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
+			 buf[0], buf[1], buf[3]);
+		break;
+	}
 
 	return 0;
 }
@@ -261,6 +287,10 @@ static int mms114_setup_regs(struct mms114_data *data)
 	if (error < 0)
 		return error;
 
+	/* MMS152 has no configuration or power on registers */
+	if (data->type == TYPE_MMS152)
+		return 0;
+
 	error = mms114_set_active(data, true);
 	if (error < 0)
 		return error;
@@ -395,6 +425,7 @@ static int mms114_probe(struct i2c_client *client,
 {
 	struct mms114_data *data;
 	struct input_dev *input_dev;
+	const void *match_data;
 	int error;
 
 	if (!i2c_check_functionality(client->adapter,
@@ -415,6 +446,13 @@ static int mms114_probe(struct i2c_client *client,
 	data->client = client;
 	data->input_dev = input_dev;
 
+	/* FIXME: switch to device_get_match_data() when available */
+	match_data = of_device_get_match_data(&client->dev);
+	if (!match_data)
+		return -EINVAL;
+
+	data->type = (enum mms_type)match_data;
+
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
 	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
@@ -435,19 +473,26 @@ static int mms114_probe(struct i2c_client *client,
 				     0, data->props.max_y, 0, 0);
 	}
 
-	/*
-	 * The firmware handles movement and pressure fuzz, so
-	 * don't duplicate that in software.
-	 */
-	data->moving_threshold = input_abs_get_fuzz(input_dev,
-						    ABS_MT_POSITION_X);
-	data->contact_threshold = input_abs_get_fuzz(input_dev,
-						     ABS_MT_PRESSURE);
-	input_abs_set_fuzz(input_dev, ABS_MT_POSITION_X, 0);
-	input_abs_set_fuzz(input_dev, ABS_MT_POSITION_Y, 0);
-	input_abs_set_fuzz(input_dev, ABS_MT_PRESSURE, 0);
-
-	input_dev->name = "MELFAS MMS114 Touchscreen";
+	if (data->type == TYPE_MMS114) {
+		/*
+		 * The firmware handles movement and pressure fuzz, so
+		 * don't duplicate that in software.
+		 */
+		data->moving_threshold = input_abs_get_fuzz(input_dev,
+							    ABS_MT_POSITION_X);
+		data->contact_threshold = input_abs_get_fuzz(input_dev,
+							     ABS_MT_PRESSURE);
+		input_abs_set_fuzz(input_dev, ABS_MT_POSITION_X, 0);
+		input_abs_set_fuzz(input_dev, ABS_MT_POSITION_Y, 0);
+		input_abs_set_fuzz(input_dev, ABS_MT_PRESSURE, 0);
+	}
+
+	input_dev->name = devm_kasprintf(&client->dev, GFP_KERNEL,
+					 "MELFAS MMS%d Touchscreen",
+					 data->type);
+	if (!input_dev->name)
+		return -ENOMEM;
+
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 	input_dev->open = mms114_input_open;
@@ -549,7 +594,13 @@ MODULE_DEVICE_TABLE(i2c, mms114_id);
 
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
-- 
2.16.0.rc1.238.g530d649a79-goog

