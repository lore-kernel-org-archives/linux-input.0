From: Tomasz Kramkowski <tk@the-tk.com>
Subject: [PATCH v2] HID: elecom: rewrite report fixup for EX-G and future mice
Date: Tue, 19 Dec 2017 20:44:36 +0000
Message-ID: <20171219204436.27737-1-tk@the-tk.com>
References: <20171204205550.2621-1-tk@the-tk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:58202 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdLSUpS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Dec 2017 15:45:18 -0500
In-Reply-To: <20171204205550.2621-1-tk@the-tk.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>, =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.eu>, Alex Manoussakis <amanou@gnu.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Kramkowski <tk@the-tk.com>

This patch rewrites the mouse report fixup used for the DEFT and HUGE
elecom trackballs in order to make it generic enough to fix other
elecom mice with similar issues. This patch also uses this new report
fixup function to fix the Elecom EX-G trackball which has 6 physical
buttons and a similar issue to the other two mice.

Elecom's track record has so far shown that they like to re-use the
same report descriptor for multiple different mice regardless of the
number of buttons the mouse has. This means that the missing buttons
on multiple mice can be fixed in one function without introducing
phantom buttons which would in turn cause the number of mouse buttons
to be misreported to userspace.

This patch drops the very verbose report descriptor "diff" comment for
a more abridged yet hopefully just as informative generic version.

Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
---
v2 changes:
* pass rsize directly to mouse_button_fixup
* add support for wireless EX-G variant
v1: https://marc.info/?i=20171204205550.2621-1-tk@the-tk.com
---
 drivers/hid/Kconfig      |  1 +
 drivers/hid/hid-elecom.c | 78 ++++++++++++++++++++++++++----------------------
 drivers/hid/hid-ids.h    |  2 ++
 drivers/hid/hid-quirks.c |  2 ++
 4 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 9058dbc4dd6e..19c499f5623d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -280,6 +280,7 @@ config HID_ELECOM
 	---help---
 	Support for ELECOM devices:
 	  - BM084 Bluetooth Mouse
+	  - EX-G Trackball (Wired and wireless)
 	  - DEFT Trackball (Wired and wireless)
 	  - HUGE Trackball (Wired and wireless)
 
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 54aeea57d209..1a1ecc491c02 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -1,9 +1,15 @@
 /*
- *  HID driver for ELECOM devices.
+ *  HID driver for ELECOM devices:
+ *  - BM084 Bluetooth Mouse
+ *  - EX-G Trackball (Wired and wireless)
+ *  - DEFT Trackball (Wired and wireless)
+ *  - HUGE Trackball (Wired and wireless)
+ *
  *  Copyright (c) 2010 Richard Nauber <Richard.Nauber@gmail.com>
  *  Copyright (c) 2016 Yuxuan Shui <yshuiv7@gmail.com>
  *  Copyright (c) 2017 Diego Elio Pettenò <flameeyes@flameeyes.eu>
  *  Copyright (c) 2017 Alex Manoussakis <amanou@gnu.org>
+ *  Copyright (c) 2017 Tomasz Kramkowski <tk@the-tk.com>
  */
 
 /*
@@ -19,6 +25,34 @@
 
 #include "hid-ids.h"
 
+/*
+ * Certain ELECOM mice misreport their button count meaning that they only work
+ * correctly with the ELECOM mouse assistant software which is unavailable for
+ * Linux. A four extra INPUT reports and a FEATURE report are described by the
+ * report descriptor but it does not appear that these enable software to
+ * control what the extra buttons map to. The only simple and straightforward
+ * solution seems to involve fixing up the report descriptor.
+ *
+ * Report descriptor format:
+ * Positions 13, 15, 21 and 31 store the button bit count, button usage minimum,
+ * button usage maximum and padding bit count respectively.
+ */
+#define MOUSE_BUTTONS_MAX 8
+static void mouse_button_fixup(struct hid_device *hdev,
+			       __u8 *rdesc, unsigned int rsize,
+			       int nbuttons)
+{
+	if (rsize < 32 || rdesc[12] != 0x95 ||
+	    rdesc[14] != 0x75 || rdesc[15] != 0x01 ||
+	    rdesc[20] != 0x29 || rdesc[30] != 0x75)
+		return;
+	hid_info(hdev, "Fixing up Elecom mouse button count\n");
+	nbuttons = clamp(nbuttons, 0, MOUSE_BUTTONS_MAX);
+	rdesc[13] = nbuttons;
+	rdesc[21] = nbuttons;
+	rdesc[31] = MOUSE_BUTTONS_MAX - nbuttons;
+}
+
 static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -31,45 +65,15 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			rdesc[47] = 0x00;
 		}
 		break;
+	case USB_DEVICE_ID_ELECOM_EX_G_WIRED:
+	case USB_DEVICE_ID_ELECOM_EX_G_WIRELESS:
+		mouse_button_fixup(hdev, rdesc, *rsize, 6);
+		break;
 	case USB_DEVICE_ID_ELECOM_DEFT_WIRED:
 	case USB_DEVICE_ID_ELECOM_DEFT_WIRELESS:
 	case USB_DEVICE_ID_ELECOM_HUGE_WIRED:
 	case USB_DEVICE_ID_ELECOM_HUGE_WIRELESS:
-		/* The DEFT/HUGE trackball has eight buttons, but its descriptor
-		 * only reports five, disabling the three Fn buttons on the top
-		 * of the mouse.
-		 *
-		 * Apply the following diff to the descriptor:
-		 *
-		 * Collection (Physical),              Collection (Physical),
-		 *     Report ID (1),                      Report ID (1),
-		 *     Report Count (5),           ->      Report Count (8),
-		 *     Report Size (1),                    Report Size (1),
-		 *     Usage Page (Button),                Usage Page (Button),
-		 *     Usage Minimum (01h),                Usage Minimum (01h),
-		 *     Usage Maximum (05h),        ->      Usage Maximum (08h),
-		 *     Logical Minimum (0),                Logical Minimum (0),
-		 *     Logical Maximum (1),                Logical Maximum (1),
-		 *     Input (Variable),                   Input (Variable),
-		 *     Report Count (1),           ->      Report Count (0),
-		 *     Report Size (3),                    Report Size (3),
-		 *     Input (Constant),                   Input (Constant),
-		 *     Report Size (16),                   Report Size (16),
-		 *     Report Count (2),                   Report Count (2),
-		 *     Usage Page (Desktop),               Usage Page (Desktop),
-		 *     Usage (X),                          Usage (X),
-		 *     Usage (Y),                          Usage (Y),
-		 *     Logical Minimum (-32768),           Logical Minimum (-32768),
-		 *     Logical Maximum (32767),            Logical Maximum (32767),
-		 *     Input (Variable, Relative),         Input (Variable, Relative),
-		 * End Collection,                     End Collection,
-		 */
-		if (*rsize == 213 && rdesc[13] == 5 && rdesc[21] == 5) {
-			hid_info(hdev, "Fixing up Elecom DEFT/HUGE Fn buttons\n");
-			rdesc[13] = 8; /* Button/Variable Report Count */
-			rdesc[21] = 8; /* Button/Variable Usage Maximum */
-			rdesc[29] = 0; /* Button/Constant Report Count */
-		}
+		mouse_button_fixup(hdev, rdesc, *rsize, 8);
 		break;
 	}
 	return rdesc;
@@ -77,6 +81,8 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 static const struct hid_device_id elecom_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_EX_G_WIRED) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_EX_G_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRED) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRED) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5da3d6256d25..d5daf2e638f7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -370,6 +370,8 @@
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
+#define USB_DEVICE_ID_ELECOM_EX_G_WIRED	0x00fb
+#define USB_DEVICE_ID_ELECOM_EX_G_WIRELESS	0x00fc
 #define USB_DEVICE_ID_ELECOM_DEFT_WIRED	0x00fe
 #define USB_DEVICE_ID_ELECOM_DEFT_WIRELESS	0x00ff
 #define USB_DEVICE_ID_ELECOM_HUGE_WIRED	0x010c
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 015e0c10248b..6f5f9c2d30f9 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -335,6 +335,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_ELECOM)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_EX_G_WIRED) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_EX_G_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRED) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRED) },
-- 
2.15.1

