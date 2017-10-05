From: Alex Manoussakis <amanou@gnu.org>
Subject: [PATCH v1] HID: hid-elecom: extend to fix descriptor for HUGE trackball
Date: Thu, 05 Oct 2017 13:41:20 -0400
Message-ID: <E1e0A9A-00059I-9E@fencepost.gnu.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eggs.gnu.org ([208.118.235.92]:32858 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbdJERlZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Oct 2017 13:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
        (envelope-from <amanou@gnu.org>)
        id 1e0A9E-0004rr-2d
        for linux-input@vger.kernel.org; Thu, 05 Oct 2017 13:41:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Diego Elio Petteno <flameeyes@flameeyes.eu>, Alex Manoussakis <amanou@gnu.org>

In addition to DEFT, Elecom introduced a larger trackball called HUGE, in
both wired (M-HT1URBK) and wireless (M-HT1DRBK) versions. It has the same
buttons and behavior as the DEFT. This patch adds the two relevant USB IDs
to enable operation of the three Fn buttons on the top of the device.

Cc: Diego Elio Petteno <flameeyes@flameeyes.eu>
Signed-off-by: Alex Manoussakis <amanou@gnu.org>

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 0a3117c..374301f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -281,6 +281,7 @@ config HID_ELECOM
 	Support for ELECOM devices:
 	  - BM084 Bluetooth Mouse
 	  - DEFT Trackball (Wired and wireless)
+	  - HUGE Trackball (Wired and wireless)
 
 config HID_ELO
 	tristate "ELO USB 4000/4500 touchscreen"
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9bc9116..330ca98 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2032,6 +2032,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRED) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRELESS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRED) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRELESS) },
 #endif
 #if IS_ENABLED(CONFIG_HID_ELO)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, 0x0009) },
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index e2c7465..54aeea5 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -3,6 +3,7 @@
  *  Copyright (c) 2010 Richard Nauber <Richard.Nauber@gmail.com>
  *  Copyright (c) 2016 Yuxuan Shui <yshuiv7@gmail.com>
  *  Copyright (c) 2017 Diego Elio Pettenò <flameeyes@flameeyes.eu>
+ *  Copyright (c) 2017 Alex Manoussakis <amanou@gnu.org>
  */
 
 /*
@@ -32,9 +33,11 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		break;
 	case USB_DEVICE_ID_ELECOM_DEFT_WIRED:
 	case USB_DEVICE_ID_ELECOM_DEFT_WIRELESS:
-		/* The DEFT trackball has eight buttons, but its descriptor only
-		 * reports five, disabling the three Fn buttons on the top of
-		 * the mouse.
+	case USB_DEVICE_ID_ELECOM_HUGE_WIRED:
+	case USB_DEVICE_ID_ELECOM_HUGE_WIRELESS:
+		/* The DEFT/HUGE trackball has eight buttons, but its descriptor
+		 * only reports five, disabling the three Fn buttons on the top
+		 * of the mouse.
 		 *
 		 * Apply the following diff to the descriptor:
 		 *
@@ -62,7 +65,7 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		 * End Collection,                     End Collection,
 		 */
 		if (*rsize == 213 && rdesc[13] == 5 && rdesc[21] == 5) {
-			hid_info(hdev, "Fixing up Elecom DEFT Fn buttons\n");
+			hid_info(hdev, "Fixing up Elecom DEFT/HUGE Fn buttons\n");
 			rdesc[13] = 8; /* Button/Variable Report Count */
 			rdesc[21] = 8; /* Button/Variable Usage Maximum */
 			rdesc[29] = 0; /* Button/Constant Report Count */
@@ -76,6 +79,8 @@ static const struct hid_device_id elecom_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRED) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRELESS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRED) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRELESS) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, elecom_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b397a14..e9da185 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -368,6 +368,8 @@
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
 #define USB_DEVICE_ID_ELECOM_DEFT_WIRED	0x00fe
 #define USB_DEVICE_ID_ELECOM_DEFT_WIRELESS	0x00ff
+#define USB_DEVICE_ID_ELECOM_HUGE_WIRED	0x010c
+#define USB_DEVICE_ID_ELECOM_HUGE_WIRELESS	0x010d
 
 #define USB_VENDOR_ID_DREAM_CHEEKY	0x1d34
 #define USB_DEVICE_ID_DREAM_CHEEKY_WN	0x0004
