From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/1] HID: uclogic: Add support for UC-Logic TWHL850
Date: Sun, 13 May 2012 23:33:10 +0300
Message-ID: <1336941190-11066-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36977 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab2EMUdi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 May 2012 16:33:38 -0400
Received: by wibhj8 with SMTP id hj8so1055085wib.1
        for <linux-input@vger.kernel.org>; Sun, 13 May 2012 13:33:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Nikolai Kondrashov <spbnick@gmail.com>

Add support for UC-Logic Wireless Tablet TWHL850.
It is known to be sold as Genius MousePen M508W.

This tablet has a bug in the default (compatibility) mode which is used in this
driver: frame button assignments are mixed up. This is to be fixed with a driver
using proprietary protocol, which is to be fully reverse-engineered yet.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---

This is based on 3.4-rc7.

I'm a bit unsure about the IFACE_RDESC_FIXUP macro. Please tell if it's not
acceptable and I'll rewrite that part in the required way.

Thanks!

 drivers/hid/hid-core.c    |    1 +
 drivers/hid/hid-ids.h     |    1 +
 drivers/hid/hid-uclogic.c |  136 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4da66b4..c25fc49 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1562,6 +1562,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP1062) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_WIRELESS_TABLET_TWHL850) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UNITEC, USB_DEVICE_ID_UNITEC_USB_TOUCH_0709) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UNITEC, USB_DEVICE_ID_UNITEC_USB_TOUCH_0A19) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e39aecb..ad8d743 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -726,6 +726,7 @@
 #define USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U	0x0004
 #define USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U	0x0005
 #define USB_DEVICE_ID_UCLOGIC_TABLET_WP1062	0x0064
+#define USB_DEVICE_ID_UCLOGIC_WIRELESS_TABLET_TWHL850	0x0522
 
 #define USB_VENDOR_ID_UNITEC	0x227d
 #define USB_DEVICE_ID_UNITEC_USB_TOUCH_0709	0x0709
diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 1f11289..c70a0bc 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/usb.h>
 
 #include "hid-ids.h"
 
@@ -352,9 +353,125 @@ static __u8 pf1209_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
+/*
+ * See TWHL850 description, device and HID report descriptors at
+ * http://sf.net/apps/mediawiki/digimend/?title=UC-Logic_Wireless_Tablet_TWHL850
+ */
+
+/* Size of the original descriptors of TWHL850 tablet */
+#define TWHL850_RDESC_ORIG_SIZE0	182
+#define TWHL850_RDESC_ORIG_SIZE1	161
+#define TWHL850_RDESC_ORIG_SIZE2	92
+
+/* Fixed PID 0522 tablet report descriptor, interface 0 (stylus) */
+static __u8 twhl850_rdesc_fixed0[] = {
+	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
+	0x09, 0x02,         /*  Usage (Pen),                        */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x09,         /*      Report ID (9),                  */
+	0x09, 0x20,         /*      Usage (Stylus),                 */
+	0xA0,               /*      Collection (Physical),          */
+	0x14,               /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x09, 0x42,         /*          Usage (Tip Switch),         */
+	0x09, 0x44,         /*          Usage (Barrel Switch),      */
+	0x09, 0x46,         /*          Usage (Tablet Pick),        */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x09, 0x32,         /*          Usage (In Range),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x75, 0x10,         /*          Report Size (16),           */
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
+	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xC0,               /*      End Collection,                 */
+	0xC0                /*  End Collection                      */
+};
+
+/* Fixed PID 0522 tablet report descriptor, interface 1 (mouse) */
+static __u8 twhl850_rdesc_fixed1[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x02,         /*  Usage (Mouse),                      */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x01,         /*      Report ID (1),                  */
+	0x09, 0x01,         /*      Usage (Pointer),                */
+	0xA0,               /*      Collection (Physical),          */
+	0x05, 0x09,         /*          Usage Page (Button),        */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x19, 0x01,         /*          Usage Minimum (01h),        */
+	0x29, 0x03,         /*          Usage Maximum (03h),        */
+	0x14,               /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x05,         /*          Report Count (5),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x09, 0x30,         /*          Usage (X),                  */
+	0x09, 0x31,         /*          Usage (Y),                  */
+	0x16, 0x00, 0x80,   /*          Logical Minimum (-32768),   */
+	0x26, 0xFF, 0x7F,   /*          Logical Maximum (32767),    */
+	0x75, 0x10,         /*          Report Size (16),           */
+	0x95, 0x02,         /*          Report Count (2),           */
+	0x81, 0x06,         /*          Input (Variable, Relative), */
+	0x09, 0x38,         /*          Usage (Wheel),              */
+	0x15, 0xFF,         /*          Logical Minimum (-1),       */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x81, 0x06,         /*          Input (Variable, Relative), */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0xC0,               /*      End Collection,                 */
+	0xC0                /*  End Collection                      */
+};
+
+/* Fixed PID 0522 tablet report descriptor, interface 2 (frame buttons) */
+static __u8 twhl850_rdesc_fixed2[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x06,         /*  Usage (Keyboard),                   */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x03,         /*      Report ID (3),                  */
+	0x05, 0x07,         /*      Usage Page (Keyboard),          */
+	0x14,               /*      Logical Minimum (0),            */
+	0x19, 0xE0,         /*      Usage Minimum (KB Leftcontrol), */
+	0x29, 0xE7,         /*      Usage Maximum (KB Right GUI),   */
+	0x25, 0x01,         /*      Logical Maximum (1),            */
+	0x75, 0x01,         /*      Report Size (1),                */
+	0x95, 0x08,         /*      Report Count (8),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x18,               /*      Usage Minimum (None),           */
+	0x29, 0xFF,         /*      Usage Maximum (FFh),            */
+	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x95, 0x06,         /*      Report Count (6),               */
+	0x80,               /*      Input,                          */
+	0xC0                /*  End Collection                      */
+};
+
 static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 					unsigned int *rsize)
 {
+	struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
+	__u8 iface_num = iface->cur_altsetting->desc.bInterfaceNumber;
+
 	switch (hdev->product) {
 	case USB_DEVICE_ID_UCLOGIC_TABLET_PF1209:
 		if (*rsize == PF1209_RDESC_ORIG_SIZE) {
@@ -386,6 +503,23 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			*rsize = sizeof(wp1062_rdesc_fixed);
 		}
 		break;
+	case USB_DEVICE_ID_UCLOGIC_WIRELESS_TABLET_TWHL850:
+		switch (iface_num) {
+#define IFACE_RDESC_FIXUP(_N) \
+	case _N:							\
+		if (*rsize == TWHL850_RDESC_ORIG_SIZE##_N) {		\
+			rdesc = twhl850_rdesc_fixed##_N;		\
+			*rsize = sizeof(twhl850_rdesc_fixed##_N);	\
+		}							\
+		break
+
+		IFACE_RDESC_FIXUP(0);
+		IFACE_RDESC_FIXUP(1);
+		IFACE_RDESC_FIXUP(2);
+
+#undef IFACE_RDESC_FIXUP
+		}
+		break;
 	}
 
 	return rdesc;
@@ -402,6 +536,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
 				USB_DEVICE_ID_UCLOGIC_TABLET_WP1062) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
+				USB_DEVICE_ID_UCLOGIC_WIRELESS_TABLET_TWHL850) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, uclogic_devices);
-- 
1.7.10

