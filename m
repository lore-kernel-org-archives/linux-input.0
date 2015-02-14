From: milan.plzik@gmail.com
Subject: [PATCH] Fix report descriptor for Genius PenSketch M912
Date: Sat, 14 Feb 2015 09:48:44 +0100
Message-ID: <1423903724-18792-1-git-send-email-milan.plzik@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:44501 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbbBNIss (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Feb 2015 03:48:48 -0500
Received: by mail-wg0-f50.google.com with SMTP id l2so20825249wgh.9
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2015 00:48:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, digimend-devel@lists.sourceforge.net, Milan Plzik <milan.plzik@gmail.com>

From: Milan Plzik <milan.plzik@gmail.com>

Genius PenSketch M912 digitizer tablet sends incorrect report descriptor by
default. This patch replaces it with a corrected one.

Signed-off-by: Milan Plzik <milan.plzik@gmail.com>
---
 drivers/hid/hid-core.c          |   1 +
 drivers/hid/hid-ids.h           |   1 +
 drivers/hid/hid-kye.c           | 140 ++++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/hid-quirks.c |   1 +
 4 files changed, 143 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8b63879..3c21c0d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1807,6 +1807,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LCPOWER, USB_DEVICE_ID_LCPOWER_LC1000 ) },
 #if IS_ENABLED(CONFIG_HID_LENOVO)
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9243359..945943d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -528,6 +528,7 @@
 #define USB_DEVICE_ID_KYE_MOUSEPEN_I608X	0x5011
 #define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2	0x501a
 #define USB_DEVICE_ID_KYE_EASYPEN_M610X	0x5013
+#define USB_DEVICE_ID_KYE_PENSKETCH_M912	0x5015
 
 #define USB_VENDOR_ID_LABTEC		0x1020
 #define USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD	0x0006
diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index 158fcf5..32e6d8d 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -268,6 +268,137 @@ static __u8 easypen_m610x_rdesc_fixed[] = {
 	0xC0                          /*  End Collection                  */
 };
 
+
+/* Original PenSketch M912 report descriptor size */
+#define PENSKETCH_M912_RDESC_ORIG_SIZE	482
+
+/* Fixed PenSketch M912 report descriptor */
+static __u8 pensketch_m912_rdesc_fixed[] = {
+	0x05, 0x01,                   /*  Usage Page (Desktop),           */
+	0x08,                         /*  Usage (00h),                    */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x05,                   /*    Report ID (5),                */
+	0x06, 0x00, 0xFF,             /*    Usage Page (FF00h),           */
+	0x09, 0x01,                   /*    Usage (01h),                  */
+	0x15, 0x81,                   /*    Logical Minimum (-127),       */
+	0x25, 0x7F,                   /*    Logical Maximum (127),        */
+	0x75, 0x08,                   /*    Report Size (8),              */
+	0x95, 0x07,                   /*    Report Count (7),             */
+	0xB1, 0x02,                   /*    Feature (Variable),           */
+	0xC0,                         /*  End Collection,                 */
+	0x05, 0x0D,                   /*  Usage Page (Digitizer),         */
+	0x09, 0x02,                   /*  Usage (Pen),                    */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x10,                   /*    Report ID (16),               */
+	0x09, 0x20,                   /*    Usage (Stylus),               */
+	0xA0,                         /*    Collection (Physical),        */
+	0x09, 0x42,                   /*      Usage (Tip Switch),         */
+	0x09, 0x44,                   /*      Usage (Barrel Switch),      */
+	0x09, 0x46,                   /*      Usage (Tablet Pick),        */
+	0x14,                         /*      Logical Minimum (0),        */
+	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x75, 0x01,                   /*      Report Size (1),            */
+	0x95, 0x03,                   /*      Report Count (3),           */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x95, 0x04,                   /*      Report Count (4),           */
+	0x81, 0x03,                   /*      Input (Constant, Variable), */
+	0x09, 0x32,                   /*      Usage (In Range),           */
+	0x95, 0x01,                   /*      Report Count (1),           */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x75, 0x10,                   /*      Report Size (16),           */
+	0x95, 0x01,                   /*      Report Count (1),           */
+	0xA4,                         /*      Push,                       */
+	0x05, 0x01,                   /*      Usage Page (Desktop),       */
+	0x55, 0xFD,                   /*      Unit Exponent (-3),         */
+	0x65, 0x13,                   /*      Unit (Inch),                */
+	0x14,                         /*      Logical Minimum (0),        */
+	0x34,                         /*      Physical Minimum (0),       */
+	0x09, 0x30,                   /*      Usage (X),                  */
+	0x27, 0x00, 0xF0, 0x00, 0x00, /*      Logical Maximum (61440),    */
+	0x46, 0xE0, 0x2E,             /*      Physical Maximum (12000),   */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x09, 0x31,                   /*      Usage (Y),                  */
+	0x27, 0x00, 0xB4, 0x00, 0x00, /*      Logical Maximum (46080),    */
+	0x46, 0x28, 0x23,             /*      Physical Maximum (9000),    */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0xB4,                         /*      Pop,                        */
+	0x09, 0x30,                   /*      Usage (Tip Pressure),       */
+	0x14,                         /*      Logical Minimum (0),        */
+	0x26, 0xFF, 0x07,             /*      Logical Maximum (2047),     */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0xC0,                         /*    End Collection,               */
+	0xC0,                         /*  End Collection,                 */
+	0x05, 0x0D,                   /*  Usage Page (Digitizer),         */
+	0x09, 0x21,                   /*  Usage (Puck),                   */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x11,                   /*    Report ID (17),               */
+	0x09, 0x21,                   /*    Usage (Puck),                 */
+	0xA0,                         /*    Collection (Physical),        */
+	0x05, 0x09,                   /*      Usage Page (Button),        */
+	0x75, 0x01,                   /*      Report Size (1),            */
+	0x19, 0x01,                   /*      Usage Minimum (01h),        */
+	0x29, 0x03,                   /*      Usage Maximum (03h),        */
+	0x14,                         /*      Logical Minimum (0),        */
+	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x95, 0x03,                   /*      Report Count (3),           */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x95, 0x04,                   /*      Report Count (4),           */
+	0x81, 0x01,                   /*      Input (Constant),           */
+	0x95, 0x01,                   /*      Report Count (1),           */
+	0x0B, 0x32, 0x00, 0x0D, 0x00, /*      Usage (Digitizer In Range), */
+	0x14,                         /*      Logical Minimum (0),        */
+	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0xA4,                         /*      Push,                       */
+	0x05, 0x01,                   /*      Usage Page (Desktop),       */
+	0x75, 0x10,                   /*      Report Size (16),           */
+	0x95, 0x01,                   /*      Report Count (1),           */
+	0x55, 0xFD,                   /*      Unit Exponent (-3),         */
+	0x65, 0x13,                   /*      Unit (Inch),                */
+	0x14,                         /*      Logical Minimum (0),        */
+	0x34,                         /*      Physical Minimum (0),       */
+	0x09, 0x30,                   /*      Usage (X),                  */
+	0x27, 0x00, 0xF0, 0x00, 0x00, /*      Logical Maximum (61440),    */
+	0x46, 0xE0, 0x2E,             /*      Physical Maximum (12000),   */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x09, 0x31,                   /*      Usage (Y),                  */
+	0x27, 0x00, 0xB4, 0x00, 0x00, /*      Logical Maximum (46080),    */
+	0x46, 0x28, 0x23,             /*      Physical Maximum (9000),    */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x09, 0x38,                   /*      Usage (Wheel),              */
+	0x75, 0x08,                   /*      Report Size (8),            */
+	0x95, 0x01,                   /*      Report Count (1),           */
+	0x15, 0xFF,                   /*      Logical Minimum (-1),       */
+	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x34,                         /*      Physical Minimum (0),       */
+	0x44,                         /*      Physical Maximum (0),       */
+	0x81, 0x06,                   /*      Input (Variable, Relative), */
+	0xB4,                         /*      Pop,                        */
+	0xC0,                         /*    End Collection,               */
+	0xC0,                         /*  End Collection,                 */
+	0x05, 0x0C,                   /*  Usage Page (Consumer),          */
+	0x09, 0x01,                   /*  Usage (Consumer Control),       */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x12,                   /*    Report ID (18),               */
+	0x14,                         /*    Logical Minimum (0),          */
+	0x25, 0x01,                   /*    Logical Maximum (1),          */
+	0x75, 0x01,                   /*    Report Size (1),              */
+	0x95, 0x08,                   /*    Report Count (8),             */
+	0x05, 0x0C,                   /*    Usage Page (Consumer),        */
+	0x0A, 0x6A, 0x02,             /*    Usage (AC Delete),            */
+	0x0A, 0x1A, 0x02,             /*    Usage (AC Undo),              */
+	0x0A, 0x01, 0x02,             /*    Usage (AC New),               */
+	0x0A, 0x2F, 0x02,             /*    Usage (AC Zoom),              */
+	0x0A, 0x25, 0x02,             /*    Usage (AC Forward),           */
+	0x0A, 0x24, 0x02,             /*    Usage (AC Back),              */
+	0x0A, 0x2D, 0x02,             /*    Usage (AC Zoom In),           */
+	0x0A, 0x2E, 0x02,             /*    Usage (AC Zoom Out),          */
+	0x81, 0x02,                   /*    Input (Variable),             */
+	0x95, 0x30,                   /*    Report Count (48),            */
+	0x81, 0x03,                   /*    Input (Constant, Variable),   */
+	0xC0                          /*  End Collection                  */
+};
+
 static __u8 *kye_consumer_control_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize, int offset, const char *device_name) {
 	/*
@@ -335,6 +466,12 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			*rsize = sizeof(easypen_m610x_rdesc_fixed);
 		}
 		break;
+	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
+		if (*rsize == PENSKETCH_M912_RDESC_ORIG_SIZE) {
+			rdesc = pensketch_m912_rdesc_fixed;
+			*rsize = sizeof(pensketch_m912_rdesc_fixed);
+		}
+		break;
 	case USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE:
 		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
 					"Genius Gila Gaming Mouse");
@@ -418,6 +555,7 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2:
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
+	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
 		ret = kye_tablet_enable(hdev);
 		if (ret) {
 			hid_err(hdev, "tablet enabling failed\n");
@@ -457,6 +595,8 @@ static const struct hid_device_id kye_devices[] = {
 				USB_DEVICE_ID_GENIUS_GX_IMPERATOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_GENIUS_MANTICORE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_PENSKETCH_M912) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, kye_devices);
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index b27b3d3..488ec99 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -126,6 +126,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS1, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.2.2

