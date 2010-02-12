From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH 3/4] hid-ntrig.c Split multi and single touch.
Date: Thu, 11 Feb 2010 22:14:07 -0500
Message-ID: <1265944448-23436-3-git-send-email-rafi@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu>
 <1265944448-23436-1-git-send-email-rafi@seas.upenn.edu>
 <1265944448-23436-2-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:45356 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757881Ab0BLDOm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 22:14:42 -0500
In-Reply-To: <1265944448-23436-2-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, chatty@enac.fr
Cc: Rafi Rubin <rafi@seas.upenn.edu>

This cleans up the identification of multitouch groups.  When two touch
input devices are available, single and multi touch streams are
partitioned to the appropriate device.

Added triple and quad tap to the single touch device for the benefit of
tools that recognize different tap types but do not have full
multi touch support.

Capture a full multitouch group before emitting events.  This allows for
additional processing, though takes little advantage of that capability.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |  239 +++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 200 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 1bda3a4..3da7287 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -20,13 +20,64 @@
 #include "hid-ids.h"
 
 #define NTRIG_DUPLICATE_USAGES	0x001
+#define NTRIG_MAX_CONTACTS	7
 
 #define nt_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
 					EV_KEY, (c))
+enum mt_orientation {
+	MT_VERTICAL   = 0,
+	MT_HORIZONTAL = 1,
+};
+
+enum ntrig_mt_emit_ghosts {
+	NTRIG_MT_EMIT_GHOSTS_NONE	  = 0,
+	NTRIG_MT_EMIT_GHOSTS_LOW_IDS_ONLY = 1,
+	NTRIG_MT_EMIT_GHOSTS_ALL	  = 2,
+};
+
+/*
+ * The relavent data needed to store events from a contact to
+ * delay transmittion.
+ */
+struct ntrig_contact {
+	__s8 logical_id;
+	__u16 x, y;
+	__u8 confidence;
+
+	/* height and width transformed */
+	enum mt_orientation orientation;
+	__u16 touch_major;
+	__u16 touch_minor;
+};
 
 struct ntrig_data {
-	__s32 x, y, id, w, h;
-	bool reading_a_point, found_contact_id;
+	/* Incoming raw values for a single contact */
+	__u16 x, y, w, h;
+	__u16 id;
+	__u8 confidence;
+
+	int max_width;
+	int max_height;
+	int max_contacts;
+
+	bool reading_mt;
+
+	/* Collected state for 2 full sets of contacts */
+	struct ntrig_contact contacts[NTRIG_MAX_CONTACTS];
+	__u8 contact_count;
+
+	__u8 mt_footer[4];
+	__u8 mt_foot_count;
+
+	/* options */
+	enum ntrig_mt_emit_ghosts emit_ghosts;
+
+	/*
+	 * Keep a pointer to the single touch input device to enable
+	 * the multitouch handler to redirect the older style single
+	 * touch events.
+	 */
+	struct input_dev *st_input;
 };
 
 /*
@@ -39,8 +90,8 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	/* No special mappings needed for the pen */
-	if (field->application == HID_DG_PEN)
+	/* No special mappings needed for the pen and single touch */
+	if (field->physical)
 		return 0;
 
 	switch (usage->hid & HID_USAGE_PAGE) {
@@ -104,8 +155,8 @@ static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	/* No special mappings needed for the pen */
-	if (field->application == HID_DG_PEN)
+	/* No special mappings needed for the pen and single touch */
+	if (field->physical)
 		return 0;
 
 	if (usage->type == EV_KEY || usage->type == EV_REL
@@ -115,6 +166,68 @@ static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
+static void ntrig_conclude_mt(struct input_dev *input, struct ntrig_data *nd)
+{
+	int i;
+	struct ntrig_contact *contact = &nd->contacts[0];
+
+	/* Emit single touch events */
+	if (contact->confidence) {
+		switch (nd->contact_count) {
+		case 0:	/* for single touch devices */
+		case 1:
+			input_report_key(nd->st_input, BTN_TOOL_DOUBLETAP, 1);
+			break;
+		case 2:
+			input_report_key(nd->st_input, BTN_TOOL_TRIPLETAP, 1);
+			break;
+		case 3:
+		default:
+			input_report_key(nd->st_input, BTN_TOOL_QUADTAP, 1);
+		}
+		input_report_key(nd->st_input, BTN_TOUCH, 1);
+		input_event(nd->st_input, EV_ABS, ABS_X, contact->x);
+		input_event(nd->st_input, EV_ABS, ABS_Y, contact->y);
+	} else {
+		input_report_key(nd->st_input, BTN_TOUCH, 0);
+		input_report_key(nd->st_input, BTN_TOOL_DOUBLETAP, 0);
+		input_report_key(nd->st_input, BTN_TOOL_TRIPLETAP, 0);
+		input_report_key(nd->st_input, BTN_TOOL_QUADTAP, 0);
+	}
+
+	/* Multitouch doesn't need to send an end of activity notice. */
+	if (!(nd->contact_count && nd->contacts[0].confidence))
+		return;
+
+	/* Emit multitouch events */
+	for (i = 0; i <= nd->max_contacts && i < NTRIG_MAX_CONTACTS; i++) {
+		if (nd->contacts[i].confidence) {
+			struct ntrig_contact *contact = &nd->contacts[i];
+			input_event(input, EV_ABS, ABS_MT_TRACKING_ID, i);
+			input_event(input, EV_ABS, ABS_MT_POSITION_X,
+					contact->x);
+			input_event(input, EV_ABS, ABS_MT_POSITION_Y,
+					contact->y);
+			input_event(input, EV_ABS, ABS_MT_ORIENTATION,
+					contact->orientation);
+			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR,
+					contact->touch_major);
+			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR,
+					contact->touch_minor);
+			input_mt_sync(input);
+		} else if (nd->emit_ghosts) {
+			/* emit filler points if so desired */
+			input_event(input, EV_ABS, ABS_MT_TRACKING_ID, i);
+			input_event(input, EV_ABS, ABS_MT_POSITION_X, 0);
+			input_event(input, EV_ABS, ABS_MT_POSITION_Y, 0);
+			input_event(input, EV_ABS, ABS_MT_ORIENTATION, 0);
+			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, 0);
+			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, 0);
+			input_mt_sync(input);
+		}
+	}
+}
+
 /*
  * this function is called upon all reports
  * so that we can filter contact point information,
@@ -133,17 +246,23 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 
         if (hid->claimed & HID_CLAIMED_INPUT) {
 		switch (usage->hid) {
+		case 0xff000001:
+			/* Tag indicating the start of a multitouch group */
+			nd->reading_mt = 1;
+			break;
+		case HID_DG_CONFIDENCE:
+			nd->confidence = value;
+			break;
 		case HID_GD_X:
 			nd->x = value;
-			nd->reading_a_point = 1;
+			/* Clear the contact footer */
+			nd->mt_foot_count = 0;
 			break;
 		case HID_GD_Y:
 			nd->y = value;
 			break;
 		case HID_DG_CONTACTID:
 			nd->id = value;
-			/* we receive this only when in multitouch mode */
-			nd->found_contact_id = 1;
 			break;
 		case HID_DG_WIDTH:
 			nd->w = value;
@@ -155,7 +274,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * report received in a finger event. We want
 			 * to emit a normal (X, Y) position
 			 */
-			if (!nd->found_contact_id) {
+			if (!nd->reading_mt) {
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
@@ -167,33 +286,58 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * this usage tells if the contact point is real
 			 * or a placeholder
 			 */
-			if (!nd->reading_a_point || value != 1)
+
+			/* Shouldn't get more than 4 footer packets, so skip */
+			if (nd->mt_foot_count >= 4)
+				break;
+
+			nd->mt_footer[nd->mt_foot_count++] = value;
+
+			/* if the footer isn't complete break */
+			if (nd->mt_foot_count != 4)
+				break;
+
+			/* Pen activity signal, trigger end of touch. */
+			if (nd->mt_footer[2]) {
+				nd->contacts[nd->id].x = 0;
+				nd->contacts[nd->id].y = 0;
+				nd->contacts[nd->id].confidence = 0;
 				break;
-			/* emit a normal (X, Y) for the first point only */
-			if (nd->id == 0) {
-				input_event(input, EV_ABS, ABS_X, nd->x);
-				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
-			input_event(input, EV_ABS, ABS_MT_POSITION_X, nd->x);
-			input_event(input, EV_ABS, ABS_MT_POSITION_Y, nd->y);
+
+			/* If the contact was invalid */
+			if (!(nd->confidence && nd->mt_footer[0])
+					|| nd->w <= 250
+					|| nd->h <= 190) {
+				nd->contacts[nd->id].x = 0;
+				nd->contacts[nd->id].y = 0;
+				nd->contacts[nd->id].confidence = 0;
+				break;
+			}
+
+			nd->contacts[nd->id].logical_id = -1;
+			nd->contacts[nd->id].confidence = nd->confidence;
+			nd->contacts[nd->id].x = nd->x;
+			nd->contacts[nd->id].y = nd->y;
+
 			if (nd->w > nd->h) {
-				input_event(input, EV_ABS,
-						ABS_MT_ORIENTATION, 1);
-				input_event(input, EV_ABS,
-						ABS_MT_TOUCH_MAJOR, nd->w);
-				input_event(input, EV_ABS,
-						ABS_MT_TOUCH_MINOR, nd->h);
+				nd->contacts[nd->id].orientation = 1;
+				nd->contacts[nd->id].touch_major = nd->w;
+				nd->contacts[nd->id].touch_minor = nd->h;
 			} else {
-				input_event(input, EV_ABS,
-						ABS_MT_ORIENTATION, 0);
-				input_event(input, EV_ABS,
-						ABS_MT_TOUCH_MAJOR, nd->h);
-				input_event(input, EV_ABS,
-						ABS_MT_TOUCH_MINOR, nd->w);
+				nd->contacts[nd->id].orientation = 0;
+				nd->contacts[nd->id].touch_major = nd->h;
+				nd->contacts[nd->id].touch_minor = nd->w;
+			}
+			break;
+
+		case HID_DG_CONTACTCOUNT:
+			/* This marks the end of the multitouch group */
+			nd->contact_count = value;
+			if (nd->reading_mt) {
+				nd->reading_mt = 0;
+				ntrig_conclude_mt(input, nd);
 			}
-			input_mt_sync(field->hidinput->input);
-			nd->reading_a_point = 0;
-			nd->found_contact_id = 0;
 			break;
 
 		default:
@@ -224,8 +368,16 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate N-Trig data\n");
 		return -ENOMEM;
 	}
-	nd->reading_a_point = 0;
-	nd->found_contact_id = 0;
+
+	/* Initialize the driver data to sane values */
+	nd->id = 0;
+	nd->reading_mt = 0;
+	nd->contact_count = 0;
+	nd->max_width = 0x500;
+	nd->max_height = 0x500;
+	nd->max_contacts = 5;
+	nd->emit_ghosts = 0;
+
 	hid_set_drvdata(hdev, nd);
 
 	ret = hid_parse(hdev);
@@ -254,11 +406,19 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			 * the multitouch only has logical input
 			 * fields.
 			 */
-			input->name =
-				(hidinput->report->field[0]
-				 ->physical) ?
-				"N-Trig Touchscreen" :
-				"N-Trig MultiTouch";
+			if (hidinput->report->field[0]->physical) {
+				input->name = "N-Trig Touchscreen";
+				nd->st_input = input;
+
+				/*
+				 * A little something special to enable
+				 * two and three finger taps.
+				 */
+				set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
+				set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
+				set_bit(BTN_TOOL_QUADTAP, input->keybit);
+			} else
+				input->name = "N-Trig MultiTouch";
 			break;
 		}
 	}
@@ -280,6 +440,7 @@ static const struct hid_device_id ntrig_devices[] = {
 		.driver_data = NTRIG_DUPLICATE_USAGES },
 	{ }
 };
+
 MODULE_DEVICE_TABLE(hid, ntrig_devices);
 
 static const struct hid_usage_id ntrig_grabbed_usages[] = {
-- 
1.6.6.1

