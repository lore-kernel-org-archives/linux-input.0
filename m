From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 3/9] HID: kye: Fix MousePen i608X v2 report descriptor
Date: Wed, 14 Sep 2016 21:38:14 +0300
Message-ID: <20160914183820.20737-4-spbnick@gmail.com>
References: <20160914101531.GJ25951@mail.corp.redhat.com>
 <20160914183820.20737-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36309 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756218AbcINSil (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 14:38:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id b184so3789393wma.3
        for <linux-input@vger.kernel.org>; Wed, 14 Sep 2016 11:38:40 -0700 (PDT)
In-Reply-To: <20160914183820.20737-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

Add a dedicated, fixed report descriptor for the second version of KYE
MousePen i608X graphics tablet. The descriptor fixes pressure and
drawing area ranges.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-kye.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index ee5ca1f..0dd1167 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -176,6 +176,105 @@ static __u8 mousepen_i608x_rdesc_fixed[] = {
 	0xC0              /*  End Collection                  */
 };
 
+/* Original MousePen i608X v2 report descriptor size */
+#define MOUSEPEN_I608X_V2_RDESC_ORIG_SIZE	482
+
+/* Fixed MousePen i608X v2 report descriptor */
+static __u8 mousepen_i608x_v2_rdesc_fixed[] = {
+	0x06, 0x00, 0xFF,             /*  Usage Page (FF00h),             */
+	0x09, 0x01,                   /*  Usage (01h),                    */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x05,                   /*    Report ID (5),                */
+	0x09, 0x01,                   /*    Usage (01h),                  */
+	0x15, 0x80,                   /*    Logical Minimum (-128),       */
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
+	0x14,                         /*      Logical Minimum (0),        */
+	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x75, 0x01,                   /*      Report Size (1),            */
+	0x09, 0x42,                   /*      Usage (Tip Switch),         */
+	0x09, 0x44,                   /*      Usage (Barrel Switch),      */
+	0x09, 0x46,                   /*      Usage (Tablet Pick),        */
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
+	0x34,                         /*      Physical Minimum (0),       */
+	0x09, 0x30,                   /*      Usage (X),                  */
+	0x46, 0x40, 0x1F,             /*      Physical Maximum (8000),    */
+	0x27, 0x00, 0xA0, 0x00, 0x00, /*      Logical Maximum (40960),    */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x09, 0x31,                   /*      Usage (Y),                  */
+	0x46, 0x70, 0x17,             /*      Physical Maximum (6000),    */
+	0x26, 0x00, 0x78,             /*      Logical Maximum (30720),    */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0xB4,                         /*      Pop,                        */
+	0x09, 0x30,                   /*      Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x07,             /*      Logical Maximum (2047),     */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0xC0,                         /*    End Collection,               */
+	0xC0,                         /*  End Collection,                 */
+	0x05, 0x01,                   /*  Usage Page (Desktop),           */
+	0x09, 0x02,                   /*  Usage (Mouse),                  */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x11,                   /*    Report ID (17),               */
+	0x09, 0x01,                   /*    Usage (Pointer),              */
+	0xA0,                         /*    Collection (Physical),        */
+	0x14,                         /*      Logical Minimum (0),        */
+	0xA4,                         /*      Push,                       */
+	0x05, 0x09,                   /*      Usage Page (Button),        */
+	0x75, 0x01,                   /*      Report Size (1),            */
+	0x19, 0x01,                   /*      Usage Minimum (01h),        */
+	0x29, 0x03,                   /*      Usage Maximum (03h),        */
+	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x95, 0x03,                   /*      Report Count (3),           */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x95, 0x05,                   /*      Report Count (5),           */
+	0x81, 0x01,                   /*      Input (Constant),           */
+	0xB4,                         /*      Pop,                        */
+	0x95, 0x01,                   /*      Report Count (1),           */
+	0xA4,                         /*      Push,                       */
+	0x55, 0xFD,                   /*      Unit Exponent (-3),         */
+	0x65, 0x13,                   /*      Unit (Inch),                */
+	0x34,                         /*      Physical Minimum (0),       */
+	0x75, 0x10,                   /*      Report Size (16),           */
+	0x09, 0x30,                   /*      Usage (X),                  */
+	0x46, 0x40, 0x1F,             /*      Physical Maximum (8000),    */
+	0x27, 0x00, 0xA0, 0x00, 0x00, /*      Logical Maximum (40960),    */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x09, 0x31,                   /*      Usage (Y),                  */
+	0x46, 0x70, 0x17,             /*      Physical Maximum (6000),    */
+	0x26, 0x00, 0x78,             /*      Logical Maximum (30720),    */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0xB4,                         /*      Pop,                        */
+	0x75, 0x08,                   /*      Report Size (8),            */
+	0x09, 0x38,                   /*      Usage (Wheel),              */
+	0x15, 0xFF,                   /*      Logical Minimum (-1),       */
+	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x81, 0x06,                   /*      Input (Variable, Relative), */
+	0x81, 0x01,                   /*      Input (Constant),           */
+	0xC0,                         /*    End Collection,               */
+	0xC0                          /*  End Collection                  */
+};
+
 /* Original EasyPen M610X report descriptor size */
 #define EASYPEN_M610X_RDESC_ORIG_SIZE	476
 
@@ -439,12 +538,17 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		}
 		break;
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
-	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
 		if (*rsize == MOUSEPEN_I608X_RDESC_ORIG_SIZE) {
 			rdesc = mousepen_i608x_rdesc_fixed;
 			*rsize = sizeof(mousepen_i608x_rdesc_fixed);
 		}
 		break;
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
+		if (*rsize == MOUSEPEN_I608X_V2_RDESC_ORIG_SIZE) {
+			rdesc = mousepen_i608x_v2_rdesc_fixed;
+			*rsize = sizeof(mousepen_i608x_v2_rdesc_fixed);
+		}
+		break;
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
 		if (*rsize == EASYPEN_M610X_RDESC_ORIG_SIZE) {
 			rdesc = easypen_m610x_rdesc_fixed;
-- 
2.9.3

