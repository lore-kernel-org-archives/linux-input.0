From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 3/3] HID: multitouch: Only send button events when we have a complete frame
Date: Tue,  7 Nov 2017 13:40:27 +0100
Message-ID: <20171107124027.26984-3-hdegoede@redhat.com>
References: <20171107124027.26984-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdKGMkg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Nov 2017 07:40:36 -0500
In-Reply-To: <20171107124027.26984-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

This commit fixes 2 different issues with buttons on touchpads in one go:

1) Devices in "single finger hybrid mode" will send one report per finger,
   on some devices only the first report of such a multi-packet frame will
   contain a value for BTN_LEFT, in subsequent reports (if multiple fingers
   are down) the value is always 0, causing hid-mt to report BTN_LEFT going
   1 - 0 - 1 - 0 when pressing a clickpad and putting down a second finger.
   This happens for example on USB 0603:0002 mt touchpads.

2) According to the Win8 Precision Touchpad spec, inside the HID_UP_BUTTON
   usage-page usage 1 is for a clickpad getting clicked, 2 for an external
   left button and 3 for an external right button. Since Linux uses
   BTN_LEFT for a clickpad being clicked we end up mapping both usage 1
   and 2 to BTN_LEFT and if a single report contains both then we ended
   up always reporting the value of both in a single SYN, e.g. :
   BTN_LEFT 1, BTN_LEFT 0, SYN. This happens for example with Hantick
   HTT5288 i2c mt touchpads.

This commit fixes both issues by not immediately reporting buttons when
we parse the report, but instead storing the values of button fields and
reporting the result from mt_sync_frame() when we've a complete frame.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Rewrite of v1 of "HID: multitouch: Fix BTN_LEFT 0-1-0-1 events on Novatek
 mt touchpad" to kill two birds with one stone

Changes in v3:
-Delay reporting for all buttons not just for BTN_LEFT
---
 drivers/hid/hid-multitouch.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5d3904d0e89d..bfbfa04d023a 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -83,6 +83,8 @@ MODULE_LICENSE("GPL");
 #define MT_IO_FLAGS_ACTIVE_SLOTS	1
 #define MT_IO_FLAGS_PENDING_SLOTS	2
 
+#define BTN_COUNT			(BTN_JOYSTICK - BTN_MOUSE)
+
 struct mt_slot {
 	__s32 x, y, cx, cy, p, w, h;
 	__s32 contactid;	/* the device ContactID assigned to this slot */
@@ -120,6 +122,7 @@ struct mt_device {
 	int scantime_index;	/* scantime field index in the report */
 	int scantime_val_index;	/* scantime value index in the field */
 	int prev_scantime;	/* scantime reported in the previous packet */
+	int buttons_state;	/* buttons state */
 	unsigned last_slot_field;	/* the last field of a slot */
 	unsigned mt_report_id;	/* the report ID of the multitouch device */
 	unsigned long initial_quirks;	/* initial quirks state */
@@ -728,9 +731,17 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
  */
 static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
 {
+	int i;
+
+	/* For non Win8 devices buttons_state = 0, so this is a no-op */
+	for (i = 0; i < BTN_COUNT; i++)
+		input_event(input, EV_KEY, BTN_MOUSE + i,
+			    (td->buttons_state >> i) & 1);
+
 	input_mt_sync_frame(input);
 	input_sync(input);
 	td->num_received = 0;
+	td->buttons_state = 0;
 	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
 		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
 	else
@@ -752,6 +763,7 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 				struct hid_usage *usage, __s32 value)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
+	__s32 cls = td->mtclass.name;
 	__s32 quirks = td->mtclass.quirks;
 	struct input_dev *input = field->hidinput->input;
 
@@ -805,6 +817,19 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 			break;
 
 		default:
+			/*
+			 * For Win8 PTP touchpads the button state should be
+			 * reported once we've a complete frame, so we store
+			 * the state here and report it in mt_sync_frame().
+			 */
+			if ((cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL) &&
+			    usage->type == EV_KEY && usage->code >= BTN_MOUSE &&
+			    usage->code < BTN_JOYSTICK) {
+				int btn = usage->code - BTN_MOUSE;
+				td->buttons_state |= (!!value) << btn;
+				return;
+			}
+
 			if (usage->type)
 				input_event(input, usage->type, usage->code,
 						value);
-- 
2.14.3

