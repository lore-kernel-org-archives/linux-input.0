From: Sebastien Alaiwan <sebastien.alaiwan@gmail.com>
Subject: [PATCH] Support for new version of USB tablet KYE-i608x (ID 0458:501A)
Date: Sat, 07 Jun 2014 09:59:58 +0200
Message-ID: <5392C67E.2090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:54825 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbaFGIAA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Jun 2014 04:00:00 -0400
Received: by mail-wi0-f181.google.com with SMTP id n15so2068823wiw.8
        for <linux-input@vger.kernel.org>; Sat, 07 Jun 2014 00:59:59 -0700 (PDT)
Received: from [10.1.1.1] (25.225.94.79.rev.sfr.net. [79.94.225.25])
        by mx.google.com with ESMTPSA id k7sm834119wjw.6.2014.06.07.00.59.58
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Jun 2014 00:59:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Here's a patch to make the hid-kye kernel module recognize a new
graphic tablet (which is a new version of the KYE i608x).

Technical stuff below:

Mine's branded as a "Genius MousePen i608x".
lsusb returns this:
Bus 005 Device 002: ID 0458:501a KYE Systems Corp. (Mouse Systems)

It seems to share the same magic HID feature report than the other
tablets of this vendor.
(not sending it results in the tablet not sending pen pressure information).

I get the tablet to send absolute information about the pen and the mouse ;
the generated events look correct, and it integrates well with xorg evdev
(except for the mouse for which a dedicated xorg driver may be needed).


-----------------------------------------------

Signed-off-by: Sebastien Alaiwan <sebastien.alaiwan@gmail.com>
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index da52279..df5534d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1775,6 +1775,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_I405X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LCPOWER, USB_DEVICE_ID_LCPOWER_LC1000 ) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 34bb220..447cd8c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -514,6 +514,7 @@
 #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
 #define USB_DEVICE_ID_KYE_EASYPEN_I405X	0x5010
 #define USB_DEVICE_ID_KYE_MOUSEPEN_I608X	0x5011
+#define USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2	0x501A
 #define USB_DEVICE_ID_KYE_EASYPEN_M610X	0x5013
 
 #define USB_VENDOR_ID_LABTEC		0x1020
diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index e776963..7f4757f 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -186,6 +186,105 @@ static __u8 mousepen_i608x_rdesc_fixed[] = {
 	0xC0              /*  End Collection                  */
 };
 
+/* Original MousePen i608X report descriptor size */
+#define MOUSEPEN_I608X_2_RDESC_ORIG_SIZE	482
+
+/* Fixed MousePen i608X report descriptor */
+static __u8 mousepen_i608x_2_rdesc_fixed[] = {
+	0x06, 0x00, 0xFF, /*  Usage Page (FF00h),             */
+	0x09, 0x01,       /*  Usage (01h),                    */
+	0xA1, 0x01,       /*  Collection (Application),       */
+	0x85, 0x05,       /*    Report ID (5),                */
+	0x09, 0x01,       /*    Usage (01h),                  */
+	0x15, 0x80,       /*    Logical Minimum (-128),       */
+	0x25, 0x7F,       /*    Logical Maximum (127),        */
+	0x75, 0x08,       /*    Report Size (8),              */
+	0x95, 0x07,       /*    Report Count (7),             */
+	0xB1, 0x02,       /*    Feature (Variable),           */
+	0xC0,             /*  End Collection,                 */
+	0x05, 0x0D,       /*  Usage Page (Digitizer),         */
+	0x09, 0x02,       /*  Usage (Pen),                    */
+	0xA1, 0x01,       /*  Collection (Application),       */
+	0x85, 0x10,       /*    Report ID (16),               */
+	0x09, 0x20,       /*    Usage (Stylus),               */
+	0xA0,             /*    Collection (Physical),        */
+	0x14,             /*      Logical Minimum (0),        */
+	0x25, 0x01,       /*      Logical Maximum (1),        */
+	0x75, 0x01,       /*      Report Size (1),            */
+	0x09, 0x42,       /*      Usage (Tip Switch),         */
+	0x09, 0x44,       /*      Usage (Barrel Switch),      */
+	0x09, 0x46,       /*      Usage (Tablet Pick),        */
+	0x95, 0x03,       /*      Report Count (3),           */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0x95, 0x04,       /*      Report Count (4),           */
+	0x81, 0x03,       /*      Input (Constant, Variable), */
+	0x09, 0x32,       /*      Usage (In Range),           */
+	0x95, 0x01,       /*      Report Count (1),           */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0x75, 0x10,       /*      Report Size (16),           */
+	0x95, 0x01,       /*      Report Count (1),           */
+	0xA4,             /*      Push,                       */
+	0x05, 0x01,       /*      Usage Page (Desktop),       */
+	0x55, 0xFD,       /*      Unit Exponent (-3),         */
+	0x65, 0x13,       /*      Unit (Inch),                */
+	0x34,             /*      Physical Minimum (0),       */
+	0x09, 0x30,       /*      Usage (X),                  */
+	0x46, 0x40, 0x1F, /*      Physical Maximum (8000),    */
+	0x26, 0x00, 0xA0, /*      Logical Maximum (40960),    */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0x09, 0x31,       /*      Usage (Y),                  */
+	0x46, 0x70, 0x17, /*      Physical Maximum (6000),    */
+	0x26, 0x00, 0x78, /*      Logical Maximum (30720),    */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0xB4,             /*      Pop,                        */
+	0x09, 0x30,       /*      Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x07, /*      Logical Maximum (2047),     */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0xC0,             /*    End Collection,               */
+	0xC0,             /*  End Collection,                 */
+	0x05, 0x01,       /*  Usage Page (Desktop),           */
+	0x09, 0x02,       /*  Usage (Mouse),                  */
+	0xA1, 0x01,       /*  Collection (Application),       */
+	0x85, 0x11,       /*    Report ID (17),               */
+	0x09, 0x01,       /*    Usage (Pointer),              */
+	0xA0,             /*    Collection (Physical),        */
+	0x14,             /*      Logical Minimum (0),        */
+	0xA4,             /*      Push,                       */
+	0x05, 0x09,       /*      Usage Page (Button),        */
+	0x75, 0x01,       /*      Report Size (1),            */
+	0x19, 0x01,       /*      Usage Minimum (01h),        */
+	0x29, 0x03,       /*      Usage Maximum (03h),        */
+	0x25, 0x01,       /*      Logical Maximum (1),        */
+	0x95, 0x03,       /*      Report Count (3),           */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0x95, 0x05,       /*      Report Count (5),           */
+	0x81, 0x01,       /*      Input (Constant),           */
+	0xB4,             /*      Pop,                        */
+	0x95, 0x01,       /*      Report Count (1),           */
+	0xA4,             /*      Push,                       */
+	0x55, 0xFD,       /*      Unit Exponent (-3),         */
+	0x65, 0x13,       /*      Unit (Inch),                */
+	0x34,             /*      Physical Minimum (0),       */
+	0x75, 0x10,       /*      Report Size (16),           */
+	0x09, 0x30,       /*      Usage (X),                  */
+	0x46, 0x40, 0x1F, /*      Physical Maximum (8000),    */
+	0x26, 0x00, 0x50, /*      Logical Maximum (20480),    */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0x09, 0x31,       /*      Usage (Y),                  */
+	0x46, 0x70, 0x17, /*      Physical Maximum (6000),    */
+	0x26, 0x00, 0x3C, /*      Logical Maximum (15360),    */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0xB4,             /*      Pop,                        */
+	0x75, 0x08,       /*      Report Size (8),            */
+	0x09, 0x38,       /*      Usage (Wheel),              */
+	0x15, 0xFF,       /*      Logical Minimum (-1),       */
+	0x25, 0x01,       /*      Logical Maximum (1),        */
+	0x81, 0x06,       /*      Input (Variable, Relative), */
+	0x81, 0x01,       /*      Input (Constant),           */
+	0xC0,             /*    End Collection,               */
+	0xC0              /*  End Collection                  */
+};
+
 /*
  * See EasyPen M610X description, device and HID report descriptors at
  * http://sf.net/apps/mediawiki/digimend/?title=KYE_EasyPen_M610X
@@ -328,6 +427,12 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			*rsize = sizeof(mousepen_i608x_rdesc_fixed);
 		}
 		break;
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2:
+		if (*rsize == MOUSEPEN_I608X_2_RDESC_ORIG_SIZE) {
+			rdesc = mousepen_i608x_2_rdesc_fixed;
+			*rsize = sizeof(mousepen_i608x_2_rdesc_fixed);
+		}
+		break;
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
 		if (*rsize == EASYPEN_M610X_RDESC_ORIG_SIZE) {
 			rdesc = easypen_m610x_rdesc_fixed;
@@ -415,6 +520,7 @@ static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	switch (id->product) {
 	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2:
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
 		ret = kye_tablet_enable(hdev);
 		if (ret) {
@@ -446,6 +552,8 @@ static const struct hid_device_id kye_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
 				USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE) },
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 8e4ddb3..85c01ec 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -113,6 +113,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X_2, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS1, HID_QUIRK_NO_INIT_REPORTS },

