From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] input: Add support for Wacom protocol 4 serial tablets
Date: Sun, 20 Jul 2014 16:46:23 +0200
Message-ID: <1405867583-3321-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29699 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbaGTOqe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 10:46:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Julian Squires <julian@cipht.net>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Recent version of xf86-input-wacom no longer support directly accessing
serial tablets. Instead xf86-input-wacom now expects all wacom tablets to
be driven by the kernel and to show up as evdev devices.

This has caused old serial Wacom tablets to stop working for people who still
have such tablets. Julian Squires has written a serio input driver to fix this:
https://github.com/tokenrove/wacom-serial-iv

This is a cleaned up version of this driver with improved Graphire support
(I own an old Graphire myself).

Signed-off-by: Julian Squires <julian@cipht.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--
Changes in v2:
-Drop text about MOUSEDEV from Kconfig help
-Drop broken URL from comment documenting the protocol
-Change a number of data types in struct wacom to more appropriate types
---
 MAINTAINERS                          |   7 +
 drivers/input/tablet/Kconfig         |  10 +
 drivers/input/tablet/Makefile        |   1 +
 drivers/input/tablet/wacom_serial4.c | 598 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/serio.h           |   1 +
 5 files changed, 617 insertions(+)
 create mode 100644 drivers/input/tablet/wacom_serial4.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1629ac9..1128b57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9855,6 +9855,13 @@ M:	Pierre Ossman <pierre@ossman.eu>
 S:	Maintained
 F:	drivers/mmc/host/wbsd.*
 
+WACOM PROTOCOL 4 SERIAL TABLETS
+M:	Julian Squires <julian@cipht.net>
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/tablet/wacom_serial4.c
+
 WATCHDOG DEVICE DRIVERS
 M:	Wim Van Sebroeck <wim@iguana.be>
 L:	linux-watchdog@vger.kernel.org
diff --git a/drivers/input/tablet/Kconfig b/drivers/input/tablet/Kconfig
index bed7cbf..a5121b0 100644
--- a/drivers/input/tablet/Kconfig
+++ b/drivers/input/tablet/Kconfig
@@ -89,4 +89,14 @@ config TABLET_USB_WACOM
 	  To compile this driver as a module, choose M here: the
 	  module will be called wacom.
 
+config TABLET_SERIAL_WACOM4
+	tristate "Wacom protocol 4 serial tablet support"
+	select SERIO
+	help
+	  Say Y here if you want to use Wacom protocol 4 serial tablets.
+	  E.g. serial versions of the Cintiq, Graphire or Penpartner.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called wacom_serial4.
+
 endif
diff --git a/drivers/input/tablet/Makefile b/drivers/input/tablet/Makefile
index 3f6c252..4d9339f 100644
--- a/drivers/input/tablet/Makefile
+++ b/drivers/input/tablet/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_TABLET_USB_GTCO)	+= gtco.o
 obj-$(CONFIG_TABLET_USB_HANWANG) += hanwang.o
 obj-$(CONFIG_TABLET_USB_KBTAB)	+= kbtab.o
 obj-$(CONFIG_TABLET_USB_WACOM)	+= wacom.o
+obj-$(CONFIG_TABLET_SERIAL_WACOM4) += wacom_serial4.o
diff --git a/drivers/input/tablet/wacom_serial4.c b/drivers/input/tablet/wacom_serial4.c
new file mode 100644
index 0000000..e85242c
--- /dev/null
+++ b/drivers/input/tablet/wacom_serial4.c
@@ -0,0 +1,598 @@
+/*
+ * Wacom protocol 4 serial tablet driver
+ *
+ * Copyright 2014      Hans de Goede <hdegoede@redhat.com>
+ * Copyright 2011-2012 Julian Squires <julian@cipht.net>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version of 2 of the License, or (at your
+ * option) any later version. See the file COPYING in the main directory of
+ * this archive for more details.
+ *
+ * Many thanks to Bill Seremetis, without whom PenPartner support
+ * would not have been possible. Thanks to Patrick Mahoney.
+ *
+ * This driver was developed with reference to much code written by others,
+ * particularly:
+ *  - elo, gunze drivers by Vojtech Pavlik <vojtech@ucw.cz>;
+ *  - wacom_w8001 driver by Jaya Kumar <jayakumar.lkml@gmail.com>;
+ *  - the USB wacom input driver, credited to many people
+ *    (see drivers/input/tablet/wacom.h);
+ *  - new and old versions of linuxwacom / xf86-input-wacom credited to
+ *    Frederic Lepied, France. <Lepied@XFree86.org> and
+ *    Ping Cheng, Wacom. <pingc@wacom.com>;
+ *  - and xf86wacom.c (a presumably ancient version of the linuxwacom code),
+ *    by Frederic Lepied and Raph Levien <raph@gtk.org>.
+ *
+ * To do:
+ *  - support pad buttons; (requires access to a model with pad buttons)
+ *  - support (protocol 4-style) tilt (requires access to a > 1.4 rom model)
+ */
+
+/*
+ * Wacom serial protocol 4 documentation taken from linuxwacom-0.9.9 code,
+ * protocol 4 uses 7 or 9 byte of data in the following format:
+ *
+ *	Byte 1
+ *	bit 7  Sync bit always 1
+ *	bit 6  Pointing device detected
+ *	bit 5  Cursor = 0 / Stylus = 1
+ *	bit 4  Reserved
+ *	bit 3  1 if a button on the pointing device has been pressed
+ *	bit 2  P0 (optional)
+ *	bit 1  X15
+ *	bit 0  X14
+ *
+ *	Byte 2
+ *	bit 7  Always 0
+ *	bits 6-0 = X13 - X7
+ *
+ *	Byte 3
+ *	bit 7  Always 0
+ *	bits 6-0 = X6 - X0
+ *
+ *	Byte 4
+ *	bit 7  Always 0
+ *	bit 6  B3
+ *	bit 5  B2
+ *	bit 4  B1
+ *	bit 3  B0
+ *	bit 2  P1 (optional)
+ *	bit 1  Y15
+ *	bit 0  Y14
+ *
+ *	Byte 5
+ *	bit 7  Always 0
+ *	bits 6-0 = Y13 - Y7
+ *
+ *	Byte 6
+ *	bit 7  Always 0
+ *	bits 6-0 = Y6 - Y0
+ *
+ *	Byte 7
+ *	bit 7 Always 0
+ *	bit 6  Sign of pressure data; or wheel-rel for cursor tool
+ *	bit 5  P7; or REL1 for cursor tool
+ *	bit 4  P6; or REL0 for cursor tool
+ *	bit 3  P5
+ *	bit 2  P4
+ *	bit 1  P3
+ *	bit 0  P2
+ *
+ *	byte 8 and 9 are optional and present only
+ *	in tilt mode.
+ *
+ *	Byte 8
+ *	bit 7 Always 0
+ *	bit 6 Sign of tilt X
+ *	bit 5  Xt6
+ *	bit 4  Xt5
+ *	bit 3  Xt4
+ *	bit 2  Xt3
+ *	bit 1  Xt2
+ *	bit 0  Xt1
+ *
+ *	Byte 9
+ *	bit 7 Always 0
+ *	bit 6 Sign of tilt Y
+ *	bit 5  Yt6
+ *	bit 4  Yt5
+ *	bit 3  Yt4
+ *	bit 2  Yt3
+ *	bit 1  Yt2
+ *	bit 0  Yt1
+ */
+
+#include <linux/completion.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include "wacom_wac.h"
+
+MODULE_AUTHOR("Julian Squires <julian@cipht.net>, Hans de Goede <hdegoede@redhat.com>");
+MODULE_DESCRIPTION("Wacom protocol 4 serial tablet driver");
+MODULE_LICENSE("GPL");
+
+#define REQUEST_MODEL_AND_ROM_VERSION	"~#"
+#define REQUEST_MAX_COORDINATES		"~C\r"
+#define REQUEST_CONFIGURATION_STRING	"~R\r"
+#define REQUEST_RESET_TO_PROTOCOL_IV	"\r#"
+/* Note: sending "\r$\r" causes at least the Digitizer II to send
+ * packets in ASCII instead of binary.  "\r#" seems to undo that. */
+
+#define COMMAND_START_SENDING_PACKETS		"ST\r"
+#define COMMAND_STOP_SENDING_PACKETS		"SP\r"
+#define COMMAND_MULTI_MODE_INPUT		"MU1\r"
+#define COMMAND_ORIGIN_IN_UPPER_LEFT		"OC1\r"
+#define COMMAND_ENABLE_ALL_MACRO_BUTTONS	"~M0\r"
+#define COMMAND_DISABLE_GROUP_1_MACRO_BUTTONS	"~M1\r"
+#define COMMAND_TRANSMIT_AT_MAX_RATE		"IT0\r"
+#define COMMAND_DISABLE_INCREMENTAL_MODE	"IN0\r"
+#define COMMAND_ENABLE_CONTINUOUS_MODE		"SR\r"
+#define COMMAND_ENABLE_PRESSURE_MODE		"PH1\r"
+#define COMMAND_Z_FILTER			"ZF1\r"
+
+/* Note that this is a protocol 4 packet without tilt information. */
+#define PACKET_LENGTH		7
+#define DATA_SIZE		32
+
+/* flags */
+#define F_COVERS_SCREEN		0x01
+#define F_HAS_STYLUS2		0x02
+#define F_HAS_SCROLLWHEEL	0x04
+
+enum { STYLUS = 1, ERASER, CURSOR };
+struct { int device_id; int input_id; } tools[] = {
+	{ 0, 0 },
+	{ STYLUS_DEVICE_ID, BTN_TOOL_PEN },
+	{ ERASER_DEVICE_ID, BTN_TOOL_RUBBER },
+	{ CURSOR_DEVICE_ID, BTN_TOOL_MOUSE },
+};
+
+struct wacom {
+	struct input_dev *dev;
+	struct completion cmd_done;
+	int result;
+	u8 expect;
+	u8 eraser_mask;
+	unsigned int extra_z_bits;
+	unsigned int flags;
+	unsigned int res_x, res_y;
+	unsigned int max_x, max_y;
+	unsigned int tool;
+	unsigned int idx;
+	unsigned char data[DATA_SIZE];
+	char phys[32];
+};
+
+enum {
+	MODEL_CINTIQ		= 0x504C, /* PL */
+	MODEL_CINTIQ2		= 0x4454, /* DT */
+	MODEL_DIGITIZER_II	= 0x5544, /* UD */
+	MODEL_GRAPHIRE		= 0x4554, /* ET */
+	MODEL_PENPARTNER	= 0x4354, /* CT */
+};
+
+static void handle_model_response(struct wacom *wacom)
+{
+	int major_v, minor_v, r = 0;
+	char *p;
+
+	p = strrchr(wacom->data, 'V');
+	if (p)
+		r = sscanf(p + 1, "%u.%u", &major_v, &minor_v);
+	if (r != 2)
+		major_v = minor_v = 0;
+
+	switch (wacom->data[2] << 8 | wacom->data[3]) {
+	case MODEL_CINTIQ:	/* UNTESTED */
+	case MODEL_CINTIQ2:
+		if ((wacom->data[2] << 8 | wacom->data[3]) == MODEL_CINTIQ) {
+			wacom->dev->name = "Wacom Cintiq";
+			wacom->dev->id.version = MODEL_CINTIQ;
+		} else {
+			wacom->dev->name = "Wacom Cintiq II";
+			wacom->dev->id.version = MODEL_CINTIQ2;
+		}
+		wacom->res_x = 508;
+		wacom->res_y = 508;
+		switch (wacom->data[5]<<8 | wacom->data[6]) {
+		case 0x3731: /* PL-710 */
+			wacom->res_x = 2540;
+			wacom->res_y = 2540;
+			/* fall through */
+		case 0x3535: /* PL-550 */
+		case 0x3830: /* PL-800 */
+			wacom->extra_z_bits = 2;
+		}
+		wacom->flags = F_COVERS_SCREEN;
+		break;
+	case MODEL_PENPARTNER:
+		wacom->dev->name = "Wacom Penpartner";
+		wacom->dev->id.version = MODEL_PENPARTNER;
+		wacom->res_x = 1000;
+		wacom->res_y = 1000;
+		break;
+	case MODEL_GRAPHIRE:
+		wacom->dev->name = "Wacom Graphire";
+		wacom->dev->id.version = MODEL_GRAPHIRE;
+		wacom->res_x = 1016;
+		wacom->res_y = 1016;
+		wacom->max_x = 5103;
+		wacom->max_y = 3711;
+		wacom->extra_z_bits = 2;
+		wacom->eraser_mask = 0x08;
+		wacom->flags = F_HAS_STYLUS2 | F_HAS_SCROLLWHEEL;
+		break;
+	case MODEL_DIGITIZER_II:
+		wacom->dev->name = "Wacom Digitizer II";
+		wacom->dev->id.version = MODEL_DIGITIZER_II;
+		if (major_v == 1 && minor_v <= 2)
+			wacom->extra_z_bits = 0; /* UNTESTED */
+		break;
+	default:
+		dev_err(&wacom->dev->dev, "Unsupported Wacom model %s\n",
+			wacom->data);
+		wacom->result = -ENODEV;
+		return;
+	}
+	dev_info(&wacom->dev->dev, "%s tablet, version %u.%u\n",
+		 wacom->dev->name, major_v, minor_v);
+}
+
+static void handle_configuration_response(struct wacom *wacom)
+{
+	int r, skip;
+
+	dev_dbg(&wacom->dev->dev, "Configuration string: %s\n", wacom->data);
+	r = sscanf(wacom->data, "~R%x,%u,%u,%u,%u", &skip, &skip, &skip,
+		   &wacom->res_x, &wacom->res_y);
+	if (r != 5)
+		dev_warn(&wacom->dev->dev, "could not get resolution\n");
+}
+
+static void handle_coordinates_response(struct wacom *wacom)
+{
+	int r;
+
+	dev_dbg(&wacom->dev->dev, "Coordinates string: %s\n", wacom->data);
+	r = sscanf(wacom->data, "~C%u,%u", &wacom->max_x, &wacom->max_y);
+	if (r != 2)
+		dev_warn(&wacom->dev->dev, "could not get max coordinates\n");
+}
+
+static void handle_response(struct wacom *wacom)
+{
+	if (wacom->data[0] != '~' || wacom->data[1] != wacom->expect) {
+		dev_err(&wacom->dev->dev,
+			"Wacom got an unexpected response: %s\n", wacom->data);
+		wacom->result = -EIO;
+		complete(&wacom->cmd_done);
+		return;
+	}
+
+	wacom->result = 0;
+
+	switch (wacom->data[1]) {
+	case '#':
+		handle_model_response(wacom);
+		break;
+	case 'R':
+		handle_configuration_response(wacom);
+		break;
+	case 'C':
+		handle_coordinates_response(wacom);
+		break;
+	}
+
+	complete(&wacom->cmd_done);
+}
+
+static void handle_packet(struct wacom *wacom)
+{
+	u8 in_proximity_p, stylus_p, button;
+	unsigned int tool;
+	int x, y, z;
+
+	in_proximity_p = wacom->data[0] & 0x40;
+	stylus_p = wacom->data[0] & 0x20;
+	button = (wacom->data[3] & 0x78) >> 3;
+	x = (wacom->data[0] & 3) << 14 | wacom->data[1]<<7 | wacom->data[2];
+	y = (wacom->data[3] & 3) << 14 | wacom->data[4]<<7 | wacom->data[5];
+
+	if (in_proximity_p && stylus_p) {
+		z = wacom->data[6] & 0x7f;
+		if (wacom->extra_z_bits >= 1)
+			z = z << 1 | (wacom->data[3] & 0x4) >> 2;
+		if (wacom->extra_z_bits > 1)
+			z = z << 1 | (wacom->data[0] & 0x4) >> 2;
+		z = z ^ (0x40 << wacom->extra_z_bits);
+	} else {
+		z = -1;
+	}
+
+	if (stylus_p)
+		tool = (button & wacom->eraser_mask) ? ERASER : STYLUS;
+	else
+		tool = CURSOR;
+
+	if (tool != wacom->tool && wacom->tool != 0) {
+		input_report_key(wacom->dev, tools[wacom->tool].input_id, 0);
+		input_sync(wacom->dev);
+	}
+	wacom->tool = tool;
+
+	input_report_key(wacom->dev, tools[tool].input_id, in_proximity_p);
+	input_report_abs(wacom->dev, ABS_MISC,
+			 in_proximity_p ? tools[tool].device_id : 0);
+	input_report_abs(wacom->dev, ABS_X, x);
+	input_report_abs(wacom->dev, ABS_Y, y);
+	input_report_abs(wacom->dev, ABS_PRESSURE, z);
+	if (stylus_p) {
+		input_report_key(wacom->dev, BTN_TOUCH, button & 1);
+		input_report_key(wacom->dev, BTN_STYLUS, button & 2);
+		input_report_key(wacom->dev, BTN_STYLUS2, button & 4);
+	} else {
+		input_report_key(wacom->dev, BTN_LEFT, button & 1);
+		input_report_key(wacom->dev, BTN_RIGHT, button & 2);
+		input_report_key(wacom->dev, BTN_MIDDLE, button & 4);
+		/* handle relative wheel for non-stylus device */
+		z = (wacom->data[6] & 0x30) >> 4;
+		if (wacom->data[6] & 0x40)
+			z = -z;
+		input_report_rel(wacom->dev, REL_WHEEL, z);
+	}
+	input_sync(wacom->dev);
+}
+
+static void wacom_clear_data_buf(struct wacom *wacom)
+{
+	memset(wacom->data, 0, DATA_SIZE);
+	wacom->idx = 0;
+}
+
+static irqreturn_t wacom_interrupt(struct serio *serio, unsigned char data,
+				   unsigned int flags)
+{
+	struct wacom *wacom = serio_get_drvdata(serio);
+
+	if (data & 0x80)
+		wacom->idx = 0;
+
+	/*
+	 * We're either expecting a carriage return-terminated ASCII
+	 * response string, or a seven-byte packet with the MSB set on
+	 * the first byte.
+	 *
+	 * Note however that some tablets (the PenPartner, for
+	 * example) don't send a carriage return at the end of a
+	 * command.  We handle these by waiting for timeout.
+	 */
+	if (data == '\r' && !(wacom->data[0] & 0x80)) {
+		handle_response(wacom);
+		wacom_clear_data_buf(wacom);
+		return IRQ_HANDLED;
+	}
+
+	/* Leave place for 0 termination */
+	if (wacom->idx > (DATA_SIZE - 2)) {
+		dev_dbg(&wacom->dev->dev,
+			"throwing away %d bytes of garbage\n", wacom->idx);
+		wacom_clear_data_buf(wacom);
+	}
+	wacom->data[wacom->idx++] = data;
+
+	if (wacom->idx == PACKET_LENGTH && (wacom->data[0] & 0x80)) {
+		handle_packet(wacom);
+		wacom_clear_data_buf(wacom);
+	}
+	return IRQ_HANDLED;
+}
+
+static void wacom_disconnect(struct serio *serio)
+{
+	struct wacom *wacom = serio_get_drvdata(serio);
+
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	input_unregister_device(wacom->dev);
+	kfree(wacom);
+}
+
+static int wacom_send(struct serio *serio, const char *command)
+{
+	int err = 0;
+
+	for (; !err && *command; command++)
+		err = serio_write(serio, *command);
+
+	return err;
+}
+
+static int send_setup_string(struct wacom *wacom, struct serio *serio)
+{
+	const char *s;
+
+	switch (wacom->dev->id.version) {
+	case MODEL_CINTIQ:	/* UNTESTED */
+		s = COMMAND_ORIGIN_IN_UPPER_LEFT
+			COMMAND_TRANSMIT_AT_MAX_RATE
+			COMMAND_ENABLE_CONTINUOUS_MODE
+			COMMAND_START_SENDING_PACKETS;
+		break;
+	case MODEL_PENPARTNER:
+		s = COMMAND_ENABLE_PRESSURE_MODE
+			COMMAND_START_SENDING_PACKETS;
+		break;
+	default:
+		s = COMMAND_MULTI_MODE_INPUT
+			COMMAND_ORIGIN_IN_UPPER_LEFT
+			COMMAND_ENABLE_ALL_MACRO_BUTTONS
+			COMMAND_DISABLE_GROUP_1_MACRO_BUTTONS
+			COMMAND_TRANSMIT_AT_MAX_RATE
+			COMMAND_DISABLE_INCREMENTAL_MODE
+			COMMAND_ENABLE_CONTINUOUS_MODE
+			COMMAND_Z_FILTER
+			COMMAND_START_SENDING_PACKETS;
+		break;
+	}
+	return wacom_send(serio, s);
+}
+
+static int wacom_send_and_wait(struct wacom *wacom, struct serio *serio,
+	const char *cmd, const char *desc)
+{
+	int err;
+	unsigned long u;
+
+	wacom->expect = cmd[1];
+	init_completion(&wacom->cmd_done);
+	err = wacom_send(serio, cmd);
+	if (err)
+		return err;
+	u = wait_for_completion_timeout(&wacom->cmd_done, HZ);
+	if (u == 0) {
+		/* Timeout, process what we've received. */
+		handle_response(wacom);
+	}
+	wacom->expect = 0;
+	return wacom->result;
+}
+
+static int wacom_setup(struct wacom *wacom, struct serio *serio)
+{
+	int err;
+
+	/* Note that setting the link speed is the job of inputattach.
+	 * We assume that reset negotiation has already happened,
+	 * here. */
+	err = wacom_send_and_wait(wacom, serio, REQUEST_MODEL_AND_ROM_VERSION,
+				  "model and version");
+	if (err)
+		return err;
+
+	if (!(wacom->res_x && wacom->res_y)) {
+		err = wacom_send_and_wait(wacom, serio,
+					  REQUEST_CONFIGURATION_STRING,
+					  "configuration string");
+		if (err)
+			return err;
+	}
+
+	if (!(wacom->max_x && wacom->max_y)) {
+		err = wacom_send_and_wait(wacom, serio,
+					  REQUEST_MAX_COORDINATES,
+					  "coordinates string");
+		if (err)
+			return err;
+	}
+
+	return send_setup_string(wacom, serio);
+}
+
+static int wacom_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct wacom *wacom;
+	struct input_dev *input_dev;
+	int err = -ENOMEM;
+
+	wacom = kzalloc(sizeof(struct wacom), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!wacom || !input_dev)
+		goto free_device;
+
+	wacom->dev = input_dev;
+	wacom->extra_z_bits = 1;
+	wacom->eraser_mask = 0x04;
+	wacom->tool = wacom->idx = 0;
+	snprintf(wacom->phys, sizeof(wacom->phys), "%s/input0", serio->phys);
+	input_dev->phys = wacom->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor  = SERIO_WACOM_IV;
+	input_dev->id.product = serio->id.extra;
+	input_dev->dev.parent = &serio->dev;
+
+	input_dev->evbit[0] =
+		BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS) | BIT_MASK(EV_REL);
+	set_bit(ABS_MISC, input_dev->absbit);
+	set_bit(BTN_TOOL_PEN, input_dev->keybit);
+	set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
+	set_bit(BTN_TOOL_MOUSE, input_dev->keybit);
+	set_bit(BTN_TOUCH, input_dev->keybit);
+	set_bit(BTN_STYLUS, input_dev->keybit);
+	set_bit(BTN_LEFT, input_dev->keybit);
+	set_bit(BTN_RIGHT, input_dev->keybit);
+	set_bit(BTN_MIDDLE, input_dev->keybit);
+
+	serio_set_drvdata(serio, wacom);
+
+	err = serio_open(serio, drv);
+	if (err)
+		goto free_device;
+
+	err = wacom_setup(wacom, serio);
+	if (err)
+		goto close_serio;
+
+	set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+	if (!(wacom->flags & F_COVERS_SCREEN))
+		set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+
+	if (wacom->flags & F_HAS_STYLUS2)
+		set_bit(BTN_STYLUS2, input_dev->keybit);
+
+	if (wacom->flags & F_HAS_SCROLLWHEEL)
+		set_bit(REL_WHEEL, input_dev->relbit);
+
+	input_abs_set_res(wacom->dev, ABS_X, wacom->res_x);
+	input_abs_set_res(wacom->dev, ABS_Y, wacom->res_y);
+	input_set_abs_params(wacom->dev, ABS_X, 0, wacom->max_x, 0, 0);
+	input_set_abs_params(wacom->dev, ABS_Y, 0, wacom->max_y, 0, 0);
+	input_set_abs_params(wacom->dev, ABS_PRESSURE, -1,
+			     (1 << (7 + wacom->extra_z_bits)) - 1, 0, 0);
+
+	err = input_register_device(wacom->dev);
+	if (err)
+		goto close_serio;
+
+	return 0;
+
+close_serio:
+	serio_close(serio);
+free_device:
+	serio_set_drvdata(serio, NULL);
+	input_free_device(input_dev);
+	kfree(wacom);
+	return err;
+}
+
+static struct serio_device_id wacom_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_WACOM_IV,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, wacom_serio_ids);
+
+static struct serio_driver wacom_drv = {
+	.driver		= {
+		.name	= "wacom_serial4",
+	},
+	.description	= "Wacom protocol 4 serial tablet driver",
+	.id_table	= wacom_serio_ids,
+	.interrupt	= wacom_interrupt,
+	.connect	= wacom_connect,
+	.disconnect	= wacom_disconnect,
+};
+
+module_serio_driver(wacom_drv);
diff --git a/include/uapi/linux/serio.h b/include/uapi/linux/serio.h
index 9f53fa7..becdd78 100644
--- a/include/uapi/linux/serio.h
+++ b/include/uapi/linux/serio.h
@@ -76,5 +76,6 @@
 #define SERIO_HAMPSHIRE	0x3b
 #define SERIO_PS2MULT	0x3c
 #define SERIO_TSC40	0x3d
+#define SERIO_WACOM_IV	0x3e
 
 #endif /* _UAPI_SERIO_H */
-- 
2.0.1

