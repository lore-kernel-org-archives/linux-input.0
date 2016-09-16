From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: touchscreen: Add support for Elan eKTF2127
 touchscreen controller
Date: Fri, 16 Sep 2016 11:56:54 -0700
Message-ID: <20160916185654.GA14732@dtor-ws>
References: <20160828160005.20415-1-hdegoede@redhat.com>
 <20160902140935.GA19453@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35393 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753513AbcIPS47 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Sep 2016 14:56:59 -0400
Content-Disposition: inline
In-Reply-To: <20160902140935.GA19453@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Siebren Vroegindeweij <siebren.vroegindeweij@gmail.com>, Michel Verlaan <michel.verl@gmail.com>, Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>

On Fri, Sep 02, 2016 at 09:09:35AM -0500, Rob Herring wrote:
> On Sun, Aug 28, 2016 at 06:00:05PM +0200, Hans de Goede wrote:
> > From: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
> > 
> > This adds a driver for the Elan eKTF2127 touchscreen controller,
> > which speaks an i2c protocol which is distinctly different from
> > the already supported eKTH controllers.
> > 
> > Signed-off-by: Michel Verlaan <michel.verl@gmail.com>
> > Signed-off-by: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Changes in v2:
> > -Improve devicetree bindings document
> > -Use touchscreen_parse_properties and touchscreen_report_pos instead of DIY
> > -Remove a bunch of unused defines (copy and paste leftover from chipone driver)
> > -Some other minor cleanups and review comments addressed
> > -Add defines for some command / address hex-values
> > -Check packet header in interrupt handler
> > ---
> >  .../bindings/input/touchscreen/ektf2127.txt        |  27 ++
> 
> Acked-by: Rob Herring <robh@kernel.org>

I'd like to merge the version below (factored out querying dimensions
and parsing/reporting touch), can you please give it a spin?

Thanks!

-- 
Dmitry

Input: touchscreen - add support for Elan eKTF2127 touchscreen controller

From: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>

This adds a driver for the Elan eKTF2127 touchscreen controller,
which speaks an i2c protocol which is distinctly different from
the already supported eKTH controllers.

Signed-off-by: Michel Verlaan <michel.verl@gmail.com>
Signed-off-by: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../bindings/input/touchscreen/ektf2127.txt        |   27 ++
 drivers/input/touchscreen/Kconfig                  |   12 +
 drivers/input/touchscreen/Makefile                 |    1 
 drivers/input/touchscreen/ektf2127.c               |  336 ++++++++++++++++++++
 4 files changed, 376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
 create mode 100644 drivers/input/touchscreen/ektf2127.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt b/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
new file mode 100644
index 0000000..5a19f4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
@@ -0,0 +1,27 @@
+* Elan eKTF2127 I2C touchscreen controller
+
+Required properties:
+ - compatible		  : "elan,ektf2127"
+ - reg			  : I2C slave address of the chip (0x40)
+ - interrupt-parent	  : a phandle pointing to the interrupt controller
+			    serving the interrupt for this chip
+ - interrupts		  : interrupt specification for the ektf2127 interrupt
+ - power-gpios		  : GPIO specification for the pin connected to the
+			    ektf2127's wake input. This needs to be driven high
+			    to take ektf2127 out of it's low power state
+
+For additional optional properties see: touchscreen.txt
+
+Example:
+
+i2c@00000000 {
+	ektf2127: touchscreen@15 {
+		compatible = "elan,ektf2127";
+		reg = <0x15>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>
+		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>;
+		touchscreen-inverted-x;
+		touchscreen-swapped-x-y;
+	};
+};
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 3b3d07a..880aa50 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -396,6 +396,18 @@ config TOUCHSCREEN_ELAN
 	  To compile this driver as a module, choose M here: the
 	  module will be called elants_i2c.
 
+config TOUCHSCREEN_EKTF2127
+	tristate "Elan eKTF2127 I2C touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have an Elan eKTF2127 touchscreen
+	  connected to your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ektf2127.
+
 config TOUCHSCREEN_ELO
 	tristate "Elo serial touchscreens"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 57a1c09..e26ff38 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+= hampshire.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ELAN)		+= elants_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_EKTF2127)	+= ektf2127.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
new file mode 100644
index 0000000..31a2dd7
--- /dev/null
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -0,0 +1,336 @@
+/*
+ * Driver for ELAN eKTF2127 i2c touchscreen controller
+ *
+ * For this driver the layout of the Chipone icn8318 i2c
+ * touchscreencontroller is used.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Author:
+ * Michel Verlaan <michel.verl@gmail.com>
+ * Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
+ *
+ * Original chipone_icn8318 driver:
+ * Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+
+/* Packet header defines (first byte of data send / received) */
+#define EKTF2127_NOISE			0x40
+#define EKTF2127_RESPONSE		0x52
+#define EKTF2127_REQUEST		0x53
+#define EKTF2127_HELLO			0x55
+#define EKTF2127_REPORT			0x5d
+#define EKTF2127_CALIB_DONE		0x66
+
+/* Register defines (second byte of data send / received) */
+#define EKTF2127_ENV_NOISY		0x41
+#define EKTF2127_HEIGHT			0x60
+#define EKTF2127_WIDTH			0x63
+
+/* 2 bytes header + 5 * 3 bytes coordinates + 3 bytes pressure info + footer */
+#define EKTF2127_TOUCH_REPORT_SIZE	21
+#define EKTF2127_MAX_TOUCHES		5
+
+struct ektf2127_ts {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct gpio_desc *power_gpios;
+	struct touchscreen_properties prop;
+};
+
+static void ektf2127_parse_coordinates(const u8* buf, unsigned int touch_count,
+				       struct input_mt_pos *touches)
+{
+	int index = 0;
+	int i;
+
+	for (i = 0; i < touch_count; i++) {
+		index = 2 + i * 3;
+
+		touches[i].x = (buf[index] & 0x0f);
+		touches[i].x <<= 8;
+		touches[i].x |= buf[index + 2];
+
+		touches[i].y = (buf[index] & 0xf0);
+		touches[i].y <<= 4;
+		touches[i].y |= buf[index + 1];
+	}
+}
+
+static void ektf2127_report_event(struct ektf2127_ts *ts, const u8 *buf)
+{
+	struct input_mt_pos touches[EKTF2127_MAX_TOUCHES];
+	int slots[EKTF2127_MAX_TOUCHES];
+	unsigned int touch_count, i;
+
+	touch_count = buf[1] & 0x07;
+	if (touch_count > EKTF2127_MAX_TOUCHES) {
+		dev_err(&ts->client->dev,
+			"Too many touches %d > %d\n",
+			touch_count, EKTF2127_MAX_TOUCHES);
+		touch_count = EKTF2127_MAX_TOUCHES;
+	}
+
+	ektf2127_parse_coordinates(buf, touch_count, touches);
+	input_mt_assign_slots(ts->input, slots, touches,
+			      touch_count, 0);
+
+	for (i = 0; i < touch_count; i++) {
+		input_mt_slot(ts->input, slots[i]);
+		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, true);
+		touchscreen_report_pos(ts->input, &ts->prop,
+				       touches[i].x, touches[i].y, true);
+	}
+
+	input_mt_sync_frame(ts->input);
+	input_sync(ts->input);
+}
+
+static irqreturn_t ektf2127_irq(int irq, void *dev_id)
+{
+	struct ektf2127_ts *ts = dev_id;
+	struct device *dev = &ts->client->dev;
+	char buf[EKTF2127_TOUCH_REPORT_SIZE];
+	int ret;
+
+	ret = i2c_master_recv(ts->client, buf, EKTF2127_TOUCH_REPORT_SIZE);
+	if (ret != EKTF2127_TOUCH_REPORT_SIZE) {
+		dev_err(dev, "Error reading touch data: %d\n", ret);
+		goto out;
+	}
+
+	switch (buf[0]) {
+	case EKTF2127_REPORT:
+		ektf2127_report_event(ts, buf);
+		break;
+
+	case EKTF2127_NOISE:
+		if (buf[1] == EKTF2127_ENV_NOISY)
+			dev_dbg(dev, "Environment is electrically noisy\n");
+		break;
+
+	case EKTF2127_HELLO:
+	case EKTF2127_CALIB_DONE:
+		break;
+
+	default:
+		dev_err(dev, "Unexpected packet header byte %#02x\n", buf[0]);
+		break;
+	}
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int ektf2127_start(struct input_dev *dev)
+{
+	struct ektf2127_ts *ts = input_get_drvdata(dev);
+
+	enable_irq(ts->client->irq);
+	gpiod_set_value_cansleep(ts->power_gpios, 1);
+
+	return 0;
+}
+
+static void ektf2127_stop(struct input_dev *dev)
+{
+	struct ektf2127_ts *ts = input_get_drvdata(dev);
+
+	disable_irq(ts->client->irq);
+	gpiod_set_value_cansleep(ts->power_gpios, 0);
+}
+
+static int ektf2127_suspend(struct device *dev)
+{
+	struct ektf2127_ts *ts = i2c_get_clientdata(to_i2c_client(dev));
+
+	mutex_lock(&ts->input->mutex);
+	if (ts->input->users)
+		ektf2127_stop(ts->input);
+	mutex_unlock(&ts->input->mutex);
+
+	return 0;
+}
+
+static int ektf2127_resume(struct device *dev)
+{
+	struct ektf2127_ts *ts = i2c_get_clientdata(to_i2c_client(dev));
+
+	mutex_lock(&ts->input->mutex);
+	if (ts->input->users)
+		ektf2127_start(ts->input);
+	mutex_unlock(&ts->input->mutex);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ektf2127_pm_ops, ektf2127_suspend,
+			 ektf2127_resume);
+
+static int ektf2127_query_dimension(struct i2c_client *client, bool width)
+{
+	struct device *dev = &client->dev;
+	const char *what = width ? "width" : "height";
+	u8 what_code = width ? EKTF2127_WIDTH : EKTF2127_HEIGHT;
+	u8 buf[4];
+	int ret;
+	int error;
+
+	/* Request dimension */
+	buf[0] = EKTF2127_REQUEST;
+	buf[1] = width ? EKTF2127_WIDTH : EKTF2127_HEIGHT;
+	buf[2] = 0x00;
+	buf[3] = 0x00;
+	ret = i2c_master_send(client, buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(dev, "Failed to request %s: %d\n", what, error);
+		return error;
+	}
+
+	msleep(20);
+
+	/* Read response */
+	ret = i2c_master_recv(client, buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		error = ret < 0 ? ret : -EIO;
+		dev_err(dev, "Failed to receive %s data: %d\n", what, error);
+		return error;
+	}
+
+	if (buf[0] != EKTF2127_RESPONSE || buf[1] != what_code) {
+		dev_err(dev, "Unexpected %s data: %#02x %#02x\n",
+			what, buf[0], buf[1]);
+		return -EIO;
+	}
+
+	return (((buf[3] & 0xf0) << 4) | buf[2]) - 1;
+}
+
+static int ektf2127_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct ektf2127_ts *ts;
+	struct input_dev *input;
+	u8 buf[4];
+	int max_x, max_y;
+	int error;
+
+	if (!client->irq) {
+		dev_err(dev, "Error no irq specified\n");
+		return -EINVAL;
+	}
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	/* This requests the gpio *and* turns on the touchscreen controller */
+	ts->power_gpios = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
+	if (IS_ERR(ts->power_gpios)) {
+		error = PTR_ERR(ts->power_gpios);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "Error getting power gpio: %d\n", error);
+		return error;
+	}
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->name = client->name;
+	input->id.bustype = BUS_I2C;
+	input->open = ektf2127_start;
+	input->close = ektf2127_stop;
+
+	ts->client = client;
+
+	/* Read hello (ignore result, depends on initial power state) */
+	msleep(20);
+	i2c_master_recv(ts->client, buf, sizeof(buf));
+
+	/* Read resolution from chip */
+	max_x = ektf2127_query_dimension(client, true);
+	if (max_x < 0)
+		return max_x;
+
+	max_y = ektf2127_query_dimension(client, false);
+	if (max_y < 0)
+		return max_y;
+
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, max_x, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, max_y, 0, 0);
+	touchscreen_parse_properties(input, true, &ts->prop);
+
+	error = input_mt_init_slots(input, EKTF2127_MAX_TOUCHES,
+				    INPUT_MT_DIRECT |
+					INPUT_MT_DROP_UNUSED |
+					INPUT_MT_TRACK);
+	if (error)
+		return error;
+
+	ts->input = input;
+	input_set_drvdata(input, ts);
+
+	error = devm_request_threaded_irq(dev, client->irq,
+					  NULL, ektf2127_irq,
+					  IRQF_ONESHOT, client->name, ts);
+	if (error) {
+		dev_err(dev, "Error requesting irq: %d\n", error);
+		return error;
+	}
+
+	/* Stop device till opened */
+	ektf2127_stop(ts->input);
+
+	error = input_register_device(input);
+	if (error)
+		return error;
+
+	i2c_set_clientdata(client, ts);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ektf2127_of_match[] = {
+	{ .compatible = "elan,ektf2127" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ektf2127_of_match);
+#endif
+
+static const struct i2c_device_id ektf2127_i2c_id[] = {
+	{ "ektf2127", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ektf2127_i2c_id);
+
+static struct i2c_driver ektf2127_driver = {
+	.driver = {
+		.name	= "elan_ektf2127",
+		.pm	= &ektf2127_pm_ops,
+		.of_match_table = of_match_ptr(ektf2127_of_match),
+	},
+	.probe = ektf2127_probe,
+	.id_table = ektf2127_i2c_id,
+};
+module_i2c_driver(ektf2127_driver);
+
+MODULE_DESCRIPTION("ELAN eKTF2127 I2C Touchscreen Driver");
+MODULE_AUTHOR("Michel Verlaan, Siebren Vroegindeweij");
+MODULE_LICENSE("GPL");
