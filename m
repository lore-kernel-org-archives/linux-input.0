From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] Input: icn8318 - Add support for icn8505
Date: Sat, 17 Jun 2017 12:58:32 +0200
Message-ID: <20170617105834.16255-2-hdegoede@redhat.com>
References: <20170617105834.16255-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752720AbdFQK6k (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 17 Jun 2017 06:58:40 -0400
In-Reply-To: <20170617105834.16255-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

The icn8505 variant found on some x86 tablets has almost the same protocol
as the 8318, protocol wise there are only 2 small differences:

1) The 8505 uses 16 bit register addresses and has a different register
address for the location of the touch data.
2) The 8505 coordinates are in little-endian format instead of in be.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../bindings/input/touchscreen/chipone_icn8318.txt |  2 +-
 drivers/input/touchscreen/Kconfig                  |  3 +-
 drivers/input/touchscreen/chipone_icn8318.c        | 53 +++++++++++++++++-----
 3 files changed, 44 insertions(+), 14 deletions(-)

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
index ddaae91f02fc..993df804883f 100644
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
@@ -20,6 +20,7 @@
 #include <linux/input/touchscreen.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #define ICN8318_REG_POWER		4
 #define ICN8318_REG_TOUCHDATA		16
@@ -30,6 +31,13 @@
 
 #define ICN8318_MAX_TOUCHES		5
 
+#define ICN8505_REG_TOUCHDATA		0x1000
+
+enum icn8318_model {
+	ICN8318,
+	ICN8505,
+};
+
 struct icn8318_touch {
 	__u8 slot;
 	__be16 x;
@@ -54,27 +62,36 @@ struct icn8318_data {
 	struct input_dev *input;
 	struct gpio_desc *wake_gpio;
 	struct touchscreen_properties prop;
+	enum icn8318_model model;
 };
 
-static int icn8318_read_touch_data(struct i2c_client *client,
+static int icn8318_read_touch_data(struct icn8318_data *data,
 				   struct icn8318_touch_data *touch_data)
 {
-	u8 reg = ICN8318_REG_TOUCHDATA;
+	u8 reg[2];
 	struct i2c_msg msg[2] = {
 		{
-			.addr = client->addr,
-			.len = 1,
-			.buf = &reg
+			.addr = data->client->addr,
+			.buf = reg
 		},
 		{
-			.addr = client->addr,
+			.addr = data->client->addr,
 			.flags = I2C_M_RD,
 			.len = sizeof(struct icn8318_touch_data),
 			.buf = (u8 *)touch_data
 		}
 	};
 
-	return i2c_transfer(client->adapter, msg, 2);
+	if (data->model == ICN8318) {
+		reg[0] = ICN8318_REG_TOUCHDATA;
+		msg[0].len = 1;
+	} else {
+		reg[0] = ICN8505_REG_TOUCHDATA >> 8;
+		reg[1] = ICN8505_REG_TOUCHDATA & 0xff;
+		msg[0].len = 2;
+	}
+
+	return i2c_transfer(data->client->adapter, msg, 2);
 }
 
 static inline bool icn8318_touch_active(u8 event)
@@ -83,6 +100,14 @@ static inline bool icn8318_touch_active(u8 event)
 	       (event == ICN8318_EVENT_UPDATE2);
 }
 
+static u16 icn8318_coord_to_cpu(struct icn8318_data *data, __be16 coord)
+{
+	if (data->model == ICN8318)
+		return be16_to_cpu(coord);
+	else
+		return le16_to_cpu((__force __le16)coord);
+}
+
 static irqreturn_t icn8318_irq(int irq, void *dev_id)
 {
 	struct icn8318_data *data = dev_id;
@@ -90,7 +115,7 @@ static irqreturn_t icn8318_irq(int irq, void *dev_id)
 	struct icn8318_touch_data touch_data;
 	int i, ret;
 
-	ret = icn8318_read_touch_data(data->client, &touch_data);
+	ret = icn8318_read_touch_data(data, &touch_data);
 	if (ret < 0) {
 		dev_err(dev, "Error reading touch data: %d\n", ret);
 		return IRQ_HANDLED;
@@ -122,8 +147,9 @@ static irqreturn_t icn8318_irq(int irq, void *dev_id)
 			continue;
 
 		touchscreen_report_pos(data->input, &data->prop,
-				       be16_to_cpu(touch->x),
-				       be16_to_cpu(touch->y), true);
+				       icn8318_coord_to_cpu(data, touch->x),
+				       icn8318_coord_to_cpu(data, touch->y),
+				       true);
 	}
 
 	input_mt_sync_frame(data->input);
@@ -187,6 +213,8 @@ static int icn8318_probe_of(struct icn8318_data *data, struct device *dev)
 {
 	int error;
 
+	data->model = (long)of_device_get_match_data(dev);
+
 	data->wake_gpio = devm_gpiod_get(dev, "wake", GPIOD_OUT_LOW);
 	if (IS_ERR(data->wake_gpio)) {
 		error = PTR_ERR(data->wake_gpio);
@@ -274,7 +302,8 @@ static int icn8318_probe(struct i2c_client *client)
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

