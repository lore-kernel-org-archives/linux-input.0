From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/1] HID: uclogic: Add support for UC-Logic TWHA60
Date: Sun, 26 Aug 2012 20:55:08 +0300
Message-ID: <1346003708-13032-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52259 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751087Ab2HZRzX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Aug 2012 13:55:23 -0400
Received: by lagy9 with SMTP id y9so2107510lag.19
        for <linux-input@vger.kernel.org>; Sun, 26 Aug 2012 10:55:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, DIGImend-devel <digimend-devel@lists.sourceforge.net>, Nikolai Kondrashov <spbnick@gmail.com>

Add support for UC-Logic Tablet TWHA60.
It is known to be sold as Genius EasyPen M610 and Monoprice MP1060-HA60.

As this tablet has several variations with different number and different
assignments of frame buttons, they are simply mapped to F1-F24 range and are
left for users to remap in userspace.
---
 drivers/hid/hid-core.c    |    1 +
 drivers/hid/hid-ids.h     |    1 +
 drivers/hid/hid-uclogic.c |   98 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8e3a6b2..218e46d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1645,6 +1645,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP1062) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_WIRELESS_TABLET_TWHL850) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SUPER_JOY_BOX_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9373f53..2155ac0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -733,6 +733,7 @@
 #define USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U	0x0005
 #define USB_DEVICE_ID_UCLOGIC_TABLET_WP1062	0x0064
 #define USB_DEVICE_ID_UCLOGIC_WIRELESS_TABLET_TWHL850	0x0522
+#define USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60	0x0781
 
 #define USB_VENDOR_ID_UNITEC	0x227d
 #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0709	0x0709
diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 3aba02b..2e56a1f 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -466,6 +466,86 @@ static __u8 twhl850_rdesc_fixed2[] = {
 	0xC0                /*  End Collection                      */
 };
 
+/*
+ * See TWHA60 description, device and HID report descriptors at
+ * http://sf.net/apps/mediawiki/digimend/?title=UC-Logic_Tablet_TWHA60
+ */
+
+/* Size of the original descriptors of TWHA60 tablet */
+#define TWHA60_RDESC_ORIG_SIZE0 254
+#define TWHA60_RDESC_ORIG_SIZE1 139
+
+/* Fixed TWHA60 report descriptor, interface 0 (stylus) */
+static __u8 twha60_rdesc_fixed0[] = {
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
+	0x27, 0x3F, 0x9C,
+		0x00, 0x00, /*          Logical Maximum (39999),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x09, 0x31,         /*          Usage (Y),                  */
+	0x46, 0x6A, 0x18,   /*          Physical Maximum (6250),    */
+	0x26, 0xA7, 0x61,   /*          Logical Maximum (24999),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xB4,               /*          Pop,                        */
+	0x09, 0x30,         /*          Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xC0,               /*      End Collection,                 */
+	0xC0                /*  End Collection                      */
+};
+
+/* Fixed TWHA60 report descriptor, interface 1 (frame buttons) */
+static __u8 twha60_rdesc_fixed1[] = {
+	0x05, 0x01, /*  Usage Page (Desktop),       */
+	0x09, 0x06, /*  Usage (Keyboard),           */
+	0xA1, 0x01, /*  Collection (Application),   */
+	0x85, 0x05, /*      Report ID (5),          */
+	0x05, 0x07, /*      Usage Page (Keyboard),  */
+	0x14,       /*      Logical Minimum (0),    */
+	0x25, 0x01, /*      Logical Maximum (1),    */
+	0x75, 0x01, /*      Report Size (1),        */
+	0x95, 0x08, /*      Report Count (8),       */
+	0x81, 0x01, /*      Input (Constant),       */
+	0x95, 0x0C, /*      Report Count (12),      */
+	0x19, 0x3A, /*      Usage Minimum (KB F1),  */
+	0x29, 0x45, /*      Usage Maximum (KB F12), */
+	0x81, 0x02, /*      Input (Variable),       */
+	0x95, 0x0C, /*      Report Count (12),      */
+	0x19, 0x68, /*      Usage Minimum (KB F13), */
+	0x29, 0x73, /*      Usage Maximum (KB F24), */
+	0x81, 0x02, /*      Input (Variable),       */
+	0x95, 0x08, /*      Report Count (8),       */
+	0x81, 0x01, /*      Input (Constant),       */
+	0xC0        /*  End Collection              */
+};
+
 static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 					unsigned int *rsize)
 {
@@ -525,6 +605,22 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			break;
 		}
 		break;
+	case USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60:
+		switch (iface_num) {
+		case 0:
+			if (*rsize == TWHA60_RDESC_ORIG_SIZE0) {
+				rdesc = twha60_rdesc_fixed0;
+				*rsize = sizeof(twha60_rdesc_fixed0);
+			}
+			break;
+		case 1:
+			if (*rsize == TWHA60_RDESC_ORIG_SIZE1) {
+				rdesc = twha60_rdesc_fixed1;
+				*rsize = sizeof(twha60_rdesc_fixed1);
+			}
+			break;
+		}
+		break;
 	}
 
 	return rdesc;
@@ -543,6 +639,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UCLOGIC_TABLET_WP1062) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
 				USB_DEVICE_ID_UCLOGIC_WIRELESS_TABLET_TWHL850) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
+				USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, uclogic_devices);
-- 
1.7.10.4

