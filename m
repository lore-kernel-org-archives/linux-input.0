From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 2/2] input: gt801_2plus1 - Add initial support for Goodix GT801 2+1
Date: Mon,  7 Dec 2015 09:26:01 +0200
Message-ID: <1449473161-3535-3-git-send-email-plaes@plaes.org>
References: <1449473161-3535-1-git-send-email-plaes@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449473161-3535-1-git-send-email-plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patch adds Goodix GT801 2+1 touchscreen controller support.

GT801 2+1 is a 10-finger touch controller consisting of
ARM controller interfacing two GT801 5-finger controllers.

Signed-off-by: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
---
 .../bindings/input/touchscreen/gt801_2plus1.txt    |  23 ++
 MAINTAINERS                                        |   6 +
 drivers/input/touchscreen/Kconfig                  |  19 +-
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/gt801_2plus1.c           | 375 +++++++++++++=
++++++++
 5 files changed, 421 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/gt801_2plus1.txt
 create mode 100644 drivers/input/touchscreen/gt801_2plus1.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/gt801_=
2plus1.txt b/Documentation/devicetree/bindings/input/touchscreen/gt801_=
2plus1.txt
new file mode 100644
index 0000000..070ff5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/gt801_2plus1.=
txt
@@ -0,0 +1,23 @@
+Device tree bindings for Goodix GT801 2+1 series touchscreen controlle=
r
+
+Required properties:
+
+ - compatible		: Should be "goodix,gt801_2plus1"
+ - reg			: I2C address of the chip. Should be 0x55
+ - interrupt-parent	: Interrupt controller to which the chip is connec=
ted
+ - interrupts		: Interrupt to which the chip is connected
+
+Example:
+
+	i2c@00000000 {
+		/* ... */
+
+		touchscreen@55 {
+			compatible =3D "goodix,gt801_2plus1";
+			reg =3D <0x55>;
+			interrupt-parent =3D <&gpio>;
+			interrupts =3D <0 0>;
+		};
+
+		/* ... */
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index cba790b..e292126 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4743,6 +4743,12 @@ L:	linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 F:	drivers/input/touchscreen/goodix.c
=20
+GOODIX GT801 2PLUS1 TOUCHSCREEN
+M:	Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
+L:	linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	drivers/input/touchscreen/gt801_2plus1.c
+
 GPIO SUBSYSTEM
 M:	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
 M:	Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index ae33da7..c7c3324 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -322,11 +322,11 @@ config TOUCHSCREEN_FUJITSU
 	  module will be called fujitsu-ts.
=20
 config TOUCHSCREEN_GOODIX
-	tristate "Goodix I2C touchscreen"
+	tristate "Goodix GT9xx I2C touchscreen"
 	depends on I2C
 	help
-	  Say Y here if you have the Goodix touchscreen (such as one
-	  installed in Onda v975w tablets) connected to your
+	  Say Y here if you have one of the Goodix GT9xx touchscreens
+	  (such as one installed in Onda v975w tablet) connected to your
 	  system. It also supports 5-finger chip models, which can be
 	  found on ARM tablets, like Wexler TAB7200 and MSI Primo73.
=20
@@ -335,6 +335,19 @@ config TOUCHSCREEN_GOODIX
 	  To compile this driver as a module, choose M here: the
 	  module will be called goodix.
=20
+config TOUCHSCREEN_GT801_2PLUS1
+	tristate "Goodix GT801 2+1 I2C touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have the Goodix GT801 2+1 touchscreen.
+	  This controller is found on some older ARM tablets like
+	  (Gemei G9 and Zareason Zatab).
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gt801_2plus1.
+
 config TOUCHSCREEN_ILI210X
 	tristate "Ilitek ILI210X based touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
index cbaa6ab..ff25d1b4 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+=3D egalax_ts.o
 obj-$(CONFIG_TOUCHSCREEN_FT6236)	+=3D ft6236.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+=3D fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+=3D goodix.o
+obj-$(CONFIG_TOUCHSCREEN_GT801_2PLUS1)	+=3D gt801_2plus1.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+=3D ili210x.o
 obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC)	+=3D imx6ul_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+=3D inexio.o
diff --git a/drivers/input/touchscreen/gt801_2plus1.c b/drivers/input/t=
ouchscreen/gt801_2plus1.c
new file mode 100644
index 0000000..e2be479
--- /dev/null
+++ b/drivers/input/touchscreen/gt801_2plus1.c
@@ -0,0 +1,375 @@
+/*
+ *  Driver for Goodix GT801 2+1 ARM touchscreen controllers
+ *
+ *  Copyright (c) 2015 Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>.
+ *
+ *  This code is based on goodix.c driver (c) 2014 Red Hat Inc,
+ *  various Android codedumps (c) 2010 - 2012 Goodix Technology
+ *  and cleanups done by Emilio L=C3=B3pez (turl) for linux-sunxi.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License as published by t=
he Free
+ * Software Foundation; version 2 of the License.
+ */
+#include <asm/unaligned.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/input/mt.h>
+
+struct gt801x_ts_data {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	int abs_x_max;
+	int abs_y_max;
+	unsigned int max_touch_num;
+	unsigned int int_trigger_type;
+};
+
+#define GOODIX_MAX_HEIGHT		4096
+#define GOODIX_MAX_WIDTH		4096
+#define GOODIX_INT_TRIGGER		1
+#define GOODIX_MAX_CONTACTS		10
+#define MAX_CONTACTS_LOC	5
+#define RESOLUTION_LOC		1
+#define TRIGGER_LOC		6
+
+/* Register defines */
+#define GT801X_COOR_ADDR		0x01
+#define GT801X_CONFIG_DATA	0x65
+#define GT801X_REG_ID			0xf0
+
+/* Device specific defines */
+#define GT801X_CONFIG_MAX_LENGTH	7
+#define GT801X_CONTACT_SIZE		5
+
+static const unsigned long goodix_irq_flags[] =3D {
+	IRQ_TYPE_EDGE_RISING,
+	IRQ_TYPE_EDGE_FALLING,
+	IRQ_TYPE_LEVEL_LOW,
+	IRQ_TYPE_LEVEL_HIGH,
+};
+
+/**
+ * gt801x_i2c_read - read data from a register of the i2c slave device=
=2E
+ *
+ * @client: i2c device.
+ * @reg: the register to read from.
+ * @buf: raw write data buffer.
+ * @len: length of the buffer to write
+ */
+static int gt801x_i2c_read(struct i2c_client *client,
+			   u8 reg, u8 *buf, int len)
+{
+	struct i2c_msg msgs[2];
+	int ret;
+
+	msgs[0].flags =3D 0;
+	msgs[0].addr  =3D client->addr;
+	msgs[0].len   =3D 1;
+	msgs[0].buf   =3D &reg;
+
+	msgs[1].flags =3D I2C_M_RD;
+	msgs[1].addr  =3D client->addr;
+	msgs[1].len   =3D len;
+	msgs[1].buf   =3D buf;
+
+	ret =3D i2c_transfer(client->adapter, msgs, 2);
+	return ret < 0 ? ret : (ret !=3D ARRAY_SIZE(msgs) ? -EIO : 0);
+}
+
+/**
+ * gt801x_process_events - Process incoming events
+ *
+ * @ts: our gt801x_ts_data pointer
+ *
+ * Called when the IRQ is triggered. Read the current device state, an=
d push
+ * the input events to the user space.
+ */
+static void gt801x_process_events(struct gt801x_ts_data *ts)
+{
+	u8 point_data[3 + GT801X_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
+	u8 touch_map[GOODIX_MAX_CONTACTS] =3D {0};
+	int input_x, input_y, input_w;
+	u8 checksum =3D 0;
+	u16 touch_raw;
+	u8 touch_num;
+	int error;
+	int loc;
+	int i;
+
+	error =3D gt801x_i2c_read(ts->client, GT801X_COOR_ADDR,
+				point_data, sizeof(point_data));
+	if (error) {
+		dev_err(&ts->client->dev, "I2C transfer error: %d\n", error);
+		return;
+	}
+
+	/* Fetch touch mapping bits */
+	touch_raw =3D get_unaligned_le16(&point_data[0]);
+	if (!touch_raw)
+		return;
+
+	/* Build touch map */
+	touch_num =3D 0;
+	for (i =3D 0; (touch_raw !=3D 0) && (i < ts->max_touch_num); i++) {
+		if (touch_raw & 1)
+			touch_map[touch_num++] =3D i;
+			touch_raw >>=3D 1;
+	}
+
+	/* Calculate checksum */
+	for (i =3D 0; i < (touch_num*GT801X_CONTACT_SIZE + 3); i++)
+		checksum +=3D point_data[i];
+	if (checksum !=3D 0)
+		return;
+
+	/* Report touches */
+	for (i =3D 0; i < touch_num; i++) {
+		loc =3D 2 + GT801X_CONTACT_SIZE * i;
+		input_x =3D get_unaligned_be16(&point_data[loc]);
+		input_y =3D get_unaligned_be16(&point_data[loc + 2]);
+		input_w =3D point_data[loc + 4];
+
+		input_mt_slot(ts->input_dev, i);
+		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
+		input_report_abs(ts->input_dev, ABS_MT_POSITION_X, input_x);
+		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, input_y);
+		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, input_w);
+		input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, input_w);
+	}
+
+	input_mt_sync_frame(ts->input_dev);
+	input_sync(ts->input_dev);
+}
+
+/**
+ * gt801x_ts_irq_handler - The IRQ handler
+ *
+ * @irq: interrupt number.
+ * @dev_id: private data pointer.
+ */
+static irqreturn_t gt801x_ts_irq_handler(int irq, void *dev_id)
+{
+	gt801x_process_events((struct gt801x_ts_data *)dev_id);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * gt801x_read_config - Read the embedded configuration of the panel
+ *
+ * @ts: our gt801x_ts_data pointer
+ *
+ * Must be called during probe
+ */
+static void gt801x_read_config(struct gt801x_ts_data *ts)
+{
+	u8 config[GT801X_CONFIG_MAX_LENGTH];
+	int error;
+
+	error =3D gt801x_i2c_read(ts->client, GT801X_CONFIG_DATA,
+				config,
+				GT801X_CONFIG_MAX_LENGTH);
+	if (error) {
+		dev_warn(&ts->client->dev,
+			 "Error reading config (%d), using defaults\n",
+			 error);
+		ts->abs_x_max =3D GOODIX_MAX_WIDTH;
+		ts->abs_y_max =3D GOODIX_MAX_HEIGHT;
+		ts->int_trigger_type =3D GOODIX_INT_TRIGGER;
+		ts->max_touch_num =3D GOODIX_MAX_CONTACTS;
+		return;
+	}
+
+	ts->abs_x_max =3D get_unaligned_be16(&config[RESOLUTION_LOC]);
+	ts->abs_y_max =3D get_unaligned_be16(&config[RESOLUTION_LOC + 2]);
+	ts->int_trigger_type =3D config[TRIGGER_LOC] & 0x03;
+	ts->max_touch_num =3D config[MAX_CONTACTS_LOC] & 0x0f;
+	if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
+		dev_err(&ts->client->dev,
+			"Invalid config, using defaults\n");
+		ts->abs_x_max =3D GOODIX_MAX_WIDTH;
+		ts->abs_y_max =3D GOODIX_MAX_HEIGHT;
+		ts->max_touch_num =3D GOODIX_MAX_CONTACTS;
+	}
+}
+
+/**
+ * gt801x_read_version - Read GT801 2+1 touchscreen version
+ *
+ * @client: the i2c client
+ * @version: output buffer containing the version on success
+ * @id: output buffer containing the id on success
+ */
+static int gt801x_read_version(struct i2c_client *client, u16 *version=
, u16 *id)
+{
+	int error;
+	u8 buf[16];
+
+	error =3D gt801x_i2c_read(client, GT801X_REG_ID, buf, sizeof(buf));
+	if (error) {
+		dev_err(&client->dev, "read version failed: %d\n", error);
+		return error;
+	}
+	/* TODO: version info contains 'GT801NI_3R15_1AV' */
+	print_hex_dump_bytes("", DUMP_PREFIX_NONE, buf, ARRAY_SIZE(buf));
+	*id =3D 0x802;
+	*version =3D 0x15;
+	dev_info(&client->dev, "ID %d, version: %04x\n", *id, *version);
+	return 0;
+}
+
+/**
+ * gt801x_i2c_test - I2C test function to check if the device answers.
+ *
+ * @client: the i2c client
+ */
+static int gt801x_i2c_test(struct i2c_client *client)
+{
+	int retry =3D 0;
+	int error;
+	u8 test;
+
+	while (retry++ < 2) {
+		error =3D gt801x_i2c_read(client, GT801X_CONFIG_DATA,
+					&test, 1);
+		if (!error)
+			return 0;
+
+		dev_err(&client->dev, "i2c test failed attempt %d: %d\n",
+			retry, error);
+		msleep(20);
+	}
+
+	return error;
+}
+
+/**
+ * gt801x_request_input_dev - Allocate, populate and register the inpu=
t device
+ *
+ * @ts: our gt801x_ts_data pointer
+ * @version: device firmware version
+ * @id: device ID
+ *
+ * Must be called during probe
+ */
+static int gt801x_request_input_dev(struct gt801x_ts_data *ts,
+					u16 version, u16 id)
+{
+	int error;
+
+	ts->input_dev =3D devm_input_allocate_device(&ts->client->dev);
+	if (!ts->input_dev) {
+		dev_err(&ts->client->dev, "Failed to allocate input device.");
+		return -ENOMEM;
+	}
+
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
+			     0, ts->abs_x_max, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
+			     0, ts->abs_y_max, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0)=
;
+	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0)=
;
+
+	input_mt_init_slots(ts->input_dev, ts->max_touch_num,
+			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+
+	ts->input_dev->name =3D "Goodix Capacitive TouchScreen (GT801 2+1)";
+	ts->input_dev->phys =3D "input/ts";
+	ts->input_dev->id.bustype =3D BUS_I2C;
+	ts->input_dev->id.vendor =3D 0x0416;
+	ts->input_dev->id.product =3D id;
+	ts->input_dev->id.version =3D version;
+
+	error =3D input_register_device(ts->input_dev);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Failed to register input device: %d", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int gt801x_ts_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	struct gt801x_ts_data *ts;
+	unsigned long irq_flags;
+	int error;
+	u16 version_info, id_info;
+
+	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "I2C check functionality failed.\n");
+		return -ENXIO;
+	}
+
+	ts =3D devm_kzalloc(&client->dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->client =3D client;
+	i2c_set_clientdata(client, ts);
+
+	error =3D gt801x_i2c_test(client);
+	if (error) {
+		dev_err(&client->dev, "I2C communication failure: %d\n", error);
+		return error;
+	}
+
+	error =3D gt801x_read_version(client, &version_info, &id_info);
+	if (error) {
+		dev_err(&client->dev, "Read version failed.\n");
+		return error;
+	}
+
+	gt801x_read_config(ts);
+
+	error =3D gt801x_request_input_dev(ts, version_info, id_info);
+	if (error)
+		return error;
+
+	irq_flags =3D goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
+	error =3D devm_request_threaded_irq(&ts->client->dev, client->irq,
+					  NULL, gt801x_ts_irq_handler,
+					  irq_flags, client->name, ts);
+	if (error) {
+		dev_err(&client->dev, "request IRQ failed: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id gt801x_ts_id[] =3D {
+	{ "GDIX1001:00", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, gt801x_ts_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id gt801x_of_match[] =3D {
+	{ .compatible =3D "goodix,gt801_2plus1" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gt801x_of_match);
+#endif
+
+static struct i2c_driver gt801x_ts_driver =3D {
+	.probe =3D gt801x_ts_probe,
+	.id_table =3D gt801x_ts_id,
+	.driver =3D {
+		.name =3D "Goodix-TS",
+		.of_match_table =3D of_match_ptr(gt801x_of_match),
+	},
+};
+module_i2c_driver(gt801x_ts_driver);
+
+MODULE_AUTHOR("Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>");
+MODULE_DESCRIPTION("Goodix GT801 2+1 touchscreen driver");
+MODULE_LICENSE("GPL v2");
--=20
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
