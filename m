From: =?UTF-8?Q?=D0=9D=D0=B8=D0=BA=D0=BE=D0=BB=D0=B0=D0=B9_?=
	 =?UTF-8?Q?=D0=9A=D1=83=D0=B4=D1=80=D1=8F=D0=B2=D1=86=D0=B5=D0=B2?=
	<nkudriavtsev@gmail.com>
Subject: [PATCH acer-switch12-keyboard] hid core: Enable support for Fn+
 controls keys on Acer Aspire Switch 12 keyboard
Date: Tue, 21 Jul 2015 13:31:52 +0300
Message-ID: <1437474712.5279.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36468 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbbGUKeN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 06:34:13 -0400
Received: by lbbqi7 with SMTP id qi7so32355255lbb.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2015 03:34:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Acer Aspire Switch 12 keyboard Chicony's controller reports too big usage
index on the 1st interface. The patch fixes the report. The work based on
solution from drivers/hid/hid-holtek-mouse.c

Bug report: https://bugzilla.kernel.org/show_bug.cgi?id=101721

Signed-off-by: Nicholas Kudriavtsev <nkudriavtsev@gmail.com>
---
Tested on git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git and it
works


diff -uNrp linux-4.0.8-300.fc22.x86_64.orig/drivers/hid/hid-chicony.c linux-4.0.8
-300.fc22.x86_64.test/drivers/hid/hid-chicony.c
--- linux-4.0.8-300.fc22.x86_64.orig/drivers/hid/hid-chicony.c	2015-07-18 15:36:18.443274174 +0300
+++ linux-4.0.8-300.fc22.x86_64.test/drivers/hid/hid-chicony.c	2015-07-19 13:53:18.153858059 +0300
@@ -20,6 +20,7 @@
 #include <linux/input.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/usb.h>
 
 #include "hid-ids.h"
 
@@ -57,10 +58,34 @@ static int ch_input_mapping(struct hid_d
 	return 1;
 }
 
+static __u8 *ch_switch12_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	
+	if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
+		/* Change usage maximum and logical maximum from 0x7fff to
+		 * 0x2fff, so they don't exceed HID_MAX_USAGES */
+		switch (hdev->product) {
+		case USB_DEVICE_ID_CHICONY_ACER_SWITCH12:
+			if (*rsize >= 128 && rdesc[64] == 0xff && rdesc[65] == 0x7f
+					&& rdesc[69] == 0xff && rdesc[70] == 0x7f) {
+				hid_info(hdev, "Fixing up report descriptor\n");
+				rdesc[65] = rdesc[70] = 0x2f;
+			}
+			break;
+		}
+
+	}
+	return rdesc;
+}
+
+
 static const struct hid_device_id ch_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_ACER_SWITCH12) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ch_devices);
@@ -68,6 +93,7 @@ MODULE_DEVICE_TABLE(hid, ch_devices);
 static struct hid_driver ch_driver = {
 	.name = "chicony",
 	.id_table = ch_devices,
+	.report_fixup = ch_switch12_report_fixup,
 	.input_mapping = ch_input_mapping,
 };
 module_hid_driver(ch_driver);
diff -uNrp linux-4.0.8-300.fc22.x86_64.orig/drivers/hid/hid-core.c linux-4.0.8
-300.fc22.x86_64.test/drivers/hid/hid-core.c
--- linux-4.0.8-300.fc22.x86_64.orig/drivers/hid/hid-core.c	2015-07-18 15:36:18.443274174 +0300
+++ linux-4.0.8-300.fc22.x86_64.test/drivers/hid/hid-core.c	2015-07-18 15:37:49.566986149 +0300
@@ -1782,6 +1782,7 @@ static const struct hid_device_id hid_ha
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_ACER_SWITCH12) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_PRODIKEYS_PCMIDI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_CP2112) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_1) },
diff -uNrp linux-4.0.8-300.fc22.x86_64.orig/drivers/hid/hid-ids.h linux-4.0.8
-300.fc22.x86_64.test/drivers/hid/hid-ids.h
--- linux-4.0.8-300.fc22.x86_64.orig/drivers/hid/hid-ids.h	2015-07-18 15:36:18.447274030 +0300
+++ linux-4.0.8-300.fc22.x86_64.test/drivers/hid/hid-ids.h	2015-07-18 15:37:49.567986113 +0300
@@ -229,6 +229,7 @@
 #define USB_DEVICE_ID_CHICONY_WIRELESS	0x0618
 #define USB_DEVICE_ID_CHICONY_WIRELESS2	0x1123
 #define USB_DEVICE_ID_CHICONY_AK1D	0x1125
+#define USB_DEVICE_ID_CHICONY_ACER_SWITCH12	0x1421
 
 #define USB_VENDOR_ID_CHUNGHWAT		0x2247
 #define USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH	0x0001
