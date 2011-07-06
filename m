From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH] HID: uclogic: Add support for UC-Logic WP1062
Date: Wed,  6 Jul 2011 09:23:41 +0300
Message-ID: <1309933421-935-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40131 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab1GFGZO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2011 02:25:14 -0400
Received: by bwd5 with SMTP id 5so5319245bwd.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 23:25:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Nikolai Kondrashov <spbnick@gmail.com>

Add support for UC-Logic Tablet WP1062 by fixing its report descriptor.

This tablet is sold as Monoprice 10X6.25 Inches Graphic Drawing Tablet.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-core.c    |    1 +
 drivers/hid/hid-ids.h     |    1 +
 drivers/hid/hid-uclogic.c |  195 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 6f3289a..5da9e3d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1491,6 +1491,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP1062) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UNITEC, USB_DEVICE_ID_UNITEC_USB_TOUCH_0709) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UNITEC, USB_DEVICE_ID_UNITEC_USB_TOUCH_0A19) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a756ee6..b156eee 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -630,6 +630,7 @@
 #define USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U	0x0003
 #define USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U	0x0004
 #define USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U	0x0005
+#define USB_DEVICE_ID_UCLOGIC_TABLET_WP1062	0x0064
 
 #define USB_VENDOR_ID_UNITEC	0x227d
 #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0709	0x0709
diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 05fdc85a..e15732f 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -343,6 +343,193 @@ static __u8 wp8060u_rdesc_fixed[] = {
 };
 
 /*
+ * Original WP1062 report descriptor.
+ *
+ * Only report ID 9 is actually used.
+ *
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Pen),                    ; Pen (02h, application collection)
+ *  Collection (Application),
+ *    Report ID (7),
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (Tip Switch),         ; Tip switch (42h, momentary control)
+ *      Usage (Barrel Switch),      ; Barrel switch (44h, momentary control)
+ *      Usage (Eraser),             ; Eraser (45h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (3),
+ *      Input (Variable),
+ *      Report Count (3),
+ *      Input (Constant, Variable),
+ *      Usage (In Range),           ; In range (32h, momentary control)
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Report Count (1),
+ *      Input (Constant, Variable),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Push,
+ *      Unit Exponent (13),
+ *      Unit (Inch),
+ *      Physical Minimum (0),
+ *      Physical Maximum (10000),
+ *      Logical Maximum (20000),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Physical Maximum (6583),
+ *      Logical Maximum (13166),
+ *      Input (Variable),
+ *      Pop,
+ *      Usage Page (Digitizer),     ; Digitizer (0Dh)
+ *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
+ *      Logical Maximum (1023),
+ *      Input (Variable),
+ *      Report Size (16),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Desktop),           ; Generic desktop controls (01h)
+ *  Usage (Mouse),                  ; Mouse (02h, application collection)
+ *  Collection (Application),
+ *    Report ID (8),
+ *    Usage (Pointer),              ; Pointer (01h, physical collection)
+ *    Collection (Physical),
+ *      Usage Page (Button),        ; Button (09h)
+ *      Usage Minimum (01h),
+ *      Usage Maximum (03h),
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Count (3),
+ *      Report Size (1),
+ *      Input (Variable),
+ *      Report Count (5),
+ *      Input (Constant),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Usage (Wheel),              ; Wheel (38h, dynamic value)
+ *      Usage (00h),
+ *      Logical Minimum (-127),
+ *      Logical Maximum (127),
+ *      Report Size (8),
+ *      Report Count (4),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Desktop),           ; Generic desktop controls (01h)
+ *  Usage (Mouse),                  ; Mouse (02h, application collection)
+ *  Collection (Application),
+ *    Report ID (9),
+ *    Usage (Pointer),              ; Pointer (01h, physical collection)
+ *    Collection (Physical),
+ *      Usage Page (Button),        ; Button (09h)
+ *      Usage Minimum (01h),
+ *      Usage Maximum (03h),
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Count (3),
+ *      Report Size (1),
+ *      Input (Variable),
+ *      Report Count (4),
+ *      Input (Constant),
+ *      Usage Page (Digitizer),     ; Digitizer (0Dh)
+ *      Usage (In Range),           ; In range (32h, momentary control)
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Push,
+ *      Unit Exponent (13),
+ *      Unit (Inch),
+ *      Physical Minimum (0),
+ *      Physical Maximum (10000),
+ *      Logical Maximum (20000),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Physical Maximum (6583),
+ *      Logical Maximum (13166),
+ *      Input (Variable),
+ *      Pop,
+ *      Usage Page (Digitizer),     ; Digitizer (0Dh)
+ *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
+ *      Logical Maximum (1023),
+ *      Report Count (1),
+ *      Report Size (16),
+ *      Input (Variable),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Desktop),           ; Generic desktop controls (01h)
+ *  Usage (00h),
+ *  Collection (Application),
+ *    Report ID (4),
+ *    Logical Minimum (0),
+ *    Logical Maximum (255),
+ *    Usage (00h),
+ *    Report Size (8),
+ *    Report Count (3),
+ *    Feature (Variable),
+ *  End Collection
+ */
+
+/* Size of the original descriptor of WP1062 tablet */
+#define WP1062_RDESC_ORIG_SIZE	254
+
+/*
+ * Fixed WP1062 report descriptor.
+ *
+ * Removed unused reports, corrected second barrel button usage code, physical
+ * units.
+ */
+static __u8 wp1062_rdesc_fixed[] = {
+	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
+	0x09, 0x02,         /*  Usage (Pen),                        */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x09,         /*      Report ID (9),                  */
+	0x09, 0x20,         /*      Usage (Stylus),                 */
+	0xA0,               /*      Collection (Physical),          */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x09, 0x42,         /*          Usage (Tip Switch),         */
+	0x09, 0x44,         /*          Usage (Barrel Switch),      */
+	0x09, 0x46,         /*          Usage (Tablet Pick),        */
+	0x14,               /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x04,         /*          Report Count (4),           */
+	0x81, 0x01,         /*          Input (Constant),           */
+	0x09, 0x32,         /*          Usage (In Range),           */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x75, 0x10,         /*          Report Size (16),           */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x14,               /*          Logical Minimum (0),        */
+	0xA4,               /*          Push,                       */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x55, 0xFD,         /*          Unit Exponent (-3),         */
+	0x65, 0x13,         /*          Unit (Inch),                */
+	0x34,               /*          Physical Minimum (0),       */
+	0x09, 0x30,         /*          Usage (X),                  */
+	0x46, 0x10, 0x27,   /*          Physical Maximum (10000),   */
+	0x26, 0x20, 0x4E,   /*          Logical Maximum (20000),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x09, 0x31,         /*          Usage (Y),                  */
+	0x46, 0xB7, 0x19,   /*          Physical Maximum (6583),    */
+	0x26, 0x6E, 0x33,   /*          Logical Maximum (13166),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xB4,               /*          Pop,                        */
+	0x09, 0x30,         /*          Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xC0,               /*      End Collection,                 */
+	0xC0                /*  End Collection                      */
+};
+
+/*
  * Original PF1209 report descriptor.
  *
  * The descriptor is similar to WPXXXXU descriptors, with an addition of a
@@ -584,6 +771,12 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			*rsize = sizeof(wp8060u_rdesc_fixed);
 		}
 		break;
+	case USB_DEVICE_ID_UCLOGIC_TABLET_WP1062:
+		if (*rsize == WP1062_RDESC_ORIG_SIZE) {
+			rdesc = wp1062_rdesc_fixed;
+			*rsize = sizeof(wp1062_rdesc_fixed);
+		}
+		break;
 	}
 
 	return rdesc;
@@ -598,6 +791,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
 				USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
+				USB_DEVICE_ID_UCLOGIC_TABLET_WP1062) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, uclogic_devices);
-- 
1.7.5.4

