From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 2/6] HID: sony: Improve navigation controller axis/button mapping
Date: Fri, 24 Mar 2017 15:17:46 -0700
Message-ID: <20170324221750.19543-3-roderick@gaikai.com>
References: <20170324221750.19543-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:36942 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754936AbdCXWSD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 18:18:03 -0400
Received: by mail-it0-f48.google.com with SMTP id 190so3886068itm.0
        for <linux-input@vger.kernel.org>; Fri, 24 Mar 2017 15:18:02 -0700 (PDT)
In-Reply-To: <20170324221750.19543-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The navigation controller is a DS3 (sixaxis) with fewer physical
axes and buttons. It utilizes the same HID report as the DS3 and
thus reports axes/buttons which aren't physically present.
Currently many non-existing buttons and axes are reported, which
we are now removing.

For the axes/buttons which do exist, we make the axis/button mapping
similar to the DS3.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 186 ++++++++++++++++++++++---------------------------
 1 file changed, 85 insertions(+), 101 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2e14788..55b25d7 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -173,96 +173,6 @@ static u8 motion_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/* PS/3 Navigation controller */
-static u8 navigation_rdesc[] = {
-	0x05, 0x01,         /*  Usage Page (Desktop),               */
-	0x09, 0x04,         /*  Usage (Joystick),                   */
-	0xA1, 0x01,         /*  Collection (Application),           */
-	0xA1, 0x02,         /*      Collection (Logical),           */
-	0x85, 0x01,         /*          Report ID (1),              */
-	0x75, 0x08,         /*          Report Size (8),            */
-	0x95, 0x01,         /*          Report Count (1),           */
-	0x15, 0x00,         /*          Logical Minimum (0),        */
-	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
-	0x81, 0x03,         /*          Input (Constant, Variable), */
-	0x75, 0x01,         /*          Report Size (1),            */
-	0x95, 0x13,         /*          Report Count (19),          */
-	0x15, 0x00,         /*          Logical Minimum (0),        */
-	0x25, 0x01,         /*          Logical Maximum (1),        */
-	0x35, 0x00,         /*          Physical Minimum (0),       */
-	0x45, 0x01,         /*          Physical Maximum (1),       */
-	0x05, 0x09,         /*          Usage Page (Button),        */
-	0x19, 0x01,         /*          Usage Minimum (01h),        */
-	0x29, 0x13,         /*          Usage Maximum (13h),        */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x75, 0x01,         /*          Report Size (1),            */
-	0x95, 0x0D,         /*          Report Count (13),          */
-	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
-	0x81, 0x03,         /*          Input (Constant, Variable), */
-	0x15, 0x00,         /*          Logical Minimum (0),        */
-	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
-	0x05, 0x01,         /*          Usage Page (Desktop),       */
-	0x09, 0x01,         /*          Usage (Pointer),            */
-	0xA1, 0x00,         /*          Collection (Physical),      */
-	0x75, 0x08,         /*              Report Size (8),        */
-	0x95, 0x02,         /*              Report Count (2),       */
-	0x35, 0x00,         /*              Physical Minimum (0),   */
-	0x46, 0xFF, 0x00,   /*              Physical Maximum (255), */
-	0x09, 0x30,         /*              Usage (X),              */
-	0x09, 0x31,         /*              Usage (Y),              */
-	0x81, 0x02,         /*              Input (Variable),       */
-	0xC0,               /*          End Collection,             */
-	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
-	0x95, 0x06,         /*          Report Count (6),           */
-	0x81, 0x03,         /*          Input (Constant, Variable), */
-	0x05, 0x01,         /*          Usage Page (Desktop),       */
-	0x75, 0x08,         /*          Report Size (8),            */
-	0x95, 0x05,         /*          Report Count (5),           */
-	0x09, 0x01,         /*          Usage (Pointer),            */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
-	0x95, 0x01,         /*          Report Count (1),           */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x05, 0x01,         /*          Usage Page (Desktop),       */
-	0x95, 0x01,         /*          Report Count (1),           */
-	0x09, 0x01,         /*          Usage (Pointer),            */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
-	0x95, 0x1E,         /*          Report Count (24),          */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x75, 0x08,         /*          Report Size (8),            */
-	0x95, 0x30,         /*          Report Count (48),          */
-	0x09, 0x01,         /*          Usage (Pointer),            */
-	0x91, 0x02,         /*          Output (Variable),          */
-	0x75, 0x08,         /*          Report Size (8),            */
-	0x95, 0x30,         /*          Report Count (48),          */
-	0x09, 0x01,         /*          Usage (Pointer),            */
-	0xB1, 0x02,         /*          Feature (Variable),         */
-	0xC0,               /*      End Collection,                 */
-	0xA1, 0x02,         /*      Collection (Logical),           */
-	0x85, 0x02,         /*          Report ID (2),              */
-	0x75, 0x08,         /*          Report Size (8),            */
-	0x95, 0x30,         /*          Report Count (48),          */
-	0x09, 0x01,         /*          Usage (Pointer),            */
-	0xB1, 0x02,         /*          Feature (Variable),         */
-	0xC0,               /*      End Collection,                 */
-	0xA1, 0x02,         /*      Collection (Logical),           */
-	0x85, 0xEE,         /*          Report ID (238),            */
-	0x75, 0x08,         /*          Report Size (8),            */
-	0x95, 0x30,         /*          Report Count (48),          */
-	0x09, 0x01,         /*          Usage (Pointer),            */
-	0xB1, 0x02,         /*          Feature (Variable),         */
-	0xC0,               /*      End Collection,                 */
-	0xA1, 0x02,         /*      Collection (Logical),           */
-	0x85, 0xEF,         /*          Report ID (239),            */
-	0x75, 0x08,         /*          Report Size (8),            */
-	0x95, 0x30,         /*          Report Count (48),          */
-	0x09, 0x01,         /*          Usage (Pointer),            */
-	0xB1, 0x02,         /*          Feature (Variable),         */
-	0xC0,               /*      End Collection,                 */
-	0xC0                /*  End Collection                      */
-};
-
 static u8 ps3remote_rdesc[] = {
 	0x05, 0x01,          /* GUsagePage Generic Desktop */
 	0x09, 0x05,          /* LUsage 0x05 [Game Pad] */
@@ -425,6 +335,40 @@ static const unsigned int buzz_keymap[] = {
 	[20] = BTN_TRIGGER_HAPPY20,
 };
 
+/* The Navigation controller is a partial DS3 and uses the same HID report
+ * and hence the same keymap indices, however not not all axes/buttons
+ * are physically present. We use the same axis and button mapping as
+ * the DS3, which uses the Linux gamepad spec.
+ */
+static const unsigned int navigation_absmap[] = {
+	[0x30] = ABS_X,
+	[0x31] = ABS_Y,
+	[0x33] = ABS_Z, /* L2 */
+};
+
+/* Buttons not physically available on the device, but still available
+ * in the reports are explicitly set to 0 for documentation purposes.
+ */
+static const unsigned int navigation_keymap[] = {
+	[0x01] = 0, /* Select */
+	[0x02] = BTN_THUMBL, /* L3 */
+	[0x03] = 0, /* R3 */
+	[0x04] = 0, /* Start */
+	[0x05] = BTN_DPAD_UP, /* Up */
+	[0x06] = BTN_DPAD_RIGHT, /* Right */
+	[0x07] = BTN_DPAD_DOWN, /* Down */
+	[0x08] = BTN_DPAD_LEFT, /* Left */
+	[0x09] = BTN_TL2, /* L2 */
+	[0x0a] = 0, /* R2 */
+	[0x0b] = BTN_TL, /* L1 */
+	[0x0c] = 0, /* R1 */
+	[0x0d] = BTN_NORTH, /* Triangle */
+	[0x0e] = BTN_EAST, /* Circle */
+	[0x0f] = BTN_SOUTH, /* Cross */
+	[0x10] = BTN_WEST, /* Square */
+	[0x11] = BTN_MODE, /* PS */
+};
+
 static const unsigned int sixaxis_absmap[] = {
 	[0x30] = ABS_X,
 	[0x31] = ABS_Y,
@@ -452,7 +396,6 @@ static const unsigned int sixaxis_keymap[] = {
 	[0x11] = BTN_MODE, /* PS */
 };
 
-
 static const unsigned int ds4_absmap[] = {
 	[0x30] = ABS_X,
 	[0x31] = ABS_Y,
@@ -650,13 +593,6 @@ static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
 	return motion_rdesc;
 }
 
-static u8 *navigation_fixup(struct hid_device *hdev, u8 *rdesc,
-			     unsigned int *rsize)
-{
-	*rsize = sizeof(navigation_rdesc);
-	return navigation_rdesc;
-}
-
 static u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
 			     unsigned int *rsize)
 {
@@ -698,6 +634,54 @@ static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 1;
 }
 
+static int navigation_mapping(struct hid_device *hdev, struct hid_input *hi,
+			  struct hid_field *field, struct hid_usage *usage,
+			  unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
+		unsigned int key = usage->hid & HID_USAGE;
+
+		if (key >= ARRAY_SIZE(sixaxis_keymap))
+			return -1;
+
+		key = navigation_keymap[key];
+		if (!key)
+			return -1;
+
+		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
+		return 1;
+	} else if (usage->hid == HID_GD_POINTER) {
+		/* See comment in sixaxis_mapping, basically the L2 (and R2)
+		 * triggers are reported through GD Pointer.
+		 * In addition we ignore any analog button 'axes' and only
+		 * support digital buttons.
+		 */
+		switch (usage->usage_index) {
+		case 8: /* L2 */
+			usage->hid = HID_GD_Z;
+			break;
+		default:
+			return -1;
+		}
+
+		hid_map_usage_clear(hi, usage, bit, max, EV_ABS, usage->hid & 0xf);
+		return 1;
+	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK) {
+		unsigned int abs = usage->hid & HID_USAGE;
+
+		if (abs >= ARRAY_SIZE(navigation_absmap))
+			return -1;
+
+		abs = navigation_absmap[abs];
+
+		hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
+		return 1;
+	}
+
+	return -1;
+}
+
+
 static int sixaxis_mapping(struct hid_device *hdev, struct hid_input *hi,
 			  struct hid_field *field, struct hid_usage *usage,
 			  unsigned long **bit, int *max)
@@ -804,9 +788,6 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 	if (sc->quirks & MOTION_CONTROLLER)
 		return motion_fixup(hdev, rdesc, rsize);
 
-	if (sc->quirks & NAVIGATION_CONTROLLER)
-		return navigation_fixup(hdev, rdesc, rsize);
-
 	if (sc->quirks & PS3REMOTE)
 		return ps3remote_fixup(hdev, rdesc, rsize);
 
@@ -1199,6 +1180,9 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (sc->quirks & PS3REMOTE)
 		return ps3remote_mapping(hdev, hi, field, usage, bit, max);
 
+	if (sc->quirks & NAVIGATION_CONTROLLER)
+		return navigation_mapping(hdev, hi, field, usage, bit, max);
+
 	if (sc->quirks & SIXAXIS_CONTROLLER)
 		return sixaxis_mapping(hdev, hi, field, usage, bit, max);
 
-- 
2.9.3

