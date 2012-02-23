From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/1] HID: kye: Add support for 3 tablets
Date: Thu, 23 Feb 2012 10:29:34 +0200
Message-ID: <1329985774-4123-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60461 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab2BWIaA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Feb 2012 03:30:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Nikolai Kondrashov <spbnick@gmail.com>

Add support for three KYE tablets: EasyPen i405X, MousePen i608X, EasyPen M610X.
Update Kconfig entry accordingly, remove EXPERT dependency.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---

I'm not sure if the Kconfig entry is changed correctly, and maybe it's not worth
citing these huge original report descriptors. Otherwise, the patch was tested
with all the tablets and they work.

 drivers/hid/Kconfig             |    9 +-
 drivers/hid/hid-core.c          |    3 +
 drivers/hid/hid-ids.h           |    3 +
 drivers/hid/hid-kye.c           | 1119 ++++++++++++++++++++++++++++++++++++++-
 drivers/hid/usbhid/hid-quirks.c |    2 +
 5 files changed, 1116 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 58776c4..54cc92f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -200,11 +200,14 @@ config HID_KEYTOUCH
 		- Keytouch IEC 60945
 
 config HID_KYE
-	tristate "Kye/Genius Ergo Mouse" if EXPERT
+	tristate "KYE/Genius devices"
 	depends on USB_HID
-	default !EXPERT
 	---help---
-	Support for Kye/Genius Ergo Mouse.
+	Support for KYE/Genius devices not fully compliant with HID standard:
+	- Ergo Mouse
+	- EasyPen i405X tablet
+	- MousePen i608X tablet
+	- EasyPen M610X tablet
 
 config HID_UCLOGIC
 	tristate "UC-Logic"
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bd89b31..6d923bd 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1436,6 +1436,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYTOUCH, USB_DEVICE_ID_KEYTOUCH_IEC) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_I405X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LCPOWER, USB_DEVICE_ID_LCPOWER_LC1000 ) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LG, USB_DEVICE_ID_LG_MULTITOUCH) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 520243c..0ce075b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -407,6 +407,9 @@
 #define USB_VENDOR_ID_KYE		0x0458
 #define USB_DEVICE_ID_KYE_ERGO_525V	0x0087
 #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
+#define USB_DEVICE_ID_KYE_EASYPEN_I405X	0x5010
+#define USB_DEVICE_ID_KYE_MOUSEPEN_I608X	0x5011
+#define USB_DEVICE_ID_KYE_EASYPEN_M610X	0x5013
 
 #define USB_VENDOR_ID_LABTEC		0x1020
 #define USB_DEVICE_ID_LABTEC_WIRELESS_KEYBOARD	0x0006
diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index f2ba9ef..8bc5f5f 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (c) 2009 Jiri Kosina
  *  Copyright (c) 2009 Tomas Hanak
+ *  Copyright (c) 2012 Nikolai Kondrashov
  */
 
 /*
@@ -15,36 +16,1119 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/usb.h>
+#include "usbhid/usbhid.h"
 
 #include "hid-ids.h"
 
-/* the fixups that need to be done:
- *   - change led usage page to button for extra buttons
- *   - report size 8 count 1 must be size 1 count 8 for button bitfield
- *   - change the button usage range to 4-7 for the extra buttons
+/*
+ * Original EasyPen i405X report descriptor.
+ *
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Physical),
+ *    Report ID (7),
+ *    Usage (EEh),
+ *    Collection (Application),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (-1),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Consumer),          ; Consumer (0Ch)
+ *  Usage (Consumer Control),       ; Consumer control
+ *                                  ; (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (3),
+ *    Logical Minimum (0),
+ *    Logical Maximum (767),
+ *    Usage Minimum (00h),
+ *    Usage Maximum (02FFh),
+ *    Report Size (16),
+ *    Report Count (1),
+ *    Input,
+ *  End Collection,
+ *  Usage Page (Desktop),           ; Generic desktop controls (01h)
+ *  Usage (00h),
+ *  Collection (Application),
+ *    Report ID (5),
+ *    Usage Page (FF00h),           ; FF00h, vendor-defined
+ *    Usage (01h),
+ *    Logical Minimum (-127),
+ *    Logical Maximum (127),
+ *    Report Size (8),
+ *    Report Count (7),
+ *    Feature (Variable),
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
+ *      Logical Minimum (0),
+ *      Logical Maximum (14080),
+ *      Physical Minimum (0),
+ *      Physical Maximum (14080),
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (10240),
+ *      Physical Minimum (0),
+ *      Physical Maximum (10240),
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Input (Variable),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Physical),
+ *    Report ID (17),
+ *    Usage (EEh),
+ *    Collection (Application),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (-1),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Pen),                    ; Pen (02h, application collection)
+ *  Collection (Application),
+ *    Report ID (16),
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (Tip Switch),         ; Tip switch (42h, momentary control)
+ *      Usage (Barrel Switch),      ; Barrel switch (44h, momentary control)
+ *      Usage (Invert),             ; Invert (3Ch, momentary control)
+ *      Usage (Eraser),             ; Eraser (45h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (4),
+ *      Input (Variable),
+ *      Report Count (3),
+ *      Input (Constant, Variable),
+ *      Usage (In Range),           ; In range (32h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Push,
+ *      Unit Exponent (13),
+ *      Unit (Inch^3),
+ *      Logical Minimum (0),
+ *      Logical Maximum (14080),
+ *      Physical Minimum (0),
+ *      Physical Maximum (14080),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Logical Maximum (10240),
+ *      Physical Maximum (10240),
+ *      Input (Variable),
+ *      Usage Page (Digitizer),     ; Digitizer (0Dh)
+ *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1023),
+ *      Physical Minimum (0),
+ *      Physical Maximum (1023),
+ *      Input (Variable),
+ *      Report Size (16),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Physical),
+ *    Report ID (20),
+ *    Usage (EEh),
+ *    Collection (Application),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (-1),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (19),
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (Tip Switch),         ; Tip switch (42h, momentary control)
+ *      Usage (Barrel Switch),      ; Barrel switch (44h, momentary control)
+ *      Usage (Invert),             ; Invert (3Ch, momentary control)
+ *      Usage (Eraser),             ; Eraser (45h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (4),
+ *      Input (Variable),
+ *      Report Count (3),
+ *      Input (Constant, Variable),
+ *      Usage (In Range),           ; In range (32h, momentary control)
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Push,
+ *      Unit Exponent (13),
+ *      Unit (Inch^3),
+ *      Logical Minimum (0),
+ *      Logical Maximum (14080),
+ *      Physical Minimum (0),
+ *      Physical Maximum (14080),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Logical Maximum (10240),
+ *      Physical Maximum (10240),
+ *      Input (Variable),
+ *      Usage Page (Digitizer),     ; Digitizer (0Dh)
+ *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1023),
+ *      Input (Variable),
+ *      Report Size (16),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Physical),
+ *    Report ID (18),
+ *    Usage (EEh),
+ *    Collection (Application),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (-1),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection
+ */
+
+/* Original EasyPen i405X report descriptor size */
+#define EASYPEN_I405X_RDESC_ORIG_SIZE	476
+
+/* Fixed EasyPen i405X report descriptor */
+static __u8 easypen_i405x_rdesc_fixed[] = {
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
+	0x46, 0x7C, 0x15, /*      Physical Maximum (5500),    */
+	0x26, 0x00, 0x37, /*      Logical Maximum (14080),    */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0x09, 0x31,       /*      Usage (Y),                  */
+	0x46, 0xA0, 0x0F, /*      Physical Maximum (4000),    */
+	0x26, 0x00, 0x28, /*      Logical Maximum (10240),    */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0xB4,             /*      Pop,                        */
+	0x09, 0x30,       /*      Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x03, /*      Logical Maximum (1023),     */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0xC0,             /*    End Collection,               */
+	0xC0              /*  End Collection                  */
+};
+
+/*
+ * Original MousePen i608X report descriptor.
+ *
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (7),
+ *    Usage (EEh),
+ *    Collection (Physical),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (-1),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Consumer),          ; Consumer (0Ch)
+ *  Usage (Consumer Control),       ; Consumer control
+ *                                  ; (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (3),
+ *    Logical Minimum (0),
+ *    Logical Maximum (767),
+ *    Usage Minimum (00h),
+ *    Usage Maximum (02FFh),
+ *    Report Size (16),
+ *    Report Count (1),
+ *    Input,
+ *  End Collection,
+ *  Usage Page (Desktop),           ; Generic desktop controls (01h)
+ *  Usage (00h),
+ *  Collection (Application),
+ *    Report ID (5),
+ *    Usage Page (FF00h),           ; FF00h, vendor-defined
+ *    Usage (01h),
+ *    Logical Minimum (-127),
+ *    Logical Maximum (127),
+ *    Report Size (8),
+ *    Report Count (7),
+ *    Feature (Variable),
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
+ *      Logical Minimum (0),
+ *      Logical Maximum (20480),
+ *      Physical Minimum (0),
+ *      Physical Maximum (20480),
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (15360),
+ *      Physical Minimum (0),
+ *      Physical Maximum (15360),
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Input (Variable),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (17),
+ *    Usage (EEh),
+ *    Collection (Physical),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (-1),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Pen),                    ; Pen (02h, application collection)
+ *  Collection (Application),
+ *    Report ID (16),
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (Tip Switch),         ; Tip switch (42h, momentary control)
+ *      Usage (Barrel Switch),      ; Barrel switch (44h, momentary control)
+ *      Usage (Invert),             ; Invert (3Ch, momentary control)
+ *      Usage (Eraser),             ; Eraser (45h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (4),
+ *      Input (Variable),
+ *      Report Count (3),
+ *      Input (Constant, Variable),
+ *      Usage (In Range),           ; In range (32h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Push,
+ *      Unit Exponent (13),
+ *      Unit (Inch^3),
+ *      Logical Minimum (0),
+ *      Logical Maximum (20480),
+ *      Physical Minimum (0),
+ *      Physical Maximum (20480),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Logical Maximum (15360),
+ *      Physical Maximum (15360),
+ *      Input (Variable),
+ *      Usage Page (Digitizer),     ; Digitizer (0Dh)
+ *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1023),
+ *      Physical Minimum (0),
+ *      Physical Maximum (1023),
+ *      Input (Variable),
+ *      Report Size (16),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (20),
+ *    Usage (EEh),
+ *    Collection (Physical),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (-1),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (19),
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (Tip Switch),         ; Tip switch (42h, momentary control)
+ *      Usage (Barrel Switch),      ; Barrel switch (44h, momentary control)
+ *      Usage (Invert),             ; Invert (3Ch, momentary control)
+ *      Usage (Eraser),             ; Eraser (45h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (4),
+ *      Input (Variable),
+ *      Report Count (3),
+ *      Input (Constant, Variable),
+ *      Usage (In Range),           ; In range (32h, momentary control)
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Push,
+ *      Unit Exponent (13),
+ *      Unit (Inch^3),
+ *      Logical Minimum (0),
+ *      Logical Maximum (20480),
+ *      Physical Minimum (0),
+ *      Physical Maximum (20480),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Logical Maximum (15360),
+ *      Physical Maximum (15360),
+ *      Input (Variable),
+ *      Usage Page (Digitizer),     ; Digitizer (0Dh)
+ *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1023),
+ *      Input (Variable),
+ *      Report Size (16),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (18),
+ *    Usage (EEh),
+ *    Collection (Physical),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (-1),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection
  */
+
+/* Original MousePen i608X report descriptor size */
+#define MOUSEPEN_I608X_RDESC_ORIG_SIZE	476
+
+/* Fixed MousePen i608X report descriptor */
+static __u8 mousepen_i608x_rdesc_fixed[] = {
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
+	0x26, 0x00, 0x50, /*      Logical Maximum (20480),    */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0x09, 0x31,       /*      Usage (Y),                  */
+	0x46, 0x70, 0x17, /*      Physical Maximum (6000),    */
+	0x26, 0x00, 0x3C, /*      Logical Maximum (15360),    */
+	0x81, 0x02,       /*      Input (Variable),           */
+	0xB4,             /*      Pop,                        */
+	0x09, 0x30,       /*      Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x03, /*      Logical Maximum (1023),     */
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
+/*
+ * Original EasyPen M610X report descriptor
+ *
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (7),
+ *    Usage (EEh),
+ *    Collection (Physical),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (127),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Consumer),          ; Consumer (0Ch)
+ *  Usage (Consumer Control),       ; Consumer control
+ *                                  ; (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (3),
+ *    Logical Minimum (0),
+ *    Logical Maximum (767),
+ *    Usage Minimum (00h),
+ *    Usage Maximum (02FFh),
+ *    Report Size (16),
+ *    Report Count (1),
+ *    Input,
+ *  End Collection,
+ *  Usage Page (Desktop),           ; Generic desktop controls (01h)
+ *  Usage (00h),
+ *  Collection (Application),
+ *    Report ID (5),
+ *    Usage Page (FF00h),           ; FF00h, vendor-defined
+ *    Usage (01h),
+ *    Logical Minimum (-127),
+ *    Logical Maximum (127),
+ *    Report Size (8),
+ *    Report Count (7),
+ *    Feature (Variable),
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
+ *      Logical Minimum (0),
+ *      Logical Maximum (20480),
+ *      Physical Minimum (0),
+ *      Physical Maximum (20480),
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (12800),
+ *      Physical Minimum (0),
+ *      Physical Maximum (12800),
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Input (Variable),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (17),
+ *    Usage (EEh),
+ *    Collection (Physical),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (127),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Pen),                    ; Pen (02h, application collection)
+ *  Collection (Application),
+ *    Report ID (16),
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (Tip Switch),         ; Tip switch (42h, momentary control)
+ *      Usage (Barrel Switch),      ; Barrel switch (44h, momentary control)
+ *      Usage (Invert),             ; Invert (3Ch, momentary control)
+ *      Usage (Eraser),             ; Eraser (45h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (4),
+ *      Input (Variable),
+ *      Report Count (3),
+ *      Input (Constant, Variable),
+ *      Usage (In Range),           ; In range (32h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Push,
+ *      Unit Exponent (13),
+ *      Unit (Inch^3),
+ *      Logical Minimum (0),
+ *      Logical Maximum (32767),
+ *      Physical Minimum (0),
+ *      Physical Maximum (32767),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Logical Maximum (25600),
+ *      Physical Maximum (25600),
+ *      Input (Variable),
+ *      Usage Page (Digitizer),     ; Digitizer (0Dh)
+ *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1023),
+ *      Physical Minimum (0),
+ *      Physical Maximum (1023),
+ *      Input (Variable),
+ *      Report Size (16),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (20),
+ *    Usage (EEh),
+ *    Collection (Physical),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (127),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (19),
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (Tip Switch),         ; Tip switch (42h, momentary control)
+ *      Usage (Barrel Switch),      ; Barrel switch (44h, momentary control)
+ *      Usage (Invert),             ; Invert (3Ch, momentary control)
+ *      Usage (Eraser),             ; Eraser (45h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (4),
+ *      Input (Variable),
+ *      Report Count (3),
+ *      Input (Constant, Variable),
+ *      Usage (In Range),           ; In range (32h, momentary control)
+ *      Report Count (1),
+ *      Input (Variable),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Push,
+ *      Unit Exponent (13),
+ *      Unit (Inch^3),
+ *      Logical Minimum (0),
+ *      Logical Maximum (32767),
+ *      Physical Minimum (0),
+ *      Physical Maximum (32767),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Logical Maximum (25600),
+ *      Physical Maximum (25600),
+ *      Input (Variable),
+ *      Usage Page (Digitizer),     ; Digitizer (0Dh)
+ *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1023),
+ *      Input (Variable),
+ *      Report Size (16),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Digitizer),              ; Digitizer (01h, application collection)
+ *  Collection (Application),
+ *    Report ID (18),
+ *    Usage (EEh),
+ *    Collection (Physical),
+ *      Usage (EEh),
+ *      Logical Minimum (0),
+ *      Logical Maximum (127),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection
+ */
+
+/* Original EasyPen M610X report descriptor size */
+#define EASYPEN_M610X_RDESC_ORIG_SIZE	476
+
+/* Fixed EasyPen M610X report descriptor */
+static __u8 easypen_m610x_rdesc_fixed[] = {
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
+	0x46, 0x10, 0x27,             /*      Physical Maximum (10000),   */
+	0x27, 0x00, 0xA0, 0x00, 0x00, /*      Logical Maximum (40960),    */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0x09, 0x31,                   /*      Usage (Y),                  */
+	0x46, 0x6A, 0x18,             /*      Physical Maximum (6250),    */
+	0x26, 0x00, 0x64,             /*      Logical Maximum (25600),    */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0xB4,                         /*      Pop,                        */
+	0x09, 0x30,                   /*      Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x03,             /*      Logical Maximum (1023),     */
+	0x81, 0x02,                   /*      Input (Variable),           */
+	0xC0,                         /*    End Collection,               */
+	0xC0,                         /*  End Collection,                 */
+	0x05, 0x0C,                   /*  Usage Page (Consumer),          */
+	0x09, 0x01,                   /*  Usage (Consumer Control),       */
+	0xA1, 0x01,                   /*  Collection (Application),       */
+	0x85, 0x12,                   /*    Report ID (18),               */
+	0x14,                         /*    Logical Minimum (0),          */
+	0x25, 0x01,                   /*    Logical Maximum (1),          */
+	0x75, 0x01,                   /*    Report Size (1),              */
+	0x95, 0x04,                   /*    Report Count (4),             */
+	0x0A, 0x1A, 0x02,             /*    Usage (AC Undo),              */
+	0x0A, 0x79, 0x02,             /*    Usage (AC Redo Or Repeat),    */
+	0x0A, 0x2D, 0x02,             /*    Usage (AC Zoom In),           */
+	0x0A, 0x2E, 0x02,             /*    Usage (AC Zoom Out),          */
+	0x81, 0x02,                   /*    Input (Variable),             */
+	0x95, 0x01,                   /*    Report Count (1),             */
+	0x75, 0x14,                   /*    Report Size (20),             */
+	0x81, 0x03,                   /*    Input (Constant, Variable),   */
+	0x75, 0x20,                   /*    Report Size (32),             */
+	0x81, 0x03,                   /*    Input (Constant, Variable),   */
+	0xC0                          /*  End Collection                  */
+};
+
 static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	if (*rsize >= 74 &&
-		rdesc[61] == 0x05 && rdesc[62] == 0x08 &&
-		rdesc[63] == 0x19 && rdesc[64] == 0x08 &&
-		rdesc[65] == 0x29 && rdesc[66] == 0x0f &&
-		rdesc[71] == 0x75 && rdesc[72] == 0x08 &&
-		rdesc[73] == 0x95 && rdesc[74] == 0x01) {
-		hid_info(hdev,
-			 "fixing up Kye/Genius Ergo Mouse report descriptor\n");
-		rdesc[62] = 0x09;
-		rdesc[64] = 0x04;
-		rdesc[66] = 0x07;
-		rdesc[72] = 0x01;
-		rdesc[74] = 0x08;
+	switch (hdev->product) {
+	case USB_DEVICE_ID_KYE_ERGO_525V:
+		/* the fixups that need to be done:
+		 *   - change led usage page to button for extra buttons
+		 *   - report size 8 count 1 must be size 1 count 8 for button
+		 *     bitfield
+		 *   - change the button usage range to 4-7 for the extra
+		 *     buttons
+		 */
+		if (*rsize >= 74 &&
+			rdesc[61] == 0x05 && rdesc[62] == 0x08 &&
+			rdesc[63] == 0x19 && rdesc[64] == 0x08 &&
+			rdesc[65] == 0x29 && rdesc[66] == 0x0f &&
+			rdesc[71] == 0x75 && rdesc[72] == 0x08 &&
+			rdesc[73] == 0x95 && rdesc[74] == 0x01) {
+			hid_info(hdev,
+				 "fixing up Kye/Genius Ergo Mouse "
+				 "report descriptor\n");
+			rdesc[62] = 0x09;
+			rdesc[64] = 0x04;
+			rdesc[66] = 0x07;
+			rdesc[72] = 0x01;
+			rdesc[74] = 0x08;
+		}
+		break;
+	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
+		if (*rsize == EASYPEN_I405X_RDESC_ORIG_SIZE) {
+			rdesc = easypen_i405x_rdesc_fixed;
+			*rsize = sizeof(easypen_i405x_rdesc_fixed);
+		}
+		break;
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
+		if (*rsize == MOUSEPEN_I608X_RDESC_ORIG_SIZE) {
+			rdesc = mousepen_i608x_rdesc_fixed;
+			*rsize = sizeof(mousepen_i608x_rdesc_fixed);
+		}
+		break;
+	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
+		if (*rsize == EASYPEN_M610X_RDESC_ORIG_SIZE) {
+			rdesc = easypen_m610x_rdesc_fixed;
+			*rsize = sizeof(easypen_m610x_rdesc_fixed);
+		}
+		break;
 	}
 	return rdesc;
 }
 
+/**
+ * Enable fully-functional tablet mode by setting a special feature report.
+ *
+ * @hdev:	HID device
+ *
+ * The specific report ID and data were discovered by sniffing the
+ * Windows driver traffic.
+ */
+static int kye_tablet_enable(struct hid_device *hdev)
+{
+	struct list_head *list;
+	struct list_head *head;
+	struct hid_report *report;
+	__s32 *value;
+
+	list = &hdev->report_enum[HID_FEATURE_REPORT].report_list;
+	list_for_each(head, list) {
+		report = list_entry(head, struct hid_report, list);
+		if (report->id == 5)
+			break;
+	}
+
+	if (head == list) {
+		hid_err(hdev, "tablet-enabling feature report not found\n");
+		return -ENODEV;
+	}
+
+	if (report->maxfield < 1 || report->field[0]->report_count < 7) {
+		hid_err(hdev, "invalid tablet-enabling feature report\n");
+		return -ENODEV;
+	}
+
+	value = report->field[0]->value;
+
+	value[0] = 0x12;
+	value[1] = 0x10;
+	value[2] = 0x11;
+	value[3] = 0x12;
+	value[4] = 0x00;
+	value[5] = 0x00;
+	value[6] = 0x00;
+	usbhid_submit_report(hdev, report, USB_DIR_OUT);
+
+	return 0;
+}
+
+static int kye_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		goto err;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		goto err;
+	}
+
+	switch (id->product) {
+	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
+	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
+		ret = kye_tablet_enable(hdev);
+		if (ret) {
+			hid_err(hdev, "tablet enabling failed\n");
+			goto enabling_err;
+		}
+		break;
+	}
+
+	return 0;
+enabling_err:
+	hid_hw_stop(hdev);
+err:
+	return ret;
+}
+
 static const struct hid_device_id kye_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_EASYPEN_I405X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_MOUSEPEN_I608X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE,
+				USB_DEVICE_ID_KYE_EASYPEN_M610X) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, kye_devices);
@@ -52,6 +1136,7 @@ MODULE_DEVICE_TABLE(hid, kye_devices);
 static struct hid_driver kye_driver = {
 	.name = "kye",
 	.id_table = kye_devices,
+	.probe = kye_probe,
 	.report_fixup = kye_report_fixup,
 };
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index ae7d283..3cfea61 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -95,6 +95,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_TOUCH, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X, HID_QUIRK_MULTI_INPUT },
 	{ 0, 0 }
 };
 
-- 
1.7.9

