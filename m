From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: [PATCH] EETI eGalaxTouch serial touchscreen driver, inputattach patch
Date: Mon, 14 Dec 2015 16:38:01 +0100
Message-ID: <566EE259.3030006@pr.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010800080502030801060107"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail9.pr.hu ([87.242.0.9]:40149 "EHLO mail9.pr.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbbLNQUp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2015 11:20:45 -0500
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
	by frontdoor.pr.hu with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <zboszor@pr.hu>)
	id 1a8VCS-0005kq-P6
	for linux-input@vger.kernel.org; Mon, 14 Dec 2015 16:38:08 +0100
Received: from host-87-242-63-18.prtelecom.hu ([87.242.63.18] helo=s002.sicom.com)
	by mail.pr.hu with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <zboszor@pr.hu>)
	id 1a8VCO-0002yq-Kb
	for linux-input@vger.kernel.org; Mon, 14 Dec 2015 16:38:06 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------010800080502030801060107
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit

Hi,

I have implemented the serial version of the EETI eGalaxTouch
touchscreen driver today using the Hampshire driver as a template.

I have also patched inputattach in linuxconsoletools 1.4.8 to initialize
and recognize the device.

I tested it with kernel 4.2.6 and Xorg 1.16.4 and xinput_calibrate with a stylus.

# inputattach -eeti /dev/ttyS3
EETI eGalaxTouch firmware: 1.13.3.HM-EX
EETI eGalaxTouch controller type: C8051F320

# dmesg | tail -f
...
[   48.381613] serio: Serial port ttyS3
[   48.388445] input: EETI eGalaxTouch Serial TouchScreen as
/devices/pnp0/00:06/tty/ttyS3/serio1/input/input9

Attached both the kernel module patch and the linuxconsoletools patch.
Can someone review these patches, please?

The kernel patch is

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>

No idea if the linuxconsoletools patch needs the annotation or not.

I also noticed that inputattach does not support SERIO_HAMPSHIRE
which was also added as a template in the patch.
Another note about inputattach.c in linuxconsoletools that it has
#ifdef SERIO_TSC40 ... #endif and SERIO_TSC40 is smaller, hence,
added earlier to the kernel than SERIO_WACOM_IV, for which the
support is unconditional. Isn't it a little inconsistent?

Best regards,
Zoltán Böszörményi


--------------010800080502030801060107
Content-Type: text/x-patch;
 name="linuxconsoletools-1.4.8-egalax-hampshire-serio-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="linuxconsoletools-1.4.8-egalax-hampshire-serio-support.patch"

diff -durpN linuxconsoletools-1.4.8.old/utils/inputattach.c linuxconsoletools-1.4.8/utils/inputattach.c
--- linuxconsoletools-1.4.8.old/utils/inputattach.c	2015-01-18 15:43:41.000000000 +0100
+++ linuxconsoletools-1.4.8/utils/inputattach.c	2015-12-14 11:07:46.351403884 +0100
@@ -622,6 +622,68 @@ static int wacom_iv_init(int fd, unsigne
 	return 0;
 }
 
+static int check_egalax_response(int fd, unsigned char *command, int sz, unsigned char *response) {
+	int pos = 0;
+	int error = 0;
+	int rest_length;
+
+	if (write(fd, command, sz) != sz)
+		return -1;
+
+	for (pos = 0; pos < 3; pos++) {
+		if (readchar(fd, &response[pos], 100)) {
+			error = 1;
+			break;
+		}
+	}
+
+	if (error)
+		return -1;
+
+	rest_length = response[1] - 1;
+
+	for (; rest_length; rest_length--, pos++) {
+		if (readchar(fd, &response[pos], 100)) {
+			error = 1;
+			break;
+		}
+	}
+
+	if (error)
+		return -1;
+
+	if (response[1] >= command[1] &&
+		response[0] == command[0] &&
+		response[2] == command[2])
+		return 0;
+
+	return -1;
+}
+
+static int egalax_init(int fd, unsigned long *id, unsigned long *extra) {
+	unsigned char packet_alive_query[3] = { 0x0a, 0x01, 'A' };
+	unsigned char packet_fw_ver[3] = { 0x0a, 0x01, 'D' };
+	unsigned char packet_ctrl_type[3] = { 0x0a, 0x01, 'E' };
+	unsigned char response[128];
+
+	if (check_egalax_response(fd, packet_alive_query, sizeof(packet_alive_query), response))
+		return -1;
+
+	if (check_egalax_response(fd, packet_fw_ver, sizeof(packet_fw_ver), response))
+		return -1;
+
+	response[(unsigned char)response[1] + 2] = '\0';
+	printf("EETI eGalaxTouch firmware: %s\n", &response[3]);
+
+	if (check_egalax_response(fd, packet_ctrl_type, sizeof(packet_ctrl_type), response))
+		return -1;
+
+	response[(unsigned char)response[1] + 2] = '\0';
+	printf("EETI eGalaxTouch controller type: %s\n", &response[3]);
+
+	return 0;
+}
+
 struct input_types {
 	const char *name;
 	const char *name2;
@@ -704,6 +766,11 @@ static struct input_types input_types[]
 { "--twiddler-joy",	"-twidjoy",	"Handykey Twiddler used as a joystick",
 	B2400, CS8,
 	SERIO_TWIDJOY,		0x00,	0x00,	0,	twiddler_init },
+#ifdef SERIO_EGALAX
+{ "--eetiegalax",	"-eeti",	"EETI eGalaxTouch",
+	B9600, CS8,
+	SERIO_EGALAX,		0x00,	0x00,	0,	egalax_init },
+#endif
 { "--elotouch",		"-elo",		"ELO touchscreen, 10-byte mode",
 	B9600, CS8,
 	SERIO_ELO,		0x00,	0x00,	0,	NULL },
@@ -716,6 +783,11 @@ static struct input_types input_types[]
 { "--elo261-280",	"-elo3b",	"ELO Touchscreen, 3-byte mode",
 	B9600, CS8 | CRTSCTS,
 	SERIO_ELO,		0x03,	0x00,	0,	NULL },
+#ifdef SERIO_HAMPSHIRE
+{ "--hampshire",   "-ham",         "Hampshire touchscreen",
+	B9600, CS8,
+	SERIO_HAMPSHIRE,	0x00,   0x00,   0,  NULL },
+#endif
 { "--mtouch",		"-mtouch",	"MicroTouch (3M) touchscreen",
 	B9600, CS8 | CRTSCTS,
 	SERIO_MICROTOUCH,	0x00,	0x00,	0,	NULL },

--------------010800080502030801060107
Content-Type: text/x-patch;
 name="01-kernel-egalax-serio.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="01-kernel-egalax-serio.patch"

diff -durpN linux-4.2.6/drivers/input/touchscreen/egalax.c linux-4.2.6.egalax-serio/drivers/input/touchscreen/egalax.c
--- linux-4.2.6/drivers/input/touchscreen/egalax.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-4.2.6.egalax-serio/drivers/input/touchscreen/egalax.c	2015-12-14 09:56:28.456074915 +0100
@@ -0,0 +1,210 @@
+/*
+ * EETI Egalax serial touchscreen driver
+ *
+ * Copyright (c) 2015 ZoltÃ¡n BÃ¶szÃ¶rmÃ©nyi <zboszor@pr.hu>
+ *
+ * based on the
+ *
+ * Hampshire serial touchscreen driver (Copyright (c) 2010 Adam Bennett)
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+
+#define DRIVER_DESC	"EETI Egalax serial touchscreen driver"
+
+MODULE_AUTHOR("ZoltÃ¡n BÃ¶szÃ¶rmÃ©nyi <zboszor@pr.hu>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+/*
+ * Definitions & global arrays.
+ */
+
+#define EGALAX_FORMAT_MAX_LENGTH 6
+#define EGALAX_RESPONSE_BEGIN_BYTE 0x80
+#define EGALAX_FORMAT_PRESSURE_BIT 0x40
+#define EGALAX_FORMAT_TOUCH_BIT 0x01
+#define EGALAX_FORMAT_RESOLUTION 0x06
+
+#define EGALAX_MIN_XC 0
+#define EGALAX_MAX_XC 0x4000
+#define EGALAX_MIN_YC 0
+#define EGALAX_MAX_YC 0x4000
+
+#define EGALAX_GET_XC(data, resbits, shift) ((((data[1] & (resbits)) << 7) | (data[2] & 0x7f)) << shift)
+#define EGALAX_GET_YC(data, resbits, shift) ((((data[3] & (resbits)) << 7) | (data[4] & 0x7f)) << shift)
+#define EGALAX_GET_TOUCHED(data) (EGALAX_FORMAT_TOUCH_BIT & data[0])
+
+/*
+ * Per-touchscreen data.
+ */
+
+struct egalax {
+	struct input_dev *dev;
+	struct serio *serio;
+	int idx;
+	int bytes;
+	int resbits;
+	int shift;
+	unsigned char data[EGALAX_FORMAT_MAX_LENGTH];
+	char phys[32];
+};
+
+static void egalax_process_data(struct egalax *pegalax)
+{
+	struct input_dev *dev = pegalax->dev;
+
+	if (++pegalax->idx == pegalax->bytes) {
+		input_report_abs(dev, ABS_X, EGALAX_GET_XC(pegalax->data, pegalax->resbits, pegalax->shift));
+		input_report_abs(dev, ABS_Y, EGALAX_GET_YC(pegalax->data, pegalax->resbits, pegalax->shift));
+		input_report_key(dev, BTN_TOUCH, EGALAX_GET_TOUCHED(pegalax->data));
+		input_sync(dev);
+
+		pegalax->idx = 0;
+	}
+}
+
+static irqreturn_t egalax_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags)
+{
+	struct egalax *pegalax = serio_get_drvdata(serio);
+
+	pegalax->data[pegalax->idx] = data;
+
+	if (EGALAX_RESPONSE_BEGIN_BYTE & pegalax->data[0]) {
+		pegalax->bytes = (EGALAX_FORMAT_PRESSURE_BIT & pegalax->data[0] ? 6 : 5);
+		switch ((EGALAX_FORMAT_RESOLUTION & pegalax->data[0]) >> 1) {
+		case 0:
+			pegalax->resbits = 0x0f;
+			pegalax->shift = 3;
+			break;
+		case 1:
+			pegalax->resbits = 0x1f;
+			pegalax->shift = 2;
+			break;
+		case 2:
+			pegalax->resbits = 0x3f;
+			pegalax->shift = 1;
+			break;
+		default:
+			pegalax->resbits = 0x7f;
+			pegalax->shift = 0;
+			break;
+		}
+		egalax_process_data(pegalax);
+	}
+	else
+		dev_dbg(&serio->dev, "unknown/unsynchronized data: %x\n",
+			pegalax->data[0]);
+
+	return IRQ_HANDLED;
+}
+
+static void egalax_disconnect(struct serio *serio)
+{
+	struct egalax *pegalax = serio_get_drvdata(serio);
+
+	input_get_device(pegalax->dev);
+	input_unregister_device(pegalax->dev);
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	input_put_device(pegalax->dev);
+	kfree(pegalax);
+}
+
+/*
+ * egalax_connect() is the routine that is called when someone adds a
+ * new serio device that supports egalax protocol and registers it as
+ * an input device. This is usually accomplished using inputattach.
+ */
+
+static int egalax_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct egalax *pegalax;
+	struct input_dev *input_dev;
+	int err;
+
+	pegalax = kzalloc(sizeof(struct egalax), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!pegalax || !input_dev) {
+		err = -ENOMEM;
+		goto fail1;
+	}
+
+	pegalax->serio = serio;
+	pegalax->dev = input_dev;
+	snprintf(pegalax->phys, sizeof(pegalax->phys),
+		 "%s/input0", serio->phys);
+
+	input_dev->name = "EETI eGalaxTouch Serial TouchScreen";
+	input_dev->phys = pegalax->phys;
+	input_dev->id.bustype = BUS_RS232;
+	input_dev->id.vendor = SERIO_EGALAX;
+	input_dev->id.product = 0;
+	input_dev->id.version = 0x0001;
+	input_dev->dev.parent = &serio->dev;
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(pegalax->dev, ABS_X,
+			     EGALAX_MIN_XC, EGALAX_MAX_XC, 0, 0);
+	input_set_abs_params(pegalax->dev, ABS_Y,
+			     EGALAX_MIN_YC, EGALAX_MAX_YC, 0, 0);
+
+	serio_set_drvdata(serio, pegalax);
+
+	err = serio_open(serio, drv);
+	if (err)
+		goto fail2;
+
+	err = input_register_device(pegalax->dev);
+	if (err)
+		goto fail3;
+
+	return 0;
+
+ fail3:	serio_close(serio);
+ fail2:	serio_set_drvdata(serio, NULL);
+ fail1:	input_free_device(input_dev);
+	kfree(pegalax);
+	return err;
+}
+
+/*
+ * The serio driver structure.
+ */
+
+static struct serio_device_id egalax_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_EGALAX,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, egalax_serio_ids);
+
+static struct serio_driver egalax_drv = {
+	.driver		= {
+		.name	= "egalax",
+	},
+	.description	= DRIVER_DESC,
+	.id_table	= egalax_serio_ids,
+	.interrupt	= egalax_interrupt,
+	.connect	= egalax_connect,
+	.disconnect	= egalax_disconnect,
+};
+
+module_serio_driver(egalax_drv);
diff -durpN linux-4.2.6/drivers/input/touchscreen/Kconfig linux-4.2.6.egalax-serio/drivers/input/touchscreen/Kconfig
--- linux-4.2.6/drivers/input/touchscreen/Kconfig	2015-11-09 23:37:56.000000000 +0100
+++ linux-4.2.6.egalax-serio/drivers/input/touchscreen/Kconfig	2015-12-14 09:58:46.363311141 +0100
@@ -295,6 +295,16 @@ config TOUCHSCREEN_EGALAX
 	  To compile this driver as a module, choose M here: the
 	  module will be called egalax_ts.
 
+config TOUCHSCREEN_EGALAX_SERIO
+	tristate "EETI eGalax serial touchscreen"
+	select SERIO
+	help
+	  Say Y here to enable support for serial connected EETI
+	  eGalax touch panels.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called egalax.
+
 config TOUCHSCREEN_FUJITSU
 	tristate "Fujitsu serial touchscreen"
 	select SERIO
diff -durpN linux-4.2.6/drivers/input/touchscreen/Makefile linux-4.2.6.egalax-serio/drivers/input/touchscreen/Makefile
--- linux-4.2.6/drivers/input/touchscreen/Makefile	2015-11-09 23:37:56.000000000 +0100
+++ linux-4.2.6.egalax-serio/drivers/input/touchscreen/Makefile	2015-12-14 09:59:26.113667470 +0100
@@ -35,6 +35,7 @@ obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_
 obj-$(CONFIG_TOUCHSCREEN_ELAN)		+= elants_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
+obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIO)	+= egalax.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
diff -durpN linux-4.2.6/include/uapi/linux/serio.h linux-4.2.6.egalax-serio/include/uapi/linux/serio.h
--- linux-4.2.6/include/uapi/linux/serio.h	2015-11-09 23:37:56.000000000 +0100
+++ linux-4.2.6.egalax-serio/include/uapi/linux/serio.h	2015-12-14 09:21:39.868415166 +0100
@@ -77,5 +77,6 @@
 #define SERIO_PS2MULT	0x3c
 #define SERIO_TSC40	0x3d
 #define SERIO_WACOM_IV	0x3e
+#define SERIO_EGALAX	0x3f
 
 #endif /* _UAPI_SERIO_H */

--------------010800080502030801060107--
