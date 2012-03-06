From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 2/3] HID: waltop: Replace original rdescs with links
Date: Tue,  6 Mar 2012 09:54:23 +0200
Message-ID: <1331020464-3962-2-git-send-email-spbnick@gmail.com>
References: <1331020464-3962-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50700 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757910Ab2CFHyp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Mar 2012 02:54:45 -0500
Received: by wgbdr13 with SMTP id dr13so4255856wgb.1
        for <linux-input@vger.kernel.org>; Mon, 05 Mar 2012 23:54:44 -0800 (PST)
In-Reply-To: <1331020464-3962-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Nikolai Kondrashov <spbnick@gmail.com>

Replace original report descriptor dumps in the comments with links to tablet
descriptions in a wiki, to make code clearer.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-waltop.c |  803 +---------------------------------------------
 1 files changed, 15 insertions(+), 788 deletions(-)

diff --git a/drivers/hid/hid-waltop.c b/drivers/hid/hid-waltop.c
index 0ec1696..c1dce51 100644
--- a/drivers/hid/hid-waltop.c
+++ b/drivers/hid/hid-waltop.c
@@ -43,139 +43,14 @@
  */
 
 /*
- * Original Slim Tablet 5.8 inch report descriptor.
- *
- * All the reports except the report with ID 16 (the stylus) are unused,
- * possibly because the tablet is not configured to, or because they were
- * just copied from a more capable model. The full purpose of features
- * described for report ID 2 is unknown.
- *
- * The stylus buttons are described as three bit fields, whereas actually
- * it's an "array", i.e. they're reported as button numbers (1, 2 and 3).
- * The "eraser" field is not used. There is also a "push" without a "pop" in
- * the stylus description.
- *
- *  Usage Page (Desktop),           ; Generic desktop controls (01h)
- *  Usage (Mouse),                  ; Mouse (02h, application collection)
- *  Collection (Application),
- *    Report ID (1),
- *    Usage (Pointer),              ; Pointer (01h, physical collection)
- *    Collection (Physical),
- *      Usage Page (Button),        ; Button (09h)
- *      Usage Minimum (01h),
- *      Usage Maximum (05h),
- *      Logical Minimum (0),
- *      Logical Maximum (1),
- *      Report Size (1),
- *      Report Count (5),
- *      Input (Variable),
- *      Report Size (3),
- *      Report Count (1),
- *      Input (Constant, Variable),
- *      Usage Page (Desktop),       ; Generic desktop controls (01h)
- *      Usage (X),                  ; X (30h, dynamic value)
- *      Usage (Y),                  ; Y (31h, dynamic value)
- *      Usage (Wheel),              ; Wheel (38h, dynamic value)
- *      Logical Minimum (-127),
- *      Logical Maximum (127),
- *      Report Size (8),
- *      Report Count (3),
- *      Input (Variable, Relative),
- *    End Collection,
- *  End Collection,
- *  Usage Page (Digitizer),         ; Digitizer (0Dh)
- *  Usage (Pen),                    ; Pen (02h, application collection)
- *  Collection (Application),
- *    Report ID (2),
- *    Usage (Stylus),               ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *      Usage (Azimuth),            ; Azimuth (3Fh, dynamic value)
- *      Usage (Altitude),           ; Altitude (40h, dynamic value)
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (2),
- *      Feature (Variable),
- *    End Collection,
- *    Report ID (5),
- *    Usage Page (Digitizer),       ; Digitizer (0Dh)
- *    Usage (Stylus),               ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *    End Collection,
- *    Report ID (10),
- *    Usage Page (Digitizer),       ; Digitizer (0Dh)
- *    Usage (Stylus),               ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (3),
- *      Input (Variable),
- *    End Collection,
- *    Report ID (16),
- *    Usage (Stylus),               ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (Tip Switch),         ; Tip switch (42h, momentary control)
- *      Usage (Barrel Switch),      ; Barrel switch (44h, momentary control)
- *      Usage (Invert),             ; Invert (3Ch, momentary control)
- *      Usage (Eraser),             ; Eraser (45h, momentary control)
- *      Usage (In Range),           ; In range (32h, momentary control)
- *      Logical Minimum (0),
- *      Logical Maximum (1),
- *      Report Size (1),
- *      Report Count (5),
- *      Input (Variable),
- *      Report Count (3),
- *      Input (Constant, Variable),
- *      Usage Page (Desktop),       ; Generic desktop controls (01h)
- *      Usage (X),                  ; X (30h, dynamic value)
- *      Report Size (16),
- *      Report Count (1),
- *      Push,
- *      Unit Exponent (13),
- *      Unit (Inch^3),
- *      Logical Minimum (0),
- *      Logical Maximum (10000),
- *      Physical Minimum (0),
- *      Physical Maximum (10000),
- *      Input (Variable),
- *      Usage (Y),                  ; Y (31h, dynamic value)
- *      Logical Maximum (6000),
- *      Physical Maximum (6000),
- *      Input (Variable),
- *      Usage Page (Digitizer),     ; Digitizer (0Dh)
- *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
- *      Logical Minimum (0),
- *      Logical Maximum (1023),
- *      Physical Minimum (0),
- *      Physical Maximum (1023),
- *      Input (Variable),
- *    End Collection,
- *  End Collection
+ * See Slim Tablet 5.8 inch description, device and HID report descriptors at
+ * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Slim_Tablet_5.8%22
  */
 
 /* Size of the original report descriptor of Slim Tablet 5.8 inch */
 #define SLIM_TABLET_5_8_INCH_RDESC_ORIG_SIZE	222
 
-/*
- * Fixed Slim Tablet 5.8 inch descriptor.
- *
- * All the reports except the stylus report (ID 16) were removed as unused.
- * The stylus buttons description was fixed.
- */
+/* Fixed Slim Tablet 5.8 inch descriptor */
 static __u8 slim_tablet_5_8_inch_rdesc_fixed[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
 	0x09, 0x02,         /*  Usage (Pen),                        */
@@ -224,158 +99,14 @@ static __u8 slim_tablet_5_8_inch_rdesc_fixed[] = {
 };
 
 /*
- * Original Slim Tablet 12.1 inch report descriptor.
- *
- * The descriptor is similar to the Slim Tablet 5.8 inch descriptor with the
- * addition of a keyboard report, seemingly unused. It may have get here
- * from a Media Tablet - probably an unimplemented feature.
- *
- *  Usage Page (Desktop),             ; Generic desktop controls (01h)
- *  Usage (Mouse),                    ; Mouse (02h, application collection)
- *  Collection (Application),
- *    Report ID (1),
- *    Usage (Pointer),                ; Pointer (01h, physical collection)
- *    Collection (Physical),
- *      Usage Page (Button),          ; Button (09h)
- *      Usage Minimum (01h),
- *      Usage Maximum (05h),
- *      Logical Minimum (0),
- *      Logical Maximum (1),
- *      Report Size (1),
- *      Report Count (5),
- *      Input (Variable),
- *      Report Size (3),
- *      Report Count (1),
- *      Input (Constant, Variable),
- *      Usage Page (Desktop),         ; Generic desktop controls (01h)
- *      Usage (X),                    ; X (30h, dynamic value)
- *      Usage (Y),                    ; Y (31h, dynamic value)
- *      Usage (Wheel),                ; Wheel (38h, dynamic value)
- *      Logical Minimum (-127),
- *      Logical Maximum (127),
- *      Report Size (8),
- *      Report Count (3),
- *      Input (Variable, Relative),
- *    End Collection,
- *  End Collection,
- *  Usage Page (Digitizer),           ; Digitizer (0Dh)
- *  Usage (Pen),                      ; Pen (02h, application collection)
- *  Collection (Application),
- *    Report ID (2),
- *    Usage (Stylus),                 ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *      Usage (Azimuth),              ; Azimuth (3Fh, dynamic value)
- *      Usage (Altitude),             ; Altitude (40h, dynamic value)
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (2),
- *      Feature (Variable),
- *    End Collection,
- *    Report ID (5),
- *    Usage Page (Digitizer),         ; Digitizer (0Dh)
- *    Usage (Stylus),                 ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *    End Collection,
- *    Report ID (10),
- *    Usage Page (Digitizer),         ; Digitizer (0Dh)
- *    Usage (Stylus),                 ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (3),
- *      Input (Variable),
- *    End Collection,
- *    Report ID (16),
- *    Usage (Stylus),                 ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (Tip Switch),           ; Tip switch (42h, momentary control)
- *      Usage (Barrel Switch),        ; Barrel switch (44h, momentary control)
- *      Usage (Invert),               ; Invert (3Ch, momentary control)
- *      Usage (Eraser),               ; Eraser (45h, momentary control)
- *      Usage (In Range),             ; In range (32h, momentary control)
- *      Logical Minimum (0),
- *      Logical Maximum (1),
- *      Report Size (1),
- *      Report Count (5),
- *      Input (Variable),
- *      Report Count (3),
- *      Input (Constant, Variable),
- *      Usage Page (Desktop),         ; Generic desktop controls (01h)
- *      Usage (X),                    ; X (30h, dynamic value)
- *      Report Size (16),
- *      Report Count (1),
- *      Push,
- *      Unit Exponent (13),
- *      Unit (Inch^3),
- *      Logical Minimum (0),
- *      Logical Maximum (20000),
- *      Physical Minimum (0),
- *      Physical Maximum (20000),
- *      Input (Variable),
- *      Usage (Y),                    ; Y (31h, dynamic value)
- *      Logical Maximum (12500),
- *      Physical Maximum (12500),
- *      Input (Variable),
- *      Usage Page (Digitizer),       ; Digitizer (0Dh)
- *      Usage (Tip Pressure),         ; Tip pressure (30h, dynamic value)
- *      Logical Minimum (0),
- *      Logical Maximum (1023),
- *      Physical Minimum (0),
- *      Physical Maximum (1023),
- *      Input (Variable),
- *    End Collection,
- *  End Collection,
- *  Usage Page (Desktop),             ; Generic desktop controls (01h)
- *  Usage (Keyboard),                 ; Keyboard (06h, application collection)
- *  Collection (Application),
- *    Report ID (13),
- *    Usage Page (Keyboard),          ; Keyboard/keypad (07h)
- *    Usage Minimum (KB Leftcontrol), ; Keyboard left control
- *                                    ; (E0h, dynamic value)
- *    Usage Maximum (KB Right GUI),   ; Keyboard right GUI (E7h, dynamic value)
- *    Logical Minimum (0),
- *    Logical Maximum (1),
- *    Report Size (1),
- *    Report Count (8),
- *    Input (Variable),
- *    Report Size (8),
- *    Report Count (1),
- *    Input (Constant),
- *    Usage Page (Keyboard),          ; Keyboard/keypad (07h)
- *    Usage Minimum (None),           ; No event (00h, selector)
- *    Usage Maximum (KB Application), ; Keyboard Application (65h, selector)
- *    Logical Minimum (0),
- *    Logical Maximum (101),
- *    Report Size (8),
- *    Report Count (5),
- *    Input,
- *  End Collection
+ * See Slim Tablet 12.1 inch description, device and HID report descriptors at
+ * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Slim_Tablet_12.1%22
  */
 
 /* Size of the original report descriptor of Slim Tablet 12.1 inch */
 #define SLIM_TABLET_12_1_INCH_RDESC_ORIG_SIZE	269
 
-/*
- * Fixed Slim Tablet 12.1 inch descriptor.
- *
- * All the reports except the stylus report (ID 16) were removed as unused.
- * The stylus buttons description was fixed.
- */
+/* Fixed Slim Tablet 12.1 inch descriptor */
 static __u8 slim_tablet_12_1_inch_rdesc_fixed[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
 	0x09, 0x02,         /*  Usage (Pen),                        */
@@ -424,142 +155,14 @@ static __u8 slim_tablet_12_1_inch_rdesc_fixed[] = {
 };
 
 /*
- * Original Q Pad report descriptor.
- *
- * The descriptor is similar to the Slim Tablet 5.8 inch descriptor with the
- * addition of consumer AC Pan field to the report ID 1, which seems to be
- * unused in the default mode. However, this tablet has resolution of 2048 LPI.
- *
- *  Usage Page (Desktop),           ; Generic desktop controls (01h)
- *  Usage (Mouse),                  ; Mouse (02h, application collection)
- *  Collection (Application),
- *    Report ID (1),
- *    Usage (Pointer),              ; Pointer (01h, physical collection)
- *    Collection (Physical),
- *      Usage Page (Button),        ; Button (09h)
- *      Usage Minimum (01h),
- *      Usage Maximum (05h),
- *      Logical Minimum (0),
- *      Logical Maximum (1),
- *      Report Size (1),
- *      Report Count (5),
- *      Input (Variable),
- *      Report Size (3),
- *      Report Count (1),
- *      Input (Constant, Variable),
- *      Usage Page (Desktop),       ; Generic desktop controls (01h)
- *      Usage (X),                  ; X (30h, dynamic value)
- *      Usage (Y),                  ; Y (31h, dynamic value)
- *      Usage (Wheel),              ; Wheel (38h, dynamic value)
- *      Logical Minimum (-127),
- *      Logical Maximum (127),
- *      Report Size (8),
- *      Report Count (3),
- *      Input (Variable, Relative),
- *      Usage Page (Consumer),      ; Consumer (0Ch)
- *      Logical Minimum (-127),
- *      Logical Maximum (127),
- *      Report Size (8),
- *      Report Count (1),
- *      Usage (AC Pan),             ; AC pan (0238h, linear control)
- *      Input (Variable, Relative),
- *    End Collection,
- *  End Collection,
- *  Usage Page (Digitizer),         ; Digitizer (0Dh)
- *  Usage (Pen),                    ; Pen (02h, application collection)
- *  Collection (Application),
- *    Report ID (2),
- *    Usage (Stylus),               ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *      Usage (Azimuth),            ; Azimuth (3Fh, dynamic value)
- *      Usage (Altitude),           ; Altitude (40h, dynamic value)
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (2),
- *      Feature (Variable),
- *    End Collection,
- *    Report ID (5),
- *    Usage Page (Digitizer),       ; Digitizer (0Dh)
- *    Usage (Stylus),               ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *    End Collection,
- *    Report ID (10),
- *    Usage Page (Digitizer),       ; Digitizer (0Dh)
- *    Usage (Stylus),               ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *    End Collection,
- *    Report ID (16),
- *    Usage (Stylus),               ; Stylus (20h, logical collection)
- *    Collection (Physical),
- *      Usage (Tip Switch),         ; Tip switch (42h, momentary control)
- *      Usage (Barrel Switch),      ; Barrel switch (44h, momentary control)
- *      Usage (Invert),             ; Invert (3Ch, momentary control)
- *      Usage (Eraser),             ; Eraser (45h, momentary control)
- *      Usage (In Range),           ; In range (32h, momentary control)
- *      Logical Minimum (0),
- *      Logical Maximum (1),
- *      Report Size (1),
- *      Report Count (5),
- *      Input (Variable),
- *      Report Count (3),
- *      Input (Constant, Variable),
- *      Usage Page (Desktop),       ; Generic desktop controls (01h)
- *      Usage (X),                  ; X (30h, dynamic value)
- *      Report Size (16),
- *      Report Count (1),
- *      Push,
- *      Unit Exponent (13),
- *      Unit (Inch^3),
- *      Logical Minimum (0),
- *      Logical Maximum (12288),
- *      Physical Minimum (0),
- *      Physical Maximum (12288),
- *      Input (Variable),
- *      Usage (Y),                  ; Y (31h, dynamic value)
- *      Logical Minimum (0),
- *      Logical Maximum (9216),
- *      Physical Minimum (0),
- *      Physical Maximum (9216),
- *      Input (Variable),
- *      Usage Page (Digitizer),     ; Digitizer (0Dh)
- *      Usage (Tip Pressure),       ; Tip pressure (30h, dynamic value)
- *      Logical Minimum (0),
- *      Logical Maximum (1023),
- *      Physical Minimum (0),
- *      Physical Maximum (1023),
- *      Input (Variable),
- *    End Collection,
- *  End Collection
+ * See Q Pad description, device and HID report descriptors at
+ * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Q_Pad
  */
 
 /* Size of the original report descriptor of Q Pad */
 #define Q_PAD_RDESC_ORIG_SIZE	241
 
-/*
- * Fixed Q Pad descriptor.
- *
- * All the reports except the stylus report (ID 16) were removed as unused.
- * The stylus buttons description was fixed.
- */
+/* Fixed Q Pad descriptor */
 static __u8 q_pad_rdesc_fixed[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
 	0x09, 0x02,         /*  Usage (Pen),                        */
@@ -608,217 +211,14 @@ static __u8 q_pad_rdesc_fixed[] = {
 };
 
 /*
- * Original Media Tablet 10.6 inch report descriptor.
- *
- * There are at least two versions of this model in the wild. They are
- * represented by Genius G-Pen M609 (older version) and Genius G-Pen M609X
- * (newer version).
- *
- * Both versions have the usual pen with two barrel buttons and two
- * identical wheels with center buttons in the top corners of the tablet
- * base. They also have buttons on the top, between the wheels, for
- * selecting the wheels' functions and wide/standard mode. In the wide mode
- * the whole working surface is sensed, in the standard mode a narrower area
- * is sensed, but the logical report extents remain the same. These modes
- * correspond roughly to 16:9 and 4:3 aspect ratios respectively.
- *
- * The older version has three wheel function buttons ("scroll", "zoom" and
- * "volume") and two separate buttons for wide and standard mode. The newer
- * version has four wheel function buttons (plus "brush") and only one
- * button is used for selecting wide/standard mode. So, the total number of
- * buttons remains the same, but one of the mode buttons is repurposed as a
- * wheels' function button in the newer version.
- *
- * The wheel functions are:
- * scroll   - the wheels act as scroll wheels, the center buttons switch
- *            between vertical and horizontal scrolling;
- * zoom     - the wheels zoom in/out, the buttons supposedly reset to 100%;
- * volume   - the wheels control the sound volume, the buttons mute;
- * brush    - the wheels are supposed to control brush width in a graphics
- *            editor, the buttons do nothing.
- *
- * Below is the newer version's report descriptor. It may very well be that
- * the older version's descriptor is different and thus it won't be
- * supported.
- *
- * The mouse report (ID 1) only uses the wheel field for reporting the tablet
- * wheels' scroll mode. The keyboard report (ID 13) is used to report the
- * wheels' zoom and brush control functions as key presses. The report ID 12
- * is used to report the wheels' volume control functions. The stylus report
- * (ID 16) has the same problems as the Slim Tablet 5.8 inch report has.
- *
- * The rest of the reports are unused, at least in the default configuration.
- * The purpose of the features is unknown.
- *
- *  Usage Page (Desktop),
- *  Usage (Mouse),
- *  Collection (Application),
- *    Report ID (1),
- *    Usage (Pointer),
- *    Collection (Physical),
- *      Usage Page (Button),
- *      Usage Minimum (01h),
- *      Usage Maximum (05h),
- *      Logical Minimum (0),
- *      Logical Maximum (1),
- *      Report Size (1),
- *      Report Count (5),
- *      Input (Variable),
- *      Report Size (3),
- *      Report Count (1),
- *      Input (Constant, Variable),
- *      Usage Page (Desktop),
- *      Usage (X),
- *      Usage (Y),
- *      Usage (Wheel),
- *      Logical Minimum (-127),
- *      Logical Maximum (127),
- *      Report Size (8),
- *      Report Count (3),
- *      Input (Variable, Relative),
- *    End Collection,
- *  End Collection,
- *  Usage Page (Digitizer),
- *  Usage (Pen),
- *  Collection (Application),
- *    Report ID (2),
- *    Usage (Stylus),
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *      Usage (Azimuth),
- *      Usage (Altitude),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (2),
- *      Feature (Variable),
- *    End Collection,
- *    Report ID (5),
- *    Usage Page (Digitizer),
- *    Usage (Stylus),
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *    End Collection,
- *    Report ID (10),
- *    Usage Page (Digitizer),
- *    Usage (Stylus),
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *    End Collection,
- *    Report ID (16),
- *    Usage (Stylus),
- *    Collection (Physical),
- *      Usage (Tip Switch),
- *      Usage (Barrel Switch),
- *      Usage (Invert),
- *      Usage (Eraser),
- *      Usage (In Range),
- *      Logical Minimum (0),
- *      Logical Maximum (1),
- *      Report Size (1),
- *      Report Count (5),
- *      Input (Variable),
- *      Report Count (3),
- *      Input (Constant, Variable),
- *      Usage Page (Desktop),
- *      Usage (X),
- *      Report Size (16),
- *      Report Count (1),
- *      Push,
- *      Unit Exponent (13),
- *      Unit (Inch^3),
- *      Logical Minimum (0),
- *      Logical Maximum (18000),
- *      Physical Minimum (0),
- *      Physical Maximum (18000),
- *      Input (Variable),
- *      Usage (Y),
- *      Logical Maximum (11000),
- *      Physical Maximum (11000),
- *      Input (Variable),
- *      Usage Page (Digitizer),
- *      Usage (Tip Pressure),
- *      Logical Minimum (0),
- *      Logical Maximum (1023),
- *      Physical Minimum (0),
- *      Physical Maximum (1023),
- *      Input (Variable),
- *    End Collection,
- *  End Collection,
- *  Usage Page (Desktop),
- *  Usage (Keyboard),
- *  Collection (Application),
- *    Report ID (13),
- *    Usage Page (Keyboard),
- *    Usage Minimum (KB Leftcontrol),
- *    Usage Maximum (KB Right GUI),
- *    Logical Minimum (0),
- *    Logical Maximum (1),
- *    Report Size (1),
- *    Report Count (8),
- *    Input (Variable),
- *    Report Size (8),
- *    Report Count (1),
- *    Input (Constant),
- *    Usage Page (Keyboard),
- *    Usage Minimum (None),
- *    Usage Maximum (KB Application),
- *    Logical Minimum (0),
- *    Logical Maximum (101),
- *    Report Size (8),
- *    Report Count (5),
- *    Input,
- *  End Collection,
- *  Usage Page (Consumer),
- *  Usage (Consumer Control),
- *  Collection (Application),
- *    Report ID (12),
- *    Usage (Volume Inc),
- *    Usage (Volume Dec),
- *    Usage (Mute),
- *    Logical Minimum (0),
- *    Logical Maximum (1),
- *    Report Size (1),
- *    Report Count (3),
- *    Input (Variable, Relative),
- *    Report Size (5),
- *    Report Count (1),
- *    Input (Constant, Variable, Relative),
- *  End Collection
+ * See Media Tablet 10.6 inch description, device and HID report descriptors at
+ * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Media_Tablet_10.6%22
  */
 
 /* Size of the original report descriptor of Media Tablet 10.6 inch */
 #define MEDIA_TABLET_10_6_INCH_RDESC_ORIG_SIZE	300
 
-/*
- * Fixed Media Tablet 10.6 inch descriptor.
- *
- * The descriptions of reports unused in the default configuration are
- * removed. The stylus report (ID 16) is fixed similarly to Slim Tablet 5.8
- * inch.  The unused mouse report (ID 1) fields are replaced with constant
- * padding.
- *
- * The keyboard report (ID 13) is hacked to instead have an "array" field
- * reporting consumer page controls, and all the unused bits are masked out
- * with constant padding. The "brush" wheels' function is represented as "Scan
- * Previous/Next Track" controls due to the lack of brush controls in the
- * usage tables specification.
- */
+/* Fixed Media Tablet 10.6 inch descriptor */
 static __u8 media_tablet_10_6_inch_rdesc_fixed[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
 	0x09, 0x02,         /*  Usage (Pen),                        */
@@ -929,187 +329,14 @@ static __u8 media_tablet_10_6_inch_rdesc_fixed[] = {
 };
 
 /*
- * Original Media Tablet 14.1 inch report descriptor.
- *
- * There are at least two versions of this model in the wild. They are
- * represented by Genius G-Pen M712 (older version) and Genius G-Pen M712X
- * (newer version). The hardware difference between these versions is the same
- * as between older and newer versions of Media Tablet 10.6 inch. The report
- * descriptors are identical for both versions.
- *
- * The function, behavior and report descriptor of this tablet is similar to
- * that of Media Tablet 10.6 inch. However, there is one more field (with
- * Consumer AC Pan usage) in the mouse description. Then the tablet X and Y
- * logical extents both get scaled to 0..16383 range (a hardware limit?),
- * which kind of defeats the advertised 4000 LPI resolution, considering the
- * physical extents of 12x7.25 inches. Plus, reports 5, 10 and 255 are used
- * sometimes (while moving the pen) with unknown purpose. Also, the key codes
- * generated for zoom in/out are different.
- *
- *  Usage Page (Desktop),
- *  Usage (Mouse),
- *  Collection (Application),
- *    Report ID (1),
- *    Usage (Pointer),
- *    Collection (Physical),
- *      Usage Page (Button),
- *      Usage Minimum (01h),
- *      Usage Maximum (05h),
- *      Logical Minimum (0),
- *      Logical Maximum (1),
- *      Report Size (1),
- *      Report Count (5),
- *      Input (Variable),
- *      Report Size (3),
- *      Report Count (1),
- *      Input (Constant, Variable),
- *      Usage Page (Desktop),
- *      Usage (X),
- *      Usage (Y),
- *      Usage (Wheel),
- *      Logical Minimum (-127),
- *      Logical Maximum (127),
- *      Report Size (8),
- *      Report Count (3),
- *      Input (Variable, Relative),
- *      Usage Page (Consumer),
- *      Logical Minimum (-127),
- *      Logical Maximum (127),
- *      Report Size (8),
- *      Report Count (1),
- *      Usage (AC Pan),
- *      Input (Variable, Relative),
- *    End Collection,
- *  End Collection,
- *  Usage Page (Digitizer),
- *  Usage (Pen),
- *  Collection (Application),
- *    Report ID (2),
- *    Usage (Stylus),
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *      Usage (Azimuth),
- *      Usage (Altitude),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (2),
- *      Feature (Variable),
- *    End Collection,
- *    Report ID (5),
- *    Usage Page (Digitizer),
- *    Usage (Stylus),
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *    End Collection,
- *    Report ID (10),
- *    Usage Page (Digitizer),
- *    Usage (Stylus),
- *    Collection (Physical),
- *      Usage (00h),
- *      Logical Minimum (0),
- *      Logical Maximum (255),
- *      Report Size (8),
- *      Report Count (7),
- *      Input (Variable),
- *    End Collection,
- *    Report ID (16),
- *    Usage (Stylus),
- *    Collection (Physical),
- *      Usage (Tip Switch),
- *      Usage (Barrel Switch),
- *      Usage (Invert),
- *      Usage (Eraser),
- *      Usage (In Range),
- *      Logical Minimum (0),
- *      Logical Maximum (1),
- *      Report Size (1),
- *      Report Count (5),
- *      Input (Variable),
- *      Report Count (3),
- *      Input (Constant, Variable),
- *      Usage Page (Desktop),
- *      Usage (X),
- *      Report Size (16),
- *      Report Count (1),
- *      Push,
- *      Unit Exponent (13),
- *      Unit (Inch^3),
- *      Logical Minimum (0),
- *      Logical Maximum (16383),
- *      Physical Minimum (0),
- *      Physical Maximum (16383),
- *      Input (Variable),
- *      Usage (Y),
- *      Input (Variable),
- *      Usage Page (Digitizer),
- *      Usage (Tip Pressure),
- *      Logical Minimum (0),
- *      Logical Maximum (1023),
- *      Physical Minimum (0),
- *      Physical Maximum (1023),
- *      Input (Variable),
- *    End Collection,
- *  End Collection,
- *  Usage Page (Desktop),
- *  Usage (Keyboard),
- *  Collection (Application),
- *    Report ID (13),
- *    Usage Page (Keyboard),
- *    Usage Minimum (KB Leftcontrol),
- *    Usage Maximum (KB Right GUI),
- *    Logical Minimum (0),
- *    Logical Maximum (1),
- *    Report Size (1),
- *    Report Count (8),
- *    Input (Variable),
- *    Report Size (8),
- *    Report Count (1),
- *    Input (Constant),
- *    Usage Page (Keyboard),
- *    Usage Minimum (None),
- *    Usage Maximum (KB Application),
- *    Logical Minimum (0),
- *    Logical Maximum (101),
- *    Report Size (8),
- *    Report Count (5),
- *    Input,
- *  End Collection,
- *  Usage Page (Consumer),
- *  Usage (Consumer Control),
- *  Collection (Application),
- *    Report ID (12),
- *    Usage (Volume Inc),
- *    Usage (Volume Dec),
- *    Usage (Mute),
- *    Logical Minimum (0),
- *    Logical Maximum (1),
- *    Report Size (1),
- *    Report Count (3),
- *    Input (Variable, Relative),
- *    Report Size (5),
- *    Report Count (1),
- *    Input (Constant, Variable, Relative),
- *  End Collection
+ * See Media Tablet 14.1 inch description, device and HID report descriptors at
+ * http://sf.net/apps/mediawiki/digimend/?title=Waltop_Media_Tablet_14.1%22
  */
 
 /* Size of the original report descriptor of Media Tablet 14.1 inch */
 #define MEDIA_TABLET_14_1_INCH_RDESC_ORIG_SIZE	309
 
-/*
- * Fixed Media Tablet 14.1 inch descriptor.
- * It is fixed similarly to the Media Tablet 10.6 inch descriptor.
- */
+/* Fixed Media Tablet 14.1 inch descriptor */
 static __u8 media_tablet_14_1_inch_rdesc_fixed[] = {
 	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
 	0x09, 0x02,         /*  Usage (Pen),                        */
-- 
1.7.9

