From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 09/12] HID: sony: DS3 comply to Linux gamepad spec
Date: Tue,  7 Mar 2017 15:45:08 -0800
Message-ID: <20170307234511.30380-10-roderick@gaikai.com>
References: <20170307234511.30380-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35941 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933278AbdCGXqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-pg0-f48.google.com with SMTP id 187so5985386pgb.3
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 15:45:24 -0800 (PST)
In-Reply-To: <20170307234511.30380-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The axis and button mapping for the DS3 is strange. This is mostly
due to the device reporting many axes as for every digital button
it also has an analog button. Due to amount of analog values it
is even leaking well into the MT axes range.

We felt it is best to remove the many analog buttons and just report
digital and comply to the Linux gamepad spec. The analog buttons are
rarely used on the official platform, let alone on Linux.

This patch does remove motion sensor support (added back in another
patch).

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 176 +++++++++++++++++++++++--------------------------
 1 file changed, 81 insertions(+), 95 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 1c62698..16f37d6 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -75,89 +75,6 @@
 
 #define MAX_LEDS 4
 
-/*
- * The Sixaxis reports both digital and analog values for each button on the
- * controller except for Start, Select and the PS button.  The controller ends
- * up reporting 27 axes which causes them to spill over into the multi-touch
- * axis values.  Additionally, the controller only has 20 actual, physical axes
- * so there are several unused axes in between the used ones.
- */
-static u8 sixaxis_rdesc[] = {
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
-	0x95, 0x04,         /*              Report Count (4),       */
-	0x35, 0x00,         /*              Physical Minimum (0),   */
-	0x46, 0xFF, 0x00,   /*              Physical Maximum (255), */
-	0x09, 0x30,         /*              Usage (X),              */
-	0x09, 0x31,         /*              Usage (Y),              */
-	0x09, 0x32,         /*              Usage (Z),              */
-	0x09, 0x35,         /*              Usage (Rz),             */
-	0x81, 0x02,         /*              Input (Variable),       */
-	0xC0,               /*          End Collection,             */
-	0x05, 0x01,         /*          Usage Page (Desktop),       */
-	0x95, 0x13,         /*          Report Count (19),          */
-	0x09, 0x01,         /*          Usage (Pointer),            */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x95, 0x0C,         /*          Report Count (12),          */
-	0x81, 0x01,         /*          Input (Constant),           */
-	0x75, 0x10,         /*          Report Size (16),           */
-	0x95, 0x04,         /*          Report Count (4),           */
-	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
-	0x46, 0xFF, 0x03,   /*          Physical Maximum (1023),    */
-	0x09, 0x01,         /*          Usage (Pointer),            */
-	0x81, 0x02,         /*          Input (Variable),           */
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
 
 /* PS/3 Motion controller */
 static u8 motion_rdesc[] = {
@@ -508,6 +425,34 @@ static const unsigned int buzz_keymap[] = {
 	[20] = BTN_TRIGGER_HAPPY20,
 };
 
+static const unsigned int sixaxis_absmap[] = {
+	[0x30] = ABS_X,
+	[0x31] = ABS_Y,
+	[0x32] = ABS_RX, /* right stick X */
+	[0x35] = ABS_RY, /* right stick Y */
+};
+
+static const unsigned int sixaxis_keymap[] = {
+	[0x01] = BTN_SELECT, /* Select */
+	[0x02] = BTN_THUMBL, /* L3 */
+	[0x03] = BTN_THUMBR, /* R3 */
+	[0x04] = BTN_START, /* Start */
+	[0x05] = BTN_DPAD_UP, /* Up */
+	[0x06] = BTN_DPAD_RIGHT, /* Right */
+	[0x07] = BTN_DPAD_DOWN, /* Down */
+	[0x08] = BTN_DPAD_LEFT, /* Left */
+	[0x09] = BTN_TL2, /* L2 */
+	[0x0a] = BTN_TR2, /* R2 */
+	[0x0b] = BTN_TL, /* L1 */
+	[0x0c] = BTN_TR, /* R1 */
+	[0x0d] = BTN_NORTH, /* Triangle */
+	[0x0e] = BTN_EAST, /* Circle */
+	[0x0f] = BTN_SOUTH, /* Cross */
+	[0x10] = BTN_WEST, /* Square */
+	[0x11] = BTN_MODE, /* PS */
+};
+
+
 static const unsigned int ds4_absmap[] = {
 	[0x30] = ABS_X,
 	[0x31] = ABS_Y,
@@ -695,13 +640,6 @@ static inline void sony_schedule_work(struct sony_sc *sc,
 	}
 }
 
-static u8 *sixaxis_fixup(struct hid_device *hdev, u8 *rdesc,
-			     unsigned int *rsize)
-{
-	*rsize = sizeof(sixaxis_rdesc);
-	return sixaxis_rdesc;
-}
-
 static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
 			     unsigned int *rsize)
 {
@@ -757,6 +695,54 @@ static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 1;
 }
 
+static int sixaxis_mapping(struct hid_device *hdev, struct hid_input *hi,
+			  struct hid_field *field, struct hid_usage *usage,
+			  unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
+		unsigned int key = usage->hid & HID_USAGE;
+
+		if (key >= ARRAY_SIZE(sixaxis_keymap))
+			return -1;
+
+		key = sixaxis_keymap[key];
+		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
+		return 1;
+	} else if (usage->hid == HID_GD_POINTER) {
+		/* The DS3 provides analog values for most buttons and even
+		 * for HAT axes through GD Pointer. L2 and R2 are reported
+		 * among these as well instead of as GD Z / RZ. Remap L2
+		 * and R2 and ignore other analog 'button axes' as there is
+		 * no good way for reporting them.
+		 */
+		switch (usage->usage_index) {
+		case 8: /* L2 */
+			usage->hid = HID_GD_Z;
+			break;
+		case 9: /* R2 */
+			usage->hid = HID_GD_RZ;
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
+		if (abs >= ARRAY_SIZE(sixaxis_absmap))
+			return -1;
+
+		abs = sixaxis_absmap[abs];
+
+		hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
+		return 1;
+	}
+
+	return -1;
+}
+
 static int ds4_mapping(struct hid_device *hdev, struct hid_input *hi,
 		       struct hid_field *field, struct hid_usage *usage,
 		       unsigned long **bit, int *max)
@@ -812,9 +798,6 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 		rdesc[55] = 0x06;
 	}
 
-	if (sc->quirks & SIXAXIS_CONTROLLER)
-		return sixaxis_fixup(hdev, rdesc, rsize);
-
 	if (sc->quirks & MOTION_CONTROLLER)
 		return motion_fixup(hdev, rdesc, rsize);
 
@@ -1196,10 +1179,13 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (sc->quirks & PS3REMOTE)
 		return ps3remote_mapping(hdev, hi, field, usage, bit, max);
 
+	if (sc->quirks & SIXAXIS_CONTROLLER)
+		return sixaxis_mapping(hdev, hi, field, usage, bit, max);
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER)
 		return ds4_mapping(hdev, hi, field, usage, bit, max);
 
+
 	/* Let hid-core decide for the others */
 	return 0;
 }
@@ -2618,13 +2604,13 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	else if (sc->quirks & SIXAXIS_CONTROLLER)
 		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
 
-	/* Patch the hw version on DS4 compatible devices, so applications can
+	/* Patch the hw version on DS3/4 compatible devices, so applications can
 	 * distinguish between the default HID mappings and the mappings defined
 	 * by the Linux game controller spec. This is important for the SDL2
 	 * library, which has a game controller database, which uses device ids
 	 * in combination with version as a key.
 	 */
-	if (sc->quirks & DUALSHOCK4_CONTROLLER)
+	if (sc->quirks & (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER))
 		hdev->version |= 0x8000;
 
 	ret = hid_hw_start(hdev, connect_mask);
-- 
2.9.3

