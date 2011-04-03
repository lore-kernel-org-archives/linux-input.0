From: Eduard Hasenleithner <eduard@hasenleithner.at>
Subject: [PATCH v2] Wacom Intuos4 LED and OLED support
Date: Sun,  3 Apr 2011 09:57:09 +0200
Message-ID: <1301817429-12782-1-git-send-email-eduard@hasenleithner.at>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [93.83.152.182] ([93.83.152.182]:46170 "EHLO
	phenom.hasenleithner.at" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751095Ab1DCH5M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 3 Apr 2011 03:57:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This commit enables control of the LEDs and OLED displays found
on the Wacom Intuos4 M, L, and XL. For this purpose, an IOCTL
interface is added to the wacom input driver. The IOCTLs can be
issued on the raw USB device of the tablet.

Summary of changes:
* A new ioctl-number (0xB2) for the Wacom IOCTL is allocated.
* A new header file for the IOCTLs is introduced
	(include/linux/usb/wacom-dev.h)
* Implementation of LED and OLED control in wacom_wac.c

Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>
---

Changes to previous version
- Fixed a few code formatting issues (checkpatch.pl)
- Added original author to "thanks" in wacom-dev.h

 Documentation/ioctl/ioctl-number.txt |    1 +
 drivers/input/tablet/wacom.h         |    1 +
 drivers/input/tablet/wacom_sys.c     |    1 +
 drivers/input/tablet/wacom_wac.c     |   98 ++++++++++++++++++++++++++++++++++
 include/linux/usb/wacom-dev.h        |   51 ++++++++++++++++++
 5 files changed, 152 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/usb/wacom-dev.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index ac293e9..80aa4c3 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -302,6 +302,7 @@ Code  Seq#(hex)	Include File		Comments
 0xB0	all	RATIO devices		in development:
 					<mailto:vgo@ratio.de>
 0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
+0xB2	00-1F	WACOM tablets		<mailto:linuxwacom-devel@lists.sourceforge.net>
 0xC0	00-0F	linux/usb/iowarrior.h
 0xCB	00-1F	CBM serial IEC bus	in development:
 					<mailto:michael.klein@puffin.lb.shuttle.de>
diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
index 23317bd..76446ec 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -118,6 +118,7 @@ struct wacom {
 
 extern const struct usb_device_id wacom_ids[];
 
+int wacom_ioctl(struct usb_interface *intf, unsigned int code, void *buf);
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
 void wacom_setup_device_quirks(struct wacom_features *features);
 void wacom_setup_input_capabilities(struct input_dev *input_dev,
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 449c0a4..6b23fdd 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -628,6 +628,7 @@ static struct usb_driver wacom_driver = {
 	.id_table =	wacom_ids,
 	.probe =	wacom_probe,
 	.disconnect =	wacom_disconnect,
+	.unlocked_ioctl = wacom_ioctl,
 	.suspend =	wacom_suspend,
 	.resume =	wacom_resume,
 	.reset_resume =	wacom_reset_resume,
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 08ba5ad..69fc8ea 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -15,6 +15,7 @@
 #include "wacom_wac.h"
 #include "wacom.h"
 #include <linux/input/mt.h>
+#include <linux/usb/wacom-dev.h>
 
 /* resolution for penabled devices */
 #define WACOM_PL_RES		20
@@ -1570,3 +1571,100 @@ const struct usb_device_id wacom_ids[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, wacom_ids);
+
+#define WAC_CMD_RETRIES 10
+
+#define WAC_CMD_LED_CTRL 0x20
+#define WAC_CMD_ICON_START 0x21
+#define WAC_CMD_ICON_XFER 0x23
+
+static int wacom_command_xfer(struct usb_interface *intf,
+	unsigned char id, void *buf, int size)
+{
+	int rval, retries = WAC_CMD_RETRIES;
+	do rval = usb_control_msg(interface_to_usbdev(intf),
+		usb_sndctrlpipe(interface_to_usbdev(intf), 0),
+		0x09, USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+		0x300 | id, intf->altsetting[0].desc.bInterfaceNumber,
+		buf, size, 1000);
+	while ((rval == -ETIMEDOUT || rval == -EPIPE) && --retries > 0);
+
+	return rval;
+}
+
+static int wacom_ioctl_led_control(struct usb_interface *intf,
+	struct wacom_led_ctrl *arg)
+{
+	struct wacom *wacom = usb_get_intfdata(intf);
+	char buf[9] = {
+		WAC_CMD_LED_CTRL,
+		((arg->led_enable != 0)<<2) | (arg->led_select & 0x03),
+		arg->led_llv & 0x7f,
+		arg->led_hlv & 0x7f,
+		arg->img_lum & 0x0f,
+		0, 0, 0, 0
+	};
+
+	if (
+		wacom->wacom_wac.features.type < INTUOS4 ||
+		wacom->wacom_wac.features.type > INTUOS4L
+	) {
+		/* device not supported */
+		return -ENODEV;
+	}
+
+	return wacom_command_xfer(intf, WAC_CMD_LED_CTRL, buf, sizeof buf);
+}
+
+static int wacom_icon_start(struct usb_interface *intf, int start)
+{
+	char buf[2] = { WAC_CMD_ICON_START, start };
+	return wacom_command_xfer(intf, WAC_CMD_ICON_START, buf, sizeof buf);
+}
+
+static int wacom_ioctl_image_put(struct usb_interface *intf,
+	struct wacom_img_put *arg)
+{
+	unsigned char *buf;
+	int i, rval;
+	struct wacom *wacom = usb_get_intfdata(intf);
+	if (
+		wacom->wacom_wac.features.type < INTUOS4 ||
+		wacom->wacom_wac.features.type > INTUOS4L
+	) {
+		/* device not supported */
+		return -ENODEV;
+	}
+
+	buf = kzalloc(259, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	rval = wacom_icon_start(intf, 1);
+	if (rval >= 0) {
+		buf[0] = WAC_CMD_ICON_XFER;
+		buf[1] = arg->button_id & 0x07;
+		for (i = 0; i < 4; i++) {
+			buf[2] = i;
+			memcpy(buf+3, arg->buf + i*256, 256);
+			rval = wacom_command_xfer(intf,
+				WAC_CMD_ICON_XFER, buf, 259);
+			if (rval < 0)
+				break;
+		}
+	}
+	kfree(buf);
+	wacom_icon_start(intf, 0);
+	return rval;
+}
+
+int wacom_ioctl(struct usb_interface *intf, unsigned int code, void *buf)
+{
+	switch (code) {
+	case WACOM_LED_CONTROL:
+		return wacom_ioctl_led_control(intf, buf);
+	case WACOM_IMAGE_PUT:
+		return wacom_ioctl_image_put(intf, buf);
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/include/linux/usb/wacom-dev.h b/include/linux/usb/wacom-dev.h
new file mode 100644
index 0000000..0156b81
--- /dev/null
+++ b/include/linux/usb/wacom-dev.h
@@ -0,0 +1,51 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Copyright (c) 2011 Eduard Hasenleithner <eduard@hasenleithner.at>
+ */
+
+#ifndef _WACOM_DEV_H
+#define _WACOM_DEV_H
+
+/*
+ * IOCTL interface for wacom tablets.
+ *
+ * The IOCTLs can be sent to the wacom driver by means of its
+ * raw usb device (i.e. usbdevice_fs).
+ *
+ * Currently only used for control of LEDs and the OLED display
+ * on the Intuos4 M, L, and XL tablets.
+ *
+ * Thanks to: Nicolas Hirsch who wrote the initial version of
+ *  the LED IOCTL interface.
+ */
+
+struct wacom_led_ctrl {
+	/* Status LED enable/disable */
+	char led_enable;
+	/* Status LED selector (0..3) when led_enable is true */
+	char led_select;
+	/* Luminance (0..127) of Status LED without stylus button pressed */
+	char led_llv;
+	/* Luminance (0..127) of Status LED with stylus button pressed */
+	char led_hlv;
+	/* Luminance (0..15) of button images */
+	char img_lum;
+};
+
+struct wacom_img_put {
+	/* Button id (0..7) to set image for */
+	unsigned char button_id;
+	/* 64x32 4-bit grayscale pixels with Intuos4 specific interleaving */
+	unsigned char buf[1024];
+};
+
+#define WACOM_IOCTL 0xB2
+
+#define WACOM_LED_CONTROL _IOW(WACOM_IOCTL, 0x00, struct wacom_led_ctrl)
+#define WACOM_IMAGE_PUT _IOW(WACOM_IOCTL, 0x01, struct wacom_img_put)
+
+#endif
-- 
1.7.0.4

