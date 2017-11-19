From: Tomasz Kramkowski <tk@the-tk.com>
Subject: Re: [PATCH] HID: elecom: fix the descriptor of the EX-G trackball
Date: Sun, 19 Nov 2017 00:23:53 +0000
Message-ID: <20171119002353.GA15931@gaia.local>
References: <CAGqt0zzPC56sU5=GDS=FkwpTcnjoHotwhOZQ8bEf01=ePObk_A@mail.gmail.com>
 <20171118222726.GA14579@gaia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:46058 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935854AbdKSAYA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 19:24:00 -0500
Content-Disposition: inline
In-Reply-To: <20171118222726.GA14579@gaia.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yuxuan Shui <yshuiv7@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.eu>, Alex Manoussakis <amanou@gnu.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Nov 18, 2017 at 10:27:26PM +0000, Tomasz Kramkowski wrote:
> I was going to do this just now actually but then I noticed that someone
> had beat me to the punch with the EX-G (I was already surprised when I
> found someone had patched the HUGE and DEFT).

Actually, I'll put my money where my mouth is.

Just some notes about the patch (maybe I talk too much, feel free to
skip the rambling):

I just tested this with the wired (I think there's a wireless variant
but I don't have it) ELECOM EX-G trackball mouse.

I've pulled in the previous relevant contributors to this file as CC.

I've dropped the big diff thing because I think that if you know the HID
spec you can probably understand most of what is happening from the
simple comment before the mouse_button_fixup function and the contents
of the function itself. Also, it would be a bit cumbersome to add a diff
for every potentially relevant device (I'm pretty sure the DEFT, HUGE
and EX-G aren't the only mice with this issue).

If removing the diff is a major problem then I propose just removing the
RHS and having just a visual representation of the relevant descriptor
fields.

At one point I thought of having a name parameter on mouse_button_fixup
which would vary the hid_info message depending on the device model but
then I decided that it was unnecessary complexity so I dropped it, but
if specifying EXACTLY which model of device the driver is fixing up is a
must then that's something that I can quickly add.

I've added a note about the aforementioned mystery FEATURE report to
hopefully prevent anyone else from going down that rabbit hole.

And finally, I didn't want to steal Yuxuan's thunder here so that's why
I didn't just send this in as a patch, but if he doesn't protest then
I'll just re-send it.

---
 drivers/hid/Kconfig      |  1 +
 drivers/hid/hid-core.c   |  1 +
 drivers/hid/hid-elecom.c | 76 +++++++++++++++++++++++++-----------------------
 drivers/hid/hid-ids.h    |  1 +
 4 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 779c5ae47f36..772f695d4e8c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -280,6 +280,7 @@ config HID_ELECOM
 	---help---
 	Support for ELECOM devices:
 	  - BM084 Bluetooth Mouse
+	  - EX-G Trackball
 	  - DEFT Trackball (Wired and wireless)
 	  - HUGE Trackball (Wired and wireless)
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f3fcb836a1f9..18912c045816 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2034,6 +2034,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_ELECOM)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRED) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRED) },
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 54aeea57d209..d81cad44cc76 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -1,9 +1,15 @@
 /*
- *  HID driver for ELECOM devices.
+ *  HID driver for ELECOM devices:
+ *  - BM084 (bluetooth mouse)
+ *  - EX-G (trackball)
+ *  - DEFT (trackball, wired and wireless)
+ *  - HUGE (trackball, wired and wireless)
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
+ * Linux. Four extra INPUT reports and a FEATURE report are described by the
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
+			       __u8 *rdesc, unsigned int *rsize,
+			       int nbuttons)
+{
+	if (*rsize < 32 || rdesc[12] != 0x95 ||
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
@@ -31,45 +65,14 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			rdesc[47] = 0x00;
 		}
 		break;
+	case USB_DEVICE_ID_ELECOM_EX_G_WIRED:
+		mouse_button_fixup(hdev, rdesc, rsize, 6);
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
+		mouse_button_fixup(hdev, rdesc, rsize, 8);
 		break;
 	}
 	return rdesc;
@@ -77,6 +80,7 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 static const struct hid_device_id elecom_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_EX_G_WIRED) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRED) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_DEFT_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_HUGE_WIRED) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5da3d6256d25..d757c78e7e15 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -370,6 +370,7 @@
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
+#define USB_DEVICE_ID_ELECOM_EX_G_WIRED	0x00fb
 #define USB_DEVICE_ID_ELECOM_DEFT_WIRED	0x00fe
 #define USB_DEVICE_ID_ELECOM_DEFT_WIRELESS	0x00ff
 #define USB_DEVICE_ID_ELECOM_HUGE_WIRED	0x010c
-- 
2.15.0

-- 
Tomasz Kramkowski | GPG: 40B037BA0A5B8680 | Web: https://the-tk.com/
