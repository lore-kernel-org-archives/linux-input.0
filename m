From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] input: touchscreen: add driver for Zeitec ZET6223
Date: Sat, 14 Jan 2017 11:14:25 -0800
Message-ID: <20170114191425.GA31309@dtor-ws>
References: <20161223163214.7716-1-jelle@vdwaa.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161223163214.7716-1-jelle-oJJ1AqDjjO4@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jelle van der Waa <jelle-oJJ1AqDjjO4@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jelle,

On Fri, Dec 23, 2016 at 05:32:13PM +0100, Jelle van der Waa wrote:
> This is a basic driver for the Zeitec ZET6223 I2C touchscreen
> controllers. The driver does not support firmware loading, which is not
> required for all tablets which contain this chip.
> 
> Signed-off-by: Jelle van der Waa <jelle-oJJ1AqDjjO4@public.gmane.org>

This looks mostly good with exception of this:

> +
> +static const struct of_device_id zet6223_of_match[] = {
> +	{ .compatible = "zeitec", "zet6223" },

The compatible should be "zeitec,zet6223", what you have here is
equivalent of:

	{ .compatible = "zeitec", .data = "zet6223" },

I also have been looking at you previosu submission and had some draft
changes. I reconciled them in the patch below, if it still works for you
then I'll fold everything together and apply. Please let me know.

Thanks.

-- 
Dmitry


Input: zeitech - misc changes

From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../bindings/input/touchscreen/zet6223.txt         |   29 +-
 drivers/input/touchscreen/Kconfig                  |   22 +-
 drivers/input/touchscreen/Makefile                 |    2 
 drivers/input/touchscreen/zet6223.c                |  262 ++++++++++++++------
 4 files changed, 209 insertions(+), 106 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt b/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
index cc0f7d06bc8b..fe6a1feef703 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
@@ -1,16 +1,19 @@
 Zeitec ZET6223 I2C touchscreen controller
 
 Required properties:
- - compatible            : "zeitec,zet6223"
- - reg                   : I2C slave address of the chip (0x76)
- - interrupt-parent      : a phandle pointing to the interrupt controller
-                           serving the interrupt for this chip
- - interrupts            : interrupt specification for the zet6223 interrupt
+- compatible		  : "zeitec,zet6223"
+- reg			  : I2C slave address of the chip (0x76)
+- interrupt-parent	  : a phandle pointing to the interrupt controller
+			    serving the interrupt for this chip
+- interrupts		  : interrupt specification for the zet6223 interrupt
 
 Optional properties:
 
-- touchscreen-size-x     : See touchscreen.txt
-- touchscreen-size-y     : See touchscreen.txt
+- vio-supply		  : Specification for VIO supply (1.8V or 3.3V,
+			    depending on system interface needs).
+- vcc-supply		  : Specification for 3.3V VCC supply.
+- touchscreen-size-x	  : See touchscreen.txt
+- touchscreen-size-y	  : See touchscreen.txt
 - touchscreen-inverted-x  : See touchscreen.txt
 - touchscreen-inverted-y  : See touchscreen.txt
 - touchscreen-swapped-x-y : See touchscreen.txt
@@ -19,11 +22,11 @@ Example:
 
 i2c@00000000 {
 
-       zet6223: touchscreen@76 {
-               compatible = "zeitec,zet6223";
-               reg = <0x76>;
-               interrupt-parent = <&pio>;
-               interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>
-       };
+	zet6223: touchscreen@76 {
+		compatible = "zeitec,zet6223";
+		reg = <0x76>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>
+	};
 
 };
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 270ce9317842..033599777651 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1165,6 +1165,17 @@ config TOUCHSCREEN_TPS6507X
 	  To compile this driver as a module, choose M here: the
 	  module will be called tps6507x_ts.
 
+config TOUCHSCREEN_ZET6223
+	tristate "Zeitec ZET6223 touchscreen driver"
+	depends on I2C
+	help
+	  Say Y here if you have a touchscreen using Zeitec ZET6223
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called zet6223.
+
 config TOUCHSCREEN_ZFORCE
 	tristate "Neonode zForce infrared touchscreens"
 	depends on I2C
@@ -1202,15 +1213,4 @@ config TOUCHSCREEN_ROHM_BU21023
 	  To compile this driver as a module, choose M here: the
 	  module will be called bu21023_ts.
 
-config TOUCHSCREEN_ZET6223
-       tristate "Zeitec ZET6223 touchscreen driver"
-       depends on I2C
-       help
-         Say Y here if you have a touchscreen using Zeitec ZET6223
-
-         If unsure, say N.
-
-         To compile this driver as a module, choose M here: the
-         module will be called zet6223.
-
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 03dc730c096c..b622e5344137 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -95,7 +95,7 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
 obj-$(CONFIG_TOUCHSCREEN_SX8654)	+= sx8654.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
+obj-$(CONFIG_TOUCHSCREEN_ZET6223)	+= zet6223.o
 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
 obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
-obj-$(CONFIG_TOUCHSCREEN_ZET6223)       += zet6223.o
diff --git a/drivers/input/touchscreen/zet6223.c b/drivers/input/touchscreen/zet6223.c
index aecae06877cf..8702d31958aa 100644
--- a/drivers/input/touchscreen/zet6223.c
+++ b/drivers/input/touchscreen/zet6223.c
@@ -1,70 +1,83 @@
 /*
  * Copyright (C) 2016, Jelle van der Waa <jelle-oJJ1AqDjjO4@public.gmane.org>
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the Free
- *  Software Foundation; either version 2 of the License, or (at your option)
- *  any later version.
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
  *
- *  This program is distributed in the hope that it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- *  more details.
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
  */
 
-#include <asm/unaligned.h>
-#include <linux/gpio/consumer.h>
-#include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <asm/unaligned.h>
+
+#define ZET6223_MAX_FINGERS		16
+#define ZET6223_MAX_PKT_SIZE		(3 + 4 * ZET6223_MAX_FINGERS)
+
+#define ZET6223_CMD_INFO		0xB2
+#define ZET6223_CMD_INFO_LENGTH		17
+#define ZET6223_VALID_PACKET		0x3c
 
-#define ZET6223_CMD_INFO 0xB2
-#define ZET6223_CMD_INFO_LENGTH 17
-#define ZET6223_VALID_PACKET 0x3c
+#define ZET6223_POWER_ON_DELAY_MSEC	30
 
-struct zet6223_data {
+struct zet6223_ts {
 	struct i2c_client *client;
 	struct input_dev *input;
+	struct regulator *vcc;
+	struct regulator *vio;
 	struct touchscreen_properties prop;
+	u16 max_x;
+	u16 max_y;
 	u8 fingernum;
 };
 
 static int zet6223_start(struct input_dev *dev)
 {
-	struct zet6223_data *data = input_get_drvdata(dev);
+	struct zet6223_ts *ts = input_get_drvdata(dev);
 
-	enable_irq(data->client->irq);
+	enable_irq(ts->client->irq);
 
 	return 0;
 }
 
 static void zet6223_stop(struct input_dev *dev)
 {
-	struct zet6223_data *data = input_get_drvdata(dev);
+	struct zet6223_ts *ts = input_get_drvdata(dev);
 
-	disable_irq(data->client->irq);
+	disable_irq(ts->client->irq);
 }
 
-static irqreturn_t irqreturn_t_zet6223(int irq, void *dev_id)
+static irqreturn_t zet6223_irq(int irq, void *dev_id)
 {
-	struct zet6223_data *data = dev_id;
-	struct device *dev = &data->client->dev;
+	struct zet6223_ts *ts = dev_id;
+	u16 finger_bits;
+
 	/*
 	 * First 3 bytes are an identifier, two bytes of finger data.
 	 * X, Y data per finger is 4 bytes.
 	 */
-	u8 bufsize = 3 + 4 * data->fingernum;
-	u8 buf[bufsize];
-	u8 i;
-	u16 finger_bits;
+	u8 bufsize = 3 + 4 * ts->fingernum;
+	u8 buf[ZET6223_MAX_PKT_SIZE];
+	int i;
 	int ret;
+	int error;
 
-	ret = i2c_master_recv(data->client, buf, bufsize);
+	ret = i2c_master_recv(ts->client, buf, bufsize);
 	if (ret != bufsize) {
-		dev_err_ratelimited(dev, "Error reading input data: %d\n", ret);
+		error = ret < 0 ? ret : -EIO;
+		dev_err_ratelimited(&ts->client->dev,
+				    "Error reading input data: %d\n", error);
 		return IRQ_HANDLED;
 	}
 
@@ -72,113 +85,201 @@ static irqreturn_t irqreturn_t_zet6223(int irq, void *dev_id)
 		return IRQ_HANDLED;
 
 	finger_bits = get_unaligned_be16(buf + 1);
-	for (i = 0; i < data->fingernum; i++) {
+	for (i = 0; i < ts->fingernum; i++) {
 		if (!(finger_bits & BIT(15 - i)))
 			continue;
 
-		input_mt_slot(data->input, i);
-		input_mt_report_slot_state(data->input, MT_TOOL_FINGER, true);
-		input_event(data->input, EV_ABS, ABS_MT_POSITION_X,
+		input_mt_slot(ts->input, i);
+		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, true);
+		input_event(ts->input, EV_ABS, ABS_MT_POSITION_X,
 				((buf[i + 3] >> 4) << 8) + buf[i + 4]);
-		input_event(data->input, EV_ABS, ABS_MT_POSITION_Y,
+		input_event(ts->input, EV_ABS, ABS_MT_POSITION_Y,
 				((buf[i + 3] & 0xF) << 8) + buf[i + 5]);
 	}
 
-	input_mt_sync_frame(data->input);
-	input_sync(data->input);
+	input_mt_sync_frame(ts->input);
+	input_sync(ts->input);
 
 	return IRQ_HANDLED;
 }
 
-static int zet6223_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int zet6223_power_on(struct zet6223_ts *ts)
+{
+	int error;
+
+	if (ts->vio) {
+		error = regulator_enable(ts->vio);
+		if (error) {
+			dev_err(&ts->client->dev,
+				"failed to enable vio supply: %d\n", error);
+			return error;
+		}
+	}
+
+	if (ts->vcc) {
+		error = regulator_enable(ts->vcc);
+		if (error) {
+			dev_err(&ts->client->dev,
+				"failed to enable vcc supply: %d\n", error);
+			goto err_disable_vio;
+		}
+	}
+
+	if (ts->vio || ts->vcc)
+		msleep(ZET6223_POWER_ON_DELAY_MSEC);
+
+	return 0;
+
+err_disable_vio:
+	if (ts->vio)
+		regulator_disable(ts->vio);
+
+	return error;
+}
+
+static void zet6223_power_off(void *_ts)
+{
+	struct zet6223_ts *ts = _ts;
+
+	if (ts->vcc)
+		regulator_disable(ts->vcc);
+
+	if (ts->vio)
+		regulator_disable(ts->vio);
+}
+
+static int zet6223_query_device(struct zet6223_ts *ts)
 {
-	struct device *dev = &client->dev;
-	struct zet6223_data *data;
-	struct input_dev *input;
 	u8 buf[ZET6223_CMD_INFO_LENGTH];
 	u8 cmd = ZET6223_CMD_INFO;
 	int ret;
+	int error;
+
+	ret = i2c_master_send(ts->client, &cmd, sizeof(cmd));
+	if (ret != sizeof(cmd)) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(&ts->client->dev,
+			"touchpanel info cmd failed: %d\n", error);
+		return error;
+	}
+
+	ret = i2c_master_recv(ts->client, buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(&ts->client->dev,
+			"failed to retrieve touchpanel info: %d\n", error);
+		return error;
+	}
+
+	ts->fingernum = buf[15] & 0x7F;
+	if (ts->fingernum > ZET6223_MAX_FINGERS) {
+		dev_warn(&ts->client->dev,
+			 "touchpanel reports %d fingers, limiting to %d\n",
+			 ts->fingernum, ZET6223_MAX_FINGERS);
+		ts->fingernum = 16;
+	}
+
+	ts->max_x = get_unaligned_le16(&buf[8]);
+	ts->max_y = get_unaligned_le16(&buf[10]);
+
+	return 0;
+}
+
+static int zet6223_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct zet6223_ts *ts;
+	struct input_dev *input;
+	int error;
 
 	if (!client->irq) {
-		dev_err(dev, "Error no irq specified\n");
+		dev_err(dev, "no irq specified\n");
 		return -EINVAL;
 	}
 
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
 		return -ENOMEM;
 
-	ret = i2c_master_send(client, &cmd, 1);
-	if (ret < 0) {
-		dev_err(dev, "touchpanel info cmd failed: %d\n", ret);
-		return -ENODEV;
+	ts->client = client;
+
+	ts->vio = devm_regulator_get_optional(dev, "vio");
+	if (IS_ERR(ts->vio)) {
+		error = PTR_ERR(ts->vio);
+		dev_err(dev, "failed to get 'vio' regulator: %d\n", error);
+		return error;
 	}
 
-	ret = i2c_master_recv(client, buf, ZET6223_CMD_INFO_LENGTH);
-	if (ret < 0) {
-		dev_err(dev, "cannot retrieve touchpanel info: %d\n", ret);
-		return -ENODEV;
+	ts->vcc = devm_regulator_get_optional(dev, "vcc");
+	if (IS_ERR(ts->vcc)) {
+		error = PTR_ERR(ts->vcc);
+		dev_err(dev, "failed to get 'vcc' regulator: %d\n", error);
+		return error;
 	}
 
-	data->fingernum = buf[15] & 0x7F;
-	if (data->fingernum > 16) {
-		data->fingernum = 16;
-		dev_warn(dev, "touchpanel reports more then 16 fingers, limit to 16");
+	error = zet6223_power_on(ts);
+	if (error)
+		return error;
+
+	error = devm_add_action_or_reset(dev, zet6223_power_off, ts);
+	if (error) {
+		dev_err(dev, "failed to install poweroff action: %d\n", error);
+		return error;
 	}
 
-	input = devm_input_allocate_device(dev);
+	error = zet6223_query_device(ts);
+	if (error)
+		return error;
+
+	ts->input = input = devm_input_allocate_device(dev);
 	if (!input)
 		return -ENOMEM;
 
-	input_set_abs_params(input, ABS_MT_POSITION_X, 0,
-			get_unaligned_le16(&buf[8]), 0, 0);
-	input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
-			get_unaligned_le16(&buf[10]), 0, 0);
-	touchscreen_parse_properties(input, true, &data->prop);
+	input_set_drvdata(input, ts);
 
 	input->name = client->name;
 	input->id.bustype = BUS_I2C;
-	input->dev.parent = dev;
 	input->open = zet6223_start;
 	input->close = zet6223_stop;
 
-	ret = input_mt_init_slots(input, data->fingernum,
-		INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
-	if (ret)
-		return ret;
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, ts->max_x, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ts->max_y, 0, 0);
 
-	data->client = client;
-	data->input = input;
+	touchscreen_parse_properties(input, true, &ts->prop);
 
-	input_set_drvdata(input, data);
+	error = input_mt_init_slots(input, ts->fingernum,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (error)
+		return error;
 
-	ret = devm_request_threaded_irq(dev, client->irq, NULL,
-			irqreturn_t_zet6223, IRQF_ONESHOT, client->name, data);
-	if (ret) {
-		dev_err(dev, "Error requesting irq: %d\n", ret);
-		return ret;
+	error = devm_request_threaded_irq(dev, client->irq, NULL, zet6223_irq,
+					  IRQF_ONESHOT, client->name, ts);
+	if (error) {
+		dev_err(dev, "failed to request irq %d: %d\n",
+			client->irq, error);
+		return error;
 	}
 
 	zet6223_stop(input);
 
-	ret = input_register_device(input);
-	if (ret)
-		return ret;
+	error = input_register_device(input);
+	if (error)
+		return error;
 
-	i2c_set_clientdata(client, data);
+	i2c_set_clientdata(client, ts);
 
 	return 0;
 }
 
 static const struct of_device_id zet6223_of_match[] = {
-	{ .compatible = "zeitec", "zet6223" },
+	{ .compatible = "zeitec,zet6223" },
 	{ }
 };
 
 static const struct i2c_device_id zet6223_id[] = {
 	{ "zet6223", 0},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, zet6223_id);
 
@@ -190,7 +291,6 @@ static struct i2c_driver zet6223_driver = {
 	.probe = zet6223_probe,
 	.id_table = zet6223_id
 };
-
 module_i2c_driver(zet6223_driver);
 
 MODULE_AUTHOR("Jelle van der Waa <jelle-oJJ1AqDjjO4@public.gmane.org>");
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
