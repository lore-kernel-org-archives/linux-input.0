From: Martin Rusko <martin.rusko@gmail.com>
Subject: [PATCH] HID: add support for Huion 580 tablet
Date: Tue, 28 May 2013 10:11:56 +0200
Message-ID: <1369728716-19286-1-git-send-email-martin.rusko@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:42906 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390Ab3E1ISw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 May 2013 04:18:52 -0400
Received: by mail-lb0-f179.google.com with SMTP id r11so7480357lbv.10
        for <linux-input@vger.kernel.org>; Tue, 28 May 2013 01:18:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>, Martin Rusko <martin.rusko@gmail.com>


Signed-off-by: Martin Rusko <martin.rusko@gmail.com>
---
 drivers/hid/Kconfig     |    6 ++
 drivers/hid/Makefile    |    1 +
 drivers/hid/hid-core.c  |    1 +
 drivers/hid/hid-huion.c |  177 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h   |    3 +
 5 files changed, 188 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-huion.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index fb52f3f..015e615 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -240,6 +240,12 @@ config HOLTEK_FF
 	  Say Y here if you have a Holtek On Line Grip based game controller
 	  and want to have force feedback support for it.
 
+config HID_HUION
+	tristate "Huion tablets"
+	depends on USB_HID
+	---help---
+	Support for Huion 580 tablet.
+
 config HID_KEYTOUCH
 	tristate "Keytouch HID devices"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 2065694..b15602b 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
+obj-$(CONFIG_HID_HUION)		+= hid-huion.o
 obj-$(CONFIG_HID_HYPERV_MOUSE)	+= hid-hyperv.o
 obj-$(CONFIG_HID_ICADE)		+= hid-icade.o
 obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 264f550..96a8348 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1584,6 +1584,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK, USB_DEVICE_ID_HOLTEK_ON_LINE_GRIP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_580) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS2, USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
new file mode 100644
index 0000000..cbf4da4
--- /dev/null
+++ b/drivers/hid/hid-huion.c
@@ -0,0 +1,177 @@
+/*
+ *  HID driver for Huion devices not fully compliant with HID standard
+ *
+ *  Copyright (c) 2013 Martin Rusko
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "usbhid/usbhid.h"
+
+#include "hid-ids.h"
+
+/* Original Huion 580 report descriptor size */
+#define HUION_580_RDESC_ORIG_SIZE	177
+
+/* Fixed Huion 580 report descriptor */
+static __u8 huion_580_rdesc_fixed[] = {
+	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
+	0x09, 0x02,         /*  Usage (Pen),                        */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x07,         /*      Report ID (7),                  */
+	0x09, 0x20,         /*      Usage (Stylus),                 */
+	0xA0,               /*      Collection (Physical),          */
+	0x14,               /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x09, 0x42,         /*          Usage (Tip Switch),         */
+	0x09, 0x44,         /*          Usage (Barrel Switch),      */
+	0x09, 0x46,         /*          Usage (Tablet Pick),        */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x09, 0x32,         /*          Usage (In Range),           */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x75, 0x10,         /*          Report Size (16),           */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0xA4,               /*          Push,                       */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x65, 0x13,         /*          Unit (Inch),                */
+	0x55, 0xFD,         /*          Unit Exponent (-3),         */
+	0x34,               /*          Physical Minimum (0),       */
+	0x09, 0x30,         /*          Usage (X),                  */
+	0x46, 0x40, 0x1F,   /*          Physical Maximum (8000),    */
+	0x26, 0x00, 0x7D,   /*          Logical Maximum (32000),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x09, 0x31,         /*          Usage (Y),                  */
+	0x46, 0x88, 0x13,   /*          Physical Maximum (5000),    */
+	0x26, 0x20, 0x4E,   /*          Logical Maximum (20000),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xB4,               /*          Pop,                        */
+	0x09, 0x30,         /*          Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x07,   /*          Logical Maximum (2047),     */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xC0,               /*      End Collection,                 */
+	0xC0                /*  End Collection                      */
+};
+
+static __u8 *huion_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	switch (hdev->product) {
+	case USB_DEVICE_ID_HUION_580:
+		if (*rsize == HUION_580_RDESC_ORIG_SIZE) {
+			rdesc = huion_580_rdesc_fixed;
+			*rsize = sizeof(huion_580_rdesc_fixed);
+		}
+		break;
+	}
+	return rdesc;
+}
+
+/**
+ * Enable fully-functional tablet mode by reading special string
+ * descriptor.
+ *
+ * @hdev:	HID device
+ *
+ * The specific string descriptor and data were discovered by sniffing
+ * the Windows driver traffic.
+ */
+static int huion_tablet_enable(struct hid_device *hdev)
+{
+	int rc;
+	char buf[22];
+
+	rc = usb_string(hid_to_usb_dev(hdev), 0x64, buf, sizeof(buf));
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+static int huion_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+
+	/* Ignore interfaces 1 (mouse) and 2 (keyboard) for Huion 580 tablet,
+	 * as they are not used
+	 */
+	switch (id->product) {
+	case USB_DEVICE_ID_HUION_580:
+		if (intf->cur_altsetting->desc.bInterfaceNumber != 0x00)
+			return -ENODEV;
+		break;
+	}
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		goto err;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		goto err;
+	}
+
+	switch (id->product) {
+	case USB_DEVICE_ID_HUION_580:
+		ret = huion_tablet_enable(hdev);
+		if (ret) {
+			hid_err(hdev, "tablet enabling failed\n");
+			goto enabling_err;
+		}
+		break;
+	}
+
+	return 0;
+enabling_err:
+	hid_hw_stop(hdev);
+err:
+	return ret;
+}
+
+static int huion_raw_event(struct hid_device *hdev, struct hid_report *report,
+			u8 *data, int size)
+{
+	/* If this is a pen input report then invert the in-range bit */
+	if (report->type == HID_INPUT_REPORT && report->id == 0x07 && size >= 2)
+		data[1] ^= 0x40;
+
+	return 0;
+}
+
+static const struct hid_device_id huion_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_580) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, huion_devices);
+
+static struct hid_driver huion_driver = {
+	.name = "huion",
+	.id_table = huion_devices,
+	.probe = huion_probe,
+	.report_fixup = huion_report_fixup,
+	.raw_event = huion_raw_event,
+};
+module_hid_driver(huion_driver);
+
+MODULE_AUTHOR("Martin Rusko");
+MODULE_DESCRIPTION("Huion HID driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 38535c9..983fd22 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -425,6 +425,9 @@
 #define USB_DEVICE_ID_UGCI_FLYING	0x0020
 #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030
 
+#define USB_VENDOR_ID_HUION		0x256c
+#define USB_DEVICE_ID_HUION_580		0x006e
+
 #define USB_VENDOR_ID_IDEACOM		0x1cb6
 #define USB_DEVICE_ID_IDEACOM_IDC6650	0x6650
 #define USB_DEVICE_ID_IDEACOM_IDC6651	0x6651
-- 
1.7.5.4

