From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.eu>
Subject: [PATCH v2.2] HID: hid-elecom: extend to fix the descriptor for DEFT trackballs.
Date: Fri, 21 Apr 2017 18:42:55 +0100
Message-ID: <20170421174255.16099-1-flameeyes@flameeyes.eu>
References: <20170421172933.14659-1-flameeyes@flameeyes.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34836 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424058AbdDUSvu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Apr 2017 14:51:50 -0400
Received: by mail-wm0-f52.google.com with SMTP id w64so22306011wma.0
        for <linux-input@vger.kernel.org>; Fri, 21 Apr 2017 11:51:49 -0700 (PDT)
In-Reply-To: <20170421172933.14659-1-flameeyes@flameeyes.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.eu>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>

The ELECOM DEFT trackballs report only five buttons, when the device
actually has 8. Change the descriptor so that the HID driver can see all of
them.

For completeness and future reference, I included a side-by-side diff of
the part of the descriptor that is being edited.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>

Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.eu>
---
 drivers/hid/Kconfig      |  6 +++--
 drivers/hid/hid-core.c   |  2 ++
 drivers/hid/hid-elecom.c | 60 ++++++++++++++++++++++++++++++++++++++++--------
 drivers/hid/hid-ids.h    |  2 ++
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4070b73..519918b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -258,10 +258,12 @@ config HID_EMS_FF
 	 - Trio Linker Plus II
 
 config HID_ELECOM
-	tristate "ELECOM BM084 bluetooth mouse"
+	tristate "ELECOM HID devices"
 	depends on HID
 	---help---
-	Support for the ELECOM BM084 (bluetooth mouse).
+	Support for ELECOM devices:
+	  - BM084 Bluetooth Mouse
+	  - DEFT Trackball (Wired and wireless)
 
 config HID_ELO
 	tristate "ELO USB 4000/4500 touchscreen"
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ea36b55..1bc9291 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1891,6 +1891,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_WN) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_FA) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRED) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, 0x0009) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, 0x0030) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II) },
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 6e3848a..2081710 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -1,10 +1,8 @@
 /*
- *  HID driver for Elecom BM084 (bluetooth mouse).
- *  Removes a non-existing horizontal wheel from
- *  the HID descriptor.
- *  (This module is based on "hid-ortek".)
- *
+ *  HID driver for ELECOM devices.
  *  Copyright (c) 2010 Richard Nauber <Richard.Nauber@gmail.com>
+ *  Copyright (c) 2016 Yuxuan Shui <yshuiv7@gmail.com>
+ *  Copyright (c) 2017 Diego Elio Pettenò <flameeyes@flameeyes.eu>
  */
 
 /*
@@ -23,15 +21,59 @@
 static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	if (*rsize >= 48 && rdesc[46] == 0x05 && rdesc[47] == 0x0c) {
-		hid_info(hdev, "Fixing up Elecom BM084 report descriptor\n");
-		rdesc[47] = 0x00;
+	switch (hdev->product) {
+	case USB_DEVICE_ID_ELECOM_BM084:
+		/* The BM084 Bluetooth mouse includes a non-existing horizontal
+		 * wheel in the HID descriptor. */
+		if (*rsize >= 48 && rdesc[46] == 0x05 && rdesc[47] == 0x0c) {
+			hid_info(hdev, "Fixing up Elecom BM084 report descriptor\n");
+			rdesc[47] = 0x00;
+		}
+	case USB_DEVICE_ID_ELECOM_DEFT_WIRED:
+	case USB_DEVICE_ID_ELECOM_DEFT_WIRELESS:
+		/* The DEFT trackball has eight buttons, but its descriptor only
+		 * reports five, disabling the three Fn buttons on the top of
+		 * the mouse.
+		 *
+		 * Apply the following diff to the descriptor:
+		 *
+		 * Collection (Physical),              Collection (Physical),
+		 *     Report ID (1),                      Report ID (1),
+		 *     Report Count (5),            |      Report Count (8),
+		 *     Report Size (1),                    Report Size (1),
+		 *     Usage Page (Button),                Usage Page (Button),
+		 *     Usage Minimum (01h),                Usage Minimum (01h),
+		 *     Usage Maximum (05h),         |      Usage Maximum (08h),
+		 *     Logical Minimum (0),                Logical Minimum (0),
+		 *     Logical Maximum (1),                Logical Maximum (1),
+		 *     Input (Variable),                   Input (Variable),
+		 *     Report Count (1),            |      Report Count (0),
+		 *     Report Size (3),                    Report Size (3),
+		 *     Input (Constant),                   Input (Constant),
+		 *     Report Size (16),                   Report Size (16),
+		 *     Report Count (2),                   Report Count (2),
+		 *     Usage Page (Desktop),               Usage Page (Desktop),
+		 *     Usage (X),                          Usage (X),
+		 *     Usage (Y),                          Usage (Y),
+		 *     Logical Minimum (-32768),           Logical Minimum (-32768),
+		 *     Logical Maximum (32767),            Logical Maximum (32767),
+		 *     Input (Variable, Relative),         Input (Variable, Relative),
+		 * End Collection,                     End Collection,
+		 */
+		if (*rsize == 213 && rdesc[13] == 5 && rdesc[21] == 5) {
+			hid_info(hdev, "Fixing up Elecom DEFT Fn buttons\n");
+			rdesc[13] = 8; /* Button/Variable Report Count */
+			rdesc[21] = 8; /* Button/Variable Usage Maximum */
+			rdesc[29] = 0; /* Button/Constant Report Count */
+		}
 	}
 	return rdesc;
 }
 
 static const struct hid_device_id elecom_devices[] = {
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084)},
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRED) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRELESS) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, elecom_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 350accf..5f1635f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -351,6 +351,8 @@
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
+#define USB_DEVICE_ID_ELECOM_DEFT_WIRED	0x00fe
+#define USB_DEVICE_ID_ELECOM_DEFT_WIRELESS	0x00ff
 
 #define USB_VENDOR_ID_DREAM_CHEEKY	0x1d34
 #define USB_DEVICE_ID_DREAM_CHEEKY_WN	0x0004
-- 
2.10.2

