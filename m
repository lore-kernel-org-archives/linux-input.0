From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/4] Input: icn8318 - Add support for icn8505
Date: Thu,  6 Jul 2017 22:49:28 +0200
Message-ID: <20170706204930.4241-2-hdegoede@redhat.com>
References: <20170706204930.4241-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752461AbdGFUth (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Jul 2017 16:49:37 -0400
In-Reply-To: <20170706204930.4241-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

The icn8505 variant found on some x86 tablets has almost the same protocol
as the 8318, protocol wise there are only a few small differences:

1) The 8505 uses 16 bit register addresses and has a different register
address for the location of the touch data.
2) The 8505 coordinates are in little-endian format instead of in be.
3) The 8505 allows reading the resolution back from the controller

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Read resolution directly from the controller
Changes in v3:
-Make x/y touch_data members u8 arrays instead of __be16 with a force-cast
 to __le16 for the icn8505 case
-Add a coord_to_cpu function pointer to struct icn8318_data, instead
 of doing a data->model check
---
 .../bindings/input/touchscreen/chipone_icn8318.txt |  2 +-
 drivers/input/touchscreen/Kconfig                  |  3 +-
 drivers/input/touchscreen/chipone_icn8318.c        | 91 ++++++++++++++++++----
 3 files changed, 77 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt b/Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt
index d11f8d615b5d..9fdd80749386 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/chipone_icn8318.txt
@@ -1,7 +1,7 @@
 * ChipOne icn8318 I2C touchscreen controller
 
 Required properties:
- - compatible		  : "chipone,icn8318"
+ - compatible		  : "chipone,icn8318" or "chipone,icn8505"
  - reg			  : I2C slave address of the chip (0x40)
  - interrupt-parent	  : a phandle pointing to the interrupt controller
 			    serving the interrupt for this chip
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index cf26ca49ae6d..fff1467506e7 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -157,7 +157,8 @@ config TOUCHSCREEN_CHIPONE_ICN8318
 	depends on I2C
 	depends on OF
 	help
-	  Say Y here if you have a ChipOne icn8318 based I2C touchscreen.
+	  Say Y here if you have a ChipOne icn8318 or icn8505 based
+	  I2C touchscreen.
 
 	  If unsure, say N.
 
diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index 27df6ca3a8a3..eba2f7eb3c3a 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -1,7 +1,7 @@
 /*
  * Driver for ChipOne icn8318 i2c touchscreen controller
  *
- * Copyright (c) 2015 Red Hat Inc.
+ * Copyright (c) 2015-2017 Red Hat Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -12,6 +12,7 @@
  * Hans de Goede <hdegoede@redhat.com>
  */
 
+#include <asm/unaligned.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
@@ -20,6 +21,7 @@
 #include <linux/input/touchscreen.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #define ICN8318_REG_POWER		4
 #define ICN8318_REG_TOUCHDATA		16
@@ -30,10 +32,18 @@
 
 #define ICN8318_MAX_TOUCHES		5
 
+#define ICN8505_REG_TOUCHDATA		0x1000
+#define ICN8505_REG_CONFIGDATA		0x8000
+
+enum icn8318_model {
+	ICN8318,
+	ICN8505,
+};
+
 struct icn8318_touch {
 	__u8 slot;
-	__be16 x;
-	__be16 y;
+	__u8 x[2];
+	__u8 y[2];
 	__u8 pressure;	/* Seems more like finger width then pressure really */
 	__u8 event;
 /* The difference between 2 and 3 is unclear */
@@ -54,27 +64,48 @@ struct icn8318_data {
 	struct input_dev *input;
 	struct gpio_desc *wake_gpio;
 	struct touchscreen_properties prop;
+	enum icn8318_model model;
+	int touchdata_reg;
+	u16 (*coord_to_cpu)(const u8 *buf);
 };
 
-static int icn8318_read_touch_data(struct i2c_client *client,
-				   struct icn8318_touch_data *touch_data)
+static int icn8318_read_data(struct icn8318_data *data, int reg,
+			     void *buf, int len)
 {
-	u8 reg = ICN8318_REG_TOUCHDATA;
+	u8 addr[2];
 	struct i2c_msg msg[2] = {
 		{
-			.addr = client->addr,
-			.len = 1,
-			.buf = &reg
+			.addr = data->client->addr,
+			.buf = addr
 		},
 		{
-			.addr = client->addr,
+			.addr = data->client->addr,
 			.flags = I2C_M_RD,
-			.len = sizeof(struct icn8318_touch_data),
-			.buf = (u8 *)touch_data
+			.len = len,
+			.buf = buf
 		}
 	};
 
-	return i2c_transfer(client->adapter, msg, 2);
+	if (data->model == ICN8318) {
+		addr[0] = reg;
+		msg[0].len = 1;
+	} else {
+		addr[0] = reg >> 8;
+		addr[1] = reg & 0xff;
+		msg[0].len = 2;
+	}
+
+	return i2c_transfer(data->client->adapter, msg, 2);
+}
+
+static u16 icn8318_coord_to_cpu(const u8 *buf)
+{
+	return get_unaligned_be16(buf);
+}
+
+static u16 icn8505_coord_to_cpu(const u8 *buf)
+{
+	return get_unaligned_le16(buf);
 }
 
 static inline bool icn8318_touch_active(u8 event)
@@ -90,7 +121,8 @@ static irqreturn_t icn8318_irq(int irq, void *dev_id)
 	struct icn8318_touch_data touch_data;
 	int i, ret;
 
-	ret = icn8318_read_touch_data(data->client, &touch_data);
+	ret = icn8318_read_data(data, data->touchdata_reg,
+				&touch_data, sizeof(touch_data));
 	if (ret < 0) {
 		dev_err(dev, "Error reading touch data: %d\n", ret);
 		return IRQ_HANDLED;
@@ -122,8 +154,9 @@ static irqreturn_t icn8318_irq(int irq, void *dev_id)
 			continue;
 
 		touchscreen_report_pos(data->input, &data->prop,
-				       be16_to_cpu(touch->x),
-				       be16_to_cpu(touch->y), true);
+				       data->coord_to_cpu(touch->x),
+				       data->coord_to_cpu(touch->y),
+				       true);
 	}
 
 	input_mt_sync_frame(data->input);
@@ -188,6 +221,7 @@ static int icn8318_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct icn8318_data *data;
 	struct input_dev *input;
+	__le16 resolution[2];
 	int error;
 
 	if (!client->irq) {
@@ -220,6 +254,28 @@ static int icn8318_probe(struct i2c_client *client,
 	input_set_capability(input, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input, EV_ABS, ABS_MT_POSITION_Y);
 
+	data->model = (long)of_device_get_match_data(dev);
+
+	if (data->model == ICN8318) {
+		data->touchdata_reg = ICN8318_REG_TOUCHDATA;
+		data->coord_to_cpu  = icn8318_coord_to_cpu;
+	} else {
+		data->touchdata_reg = ICN8505_REG_TOUCHDATA;
+		data->coord_to_cpu  = icn8505_coord_to_cpu;
+
+		error = icn8318_read_data(data, ICN8505_REG_CONFIGDATA,
+					  resolution, sizeof(resolution));
+		if (error < 0) {
+			dev_err(dev, "Error reading resolution: %d\n", error);
+			return error;
+		}
+
+		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
+				     le16_to_cpu(resolution[0]) - 1, 0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
+				     le16_to_cpu(resolution[1]) - 1, 0, 0);
+	}
+
 	touchscreen_parse_properties(input, true, &data->prop);
 	if (!input_abs_get_max(input, ABS_MT_POSITION_X) ||
 	    !input_abs_get_max(input, ABS_MT_POSITION_Y)) {
@@ -256,7 +312,8 @@ static int icn8318_probe(struct i2c_client *client,
 }
 
 static const struct of_device_id icn8318_of_match[] = {
-	{ .compatible = "chipone,icn8318" },
+	{ .compatible = "chipone,icn8318", .data = (void *)ICN8318 },
+	{ .compatible = "chipone,icn8505", .data = (void *)ICN8505 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, icn8318_of_match);
-- 
2.13.0

