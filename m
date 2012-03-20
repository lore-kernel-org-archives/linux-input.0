From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 2/2] HID: waltop: Add support for Sirius tablet
Date: Tue, 20 Mar 2012 16:01:33 +0200
Message-ID: <1332252093-13394-3-git-send-email-spbnick@gmail.com>
References: <1332252093-13394-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34178 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760077Ab2CTOB4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 10:01:56 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so53014lah.19
        for <linux-input@vger.kernel.org>; Tue, 20 Mar 2012 07:01:55 -0700 (PDT)
In-Reply-To: <1332252093-13394-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Nikolai Kondrashov <spbnick@gmail.com>

Add support for Waltop Sirius Battery Free Tablet. VisTablet Muse and Princeton
PTB-S1BK are other possible names of this tablet.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-core.c          |    1 +
 drivers/hid/hid-ids.h           |    1 +
 drivers/hid/hid-waltop.c        |  189 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/hid-quirks.c |    1 +
 4 files changed, 192 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c39c25b..f9b5bf7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1576,6 +1576,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_PID_0038) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_XAT, USB_DEVICE_ID_XAT_CSR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XIROKU_SPX) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_XIROKU, USB_DEVICE_ID_XIROKU_MPX) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 743269a..41f7887 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -730,6 +730,7 @@
 #define USB_DEVICE_ID_WALTOP_PID_0038			0x0038
 #define USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH	0x0501
 #define USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH	0x0500
+#define USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET	0x0502
 
 #define USB_VENDOR_ID_WISEGROUP		0x0925
 #define USB_DEVICE_ID_SMARTJOY_PLUS	0x0005
diff --git a/drivers/hid/hid-waltop.c b/drivers/hid/hid-waltop.c
index 2cfd95c..9a48438 100644
--- a/drivers/hid/hid-waltop.c
+++ b/drivers/hid/hid-waltop.c
@@ -502,6 +502,142 @@ static __u8 media_tablet_14_1_inch_rdesc_fixed[] = {
 	0xC0                /*  End Collection                      */
 };
 
+/*
+ * See Sirius Battery Free Tablet description, device and HID report descriptors
+ * at
+ * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Sirius_Battery_Free_Tablet
+ */
+
+/* Size of the original report descriptor of Sirius Battery Free Tablet */
+#define SIRIUS_BATTERY_FREE_TABLET_RDESC_ORIG_SIZE	335
+
+/* Fixed Sirius Battery Free Tablet descriptor */
+static __u8 sirius_battery_free_tablet_rdesc_fixed[] = {
+	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
+	0x09, 0x02,         /*  Usage (Pen),                        */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x10,         /*      Report ID (16),                 */
+	0x09, 0x20,         /*      Usage (Stylus),                 */
+	0xA0,               /*      Collection (Physical),          */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x15, 0x01,         /*          Logical Minimum (1),        */
+	0x25, 0x03,         /*          Logical Maximum (3),        */
+	0x75, 0x02,         /*          Report Size (2),            */
+	0x09, 0x42,         /*          Usage (Tip Switch),         */
+	0x09, 0x44,         /*          Usage (Barrel Switch),      */
+	0x09, 0x46,         /*          Usage (Tablet Pick),        */
+	0x80,               /*          Input,                      */
+	0x14,               /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x09, 0x3C,         /*          Usage (Invert),             */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x09, 0x32,         /*          Usage (In Range),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0xA4,               /*          Push,                       */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x55, 0xFD,         /*          Unit Exponent (-3),         */
+	0x65, 0x13,         /*          Unit (Inch),                */
+	0x34,               /*          Physical Minimum (0),       */
+	0x14,               /*          Logical Minimum (0),        */
+	0x75, 0x10,         /*          Report Size (16),           */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x46, 0x10, 0x27,   /*          Physical Maximum (10000),   */
+	0x26, 0x20, 0x4E,   /*          Logical Maximum (20000),    */
+	0x09, 0x30,         /*          Usage (X),                  */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x46, 0x70, 0x17,   /*          Physical Maximum (6000),    */
+	0x26, 0xE0, 0x2E,   /*          Logical Maximum (12000),    */
+	0x09, 0x31,         /*          Usage (Y),                  */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xB4,               /*          Pop,                        */
+	0x75, 0x10,         /*          Report Size (16),           */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x14,               /*          Logical Minimum (0),        */
+	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+	0x09, 0x30,         /*          Usage (Tip Pressure),       */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xA4,               /*          Push,                       */
+	0x55, 0xFE,         /*          Unit Exponent (-2),         */
+	0x65, 0x12,         /*          Unit (Radians),             */
+	0x35, 0x97,         /*          Physical Minimum (-105),    */
+	0x45, 0x69,         /*          Physical Maximum (105),     */
+	0x15, 0x97,         /*          Logical Minimum (-105),     */
+	0x25, 0x69,         /*          Logical Maximum (105),      */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x02,         /*          Report Count (2),           */
+	0x09, 0x3D,         /*          Usage (X Tilt),             */
+	0x09, 0x3E,         /*          Usage (Y Tilt),             */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xB4,               /*          Pop,                        */
+	0xC0,               /*      End Collection,                 */
+	0xC0,               /*  End Collection,                     */
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x02,         /*  Usage (Mouse),                      */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x01,         /*      Report ID (1),                  */
+	0x09, 0x01,         /*      Usage (Pointer),                */
+	0xA0,               /*      Collection (Physical),          */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x09, 0x38,         /*          Usage (Wheel),              */
+	0x15, 0xFF,         /*          Logical Minimum (-1),       */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x06,         /*          Input (Variable, Relative), */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0xC0,               /*      End Collection,                 */
+	0xC0,               /*  End Collection,                     */
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x06,         /*  Usage (Keyboard),                   */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x0D,         /*      Report ID (13),                 */
+	0x05, 0x07,         /*      Usage Page (Keyboard),          */
+	0x19, 0xE0,         /*      Usage Minimum (KB Leftcontrol), */
+	0x29, 0xE7,         /*      Usage Maximum (KB Right GUI),   */
+	0x14,               /*      Logical Minimum (0),            */
+	0x25, 0x01,         /*      Logical Maximum (1),            */
+	0x75, 0x01,         /*      Report Size (1),                */
+	0x95, 0x08,         /*      Report Count (8),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0x81, 0x01,         /*      Input (Constant),               */
+	0x18,               /*      Usage Minimum (None),           */
+	0x29, 0x65,         /*      Usage Maximum (KB Application), */
+	0x14,               /*      Logical Minimum (0),            */
+	0x25, 0x65,         /*      Logical Maximum (101),          */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x95, 0x05,         /*      Report Count (5),               */
+	0x80,               /*      Input,                          */
+	0xC0,               /*  End Collection,                     */
+	0x05, 0x0C,         /*  Usage Page (Consumer),              */
+	0x09, 0x01,         /*  Usage (Consumer Control),           */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x0C,         /*      Report ID (12),                 */
+	0x09, 0xE9,         /*      Usage (Volume Inc),             */
+	0x09, 0xEA,         /*      Usage (Volume Dec),             */
+	0x14,               /*      Logical Minimum (0),            */
+	0x25, 0x01,         /*      Logical Maximum (1),            */
+	0x75, 0x01,         /*      Report Size (1),                */
+	0x95, 0x02,         /*      Report Count (2),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x75, 0x06,         /*      Report Size (6),                */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0x81, 0x03,         /*      Input (Constant, Variable),     */
+	0x75, 0x10,         /*      Report Size (16),               */
+	0x95, 0x03,         /*      Report Count (3),               */
+	0x81, 0x03,         /*      Input (Constant, Variable),     */
+	0xC0                /*  End Collection                      */
+};
+
 struct waltop_state {
 	u8 pressure0;
 	u8 pressure1;
@@ -583,6 +719,12 @@ static __u8 *waltop_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			*rsize = sizeof(media_tablet_14_1_inch_rdesc_fixed);
 		}
 		break;
+	case USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET:
+		if (*rsize == SIRIUS_BATTERY_FREE_TABLET_RDESC_ORIG_SIZE) {
+			rdesc = sirius_battery_free_tablet_rdesc_fixed;
+			*rsize = sizeof(sirius_battery_free_tablet_rdesc_fixed);
+		}
+		break;
 	}
 	return rdesc;
 }
@@ -614,6 +756,51 @@ static int waltop_raw_event(struct hid_device *hdev, struct hid_report *report,
 		}
 	}
 
+	/* If this is a pen input report of Sirius Battery Free Tablet */
+	if (hdev->product == USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET &&
+	    report->type == HID_INPUT_REPORT &&
+	    report->id == 16 &&
+	    size == 10) {
+		/*
+		 * The tablet reports tilt as roughly sin(a)*21 (18 means 60
+		 * degrees).
+		 *
+		 * This array stores angles as radians * 100, corresponding to
+		 * reported values up to 60 degrees, as expected by userspace.
+		 */
+		static const s8 tilt_to_radians[] = {
+			0, 5, 10, 14, 19, 24, 29, 34, 40, 45,
+			50, 56, 62, 68, 74, 81, 88, 96, 105
+		};
+
+		s8 tilt_x = (s8)data[8];
+		s8 tilt_y = (s8)data[9];
+		s8 sign_x = tilt_x >= 0 ? 1 : -1;
+		s8 sign_y = tilt_y >= 0 ? 1 : -1;
+
+		tilt_x *= sign_x;
+		tilt_y *= sign_y;
+
+		/*
+		 * Reverse the Y Tilt direction to match the HID standard and
+		 * userspace expectations. See HID Usage Tables v1.12 16.3.2
+		 * Tilt Orientation.
+		 */
+		sign_y *= -1;
+
+		/*
+		 * This effectively clamps reported tilt to 60 degrees - the
+		 * range expected by userspace
+		 */
+		if (tilt_x > ARRAY_SIZE(tilt_to_radians) - 1)
+			tilt_x = ARRAY_SIZE(tilt_to_radians) - 1;
+		if (tilt_y > ARRAY_SIZE(tilt_to_radians) - 1)
+			tilt_y = ARRAY_SIZE(tilt_to_radians) - 1;
+
+		data[8] = tilt_to_radians[tilt_x] * sign_x;
+		data[9] = tilt_to_radians[tilt_y] * sign_y;
+	}
+
 	return 0;
 }
 
@@ -638,6 +825,8 @@ static const struct hid_device_id waltop_devices[] = {
 				USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
 				USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
+			 USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, waltop_devices);
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 2115924..c9ace13 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -87,6 +87,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 
 	{ USB_VENDOR_ID_WISEGROUP_LTD2, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
-- 
1.7.9.1

