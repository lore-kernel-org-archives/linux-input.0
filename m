From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH v2] HID: Add support for two Waltop tablets
Date: Thu, 19 Aug 2010 13:18:19 +0400
Message-ID: <1282209499-18509-1-git-send-email-spbnick@gmail.com>
References: <1281988875-7088-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50456 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab0HSJSk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Aug 2010 05:18:40 -0400
In-Reply-To: <1281988875-7088-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb <linux-usb@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nikolai Kondrashov <spbnick@gmail.com>

Add support for Waltop Slim Tablet 5.8 inch and Media Tablet 10.6 inch.

These (and other Waltop) tablets are usually sold by different companies
(such as Genius and Trust) and with different names, but with the same USB
vendor/product IDs.

Slim Tablet 5.8 inch is known to also be sold as Genius G-Pen F350 and Trust
Widescreen Mini Tablet (item no 16485).

Media Tablet 10.6 inch is known to also be sold as Genius G-Pen M609.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---

This new version fixes coding style issues and patch subject.

I now realized that I should've probably sent it to Dmitry and linux-input
instead, but since this patch depends on my previous patches to generic HID,
maybe it is better be sent to you. Correct me, please, if I'm wrong.

The patches required are:

"Allow resizing and replacing report descriptors"
[http://article.gmane.org/gmane.linux.usb.general/34506]

and

"Add Tablet Pick -> BTN_STYLUS2 mapping"
[http://article.gmane.org/gmane.linux.usb.general/34508]

 drivers/hid/Kconfig             |    6 +
 drivers/hid/Makefile            |    1 +
 drivers/hid/hid-core.c          |    2 +
 drivers/hid/hid-ids.h           |    4 +
 drivers/hid/hid-waltop.c        |  548 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/hid-quirks.c |    1 +
 6 files changed, 562 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-waltop.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 34402bb..4cae11e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -182,6 +182,12 @@ config HID_UCLOGIC
 	---help---
 	Support for UC-Logic tablets.
 
+config HID_WALTOP
+	tristate "Waltop"
+	depends on USB_HID
+	---help---
+	Support for Waltop tablets.
+
 config HID_GYRATION
 	tristate "Gyration"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 8c4a510..c46c7a1 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_HID_UCLOGIC)	+= hid-uclogic.o
 obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
 obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
 obj-$(CONFIG_HID_WACOM)		+= hid-wacom.o
+obj-$(CONFIG_HID_WALTOP)	+= hid-waltop.o
 
 obj-$(CONFIG_USB_HID)		+= usbhid/
 obj-$(CONFIG_USB_MOUSE)		+= usbhid/
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 7eb3b16..7bd5365 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1388,6 +1388,8 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b887e73..5be6293 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -519,6 +519,10 @@
 #define USB_VENDOR_ID_WACOM		0x056a
 #define USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH	0x81
 
+#define USB_VENDOR_ID_WALTOP				0x172f
+#define USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH	0x0032
+#define USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH	0x0501
+
 #define USB_VENDOR_ID_WISEGROUP		0x0925
 #define USB_DEVICE_ID_SMARTJOY_PLUS	0x0005
 #define USB_DEVICE_ID_1_PHIDGETSERVO_20	0x8101
diff --git a/drivers/hid/hid-waltop.c b/drivers/hid/hid-waltop.c
new file mode 100644
index 0000000..b25cc95
--- /dev/null
+++ b/drivers/hid/hid-waltop.c
@@ -0,0 +1,548 @@
+/*
+ *  HID driver for Waltop devices not fully compliant with HID standard
+ *
+ *  Copyright (c) 2010 Nikolai Kondrashov
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+/*
+ * Original Slim Tablet 5.8 inch report descriptor.
+ *
+ * All the reports except the report with ID 16 (the stylus) are unused,
+ * possibly because the tablet is not configured to, or because they were
+ * just copied from a more capable model. The purpose of features described
+ * for report ID 2 is unknown.
+ *
+ * The stylus buttons are described as three bit fields, whereas actually
+ * it's an "array", i.e. they're reported as button numbers (1, 2 and 3).
+ * The "eraser" field is not used. There is also a "push" without a "pop" in
+ * the stylus description.
+ *
+ *  Usage Page (Desktop),           ; Generic desktop controls (01h)
+ *  Usage (Mouse),                  ; Mouse (02h, application collection)
+ *  Collection (Application),
+ *    Report ID (1),
+ *    Usage (Pointer),              ; Pointer (01h, physical collection)
+ *    Collection (Physical),
+ *      Usage Page (Button),        ; Button (09h)
+ *      Usage Minimum (01h),
+ *      Usage Maximum (05h),
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (5),
+ *      Input (Variable),
+ *      Report Size (3),
+ *      Report Count (1),
+ *      Input (Constant, Variable),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Usage (Wheel),              ; Wheel (38h, dynamic value)
+ *      Logical Minimum (-127),
+ *      Logical Maximum (127),
+ *      Report Size (8),
+ *      Report Count (3),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),         ; Digitizer (0Dh)
+ *  Usage (Pen),                    ; Pen (02h, application collection)
+ *  Collection (Application),
+ *    Report ID (2),
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (00h),
+ *      Logical Minimum (0),
+ *      Logical Maximum (255),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable),
+ *      Usage (Azimuth),            ; Azimuth (3Fh, dynamic value)
+ *      Usage (Altitude),           ; Altitude (40h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (255),
+ *      Report Size (8),
+ *      Report Count (2),
+ *      Feature (Variable),
+ *    End Collection,
+ *    Report ID (5),
+ *    Usage Page (Digitizer),       ; Digitizer (0Dh)
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (00h),
+ *      Logical Minimum (0),
+ *      Logical Maximum (255),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable),
+ *    End Collection,
+ *    Report ID (10),
+ *    Usage Page (Digitizer),       ; Digitizer (0Dh)
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (00h),
+ *      Logical Minimum (0),
+ *      Logical Maximum (255),
+ *      Report Size (8),
+ *      Report Count (3),
+ *      Input (Variable),
+ *    End Collection,
+ *    Report ID (16),
+ *    Usage (Stylus),               ; Stylus (20h, logical collection)
+ *    Collection (Physical),
+ *      Usage (Tip Switch),         ; Tip switch (42h, momentary control)
+ *      Usage (Barrel Switch),      ; Barrel switch (44h, momentary control)
+ *      Usage (Invert),             ; Invert (3Ch, momentary control)
+ *      Usage (Eraser),             ; Eraser (45h, momentary control)
+ *      Usage (In Range),           ; In range (32h, momentary control)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (5),
+ *      Input (Variable),
+ *      Report Count (3),
+ *      Input (Constant, Variable),
+ *      Usage Page (Desktop),       ; Generic desktop controls (01h)
+ *      Usage (X),                  ; X (30h, dynamic value)
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Push,
+ *      Unit Exponent (13),
+ *      Unit (Inch^3),
+ *      Logical Minimum (0),
+ *      Logical Maximum (10000),
+ *      Physical Minimum (0),
+ *      Physical Maximum (10000),
+ *      Input (Variable),
+ *      Usage (Y),                  ; Y (31h, dynamic value)
+ *      Logical Maximum (6000),
+ *      Physical Maximum (6000),
+ *      Input (Variable),
+ *      Usage Page (Digitizer),     ; Digitizer (0Dh)
+ *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
+ *      Logical Minimum (0),
+ *      Logical Maximum (1023),
+ *      Physical Minimum (0),
+ *      Physical Maximum (1023),
+ *      Input (Variable),
+ *    End Collection,
+ *  End Collection
+ */
+
+/* Size of the original report descriptor of Slim Tablet 5.8 inch */
+#define SLIM_TABLET_5_8_INCH_RDESC_ORIG_SIZE	222
+
+/*
+ * Fixed Slim Tablet 5.8 inch descriptor.
+ *
+ * All the reports except the stylus report (ID 16) were removed as unused.
+ * The stylus buttons description was fixed.
+ */
+static __u8 slim_tablet_5_8_inch_rdesc_fixed[] = {
+	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
+	0x09, 0x02,         /*  Usage (Pen),                        */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x10,         /*      Report ID (16),                 */
+	0x09, 0x20,         /*      Usage (Stylus),                 */
+	0xA0,               /*      Collection (Physical),          */
+	0x09, 0x42,         /*          Usage (Tip Switch),         */
+	0x09, 0x44,         /*          Usage (Barrel Switch),      */
+	0x09, 0x46,         /*          Usage (Tablet Pick),        */
+	0x15, 0x01,         /*          Logical Minimum (1),        */
+	0x25, 0x03,         /*          Logical Maximum (3),        */
+	0x75, 0x04,         /*          Report Size (4),            */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x80,               /*          Input,                      */
+	0x09, 0x32,         /*          Usage (In Range),           */
+	0x14,               /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x75, 0x10,         /*          Report Size (16),           */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x14,               /*          Logical Minimum (0),        */
+	0xA4,               /*          Push,                       */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x65, 0x13,         /*          Unit (Inch),                */
+	0x55, 0xFD,         /*          Unit Exponent (-3),         */
+	0x34,               /*          Physical Minimum (0),       */
+	0x09, 0x30,         /*          Usage (X),                  */
+	0x46, 0x88, 0x13,   /*          Physical Maximum (5000),    */
+	0x26, 0x10, 0x27,   /*          Logical Maximum (10000),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x09, 0x31,         /*          Usage (Y),                  */
+	0x46, 0xB8, 0x0B,   /*          Physical Maximum (3000),    */
+	0x26, 0x70, 0x17,   /*          Logical Maximum (6000),     */
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
+ * Original Media Tablet 10.6 inch report descriptor.
+ *
+ * The tablet has the usual pen with two barrel buttons, plus four hardware
+ * selector buttons over the working area, switching the function of two
+ * identical wheels in the top corners. Each wheel has a button in the
+ * center. The tablet also has a "wide/standard" selector button (to the
+ * right of the wheel function buttons) switching the sensed width of the
+ * working area.
+ *
+ * The three wheel function buttons are (from left to right):
+ * Scroll   - the wheels act as scroll wheels, the center buttons do nothing.
+ * Zoom     - the wheels zoom in/out, the buttons supposedly reset to 100%.
+ * Volume   - the wheels control the sound volume, the buttons mute.
+ * Brush    - the wheels supposedly control brush selection in a graphics
+ *            editor, the buttons do nothing.
+ *
+ * There seems to exist a newer version of this model, but its
+ * vendor/product ID is unknown. This model has only three wheel function
+ * buttons (minus the brush button), but instead has separate buttons for
+ * selecting the "wide" and "standard" mode, possibly due to low usability of
+ * a single button switch.
+ *
+ * The mouse report (ID 1) only uses the wheel field for reporting the tablet
+ * wheels' scroll mode. The keyboard report (ID 13) is used to report the
+ * wheels' zoom and brush control functions as key presses. The report ID 12
+ * is used to report the wheels' volume control functions. The stylus report
+ * (ID 16) has the same problems as the Slim Tablet 5.8 inch report has.
+ *
+ * The rest of the reports are unused, at least in the default configuration.
+ * The purpose of the features is unknown.
+ *
+ *  Usage Page (Desktop),
+ *  Usage (Mouse),
+ *  Collection (Application),
+ *    Report ID (1),
+ *    Usage (Pointer),
+ *    Collection (Physical),
+ *      Usage Page (Button),
+ *      Usage Minimum (01h),
+ *      Usage Maximum (05h),
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (5),
+ *      Input (Variable),
+ *      Report Size (3),
+ *      Report Count (1),
+ *      Input (Constant, Variable),
+ *      Usage Page (Desktop),
+ *      Usage (X),
+ *      Usage (Y),
+ *      Usage (Wheel),
+ *      Logical Minimum (-127),
+ *      Logical Maximum (127),
+ *      Report Size (8),
+ *      Report Count (3),
+ *      Input (Variable, Relative),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Digitizer),
+ *  Usage (Pen),
+ *  Collection (Application),
+ *    Report ID (2),
+ *    Usage (Stylus),
+ *    Collection (Physical),
+ *      Usage (00h),
+ *      Logical Minimum (0),
+ *      Logical Maximum (255),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable),
+ *      Usage (Azimuth),
+ *      Usage (Altitude),
+ *      Logical Minimum (0),
+ *      Logical Maximum (255),
+ *      Report Size (8),
+ *      Report Count (2),
+ *      Feature (Variable),
+ *    End Collection,
+ *    Report ID (5),
+ *    Usage Page (Digitizer),
+ *    Usage (Stylus),
+ *    Collection (Physical),
+ *      Usage (00h),
+ *      Logical Minimum (0),
+ *      Logical Maximum (255),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable),
+ *    End Collection,
+ *    Report ID (10),
+ *    Usage Page (Digitizer),
+ *    Usage (Stylus),
+ *    Collection (Physical),
+ *      Usage (00h),
+ *      Logical Minimum (0),
+ *      Logical Maximum (255),
+ *      Report Size (8),
+ *      Report Count (7),
+ *      Input (Variable),
+ *    End Collection,
+ *    Report ID (16),
+ *    Usage (Stylus),
+ *    Collection (Physical),
+ *      Usage (Tip Switch),
+ *      Usage (Barrel Switch),
+ *      Usage (Invert),
+ *      Usage (Eraser),
+ *      Usage (In Range),
+ *      Logical Minimum (0),
+ *      Logical Maximum (1),
+ *      Report Size (1),
+ *      Report Count (5),
+ *      Input (Variable),
+ *      Report Count (3),
+ *      Input (Constant, Variable),
+ *      Usage Page (Desktop),
+ *      Usage (X),
+ *      Report Size (16),
+ *      Report Count (1),
+ *      Push,
+ *      Unit Exponent (13),
+ *      Unit (Inch^3),
+ *      Logical Minimum (0),
+ *      Logical Maximum (18000),
+ *      Physical Minimum (0),
+ *      Physical Maximum (18000),
+ *      Input (Variable),
+ *      Usage (Y),
+ *      Logical Maximum (11000),
+ *      Physical Maximum (11000),
+ *      Input (Variable),
+ *      Usage Page (Digitizer),
+ *      Usage (Tip Pressure),
+ *      Logical Minimum (0),
+ *      Logical Maximum (1023),
+ *      Physical Minimum (0),
+ *      Physical Maximum (1023),
+ *      Input (Variable),
+ *    End Collection,
+ *  End Collection,
+ *  Usage Page (Desktop),
+ *  Usage (Keyboard),
+ *  Collection (Application),
+ *    Report ID (13),
+ *    Usage Page (Keyboard),
+ *    Usage Minimum (KB Leftcontrol),
+ *    Usage Maximum (KB Right GUI),
+ *    Logical Minimum (0),
+ *    Logical Maximum (1),
+ *    Report Size (1),
+ *    Report Count (8),
+ *    Input (Variable),
+ *    Report Size (8),
+ *    Report Count (1),
+ *    Input (Constant),
+ *    Usage Page (Keyboard),
+ *    Usage Minimum (None),
+ *    Usage Maximum (KB Application),
+ *    Logical Minimum (0),
+ *    Logical Maximum (101),
+ *    Report Size (8),
+ *    Report Count (5),
+ *    Input,
+ *  End Collection,
+ *  Usage Page (Consumer),
+ *  Usage (Consumer Control),
+ *  Collection (Application),
+ *    Report ID (12),
+ *    Usage (Volume Inc),
+ *    Usage (Volume Dec),
+ *    Usage (Mute),
+ *    Logical Minimum (0),
+ *    Logical Maximum (1),
+ *    Report Size (1),
+ *    Report Count (3),
+ *    Input (Variable, Relative),
+ *    Report Size (5),
+ *    Report Count (1),
+ *    Input (Constant, Variable, Relative),
+ *  End Collection
+ */
+
+/* Size of the original report descriptor of Media Tablet 10.6 inch */
+#define MEDIA_TABLET_10_6_INCH_RDESC_ORIG_SIZE	300
+
+/*
+ * Fixed Media Tablet 10.6 inch descriptor.
+ *
+ * The descriptions of reports unused in the default configuration are
+ * removed. The stylus report (ID 16) is fixed similarly to Slim Tablet 5.8
+ * inch.  The unused mouse report (ID 1) fields are replaced with constant
+ * padding.
+ *
+ * The keyboard report (ID 13) is hacked to instead have an "array" field
+ * reporting consumer page controls, and all the unused bits are masked out
+ * with constant padding. The "brush" wheels' function is represented as "Scan
+ * Previous/Next Track" controls due to the lack of brush controls in the
+ * usage tables specification.
+ */
+static __u8 media_tablet_10_6_inch_rdesc_fixed[] = {
+	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
+	0x09, 0x02,         /*  Usage (Pen),                        */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x10,         /*      Report ID (16),                 */
+	0x09, 0x20,         /*      Usage (Stylus),                 */
+	0xA0,               /*      Collection (Physical),          */
+	0x09, 0x42,         /*          Usage (Tip Switch),         */
+	0x09, 0x44,         /*          Usage (Barrel Switch),      */
+	0x09, 0x46,         /*          Usage (Tablet Pick),        */
+	0x15, 0x01,         /*          Logical Minimum (1),        */
+	0x25, 0x03,         /*          Logical Maximum (3),        */
+	0x75, 0x04,         /*          Report Size (4),            */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x80,               /*          Input,                      */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x09, 0x32,         /*          Usage (In Range),           */
+	0x14,               /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x03,         /*          Report Count (3),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x75, 0x10,         /*          Report Size (16),           */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x14,               /*          Logical Minimum (0),        */
+	0xA4,               /*          Push,                       */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x65, 0x13,         /*          Unit (Inch),                */
+	0x55, 0xFD,         /*          Unit Exponent (-3),         */
+	0x34,               /*          Physical Minimum (0),       */
+	0x09, 0x30,         /*          Usage (X),                  */
+	0x46, 0x28, 0x23,   /*          Physical Maximum (9000),    */
+	0x26, 0x50, 0x46,   /*          Logical Maximum (18000),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x09, 0x31,         /*          Usage (Y),                  */
+	0x46, 0x7C, 0x15,   /*          Physical Maximum (5500),    */
+	0x26, 0xF8, 0x2A,   /*          Logical Maximum (11000),    */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xB4,               /*          Pop,                        */
+	0x09, 0x30,         /*          Usage (Tip Pressure),       */
+	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xC0,               /*      End Collection,                 */
+	0xC0,               /*  End Collection,                     */
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x02,         /*  Usage (Mouse),                      */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x01,         /*      Report ID (1),                  */
+	0x09, 0x01,         /*      Usage (Pointer),                */
+	0xA0,               /*      Collection (Physical),          */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x75, 0x18,         /*          Report Size (24),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x09, 0x38,         /*          Usage (Wheel),              */
+	0x15, 0xFF,         /*          Logical Minimum (-1),       */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x81, 0x06,         /*          Input (Variable, Relative), */
+	0x75, 0x18,         /*          Report Size (24),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0xC0,               /*      End Collection,                 */
+	0xC0,               /*  End Collection,                     */
+	0x05, 0x0C,         /*  Usage Page (Consumer),              */
+	0x09, 0x01,         /*  Usage (Consumer Control),           */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x0D,         /*      Report ID (13),                 */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0x75, 0x10,         /*      Report Size (16),               */
+	0x81, 0x03,         /*      Input (Constant, Variable),     */
+	0x0A, 0x2F, 0x02,   /*      Usage (AC Zoom),                */
+	0x0A, 0x2E, 0x02,   /*      Usage (AC Zoom Out),            */
+	0x0A, 0x2D, 0x02,   /*      Usage (AC Zoom In),             */
+	0x09, 0xB6,         /*      Usage (Scan Previous Track),    */
+	0x09, 0xB5,         /*      Usage (Scan Next Track),        */
+	0x15, 0x2C,         /*      Logical Minimum (44),           */
+	0x25, 0x30,         /*      Logical Maximum (48),           */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x80,               /*      Input,                          */
+	0x75, 0x20,         /*      Report Size (32),               */
+	0x81, 0x03,         /*      Input (Constant, Variable),     */
+	0xC0,               /*  End Collection,                     */
+	0x09, 0x01,         /*  Usage (Consumer Control),           */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x0C,         /*      Report ID (12),                 */
+	0x75, 0x01,         /*      Report Size (1),                */
+	0x09, 0xE9,         /*      Usage (Volume Inc),             */
+	0x09, 0xEA,         /*      Usage (Volume Dec),             */
+	0x09, 0xE2,         /*      Usage (Mute),                   */
+	0x14,               /*      Logical Minimum (0),            */
+	0x25, 0x01,         /*      Logical Maximum (1),            */
+	0x95, 0x03,         /*      Report Count (3),               */
+	0x81, 0x06,         /*      Input (Variable, Relative),     */
+	0x95, 0x35,         /*      Report Count (53),              */
+	0x81, 0x03,         /*      Input (Constant, Variable),     */
+	0xC0                /*  End Collection                      */
+};
+
+static __u8 *waltop_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	switch (hdev->product) {
+	case USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH:
+		if (*rsize == SLIM_TABLET_5_8_INCH_RDESC_ORIG_SIZE) {
+			rdesc = slim_tablet_5_8_inch_rdesc_fixed;
+			*rsize = sizeof(slim_tablet_5_8_inch_rdesc_fixed);
+		}
+		break;
+	case USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH:
+		if (*rsize == MEDIA_TABLET_10_6_INCH_RDESC_ORIG_SIZE) {
+			rdesc = media_tablet_10_6_inch_rdesc_fixed;
+			*rsize = sizeof(media_tablet_10_6_inch_rdesc_fixed);
+		}
+		break;
+	}
+	return rdesc;
+}
+
+static const struct hid_device_id waltop_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
+				USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
+				USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, waltop_devices);
+
+static struct hid_driver waltop_driver = {
+	.name = "waltop",
+	.id_table = waltop_devices,
+	.report_fixup = waltop_report_fixup,
+};
+
+static int __init waltop_init(void)
+{
+	return hid_register_driver(&waltop_driver);
+}
+
+static void __exit waltop_exit(void)
+{
+	hid_unregister_driver(&waltop_driver);
+}
+
+module_init(waltop_init);
+module_exit(waltop_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 162aa4b..1b45fb7 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -70,6 +70,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP8060U, HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 
-- 
1.7.1

