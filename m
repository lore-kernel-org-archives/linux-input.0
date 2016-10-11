From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: [PATCH 3/5] Input: add driver for Ilitek ili2139 touch IC
Date: Tue, 11 Oct 2016 08:33:57 +0800
Message-ID: <20161011003359.26079-3-icenowy@aosc.xyz>
References: <20161011003359.26079-1-icenowy@aosc.xyz>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBB57H6C7QKGQEFT6EJPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161011003359.26079-1-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Rask Ingemann Lambertsen <ccc94453-1EA3ORoCGBhoJ7GROcy7lA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Damien Riegel <damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jeffrey Lin <jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Sangwon Jee <jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org>, Siebren Vroegindeweij <siebren.vroegindeweij-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kerne
List-Id: linux-input@vger.kernel.org

This driver adds support for Ilitek ili2139 touch IC, which is used in
several Colorfly tablets (for example, Colorfly E708 Q1, which is an
Allwinner A31s tablet with mainline kernel support).

Theortically it may support more Ilitek touch ICs, however, only ili2139
is used in any mainlined device.

It supports device tree enumeration, with screen resolution and axis
quirks configurable.

Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
---
 drivers/input/touchscreen/Kconfig   |  14 ++
 drivers/input/touchscreen/Makefile  |   1 +
 drivers/input/touchscreen/ili2139.c | 320 ++++++++++++++++++++++++++++++++++++
 3 files changed, 335 insertions(+)
 create mode 100644 drivers/input/touchscreen/ili2139.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 5079813..bb4d9d2 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -348,6 +348,20 @@ config TOUCHSCREEN_ILI210X
 	  To compile this driver as a module, choose M here: the
 	  module will be called ili210x.
 
+config TOUCHSCREEN_ILI2139
+	tristate "Ilitek ILI2139 based touchscreen"
+	depends on I2C
+	depends on OF
+	help
+	  Say Y here if you have a ILI2139 based touchscreen
+	  controller. Such kind of chipsets can be found in several
+	  Colorfly tablets.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here; the
+	  module will be called ili2139.
+
 config TOUCHSCREEN_IPROC
 	tristate "IPROC touch panel driver support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 81b8645..930b5e2 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
+obj-$(CONFIG_TOUCHSCREEN_ILI2139)	+= ili2139.o
 obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC)	+= imx6ul_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
 obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+= intel-mid-touch.o
diff --git a/drivers/input/touchscreen/ili2139.c b/drivers/input/touchscreen/ili2139.c
new file mode 100644
index 0000000..65c2dea
--- /dev/null
+++ b/drivers/input/touchscreen/ili2139.c
@@ -0,0 +1,320 @@
+/* -------------------------------------------------------------------------
+ * Copyright (C) 2016, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
+ *
+ * Derived from:
+ *  ili210x.c
+ *  Copyright (C) Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ * -------------------------------------------------------------------------
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+
+#define DEFAULT_POLL_PERIOD	20
+
+#define MAX_TOUCHES		10
+#define COMPATIBLE_TOUCHES	2
+
+/* Touchscreen commands */
+#define REG_TOUCHDATA		0x10
+#define REG_TOUCHSUBDATA	0x11
+#define REG_PANEL_INFO		0x20
+#define REG_FIRMWARE_VERSION	0x40
+#define REG_PROTO_VERSION	0x42
+
+#define SUBDATA_STATUS_TOUCH_POINT	0x80
+#define SUBDATA_STATUS_RELEASE_POINT	0x00
+
+struct finger {
+	u8 x_low;
+	u8 x_high;
+	u8 y_low;
+	u8 y_high;
+} __packed;
+
+struct touchdata {
+	u8 length;
+	struct finger finger[COMPATIBLE_TOUCHES];
+} __packed;
+
+struct touch_subdata {
+	u8 status;
+	struct finger finger;
+} __packed;
+
+struct panel_info {
+	struct finger finger_max;
+	u8 xchannel_num;
+	u8 ychannel_num;
+} __packed;
+
+struct firmware_version {
+	u8 id;
+	u8 major;
+	u8 minor;
+} __packed;
+
+struct ili2139 {
+	struct i2c_client *client;
+	struct input_dev *input;
+	unsigned int poll_period;
+	struct delayed_work dwork;
+	struct touchscreen_properties prop;
+	int slots[MAX_TOUCHES];
+	int ids[MAX_TOUCHES];
+	struct input_mt_pos pos[MAX_TOUCHES];
+};
+
+static int ili2139_read_reg(struct i2c_client *client, u8 reg, void *buf,
+			    size_t len)
+{
+	struct i2c_msg msg[2] = {
+		{
+			.addr	= client->addr,
+			.flags	= 0,
+			.len	= 1,
+			.buf	= &reg,
+		},
+		{
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+			.len	= len,
+			.buf	= buf,
+		}
+	};
+
+	if (i2c_transfer(client->adapter, msg, 2) != 2) {
+		dev_err(&client->dev, "i2c transfer failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void ili2139_work(struct work_struct *work)
+{
+	int id;
+	struct ili2139 *priv = container_of(work, struct ili2139,
+					    dwork.work);
+	struct i2c_client *client = priv->client;
+	struct touchdata touchdata;
+	struct touch_subdata subdata;
+	int error;
+
+	error = ili2139_read_reg(client, REG_TOUCHDATA,
+				 &touchdata, sizeof(touchdata));
+	if (error) {
+		dev_err(&client->dev,
+			"Unable to get touchdata, err = %d\n", error);
+		return;
+	}
+
+	for (id = 0; id < touchdata.length; id++) {
+		error = ili2139_read_reg(client, REG_TOUCHSUBDATA, &subdata,
+					 sizeof(subdata));
+		if (error) {
+			dev_err(&client->dev,
+				"Unable to get touch subdata, err = %d\n",
+				error);
+			return;
+		}
+
+		priv->ids[id] = subdata.status & 0x3F;
+
+		/* The sequence changed in the v2 subdata protocol. */
+		touchscreen_set_mt_pos(&priv->pos[id], &priv->prop,
+			(subdata.finger.x_high | (subdata.finger.x_low << 8)),
+			(subdata.finger.y_high | (subdata.finger.y_low << 8)));
+	}
+
+	input_mt_assign_slots(priv->input, priv->slots, priv->pos,
+			      touchdata.length, 0);
+
+	for (id = 0; id < touchdata.length; id++) {
+		input_mt_slot(priv->input, priv->slots[id]);
+		input_mt_report_slot_state(priv->input, MT_TOOL_FINGER,
+					   subdata.status &
+					   SUBDATA_STATUS_TOUCH_POINT);
+		input_report_abs(priv->input, ABS_MT_POSITION_X,
+				 priv->pos[id].x);
+		input_report_abs(priv->input, ABS_MT_POSITION_Y,
+				 priv->pos[id].y);
+	}
+
+	input_mt_sync_frame(priv->input);
+	input_sync(priv->input);
+
+	schedule_delayed_work(&priv->dwork,
+			      msecs_to_jiffies(priv->poll_period));
+}
+
+static irqreturn_t ili2139_irq(int irq, void *irq_data)
+{
+	struct ili2139 *priv = irq_data;
+
+	schedule_delayed_work(&priv->dwork, 0);
+
+	return IRQ_HANDLED;
+}
+
+static int ili2139_i2c_probe(struct i2c_client *client,
+				       const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct ili2139 *priv;
+	struct input_dev *input;
+	struct panel_info panel;
+	struct firmware_version firmware;
+	int xmax, ymax;
+	int error;
+
+	dev_dbg(dev, "Probing for ILI2139 I2C Touschreen driver");
+
+	if (client->irq <= 0) {
+		dev_err(dev, "No IRQ!\n");
+		return -ENODEV;
+	}
+
+	/* Get firmware version */
+	error = ili2139_read_reg(client, REG_FIRMWARE_VERSION,
+				 &firmware, sizeof(firmware));
+	if (error) {
+		dev_err(dev, "Failed to get firmware version, err: %d\n",
+			error);
+		return error;
+	}
+
+	/* get panel info */
+	error = ili2139_read_reg(client, REG_PANEL_INFO, &panel, sizeof(panel));
+	if (error) {
+		dev_err(dev, "Failed to get panel information, err: %d\n",
+			error);
+		return error;
+	}
+
+	xmax = panel.finger_max.x_low | (panel.finger_max.x_high << 8);
+	ymax = panel.finger_max.y_low | (panel.finger_max.y_high << 8);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	input = devm_input_allocate_device(dev);
+	if (!priv || !input)
+		return -ENOMEM;
+
+	priv->client = client;
+	priv->input = input;
+	priv->poll_period = DEFAULT_POLL_PERIOD;
+	INIT_DELAYED_WORK(&priv->dwork, ili2139_work);
+
+	/* Setup input device */
+	input->name = "ILI2139 Touchscreen";
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = dev;
+
+	__set_bit(EV_SYN, input->evbit);
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_ABS, input->evbit);
+
+	/* Multi touch */
+	input_mt_init_slots(input, MAX_TOUCHES, INPUT_MT_DIRECT |
+			    INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK);
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, xmax, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ymax, 0, 0);
+
+	touchscreen_parse_properties(input, true, &priv->prop);
+
+	input_set_drvdata(input, priv);
+	i2c_set_clientdata(client, priv);
+
+	error = devm_request_irq(dev, client->irq, ili2139_irq,
+				 IRQF_TRIGGER_FALLING, client->name, priv);
+	if (error) {
+		dev_err(dev, "Unable to request touchscreen IRQ, err: %d\n",
+			error);
+		return error;
+	}
+
+	error = input_register_device(priv->input);
+	if (error) {
+		dev_err(dev, "Cannot register input device, err: %d\n", error);
+		return error;
+	}
+
+	device_init_wakeup(&client->dev, 1);
+
+	dev_dbg(dev,
+		"ILI2139 initialized (IRQ: %d), firmware version %d.%d.%d",
+		client->irq, firmware.id, firmware.major, firmware.minor);
+
+	return 0;
+}
+
+static int ili2139_i2c_remove(struct i2c_client *client)
+{
+	struct ili2139 *priv = i2c_get_clientdata(client);
+
+	cancel_delayed_work_sync(&priv->dwork);
+
+	return 0;
+}
+
+static int __maybe_unused ili2139_i2c_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int __maybe_unused ili2139_i2c_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ili2139_i2c_pm,
+			 ili2139_i2c_suspend, ili2139_i2c_resume);
+
+static const struct i2c_device_id ili2139_i2c_id[] = {
+	{ "ili2139", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ili2139_i2c_id);
+
+static struct i2c_driver ili2139_ts_driver = {
+	.driver = {
+		.name = "ili2139_i2c",
+		.pm = &ili2139_i2c_pm,
+	},
+	.id_table = ili2139_i2c_id,
+	.probe = ili2139_i2c_probe,
+	.remove = ili2139_i2c_remove,
+};
+
+module_i2c_driver(ili2139_ts_driver);
+
+MODULE_AUTHOR("Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>");
+MODULE_DESCRIPTION("ILI2139 I2C Touchscreen Driver");
+MODULE_LICENSE("GPL");
-- 
2.10.1
