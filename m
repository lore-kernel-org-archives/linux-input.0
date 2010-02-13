From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Fri, 12 Feb 2010 21:13:05 -0500
Message-ID: <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>
References: <4B75E14A.2050602@seas.upenn.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:50619 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab0BMCNt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2010 21:13:49 -0500
In-Reply-To: <4B75E14A.2050602@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, chatty@enac.fr, rydberg@euromail.se
Cc: Rafi Rubin <rafi@seas.upenn.edu>

This cleans up the identification of multitouch groups and enables
the end of group sync.

Taps are now explicitly handled to adjust for the changes in the
event stream in multitouch mode.  Added triple and quad tap for the
benefit of tools that recognize different tap types but do not have
full multi touch support.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |  116 ++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 94 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 1bda3a4..f6f882d 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -25,8 +25,16 @@
 					EV_KEY, (c))
 
 struct ntrig_data {
-	__s32 x, y, id, w, h;
-	bool reading_a_point, found_contact_id;
+	/* Incoming raw values for a single contact */
+	__u16 x, y, w, h;
+	__u16 id;
+	__u8 confidence;
+
+	bool reading_mt;
+	__u8 first_contact_confidence;
+
+	__u8 mt_footer[4];
+	__u8 mt_foot_count;
 };
 
 /*
@@ -39,8 +47,8 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	/* No special mappings needed for the pen */
-	if (field->application == HID_DG_PEN)
+	/* No special mappings needed for the pen and single touch */
+	if (field->physical)
 		return 0;
 
 	switch (usage->hid & HID_USAGE_PAGE) {
@@ -66,18 +74,12 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	case HID_UP_DIGITIZER:
 		switch (usage->hid) {
 		/* we do not want to map these for now */
-		case HID_DG_CONTACTID: /* value is useless */
+		case HID_DG_CONTACTID: /* Not trustworthy, squelch for now */
 		case HID_DG_INPUTMODE:
 		case HID_DG_DEVICEINDEX:
-		case HID_DG_CONTACTCOUNT:
 		case HID_DG_CONTACTMAX:
 			return -1;
 
-		/* original mapping by Rafi Rubin */
-		case HID_DG_CONFIDENCE:
-			nt_map_key_clear(BTN_TOOL_DOUBLETAP);
-			return 1;
-
 		/* width/height mapped on TouchMajor/TouchMinor/Orientation */
 		case HID_DG_WIDTH:
 			hid_map_usage(hi, usage, bit, max,
@@ -104,8 +106,8 @@ static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	/* No special mappings needed for the pen */
-	if (field->application == HID_DG_PEN)
+	/* No special mappings needed for the pen and single touch */
+	if (field->physical)
 		return 0;
 
 	if (usage->type == EV_KEY || usage->type == EV_REL
@@ -133,17 +135,24 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 
         if (hid->claimed & HID_CLAIMED_INPUT) {
 		switch (usage->hid) {
+		case 0xff000001:
+			/* Tag indicating the start of a multitouch group */
+			nd->reading_mt = 1;
+			nd->first_contact_confidence = 0;
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
@@ -155,7 +164,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * report received in a finger event. We want
 			 * to emit a normal (X, Y) position
 			 */
-			if (!nd->found_contact_id) {
+			if (!nd->reading_mt) {
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
@@ -167,10 +176,34 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
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
+				nd->confidence = 0;
+				break;
+			}
+
+			/* If the contact was invalid */
+			if (!(nd->confidence && nd->mt_footer[0])
+					|| nd->w <= 250
+					|| nd->h <= 190) {
+				nd->confidence = 0;
 				break;
+			}
+
 			/* emit a normal (X, Y) for the first point only */
 			if (nd->id == 0) {
+				nd->first_contact_confidence = nd->confidence;
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
@@ -192,8 +225,39 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 						ABS_MT_TOUCH_MINOR, nd->w);
 			}
 			input_mt_sync(field->hidinput->input);
-			nd->reading_a_point = 0;
-			nd->found_contact_id = 0;
+			break;
+
+		case HID_DG_CONTACTCOUNT: /* End of a multitouch group */
+			if (!nd->reading_mt)
+				break;
+
+			nd->reading_mt = 0;
+
+			if (nd->first_contact_confidence) {
+				switch (value) {
+				case 0:	/* for single touch devices */
+				case 1:
+					input_report_key(input,
+							BTN_TOOL_DOUBLETAP, 1);
+					break;
+				case 2:
+					input_report_key(input,
+							BTN_TOOL_TRIPLETAP, 1);
+					break;
+				case 3:
+				default:
+					input_report_key(input,
+							BTN_TOOL_QUADTAP, 1);
+				}
+				input_report_key(input, BTN_TOUCH, 1);
+			} else {
+				input_report_key(input,
+						BTN_TOOL_DOUBLETAP, 0);
+				input_report_key(input,
+						BTN_TOOL_TRIPLETAP, 0);
+				input_report_key(input,
+						BTN_TOOL_QUADTAP, 0);
+			}
 			break;
 
 		default:
@@ -224,8 +288,8 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate N-Trig data\n");
 		return -ENOMEM;
 	}
-	nd->reading_a_point = 0;
-	nd->found_contact_id = 0;
+
+	nd->reading_mt = 0;
 	hid_set_drvdata(hdev, nd);
 
 	ret = hid_parse(hdev);
@@ -248,6 +312,14 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			input->name = "N-Trig Pen";
 			break;
 		case HID_DG_TOUCHSCREEN:
+			__clear_bit(BTN_TOOL_PEN, input->keybit);
+			/*
+			 * A little something special to enable
+			 * two and three finger taps.
+			 */
+			__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
+			__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
+			__set_bit(BTN_TOOL_QUADTAP, input->keybit);
 			/*
 			 * The physical touchscreen (single touch)
 			 * input has a value for physical, whereas
-- 
1.6.6.1

