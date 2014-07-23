From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/5] hid: huion: Use "tablet" instead of specific model
Date: Wed, 23 Jul 2014 15:42:54 +0300
Message-ID: <1406119378-24551-2-git-send-email-spbnick@gmail.com>
References: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:37266 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbaGWMnV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 08:43:21 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so1139588wes.34
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 05:43:20 -0700 (PDT)
In-Reply-To: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Nikolai Kondrashov <spbnick@gmail.com>

Use word "tablet" in identifiers and comments instead of referring to specific
Huion tablet model name, as the product ID is used by at least several tablet
models.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-core.c  |  2 +-
 drivers/hid/hid-huion.c | 25 +++++++++++++------------
 drivers/hid/hid-ids.h   |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8ed66fd..84ed7d4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1782,7 +1782,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A070) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A072) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_580) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS2, USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
index cbf4da4..25d01cd 100644
--- a/drivers/hid/hid-huion.c
+++ b/drivers/hid/hid-huion.c
@@ -2,6 +2,7 @@
  *  HID driver for Huion devices not fully compliant with HID standard
  *
  *  Copyright (c) 2013 Martin Rusko
+ *  Copyright (c) 2014 Nikolai Kondrashov
  */
 
 /*
@@ -19,11 +20,11 @@
 
 #include "hid-ids.h"
 
-/* Original Huion 580 report descriptor size */
-#define HUION_580_RDESC_ORIG_SIZE	177
+/* Original tablet report descriptor size */
+#define HUION_TABLET_RDESC_ORIG_SIZE	177
 
-/* Fixed Huion 580 report descriptor */
-static __u8 huion_580_rdesc_fixed[] = {
+/* Fixed tablet report descriptor */
+static __u8 huion_tablet_rdesc_fixed[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
 	0x09, 0x02,         /*  Usage (Pen),                        */
 	0xA1, 0x01,         /*  Collection (Application),           */
@@ -72,10 +73,10 @@ static __u8 *huion_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
 	switch (hdev->product) {
-	case USB_DEVICE_ID_HUION_580:
-		if (*rsize == HUION_580_RDESC_ORIG_SIZE) {
-			rdesc = huion_580_rdesc_fixed;
-			*rsize = sizeof(huion_580_rdesc_fixed);
+	case USB_DEVICE_ID_HUION_TABLET:
+		if (*rsize == HUION_TABLET_RDESC_ORIG_SIZE) {
+			rdesc = huion_tablet_rdesc_fixed;
+			*rsize = sizeof(huion_tablet_rdesc_fixed);
 		}
 		break;
 	}
@@ -108,11 +109,11 @@ static int huion_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	int ret;
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 
-	/* Ignore interfaces 1 (mouse) and 2 (keyboard) for Huion 580 tablet,
+	/* Ignore interfaces 1 (mouse) and 2 (keyboard) for tablet,
 	 * as they are not used
 	 */
 	switch (id->product) {
-	case USB_DEVICE_ID_HUION_580:
+	case USB_DEVICE_ID_HUION_TABLET:
 		if (intf->cur_altsetting->desc.bInterfaceNumber != 0x00)
 			return -ENODEV;
 		break;
@@ -131,7 +132,7 @@ static int huion_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	switch (id->product) {
-	case USB_DEVICE_ID_HUION_580:
+	case USB_DEVICE_ID_HUION_TABLET:
 		ret = huion_tablet_enable(hdev);
 		if (ret) {
 			hid_err(hdev, "tablet enabling failed\n");
@@ -158,7 +159,7 @@ static int huion_raw_event(struct hid_device *hdev, struct hid_report *report,
 }
 
 static const struct hid_device_id huion_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_580) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, huion_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 48b66bb..fe2f163 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -448,7 +448,7 @@
 #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030
 
 #define USB_VENDOR_ID_HUION		0x256c
-#define USB_DEVICE_ID_HUION_580		0x006e
+#define USB_DEVICE_ID_HUION_TABLET	0x006e
 
 #define USB_VENDOR_ID_IDEACOM		0x1cb6
 #define USB_DEVICE_ID_IDEACOM_IDC6650	0x6650
-- 
2.0.1

