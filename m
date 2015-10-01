From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v2] Input: Add support for FocalTech FT6236 touchscreen controller
Date: Thu,  1 Oct 2015 13:36:03 +0200
Message-ID: <1443699363-17626-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: xobs@kosagi.com, mark@ozzmaker.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
List-Id: linux-input@vger.kernel.org

This adds support for the FT6x06 and the FT6x36 family of
capacitive touch panel controllers, in particular the FT6236.

Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
---

The driver is based on:
https://github.com/adafruit/adafruit-raspberrypi-linux/blob/rpi-3.18.y/=
drivers/input/touchscreen/ft6x06_ts.c

Changes from v1:
	Dmitry Torokhov:
	s/ret/error/
	reset gpio polarity should be encoded in DT/ACPI data

 .../input/touchscreen/focaltech-ft6236.txt         |  35 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/input/touchscreen/Kconfig                  |  14 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/ft6236.c                 | 322 +++++++++++++=
++++++++
 5 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/focaltech-ft6236.txt
 create mode 100644 drivers/input/touchscreen/ft6236.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/focalt=
ech-ft6236.txt b/Documentation/devicetree/bindings/input/touchscreen/fo=
caltech-ft6236.txt
new file mode 100644
index 0000000..777521d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6=
236.txt
@@ -0,0 +1,35 @@
+* FocalTech FT6236 I2C touchscreen controller
+
+Required properties:
+ - compatible		  : "focaltech,ft6236"
+ - reg			  : I2C slave address of the chip (0x38)
+ - interrupt-parent	  : a phandle pointing to the interrupt controller
+			    serving the interrupt for this chip
+ - interrupts		  : interrupt specification for the touch controller
+			    interrupt
+ - reset-gpios		  : GPIO specification for the RSTN input
+ - touchscreen-size-x	  : horizontal resolution of touchscreen (in pix=
els)
+ - touchscreen-size-y	  : vertical resolution of touchscreen (in pixel=
s)
+
+Optional properties:
+ - touchscreen-fuzz-x	  : horizontal noise value of the absolute input
+			    device (in pixels)
+ - touchscreen-fuzz-y	  : vertical noise value of the absolute input
+			    device (in pixels)
+ - touchscreen-inverted-x : X axis is inverted (boolean)
+ - touchscreen-inverted-y : Y axis is inverted (boolean)
+ - touchscreen-swapped-x-y: X and Y axis are swapped (boolean)
+			    Swapping is done after inverting the axis
+
+Example:
+
+	ft6x06@38 {
+		compatible =3D "focaltech,ft6236";
+		reg =3D <0x38>;
+		interrupt-parent =3D <&gpio>;
+		interrupts =3D <23 2>;
+		touchscreen-size-x =3D <320>;
+		touchscreen-size-y =3D <480>;
+		touchscreen-inverted-x;
+		touchscreen-swapped-x-y;
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Do=
cumentation/devicetree/bindings/vendor-prefixes.txt
index 8033919..08490ef 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -76,6 +76,7 @@ everspin	Everspin Technologies, Inc.
 excito	Excito
 fcs	Fairchild Semiconductor
 firefly	Firefly
+focaltech	FocalTech Systems Co.,Ltd
 fsl	Freescale Semiconductor
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index d7e74a1..7982b87 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -295,6 +295,20 @@ config TOUCHSCREEN_EGALAX
 	  To compile this driver as a module, choose M here: the
 	  module will be called egalax_ts.

+config TOUCHSCREEN_FT6236
+	tristate "FT6236 I2C touchscreen"
+	depends on I2C
+	depends on GPIOLIB
+	help
+	  Say Y here to enable support for the I2C connected FT6x06 and
+	  FT6x36 family of capacitive touchscreen drivers.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ft6236.
+
+
 config TOUCHSCREEN_FUJITSU
 	tristate "Fujitsu serial touchscreen"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
index a1be09f..c867f82 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_TOUCHSCREEN_EETI)		+=3D eeti_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ELAN)		+=3D elants_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+=3D elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+=3D egalax_ts.o
+obj-$(CONFIG_TOUCHSCREEN_FT6236)	+=3D ft6236.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+=3D fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+=3D goodix.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+=3D ili210x.o
diff --git a/drivers/input/touchscreen/ft6236.c b/drivers/input/touchsc=
reen/ft6236.c
new file mode 100644
index 0000000..e8cd9fc
--- /dev/null
+++ b/drivers/input/touchscreen/ft6236.c
@@ -0,0 +1,322 @@
+/*
+ * FocalTech FT6236 TouchScreen driver.
+ *
+ * Copyright (c) 2010  Focal tech Ltd.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/property.h>
+
+#define FT6236_MAX_TOUCH_POINTS		2
+
+#define FT6236_REG_TH_GROUP		0x80
+#define FT6236_REG_PERIODACTIVE		0x88
+#define FT6236_REG_LIB_VER_H		0xa1
+#define FT6236_REG_LIB_VER_L		0xa2
+#define FT6236_REG_CIPHER		0xa3
+#define FT6236_REG_FIRMID		0xa6
+#define FT6236_REG_FOCALTECH_ID		0xa8
+#define FT6236_REG_RELEASE_CODE_ID	0xaf
+
+#define FT6236_EVENT_PRESS_DOWN		0
+#define FT6236_EVENT_LIFT_UP		1
+#define FT6236_EVENT_CONTACT		2
+#define FT6236_EVENT_NO_EVENT		3
+
+struct ft6236_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct gpio_desc *reset_gpio;
+	u32 max_x;
+	u32 max_y;
+	bool invert_x;
+	bool invert_y;
+	bool swap_xy;
+};
+
+/*
+ * This struct is a touchpoint as stored in hardware.  Note that the i=
d,
+ * as well as the event, are stored in the upper nybble of the hi byte=
=2E
+ */
+struct ft6236_touchpoint {
+	union {
+		u8 xhi;
+		u8 event;
+	};
+	u8 xlo;
+	union {
+		u8 yhi;
+		u8 id;
+	};
+	u8 ylo;
+	u8 weight;
+	u8 misc;
+} __packed;
+
+/* This packet represents the register map as read from offset 0 */
+struct ft6236_packet {
+	u8 dev_mode;
+	u8 gest_id;
+	u8 touches;
+	struct ft6236_touchpoint points[FT6236_MAX_TOUCH_POINTS];
+} __packed;
+
+static int ft6236_read(struct i2c_client *client, u8 reg, u8 len, void=
 *data)
+{
+	int error;
+
+	error =3D i2c_smbus_read_i2c_block_data(client, reg, len, data);
+	if (error < 0)
+		return error;
+	if (error !=3D len)
+		return -EIO;
+	return 0;
+}
+
+static irqreturn_t ft6236_interrupt(int irq, void *dev_id)
+{
+	struct ft6236_data *ft6236 =3D dev_id;
+	struct device *dev =3D &ft6236->client->dev;
+	struct input_dev *input =3D ft6236->input;
+	struct ft6236_packet buf;
+	u8 touches;
+	int i, error;
+
+	error =3D ft6236_read(ft6236->client, 0, sizeof(buf), &buf);
+	if (error) {
+		dev_err(dev, "read touchdata failed %d\n", error);
+		return IRQ_HANDLED;
+	}
+
+	touches =3D buf.touches & 0xf;
+	if (touches > FT6236_MAX_TOUCH_POINTS) {
+		dev_dbg(dev,
+			"%d touch points reported, only %d are supported\n",
+			touches, FT6236_MAX_TOUCH_POINTS);
+		touches =3D FT6236_MAX_TOUCH_POINTS;
+	}
+
+	for (i =3D 0; i < touches; i++) {
+		u16 x =3D ((buf.points[i].xhi & 0xf) << 8) | buf.points[i].xlo;
+		u16 y =3D ((buf.points[i].yhi & 0xf) << 8) | buf.points[i].ylo;
+		u8 event =3D buf.points[i].event >> 6;
+		u8 id =3D buf.points[i].id >> 4;
+		bool act =3D (event =3D=3D FT6236_EVENT_PRESS_DOWN ||
+			    event =3D=3D FT6236_EVENT_CONTACT);
+
+		input_mt_slot(input, id);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, act);
+		if (!act)
+			continue;
+
+		if (ft6236->invert_x)
+			x =3D ft6236->max_x - x;
+
+		if (ft6236->invert_y)
+			y =3D ft6236->max_y - y;
+
+		if (ft6236->swap_xy) {
+			input_report_abs(input, ABS_MT_POSITION_X, y);
+			input_report_abs(input, ABS_MT_POSITION_Y, x);
+		} else {
+			input_report_abs(input, ABS_MT_POSITION_X, x);
+			input_report_abs(input, ABS_MT_POSITION_Y, y);
+		}
+	}
+
+	input_mt_sync_frame(input);
+	input_sync(input);
+
+	return IRQ_HANDLED;
+}
+
+static u8 ft6236_debug_read_byte(struct ft6236_data *ft6236, u8 reg)
+{
+	struct i2c_client *client =3D ft6236->client;
+	u8 val =3D 0;
+	int error;
+
+	error =3D ft6236_read(client, reg, 1, &val);
+	if (error)
+		dev_dbg(&client->dev, "error reading register 0x%02x\n", reg);
+	return val;
+}
+
+static void ft6236_debug_info(struct ft6236_data *ft6236)
+{
+	struct device *dev =3D &ft6236->client->dev;
+
+	dev_dbg(dev, "Touch threshold is %d\n",
+		ft6236_debug_read_byte(ft6236, FT6236_REG_TH_GROUP) * 4);
+	dev_dbg(dev, "Report rate is %dHz\n",
+		ft6236_debug_read_byte(ft6236, FT6236_REG_PERIODACTIVE) * 10);
+	dev_dbg(dev, "Firmware library version 0x%02x%02x\n",
+		ft6236_debug_read_byte(ft6236, FT6236_REG_LIB_VER_H),
+		ft6236_debug_read_byte(ft6236, FT6236_REG_LIB_VER_L));
+	dev_dbg(dev, "Firmware version 0x%02x\n",
+		ft6236_debug_read_byte(ft6236, FT6236_REG_FIRMID));
+	dev_dbg(dev, "Chip vendor ID 0x%02x\n",
+		ft6236_debug_read_byte(ft6236, FT6236_REG_CIPHER));
+	dev_dbg(dev, "CTPM vendor ID 0x%02x\n",
+		ft6236_debug_read_byte(ft6236, FT6236_REG_FOCALTECH_ID));
+	dev_dbg(dev, "Release code version 0x%02x\n",
+		ft6236_debug_read_byte(ft6236, FT6236_REG_RELEASE_CODE_ID));
+}
+
+static void ft6236_reset(struct ft6236_data *ft6236)
+{
+	if (!ft6236->reset_gpio)
+		return;
+
+	gpiod_set_value_cansleep(ft6236->reset_gpio, 1);
+	usleep_range(5000, 20000);
+	gpiod_set_value_cansleep(ft6236->reset_gpio, 0);
+	msleep(300);
+}
+
+static int ft6236_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct device *dev =3D &client->dev;
+	struct ft6236_data *ft6236;
+	struct input_dev *input;
+	u32 fuzz_x =3D 0, fuzz_y =3D 0;
+	u8 val;
+	int error;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	if (!client->irq) {
+		dev_err(dev, "irq is missing\n");
+		return -EINVAL;
+	}
+
+	ft6236 =3D devm_kzalloc(dev, sizeof(*ft6236), GFP_KERNEL);
+	if (!ft6236)
+		return -ENOMEM;
+
+	ft6236->client =3D client;
+	ft6236->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(ft6236->reset_gpio)) {
+		error =3D PTR_ERR(ft6236->reset_gpio);
+		if (error !=3D -EPROBE_DEFER)
+			dev_err(dev, "error getting reset gpio\n");
+		return error;
+	}
+
+	ft6236_reset(ft6236);
+
+	/* verify that the controller is present */
+	error =3D ft6236_read(client, 0x00, 1, &val);
+	if (error) {
+		dev_err(dev, "failed to read from controller\n");
+		return error;
+	}
+
+	ft6236_debug_info(ft6236);
+
+	input =3D devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	ft6236->input =3D input;
+	input->name =3D client->name;
+	input->id.bustype =3D BUS_I2C;
+
+	if (device_property_read_u32(dev, "touchscreen-size-x",
+				     &ft6236->max_x) ||
+	    device_property_read_u32(dev, "touchscreen-size-y",
+				     &ft6236->max_y)) {
+		dev_err(dev, "touchscreen-size-x and/or -y missing\n");
+		return -EINVAL;
+	}
+
+	device_property_read_u32(dev, "touchscreen-fuzz-x", &fuzz_x);
+	device_property_read_u32(dev, "touchscreen-fuzz-y", &fuzz_y);
+	ft6236->invert_x =3D device_property_read_bool(dev,
+						     "touchscreen-inverted-x");
+	ft6236->invert_y =3D device_property_read_bool(dev,
+						     "touchscreen-inverted-y");
+	ft6236->swap_xy =3D device_property_read_bool(dev,
+						    "touchscreen-swapped-x-y");
+
+	if (ft6236->swap_xy) {
+		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
+				     ft6236->max_y, fuzz_y, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
+				     ft6236->max_x, fuzz_x, 0);
+	} else {
+		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
+				     ft6236->max_x, fuzz_x, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
+				     ft6236->max_y, fuzz_y, 0);
+	}
+
+	error =3D input_mt_init_slots(input, FT6236_MAX_TOUCH_POINTS,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (error)
+		return error;
+
+	error =3D devm_request_threaded_irq(dev, client->irq, NULL,
+					  ft6236_interrupt, IRQF_ONESHOT,
+					  client->name, ft6236);
+	if (error < 0) {
+		dev_err(dev, "request irq failed\n");
+		return error;
+	}
+
+	error =3D input_register_device(input);
+	if (error) {
+		dev_err(dev, "failed to register input device\n");
+		return error;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ft6236_of_match[] =3D {
+	{ .compatible =3D "focaltech,ft6236", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ft6236_of_match);
+
+static const struct i2c_device_id ft6236_id[] =3D {
+	{ "ft6236", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ft6236_id);
+
+static struct i2c_driver ft6236_driver =3D {
+	.driver =3D {
+		.name =3D "ft6236",
+		.owner =3D THIS_MODULE,
+		.of_match_table =3D ft6236_of_match,
+	},
+	.probe =3D ft6236_probe,
+	.id_table =3D ft6236_id,
+};
+
+module_i2c_driver(ft6236_driver);
+
+MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>");
+MODULE_AUTHOR("Noralf Tr=C3=B8nnes <noralf@tronnes.org>");
+MODULE_DESCRIPTION("FocalTech FT6236 TouchScreen driver");
+MODULE_LICENSE("GPL");
--
2.2.2
