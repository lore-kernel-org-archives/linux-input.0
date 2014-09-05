From: John DeSilva <desilvjo@umich.edu>
Subject: [PATCH] HID: Add Holtek USB ID 04d9:a0c2 ETEKCITY Scroll
Date: Thu,  4 Sep 2014 21:08:05 -0400
Message-ID: <1409879285-15816-1-git-send-email-desilvjo@umich.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33167 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbaIEBJE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Sep 2014 21:09:04 -0400
Received: by mail-ig0-f170.google.com with SMTP id h3so19152igd.3
        for <linux-input@vger.kernel.org>; Thu, 04 Sep 2014 18:09:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, John DeSilva <desilvjo@umich.edu>

The report descriptor for the HOLTEK USB ID 04d9:a0c2 (ETEKCITY Scroll
T-140 Gaming Mouse) is set to a very large amount of consumer usages
(2^16), exceeding HID_MAX_USAGES. Added id, bindings and comments for
the mouse, and reduced the usage and logical maximums to 0x2fff,
consistent with the other mice in the category.
Tested on the hardware.

Signed-off-by: John C. DeSilva <desilvjo@umich.edu>
---
 drivers/hid/hid-holtek-mouse.c | 4 ++++
 drivers/hid/hid-ids.h          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-holtek-mouse.c b/drivers/hid/hid-holtek-mouse.c
index d60fbd0..78b3a0c 100644
--- a/drivers/hid/hid-holtek-mouse.c
+++ b/drivers/hid/hid-holtek-mouse.c
@@ -29,6 +29,7 @@
  *   and Zalman ZM-GM1
  * - USB ID 04d9:a081, sold as SHARKOON DarkGlider Gaming mouse
  * - USB ID 04d9:a072, sold as LEETGION Hellion Gaming Mouse
+ * - USB ID 04d9:a0c2, sold as ETEKCITY Scroll T-140 Gaming Mouse
  */
 
 static __u8 *holtek_mouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
@@ -42,6 +43,7 @@ static __u8 *holtek_mouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		switch (hdev->product) {
 		case USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A067:
 		case USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A072:
+		case USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2:
 			if (*rsize >= 122 && rdesc[115] == 0xff && rdesc[116] == 0x7f
 					&& rdesc[120] == 0xff && rdesc[121] == 0x7f) {
 				hid_info(hdev, "Fixing up report descriptor\n");
@@ -74,6 +76,8 @@ static const struct hid_device_id holtek_mouse_devices[] = {
 			USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A072) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT,
 			USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT,
+			USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, holtek_mouse_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 25cd674..c7b36ad 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -479,6 +479,7 @@
 #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A070	0xa070
 #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A072	0xa072
 #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081	0xa081
+#define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2	0xa0c2
 #define USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096	0xa096
 
 #define USB_VENDOR_ID_IMATION		0x0718
-- 
1.8.5.5

