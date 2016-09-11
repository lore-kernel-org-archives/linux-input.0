From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] [RFC] HID: udraw: Add support for the uDraw tablet for PS3
Date: Sun, 11 Sep 2016 18:48:24 +0200
Message-ID: <1473612504.7457.4.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53423 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755666AbcIKQse (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Sep 2016 12:48:34 -0400
Received: from mfilter48-d.gandi.net (mfilter48-d.gandi.net [217.70.178.179])
        by relay4-d.mail.gandi.net (Postfix) with ESMTP id 7201917209D
        for <linux-input@vger.kernel.org>; Sun, 11 Sep 2016 18:48:31 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
        by mfilter48-d.gandi.net (mfilter48-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id w5berIiVdWGU for <linux-input@vger.kernel.org>;
        Sun, 11 Sep 2016 18:48:29 +0200 (CEST)
Received: from surface (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A9D3F17209B
        for <linux-input@vger.kernel.org>; Sun, 11 Sep 2016 18:48:27 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This adds support for the THQ uDraw tablet for the PS3, as
4 separate device nodes, so that user-space can easily consume
events coming from the hardware.

Tested-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Bastien Nocera <hadess@hadess.net>

---

I didn't compile it in-tree yet, only out-of-tree, and I'm still
investigating support for LEDs, battery and better two-finger tap
support.

Comments welcome

 MAINTAINERS             |   6 +
 drivers/hid/Kconfig     |   7 +
 drivers/hid/Makefile    |   1 +
 drivers/hid/hid-core.c  |   1 +
 drivers/hid/hid-ids.h   |   3 +
 drivers/hid/hid-udraw.c | 434
++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 452 insertions(+)
 create mode 100644 drivers/hid/hid-udraw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cbef71..46b5dc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11835,6 +11835,12 @@ S:	Maintained
 F:	Documentation/filesystems/udf.txt
 F:	fs/udf/
 
+UDRAW TABLET
+M:	Bastien Nocera <hadess@hadess.net>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-udraw.c
+
 UFS FILESYSTEM
 M:	Evgeniy Dushistov <dushistov@mail.ru>
 S:	Maintained
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 78ac481..be24a81 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -856,6 +856,13 @@ config THRUSTMASTER_FF
 	  a THRUSTMASTER Dual Trigger 3-in-1 or a THRUSTMASTER Ferrari
GT
 	  Rumble Force or Force Feedback Wheel.
 
+config HID_UDRAW
+	tristate "THQ PS3 uDraw tablet"
+	depends on HID
+	---help---
+	  Say Y here if you want to use the THQ uDraw gaming tablet
for
+	  the PS3.
+
 config HID_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index fc4b2aa..b7d7fb5 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_HID_TIVO)		+= hid-tivo.o
 obj-$(CONFIG_HID_TOPSEED)	+= hid-topseed.o
 obj-$(CONFIG_HID_TWINHAN)	+= hid-twinhan.o
 obj-$(CONFIG_HID_UCLOGIC)	+= hid-uclogic.o
+obj-$(CONFIG_HID_UDRAW)		+= hid-udraw.o
 obj-$(CONFIG_HID_LED)		+= hid-led.o
 obj-$(CONFIG_HID_XINMO)		+= hid-xinmo.o
 obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 08f53c7..3e2dcc3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2083,6 +2083,7 @@ static const struct hid_device_id
hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
USB_DEVICE_ID_UCLOGIC_TABLET_WP1062) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
USB_DEVICE_ID_UCLOGIC_WIRELESS_TABLET_TWHL850) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THQ,
USB_DEVICE_ID_THQ_PS3_UDRAW) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP,
USB_DEVICE_ID_SMARTJOY_PLUS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP,
USB_DEVICE_ID_SUPER_JOY_BOX_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP,
USB_DEVICE_ID_DUAL_USB_JOYPAD) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4ed9a4f..3756630 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -952,6 +952,9 @@
 #define USB_VENDOR_ID_THINGM		0x27b8
 #define USB_DEVICE_ID_BLINK1		0x01ed
 
+#define USB_VENDOR_ID_THQ		0x20d6
+#define USB_DEVICE_ID_THQ_PS3_UDRAW	0xcb17
+
 #define USB_VENDOR_ID_THRUSTMASTER	0x044f
 
 #define USB_VENDOR_ID_TIVO		0x150a
diff --git a/drivers/hid/hid-udraw.c b/drivers/hid/hid-udraw.c
new file mode 100644
index 0000000..6728cae
--- /dev/null
+++ b/drivers/hid/hid-udraw.c
@@ -0,0 +1,434 @@
+/*
+ * HID driver for THQ PS3 uDraw tablet
+ *
+ * Copyright (C) 2016 Red Hat Inc. All Rights Reserved
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation,
and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include "hid-ids.h"
+
+MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
+MODULE_DESCRIPTION("PS3 uDraw tablet driver");
+MODULE_LICENSE("GPL");
+
+/*
+ * Protocol information from:
+ * http://brandonw.net/udraw/
+ * and the source code of:
+ * https://vvvv.org/contribution/udraw-hid
+ */
+
+/*
+ * The device is setup with multiple input devices to make it easier
+ * to handle in user-space:
+ * - the touch area which works as a touchpad
+ * - the tablet area which works as a touchpad/drawing tablet
+ * - a joypad with a d-pad, and 7 buttons
+ * - an optional, disabled by default, accelerometer device
+ */
+
+static const unsigned short udraw_joy_key_table[] = {
+	BTN_SOUTH,
+	BTN_NORTH,
+	BTN_EAST,
+	BTN_WEST,
+	BTN_SELECT,
+	BTN_START,
+	BTN_MODE
+};
+
+enum {
+	TOUCH_NONE,
+	TOUCH_PEN,
+	TOUCH_FINGER,
+	TOUCH_FINGERS
+};
+
+/* Accelerometer min/max values
+ * in order, X, Y and Z
+ */
+struct {
+	int min;
+	int max;
+} accel_limits[] = {
+	{ 0x1EA, 0x216 },
+	{ 0x1EA, 0x216 },
+	{ 0x1EC, 0x218 }
+};
+
+#define DEVICE_NAME "THQ uDraw Game Tablet for PS3"
+/* resolution in pixels */
+#define RES_X 1920
+#define RES_Y 1080
+/* size in mm */
+#define WIDTH  160
+#define HEIGHT 90
+#define PRESSURE_OFFSET 0x71
+#define MAX_PRESSURE (0xFF - PRESSURE_OFFSET)
+
+struct udraw {
+	struct input_dev *joy_input_dev;
+	struct input_dev *touch_input_dev;
+	struct input_dev *pen_input_dev;
+	struct input_dev *accel_input_dev;
+	struct hid_device *hdev;
+};
+
+static int clamp_accel(int axis, int offset)
+{
+	axis = clamp(axis,
+			accel_limits[offset].min,
+			accel_limits[offset].max);
+	axis = (axis - accel_limits[offset].min) /
+			((accel_limits[offset].max -
+			  accel_limits[offset].min) * 0xFF);
+	return axis;
+}
+
+static int udraw_raw_event(struct hid_device *hdev, struct hid_report
*report,
+	 u8 *data, int len)
+{
+	struct udraw *udraw = hid_get_drvdata(hdev);
+	int touch;
+	int x, y, z;
+
+	if (len != 0x1B)
+		return 0;
+
+	if (data[11] == 0x00)
+		touch = TOUCH_NONE;
+	else if (data[11] == 0x40)
+		touch = TOUCH_PEN;
+	else if (data[11] == 0x80)
+		touch = TOUCH_FINGER;
+	else
+		touch = TOUCH_FINGERS;
+
+	/* joypad */
+	input_report_key(udraw->joy_input_dev, BTN_WEST, data[0] & 1);
+	input_report_key(udraw->joy_input_dev, BTN_SOUTH, data[0] &
2);
+	input_report_key(udraw->joy_input_dev, BTN_EAST, data[0] & 4);
+	input_report_key(udraw->joy_input_dev, BTN_NORTH, data[0] &
8);
+
+	input_report_key(udraw->joy_input_dev, BTN_SELECT, data[1] &
1);
+	input_report_key(udraw->joy_input_dev, BTN_START, data[1] &
2);
+	input_report_key(udraw->joy_input_dev, BTN_MODE, data[1] &
16);
+
+	x = y = 0;
+	switch (data[2]) {
+	case 0x0:
+		y = -127;
+		break;
+	case 0x1:
+		y = -127;
+		x = 127;
+		break;
+	case 0x2:
+		x = 127;
+		break;
+	case 0x3:
+		y = 127;
+		x = 127;
+		break;
+	case 0x4:
+		y = 127;
+		break;
+	case 0x5:
+		y = 127;
+		x = -127;
+		break;
+	case 0x6:
+		x = -127;
+		break;
+	case 0x7:
+		y = -127;
+		x = -127;
+		break;
+	default:
+		break;
+	}
+
+	input_report_abs(udraw->joy_input_dev, ABS_X, x);
+	input_report_abs(udraw->joy_input_dev, ABS_Y, y);
+
+	input_sync(udraw->joy_input_dev);
+
+	/* For pen and touchpad */
+	x = y = 0;
+	if (touch != TOUCH_NONE) {
+		if (data[15] != 0x0F)
+			x = data[15] * 256 + data[17];
+		if (data[16] != 0x0F)
+			y = data[16] * 256 + data[18];
+	}
+
+	/* touchpad */
+	if (touch == TOUCH_FINGER || touch == TOUCH_FINGERS) {
+		input_report_key(udraw->touch_input_dev, BTN_TOUCH,
1);
+		input_report_key(udraw->touch_input_dev,
BTN_TOOL_FINGER,
+				touch == TOUCH_FINGER);
+		input_report_key(udraw->touch_input_dev,
BTN_TOOL_DOUBLETAP,
+				touch == TOUCH_FINGERS);
+
+		input_report_abs(udraw->touch_input_dev, ABS_X, x);
+		input_report_abs(udraw->touch_input_dev, ABS_Y, y);
+	} else {
+		input_report_key(udraw->touch_input_dev, BTN_TOUCH,
0);
+		input_report_key(udraw->touch_input_dev,
BTN_TOOL_FINGER, 0);
+		input_report_key(udraw->touch_input_dev,
BTN_TOOL_DOUBLETAP, 0);
+	}
+	input_sync(udraw->touch_input_dev);
+
+	/* pen */
+	if (touch == TOUCH_PEN) {
+		int level;
+
+		level = clamp(data[13] - PRESSURE_OFFSET,
+				0, MAX_PRESSURE);
+
+		input_report_key(udraw->pen_input_dev, BTN_TOUCH,
(level != 0));
+		input_report_key(udraw->pen_input_dev, BTN_TOOL_PEN,
1);
+		input_report_abs(udraw->pen_input_dev, ABS_PRESSURE,
level);
+		input_report_abs(udraw->pen_input_dev, ABS_X, x);
+		input_report_abs(udraw->pen_input_dev, ABS_Y, y);
+	} else {
+		input_report_key(udraw->pen_input_dev, BTN_TOUCH, 0);
+		input_report_abs(udraw->pen_input_dev, ABS_PRESSURE,
0);
+		input_report_key(udraw->pen_input_dev, BTN_TOOL_PEN,
0);
+	}
+	input_sync(udraw->pen_input_dev);
+
+	/* accel */
+	x = (data[19] + (data[20] << 8));
+	x = clamp_accel(x, 0);
+	y = (data[21] + (data[22] << 8));
+	y = clamp_accel(y, 1);
+	z = (data[23] + (data[24] << 8));
+	z = clamp_accel(z, 2);
+	input_report_abs(udraw->accel_input_dev, ABS_X, x);
+	input_report_abs(udraw->accel_input_dev, ABS_Y, y);
+	input_report_abs(udraw->accel_input_dev, ABS_Z, z);
+	input_sync(udraw->accel_input_dev);
+
+	/* let hidraw and hiddev handle the report */
+	return 0;
+}
+
+static int udraw_open(struct input_dev *dev)
+{
+	struct udraw *udraw = input_get_drvdata(dev);
+
+	return hid_hw_open(udraw->hdev);
+}
+
+static void udraw_close(struct input_dev *dev)
+{
+	struct udraw *udraw = input_get_drvdata(dev);
+
+	hid_hw_close(udraw->hdev);
+}
+
+static struct input_dev *allocate_and_setup(struct hid_device *hdev,
+		const char *name)
+{
+	struct input_dev *input_dev;
+
+	input_dev = devm_input_allocate_device(&hdev->dev);
+	if (!input_dev)
+		return NULL;
+
+	input_dev->name = name;
+	input_dev->phys = hdev->phys;
+	input_dev->dev.parent = &hdev->dev;
+	input_dev->open = udraw_open;
+	input_dev->close = udraw_close;
+	input_dev->uniq = hdev->uniq;
+	input_dev->id.bustype = hdev->bus;
+	input_dev->id.vendor  = hdev->vendor;
+	input_dev->id.product = hdev->product;
+	input_dev->id.version = hdev->version;
+	input_set_drvdata(input_dev, hid_get_drvdata(hdev));
+
+	return input_dev;
+}
+
+static bool udraw_setup_touch(struct udraw *udraw,
+		struct hid_device *hdev)
+{
+	struct input_dev *input_dev;
+
+	input_dev = allocate_and_setup(hdev, DEVICE_NAME "
(touchpad)");
+	if (!input_dev)
+		return false;
+
+	input_dev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
+
+	set_bit(ABS_X, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_X, 0, RES_X, 1, 0);
+	input_abs_set_res(input_dev, ABS_X, RES_X / WIDTH);
+	set_bit(ABS_Y, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_Y, 0, RES_Y, 1, 0);
+	input_abs_set_res(input_dev, ABS_Y, RES_Y / HEIGHT);
+
+	set_bit(BTN_TOUCH, input_dev->keybit);
+	set_bit(BTN_TOOL_FINGER, input_dev->keybit);
+	set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
+
+	set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
+	udraw->touch_input_dev = input_dev;
+
+	return true;
+}
+
+static bool udraw_setup_pen(struct udraw *udraw,
+		struct hid_device *hdev)
+{
+	struct input_dev *input_dev;
+
+	input_dev = allocate_and_setup(hdev, DEVICE_NAME " (pen)");
+	if (!input_dev)
+		return false;
+
+	input_dev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
+
+	set_bit(ABS_X, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_X, 0, RES_X, 1, 0);
+	input_abs_set_res(input_dev, ABS_X, RES_X / WIDTH);
+	set_bit(ABS_Y, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_Y, 0, RES_Y, 1, 0);
+	input_abs_set_res(input_dev, ABS_Y, RES_Y / HEIGHT);
+	set_bit(ABS_PRESSURE, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_PRESSURE,
+			0, MAX_PRESSURE, 0, 0);
+
+	set_bit(BTN_TOUCH, input_dev->keybit);
+	set_bit(BTN_TOOL_PEN, input_dev->keybit);
+
+	set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
+	udraw->pen_input_dev = input_dev;
+
+	return true;
+}
+
+static bool udraw_setup_accel(struct udraw *udraw,
+		struct hid_device *hdev)
+{
+	struct input_dev *input_dev;
+
+	input_dev = allocate_and_setup(hdev, DEVICE_NAME "
(accelerometer)");
+	if (!input_dev)
+		return false;
+
+	input_dev->evbit[0] = BIT(EV_ABS);
+
+	/* 1G accel is reported as ~256, so clamp to 2G */
+	set_bit(ABS_X, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_X, -512, 512, 0, 0);
+	set_bit(ABS_Y, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_Y, -512, 512, 0, 0);
+	set_bit(ABS_Z, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_Z, -512, 512, 0, 0);
+
+	set_bit(INPUT_PROP_ACCELEROMETER, input_dev->propbit);
+
+	udraw->accel_input_dev = input_dev;
+
+	return true;
+}
+
+static bool udraw_setup_joypad(struct udraw *udraw,
+		struct hid_device *hdev)
+{
+	struct input_dev *input_dev;
+	int i;
+
+	input_dev = allocate_and_setup(hdev, DEVICE_NAME " (joypad)");
+	if (!input_dev)
+		return false;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+
+	set_bit(ABS_X, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_X, -127, 127, 0, 0);
+	set_bit(ABS_Y, input_dev->absbit);
+	input_set_abs_params(input_dev, ABS_Y, -127, 127, 0, 0);
+
+	for (i = 0; i < ARRAY_SIZE(udraw_joy_key_table); i++)
+		set_bit(udraw_joy_key_table[i], input_dev->keybit);
+
+	udraw->joy_input_dev = input_dev;
+
+	return true;
+}
+
+static int udraw_probe(struct hid_device *hdev, const struct
hid_device_id *id)
+{
+	struct udraw *udraw;
+	int ret;
+
+	udraw = devm_kzalloc(&hdev->dev, sizeof(struct udraw),
GFP_KERNEL);
+	if (!udraw)
+		return -ENOMEM;
+
+	udraw->hdev = hdev;
+
+	hid_set_drvdata(hdev, udraw);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	if (!udraw_setup_joypad(udraw, hdev) ||
+	    !udraw_setup_touch(udraw, hdev) ||
+	    !udraw_setup_pen(udraw, hdev) ||
+	    !udraw_setup_accel(udraw, hdev)) {
+		hid_err(hdev, "could not allocate interfaces\n");
+		return -ENOMEM;
+	}
+
+	ret = input_register_device(udraw->joy_input_dev) ||
+		input_register_device(udraw->touch_input_dev) ||
+		input_register_device(udraw->pen_input_dev) ||
+		input_register_device(udraw->accel_input_dev);
+	if (ret) {
+		hid_err(hdev, "failed to register interfaces\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW |
HID_CONNECT_DRIVER);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id udraw_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THQ,
USB_DEVICE_ID_THQ_PS3_UDRAW) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, udraw_devices);
+
+static struct hid_driver udraw_driver = {
+	.name = "hid-udraw",
+	.id_table = udraw_devices,
+	.raw_event = udraw_raw_event,
+	.probe = udraw_probe,
+};
+module_hid_driver(udraw_driver);
-- 
2.7.4
