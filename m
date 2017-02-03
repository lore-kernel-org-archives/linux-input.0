From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH v3 4/7] HID: sony: Remove report descriptor fixup for DS4
Date: Thu,  2 Feb 2017 16:21:03 -0800
Message-ID: <20170203002106.23225-5-roderick@gaikai.com>
References: <20170203002106.23225-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33907 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbdBCAVe (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2017 19:21:34 -0500
Received: by mail-pf0-f180.google.com with SMTP id e4so1096424pfg.1
        for <linux-input@vger.kernel.org>; Thu, 02 Feb 2017 16:21:34 -0800 (PST)
In-Reply-To: <20170203002106.23225-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The DS4 in BT mode sends initial input reports through report 1, which
is described in the HID report descriptors. When activated after sending
a certain feature report, the device uses report 17.

Currently the hid-sony driver fixes up the BT HID report descriptors,
so the HID layer can manage input reports for report 17.

We think it is best to eliminate this fixup and do the handling ourselves,
which is what this patch does. The main motivation is that there are
various users of DS4 through hidraw, including various cross-platform
applications/games, which have their own HID parsing across Linux/Win/OSX.
Due to the fixup the descriptors differ, which is causing pain for many
developers including major game publishers (who reached out privately).
Without the fixup, the Windows titles also have a fighting chance for
working on Wine, which provides HID support now. Overall it felt
best because of these reasons to remove the fixup.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 261 +++++++++++--------------------------------------
 1 file changed, 59 insertions(+), 202 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 9f79d1b..e367db3 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -344,197 +344,6 @@ static u8 navigation_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
-
-/*
- * The default behavior of the Dualshock 4 is to send reports using report
- * type 1 when running over Bluetooth. However, when feature report 2 is
- * requested during the controller initialization it starts sending input
- * reports in report 17.  Since report 17 is undefined in the default HID
- * descriptor the button and axis definitions must be moved to report 17 or
- * the HID layer won't process the received input.
- */
-static u8 dualshock4_bt_rdesc[] = {
-	0x05, 0x01,         /*  Usage Page (Desktop),               */
-	0x09, 0x05,         /*  Usage (Gamepad),                    */
-	0xA1, 0x01,         /*  Collection (Application),           */
-	0x85, 0x01,         /*      Report ID (1),                  */
-	0x75, 0x08,         /*      Report Size (8),                */
-	0x95, 0x0A,         /*      Report Count (9),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x06, 0x04, 0xFF,   /*      Usage Page (FF04h),             */
-	0x85, 0x02,         /*      Report ID (2),                  */
-	0x09, 0x24,         /*      Usage (24h),                    */
-	0x95, 0x24,         /*      Report Count (36),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA3,         /*      Report ID (163),                */
-	0x09, 0x25,         /*      Usage (25h),                    */
-	0x95, 0x30,         /*      Report Count (48),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x05,         /*      Report ID (5),                  */
-	0x09, 0x26,         /*      Usage (26h),                    */
-	0x95, 0x28,         /*      Report Count (40),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x06,         /*      Report ID (6),                  */
-	0x09, 0x27,         /*      Usage (27h),                    */
-	0x95, 0x34,         /*      Report Count (52),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x07,         /*      Report ID (7),                  */
-	0x09, 0x28,         /*      Usage (28h),                    */
-	0x95, 0x30,         /*      Report Count (48),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x08,         /*      Report ID (8),                  */
-	0x09, 0x29,         /*      Usage (29h),                    */
-	0x95, 0x2F,         /*      Report Count (47),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x06, 0x03, 0xFF,   /*      Usage Page (FF03h),             */
-	0x85, 0x03,         /*      Report ID (3),                  */
-	0x09, 0x21,         /*      Usage (21h),                    */
-	0x95, 0x26,         /*      Report Count (38),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x04,         /*      Report ID (4),                  */
-	0x09, 0x22,         /*      Usage (22h),                    */
-	0x95, 0x2E,         /*      Report Count (46),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xF0,         /*      Report ID (240),                */
-	0x09, 0x47,         /*      Usage (47h),                    */
-	0x95, 0x3F,         /*      Report Count (63),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xF1,         /*      Report ID (241),                */
-	0x09, 0x48,         /*      Usage (48h),                    */
-	0x95, 0x3F,         /*      Report Count (63),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xF2,         /*      Report ID (242),                */
-	0x09, 0x49,         /*      Usage (49h),                    */
-	0x95, 0x0F,         /*      Report Count (15),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x11,         /*      Report ID (17),                 */
-	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
-	0x09, 0x20,         /*      Usage (20h),                    */
-	0x95, 0x02,         /*      Report Count (2),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x05, 0x01,         /*      Usage Page (Desktop),           */
-	0x09, 0x30,         /*      Usage (X),                      */
-	0x09, 0x31,         /*      Usage (Y),                      */
-	0x09, 0x32,         /*      Usage (Z),                      */
-	0x09, 0x35,         /*      Usage (Rz),                     */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
-	0x75, 0x08,         /*      Report Size (8),                */
-	0x95, 0x04,         /*      Report Count (4),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x09, 0x39,         /*      Usage (Hat Switch),             */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x25, 0x07,         /*      Logical Maximum (7),            */
-	0x75, 0x04,         /*      Report Size (4),                */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0x81, 0x42,         /*      Input (Variable, Null State),   */
-	0x05, 0x09,         /*      Usage Page (Button),            */
-	0x19, 0x01,         /*      Usage Minimum (01h),            */
-	0x29, 0x0D,         /*      Usage Maximum (0Dh),            */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x25, 0x01,         /*      Logical Maximum (1),            */
-	0x75, 0x01,         /*      Report Size (1),                */
-	0x95, 0x0E,         /*      Report Count (14),              */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x75, 0x06,         /*      Report Size (6),                */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0x81, 0x01,         /*      Input (Constant),               */
-	0x05, 0x01,         /*      Usage Page (Desktop),           */
-	0x09, 0x33,         /*      Usage (Rx),                     */
-	0x09, 0x34,         /*      Usage (Ry),                     */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
-	0x75, 0x08,         /*      Report Size (8),                */
-	0x95, 0x02,         /*      Report Count (2),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h)              */
-	0x09, 0x21,         /*      Usage (0x21)                    */
-	0x95, 0x42,         /*      Report Count (66)               */
-	0x81, 0x02,         /*      Input (Variable)                */
-	0x09, 0x21,         /*      Usage (21h),                    */
-	0x75, 0x08,         /*      Report Size (8),                */
-	0x95, 0x4D,         /*      Report Count (77),              */
-	0x91, 0x02,         /*      Output (Variable),              */
-	0x85, 0x12,         /*      Report ID (18),                 */
-	0x09, 0x22,         /*      Usage (22h),                    */
-	0x95, 0x8D,         /*      Report Count (141),             */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x09, 0x23,         /*      Usage (23h),                    */
-	0x91, 0x02,         /*      Output (Variable),              */
-	0x85, 0x13,         /*      Report ID (19),                 */
-	0x09, 0x24,         /*      Usage (24h),                    */
-	0x95, 0xCD,         /*      Report Count (205),             */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x09, 0x25,         /*      Usage (25h),                    */
-	0x91, 0x02,         /*      Output (Variable),              */
-	0x85, 0x14,         /*      Report ID (20),                 */
-	0x09, 0x26,         /*      Usage (26h),                    */
-	0x96, 0x0D, 0x01,   /*      Report Count (269),             */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x09, 0x27,         /*      Usage (27h),                    */
-	0x91, 0x02,         /*      Output (Variable),              */
-	0x85, 0x15,         /*      Report ID (21),                 */
-	0x09, 0x28,         /*      Usage (28h),                    */
-	0x96, 0x4D, 0x01,   /*      Report Count (333),             */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x09, 0x29,         /*      Usage (29h),                    */
-	0x91, 0x02,         /*      Output (Variable),              */
-	0x85, 0x16,         /*      Report ID (22),                 */
-	0x09, 0x2A,         /*      Usage (2Ah),                    */
-	0x96, 0x8D, 0x01,   /*      Report Count (397),             */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x09, 0x2B,         /*      Usage (2Bh),                    */
-	0x91, 0x02,         /*      Output (Variable),              */
-	0x85, 0x17,         /*      Report ID (23),                 */
-	0x09, 0x2C,         /*      Usage (2Ch),                    */
-	0x96, 0xCD, 0x01,   /*      Report Count (461),             */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x09, 0x2D,         /*      Usage (2Dh),                    */
-	0x91, 0x02,         /*      Output (Variable),              */
-	0x85, 0x18,         /*      Report ID (24),                 */
-	0x09, 0x2E,         /*      Usage (2Eh),                    */
-	0x96, 0x0D, 0x02,   /*      Report Count (525),             */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x09, 0x2F,         /*      Usage (2Fh),                    */
-	0x91, 0x02,         /*      Output (Variable),              */
-	0x85, 0x19,         /*      Report ID (25),                 */
-	0x09, 0x30,         /*      Usage (30h),                    */
-	0x96, 0x22, 0x02,   /*      Report Count (546),             */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x09, 0x31,         /*      Usage (31h),                    */
-	0x91, 0x02,         /*      Output (Variable),              */
-	0x06, 0x80, 0xFF,   /*      Usage Page (FF80h),             */
-	0x85, 0x82,         /*      Report ID (130),                */
-	0x09, 0x22,         /*      Usage (22h),                    */
-	0x95, 0x3F,         /*      Report Count (63),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x83,         /*      Report ID (131),                */
-	0x09, 0x23,         /*      Usage (23h),                    */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x84,         /*      Report ID (132),                */
-	0x09, 0x24,         /*      Usage (24h),                    */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x90,         /*      Report ID (144),                */
-	0x09, 0x30,         /*      Usage (30h),                    */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x91,         /*      Report ID (145),                */
-	0x09, 0x31,         /*      Usage (31h),                    */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x92,         /*      Report ID (146),                */
-	0x09, 0x32,         /*      Usage (32h),                    */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x93,         /*      Report ID (147),                */
-	0x09, 0x33,         /*      Usage (33h),                    */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA0,         /*      Report ID (160),                */
-	0x09, 0x40,         /*      Usage (40h),                    */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA4,         /*      Report ID (164),                */
-	0x09, 0x44,         /*      Usage (44h),                    */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0xC0                /*  End Collection                      */
-};
-
 static u8 ps3remote_rdesc[] = {
 	0x05, 0x01,          /* GUsagePage Generic Desktop */
 	0x09, 0x05,          /* LUsage 0x05 [Game Pad] */
@@ -722,6 +531,10 @@ static const unsigned int ds4_keymap[] = {
 	[0xd] = BTN_MODE, /* PS */
 };
 
+static const struct {int x; int y; } ds4_hat_mapping[] = {
+	{0, -1}, {1, -1}, {1, 0}, {1, 1}, {0, 1}, {-1, 1}, {-1, 0}, {-1, -1},
+	{0, 0}
+};
 
 static enum power_supply_property sony_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
@@ -780,6 +593,7 @@ struct motion_output_report_02 {
 /* Offsets relative to USB input report (0x1). Bluetooth (0x11) requires an
  * additional +2.
  */
+#define DS4_INPUT_REPORT_AXIS_OFFSET      1
 #define DS4_INPUT_REPORT_BUTTON_OFFSET    5
 #define DS4_INPUT_REPORT_TIMESTAMP_OFFSET 10
 #define DS4_INPUT_REPORT_GYRO_X_OFFSET   13
@@ -974,17 +788,6 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 		rdesc[55] = 0x06;
 	}
 
-	/*
-	 * The default Dualshock 4 BT descriptor doesn't describe report ID 17
-	 * which is most often used for input data. Add this mapping, so we
-	 * use the generic hid code for parsing the buttons and axes.
-	 */
-	if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
-		hid_info(hdev, "Using modified Dualshock 4 Bluetooth report descriptor\n");
-		rdesc = dualshock4_bt_rdesc;
-		*rsize = sizeof(dualshock4_bt_rdesc);
-	}
-
 	if (sc->quirks & SIXAXIS_CONTROLLER)
 		return sixaxis_fixup(hdev, rdesc, rsize);
 
@@ -1035,6 +838,9 @@ static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 
 static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 {
+	struct hid_input *hidinput = list_entry(sc->hdev->inputs.next,
+						struct hid_input, list);
+	struct input_dev *input_dev = hidinput->input;
 	unsigned long flags;
 	int n, m, offset, num_touch_data, max_touch_data;
 	u8 cable_state, battery_capacity, battery_charging;
@@ -1047,6 +853,57 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	offset = data_offset + DS4_INPUT_REPORT_BUTTON_OFFSET;
 	input_report_key(sc->touchpad, BTN_LEFT, rd[offset+2] & 0x2);
 
+	/*
+	 * The default behavior of the Dualshock 4 is to send reports using
+	 * report type 1 when running over Bluetooth. However, when feature
+	 * report 2 is requested during the controller initialization it starts
+	 * sending input reports in report 17. Since report 17 is undefined
+	 * in the default HID descriptor, the HID layer won't generate events.
+	 * While it is possible (and this was done before) to fixup the HID
+	 * descriptor to add this mapping, it was better to do this manually.
+	 * The reason is there were various pieces software both open and closed
+	 * source, relying on the descriptors to be the same across various
+	 * operating systems. If the descriptors wouldn't match some
+	 * applications e.g. games on Wine would not be able to function due
+	 * to different descriptors, which such applications are not parsing.
+	 */
+	if (rd[0] == 17) {
+		int value;
+
+		offset = data_offset + DS4_INPUT_REPORT_AXIS_OFFSET;
+		input_report_abs(input_dev, ABS_X, rd[offset]);
+		input_report_abs(input_dev, ABS_Y, rd[offset+1]);
+		input_report_abs(input_dev, ABS_RX, rd[offset+2]);
+		input_report_abs(input_dev, ABS_RY, rd[offset+3]);
+
+		value = rd[offset+4] & 0xf;
+		if (value > 7)
+			value = 8; /* Center 0, 0 */
+		input_report_abs(input_dev, ABS_HAT0X, ds4_hat_mapping[value].x);
+		input_report_abs(input_dev, ABS_HAT0Y, ds4_hat_mapping[value].y);
+
+		input_report_key(input_dev, BTN_WEST, rd[offset+4] & 0x10);
+		input_report_key(input_dev, BTN_SOUTH, rd[offset+4] & 0x20);
+		input_report_key(input_dev, BTN_EAST, rd[offset+4] & 0x40);
+		input_report_key(input_dev, BTN_NORTH, rd[offset+4] & 0x80);
+
+		input_report_key(input_dev, BTN_TL, rd[offset+5] & 0x1);
+		input_report_key(input_dev, BTN_TR, rd[offset+5] & 0x2);
+		input_report_key(input_dev, BTN_TL2, rd[offset+5] & 0x4);
+		input_report_key(input_dev, BTN_TR2, rd[offset+5] & 0x8);
+		input_report_key(input_dev, BTN_SELECT, rd[offset+5] & 0x10);
+		input_report_key(input_dev, BTN_START, rd[offset+5] & 0x20);
+		input_report_key(input_dev, BTN_THUMBL, rd[offset+5] & 0x40);
+		input_report_key(input_dev, BTN_THUMBR, rd[offset+5] & 0x80);
+
+		input_report_key(input_dev, BTN_MODE, rd[offset+6] & 0x1);
+
+		input_report_abs(input_dev, ABS_Z, rd[offset+7]);
+		input_report_abs(input_dev, ABS_RZ, rd[offset+8]);
+
+		input_sync(input_dev);
+	}
+
 	/* Convert timestamp (in 5.33us unit) to timestamp_us */
 	offset = data_offset + DS4_INPUT_REPORT_TIMESTAMP_OFFSET;
 	timestamp = get_unaligned_le16(&rd[offset]);
-- 
2.9.3

