From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH] HID: Major update to N-Trig touchscreen
Date: Fri,  5 Feb 2010 19:56:48 -0500
Message-ID: <1265417808-14114-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:47822 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933128Ab0BFA5B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 19:57:01 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr, evilynux@gmail.com, dmitry.torokhov@gmail.com
Cc: Rafi Rubin <rafi@seas.upenn.edu>

Improvements to multitouch handling:
	enabled mt input events were were masked off
	adjusted interpretation of some hid events
	added finger tracking

	added start and end of activity suppression to compensate for noisy
	events from the sensor

Pen and touch sensors moved to separate event nodes (HID_QUIRK_MULTI_INPUT)
and related changes removing unnecessary code and events that supported the
multiplexed streams.

Added names representing the sensor type and mode for each input dev.
Split event handlers for the sensors to make the code a bit more readable.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |  634 ++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 511 insertions(+), 123 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 49ce69d..9113cc7 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -16,31 +16,74 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
+#include <linux/input.h>
+#include <linux/list.h>
 
 #include "hid-ids.h"
 
 #define NTRIG_DUPLICATE_USAGES	0x001
+#define NTRIG_MAX_CONTACTS			10
 
 #define nt_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
 					EV_KEY, (c))
 
-struct ntrig_data {
-	__s32 x, y, id, w, h;
-	char reading_a_point, found_contact_id;
-	char pen_active;
-	char finger_active;
-	char inverted;
+/* to be used soon for caching so that we 
+ * can unjumble fingers */
+struct ntrig_contact {
+	char active;
+	__s8 logical_id;
+	__s32 x, y;
+	__s32 confidence;
+
+	/* height and width transformed */
+	char orientation;
+	__s32 touch_major;
+	__s32 touch_minor;
 };
 
-/*
- * this driver is aimed at two firmware versions in circulation:
- *  - dual pen/finger single touch
- *  - finger multitouch, pen not working
- */
+struct ntrig_data {
+	__s32 x, y;
+
+	/* Touch values */
+	__s32 id, w, h;
+	__s32 confidence;
+
+	int max_width;
+	int max_height;
+
+	/* used to determine when enough groups have been supressed */
+	unsigned int groups_suppressed;
+
+	/* and for the end of activity */
+	unsigned int touch_end_count;
+
+	unsigned char reading_mt;
+
+	/* Collected state for 2 full sets of contacts */
+	struct ntrig_contact contacts[NTRIG_MAX_CONTACTS];
+	struct ntrig_contact prev_contacts[NTRIG_MAX_CONTACTS];
+	__u8 contact_count;
+	__u8 prev_contact_count;
+	__s8 contact_map[NTRIG_MAX_CONTACTS];
+
+	__u8 mt_footer[4];
+	__u8 mt_foot_count;
+
+	/* pen state */
+	__u32 pen_current_tool;
+	__u32 tip, barrel, eraser;
+	unsigned char inverted;
+	unsigned char inrange;
+
+	/* options */
+	unsigned char emit_ghosts;
+	unsigned int touch_suppress;
+	unsigned int touch_end_slack;
+};
 
 static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
-		struct hid_field *field, struct hid_usage *usage,
-		unsigned long **bit, int *max)
+			       struct hid_field *field, struct hid_usage *usage,
+			       unsigned long **bit, int *max)
 {
 	switch (usage->hid & HID_USAGE_PAGE) {
 
@@ -48,48 +91,22 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		switch (usage->hid) {
 		case HID_GD_X:
 			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_POSITION_X);
+				      EV_ABS, ABS_MT_POSITION_X);
 			input_set_abs_params(hi->input, ABS_X,
-					field->logical_minimum,
-					field->logical_maximum, 0, 0);
+					     field->logical_minimum,
+					     field->logical_maximum, 0, 0);
 			return 1;
 		case HID_GD_Y:
 			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_POSITION_Y);
+				      EV_ABS, ABS_MT_POSITION_Y);
 			input_set_abs_params(hi->input, ABS_Y,
-					field->logical_minimum,
-					field->logical_maximum, 0, 0);
+					     field->logical_minimum,
+					     field->logical_maximum, 0, 0);
 			return 1;
 		}
 		return 0;
 
 	case HID_UP_DIGITIZER:
-		switch (usage->hid) {
-		/* we do not want to map these for now */
-		case HID_DG_CONTACTID: /* value is useless */
-		case HID_DG_INPUTMODE:
-		case HID_DG_DEVICEINDEX:
-		case HID_DG_CONTACTCOUNT:
-		case HID_DG_CONTACTMAX:
-			return -1;
-
-		/* original mapping by Rafi Rubin */
-		case HID_DG_CONFIDENCE:
-			nt_map_key_clear(BTN_TOOL_DOUBLETAP);
-			return 1;
-
-		/* width/height mapped on TouchMajor/TouchMinor/Orientation */
-		case HID_DG_WIDTH:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_TOUCH_MAJOR);
-			return 1;
-		case HID_DG_HEIGHT:
-			hid_map_usage(hi, usage, bit, max,
-					EV_ABS, ABS_MT_TOUCH_MINOR);
-			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
-					0, 1, 0, 0);
-			return 1;
-		}
 		return 0;
 
 	case 0xff000000:
@@ -101,53 +118,348 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 }
 
 static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
-		struct hid_field *field, struct hid_usage *usage,
-		unsigned long **bit, int *max)
+			      struct hid_field *field, struct hid_usage *usage,
+			      unsigned long **bit, int *max)
 {
 	if (usage->type == EV_KEY || usage->type == EV_REL
-			|| usage->type == EV_ABS)
+	    || usage->type == EV_ABS)
 		clear_bit(usage->code, *bit);
 
 	return 0;
 }
 
+static int ntrig_pen_event(struct hid_device *hid, struct hid_field *field,
+			   struct hid_usage *usage, __s32 value)
+{
+	struct input_dev *input = field->hidinput->input;
+	struct ntrig_data *nd = hid_get_drvdata(hid);
+
+	if (hid->claimed & HID_CLAIMED_INPUT) {
+		switch (usage->hid) {
+		case HID_DG_INRANGE:
+			nd->inrange = value;
+			return 0;
+		case HID_DG_TIPSWITCH:
+			nd->tip = value;
+			break;
+		case HID_DG_BARRELSWITCH:
+			nd->barrel = value;
+			break;
+		case HID_DG_INVERT:
+			nd->inverted = value;
+			break;
+		case HID_DG_ERASER:
+			nd->eraser = value;
+			if (nd->inverted) {
+				input_report_key(input, BTN_TOOL_PEN, 0);
+				input_report_key(input, BTN_TOOL_RUBBER, 1);
+				input_report_key(input, BTN_TOUCH, nd->eraser);
+				input_report_key(input, BTN_2, nd->eraser);
+			} else if (nd->inrange) {
+				input_report_key(input, BTN_TOOL_RUBBER, 0);
+				input_report_key(input, BTN_TOOL_PEN, 1);
+				input_report_key(input, BTN_TOUCH, nd->tip);
+				input_report_key(input, BTN_0, nd->tip);
+				input_report_key(input, BTN_STYLUS, nd->barrel);
+				input_report_key(input, BTN_1, nd->barrel);
+			} else {
+				input_report_key(input, BTN_TOUCH, 0);
+				input_report_key(input, BTN_0, 0);
+				input_report_key(input, BTN_STYLUS, 0);
+				input_report_key(input, BTN_1, 0);
+				input_report_key(input, BTN_2, 0);
+				input_report_key(input, BTN_TOOL_PEN, 0);
+				input_report_key(input, BTN_TOOL_RUBBER, 0);
+			}
+			break;
+
+		case HID_GD_X:
+			nd->x = value;
+			input_event(input, EV_ABS, ABS_X, nd->x);
+			break;
+		case HID_GD_Y:
+			nd->y = value;
+			input_event(input, EV_ABS, ABS_Y, nd->y);
+			break;
+
+		case HID_DG_TIPPRESSURE:
+		default:
+			return 0;
+		}
+	}
+
+	/* we have handled the hidinput part, now remains hiddev */
+	if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
+		hid->hiddev_hid_event(hid, field, usage, value);
+
+	return 1;
+}
+
+static void ntrig_single_touch_emit(struct input_dev *input,
+				    struct ntrig_data *nd)
+{
+	if (nd->confidence) {
+		switch (nd->contact_count) {
+		case 0:	/* for single touch devices */
+		case 1:
+			input_report_key(input, BTN_TOOL_DOUBLETAP, 1);
+			input_report_key(input, BTN_0, 1);
+			break;
+		case 2:
+			input_report_key(input, BTN_TOOL_TRIPLETAP, 1);
+			input_report_key(input, BTN_1, 1);
+			break;
+		case 3:
+		default:
+			input_report_key(input, BTN_TOOL_QUADTAP, 1);
+			input_report_key(input, BTN_2, 1);
+		}
+		input_report_key(input, BTN_TOUCH, 1);
+	} else {
+		/* No active fingers, clear all state */
+		input_report_key(input, BTN_TOUCH, 0);
+		input_report_key(input, BTN_TOOL_DOUBLETAP, 0);
+		input_report_key(input, BTN_TOOL_TRIPLETAP, 0);
+		input_report_key(input, BTN_TOOL_QUADTAP, 0);
+		input_report_key(input, BTN_0, 0);
+		input_report_key(input, BTN_1, 0);
+		input_report_key(input, BTN_2, 0);
+	}
+	input_event(input, EV_ABS, ABS_X, nd->x);
+	input_event(input, EV_ABS, ABS_Y, nd->y);
+	input_sync(input);
+}
+
+/* 
+ * Spatial comparison of two points.  If the difference
+ * is within the given thresholds they are treated as the
+ * same point.
+ */
+#define nt_same_point(a, b, max_dx, max_dy) ( \
+		(abs(a.x - b.x) <= max_dx) && \
+		(abs(a.y - b.y) <= max_dy))
+
+/*
+ * To verify a new contact matches a contact in the previous
+ * group, ensure both are valid then check spatial correlation.
+ */
+#define nt_match_points(nd, new, old) (nd->contacts[new].confidence && \
+		nd->prev_contacts[old].confidence && \
+		nt_same_point(nd->contacts[new], nd->prev_contacts[old], \
+			nd->max_width, nd->max_height))
+
+/*
+ * After an older contact is identified as a match nt_map_match updates
+ * the newer point as well as the contact map
+ */
+#define nt_map_match(nd, contact_map, new, old) \
+	nd->contacts[new].logical_id = nd->prev_contacts[old].logical_id; \
+	contact_map[nd->contacts[new].logical_id] = new;
+
+static void ntrig_conclude_mt(struct input_dev *input, struct ntrig_data *nd)
+{
+	__s8 contact_map[NTRIG_MAX_CONTACTS];
+	int i, j, k;
+	int matched = 0;
+	int first_free_id = 0;
+	int count = nd->contact_count;
+	int prev_count = nd->prev_contact_count;
+
+	/* If the previous state is corrupted, discard it. */
+	if (nd->prev_contact_count >= NTRIG_MAX_CONTACTS) {
+		printk(KERN_ERR
+		       "N-Trig previous state corrupted, discarding\n");
+		nd->prev_contact_count = 0;
+		prev_count = 0;
+	}
+
+	/* Under some circumstances an empty group is emitted with an invalid
+	 * contact 0 and contact count of 1. */
+	if (count && (!nd->contacts[0].confidence)) {
+		count = 0;
+		nd->contact_count = 0;
+	}
+
+	/*
+	 * The sensor sometimes sends a garbage empty group.  The real end
+	 * of activity results in a several empty groups (7 or 8).
+	 * Discarding groups up to a threshold helps reduce tracking loss.
+	 *
+	 * Pen activity results in slightly different signal that should
+	 * trigger the threshold immediately.
+	 */
+	if (!count) {
+		if (nd->touch_end_count < nd->touch_end_slack) {
+			nd->touch_end_count++;
+			return;
+		}
+	} else			/* Still active, reset the counter */
+		nd->touch_end_count = 0;
+
+	/* Initialize and empty logical id map */
+	for (i = 0; i < NTRIG_MAX_CONTACTS; i++) {
+		contact_map[i] = -1;
+	}
+
+	/* 
+	 * Phase 1: Identify which contacts seem to match
+	 * those with the same physical id from the previous group.
+	 * This should be the most common case during long touch
+	 * action. */
+	for (i = 0; i < count && i < prev_count; i++) {
+		if (nt_match_points(nd, i, i)) {
+			nt_map_match(nd, contact_map, i, i);
+			matched++;
+		} else
+			nd->contacts[i].logical_id = -1;
+	}
+
+	/* 
+	 * Phase 2: Find corresponding contacts when the incoming
+	 * order has changed.
+	 */
+	for (i = 0; i < count && matched < count; i++) {
+		for (j = 0; j < nd->prev_contact_count &&
+		     (nd->contacts[i].logical_id < 0); j++) {
+
+			/* Check the map to avoid reusing an old contact
+			 * for multiple current contacts */
+			if ((contact_map[nd->prev_contacts[j].logical_id] < 0)
+			    && nt_match_points(nd, i, j)) {
+				nt_map_match(nd, contact_map, i, j);
+				matched++;
+			}
+		}
+	}
+
+	/*
+	 * Phase 3: New or unidentied contacts are assigned logical ids.
+	 */
+	for (i = 0; i < count && matched < count; i++) {
+		/* Ignore points that are already mapped */
+		if ((nd->contacts[i].confidence
+		     && nd->contacts[i].logical_id < 0)) {
+			/* find the first available logical id */
+			while (contact_map[first_free_id] >= 0
+			       && first_free_id < NTRIG_MAX_CONTACTS)
+				first_free_id++;
+			if (first_free_id >= NTRIG_MAX_CONTACTS) {
+				printk(KERN_ERR
+				       "hid-ntrig: exceeded contacts limit\n");
+				break;
+			}
+			nd->contacts[i].logical_id = first_free_id;
+			contact_map[first_free_id++] = i;
+		}
+	}
+
+	k = -1;			/* Lowest id contact */
+	j = -1;			/* Highest id contact */
+	for (i = 0; i < NTRIG_MAX_CONTACTS; i++)
+		if (contact_map[i] >= 0) {
+			j = i;
+			if (k < 0)
+				k = i;
+		}
+
+	/* Update the classic touchscreen state */
+	if (count) {
+		if (nd->groups_suppressed >= nd->touch_suppress) {
+			nd->x = nd->contacts[contact_map[k]].x;
+			nd->y = nd->contacts[contact_map[k]].y;
+			nd->confidence =
+			    nd->contacts[contact_map[k]].confidence;
+			ntrig_single_touch_emit(input, nd);
+		} else
+			nd->groups_suppressed++;
+	} else if (prev_count) {
+		/* Hit the end of activity, clear state */
+		for (i = 0; i < NTRIG_MAX_CONTACTS; i++)
+			if (nd->contact_map[i] >= 0) {
+				k = nd->contact_map[i];
+				nd->x = nd->prev_contacts[k].x;
+				nd->y = nd->prev_contacts[k].y;
+			}
+		nd->confidence = 0;
+		nd->groups_suppressed = 0;
+		ntrig_single_touch_emit(input, nd);
+	}
+
+	/* If we have two empty groups of events don't update */
+	/* Take this oportunity to update the saved mapping */
+	for (i = 0; i <= j && i < NTRIG_MAX_CONTACTS; i++)
+		nd->contact_map[i] = contact_map[i];
+
+	/* Emit multitouch events */
+	for (i = 0; i <= j && i < NTRIG_MAX_CONTACTS; i++) {
+		/* Valid contact, send real values */
+		if (contact_map[i] >= 0
+		    && nd->contacts[contact_map[i]].confidence) {
+			struct ntrig_contact *contact =
+			    &nd->contacts[contact_map[i]];
+			input_event(input, EV_ABS, ABS_MT_TRACKING_ID, i);
+			input_event(input, EV_ABS, ABS_MT_POSITION_X,
+				    contact->x);
+			input_event(input, EV_ABS, ABS_MT_POSITION_Y,
+				    contact->y);
+			input_event(input, EV_ABS, ABS_MT_ORIENTATION,
+				    contact->orientation);
+			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR,
+				    contact->touch_major);
+			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR,
+				    contact->touch_minor);
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
+
+	/* Age the current state to previous. */
+	for (i = 0; i < nd->contact_count && i < NTRIG_MAX_CONTACTS; i++) {
+		nd->prev_contacts[i] = nd->contacts[i];
+	}
+	nd->prev_contact_count = nd->contact_count;
+}
+
 /*
  * this function is called upon all reports
  * so that we can filter contact point information,
  * decide whether we are in multi or single touch mode
  * and call input_mt_sync after each point if necessary
  */
-static int ntrig_event (struct hid_device *hid, struct hid_field *field,
-		                        struct hid_usage *usage, __s32 value)
+static int ntrig_touchscreen_event(struct hid_device *hid,
+				   struct hid_field *field,
+				   struct hid_usage *usage, __s32 value)
 {
 	struct input_dev *input = field->hidinput->input;
 	struct ntrig_data *nd = hid_get_drvdata(hid);
 
-        if (hid->claimed & HID_CLAIMED_INPUT) {
+	if (hid->claimed & HID_CLAIMED_INPUT) {
 		switch (usage->hid) {
 
-		case HID_DG_INRANGE:
-			if (field->application & 0x3)
-				nd->pen_active = (value != 0);
-			else
-				nd->finger_active = (value != 0);
-			return 0;
-
-		case HID_DG_INVERT:
-			nd->inverted = value;
-			return 0;
-
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
@@ -159,69 +471,76 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * report received in a finger event. We want
 			 * to emit a normal (X, Y) position
 			 */
-			if (!nd->found_contact_id) {
-				if (nd->pen_active && nd->finger_active) {
-					input_report_key(input, BTN_TOOL_DOUBLETAP, 0);
-					input_report_key(input, BTN_TOOL_DOUBLETAP, 1);
-				}
-				input_event(input, EV_ABS, ABS_X, nd->x);
-				input_event(input, EV_ABS, ABS_Y, nd->y);
-			}
-			break;
-		case HID_DG_TIPPRESSURE:
-			/*
-			 * when in single touch mode, this is the last
-			 * report received in a pen event. We want
-			 * to emit a normal (X, Y) position
-			 */
-			if (! nd->found_contact_id) {
-				if (nd->pen_active && nd->finger_active) {
-					input_report_key(input,
-							nd->inverted ? BTN_TOOL_RUBBER : BTN_TOOL_PEN
-							, 0);
-					input_report_key(input,
-							nd->inverted ? BTN_TOOL_RUBBER : BTN_TOOL_PEN
-							, 1);
+			if (!nd->reading_mt) {
+				if (!nd->confidence) {
+					nd->x = nd->contacts[0].x;
+					nd->y = nd->contacts[0].y;
+				} else {
+					nd->contacts[0].x = nd->x;
+					nd->contacts[0].y = nd->y;
 				}
-				input_event(input, EV_ABS, ABS_X, nd->x);
-				input_event(input, EV_ABS, ABS_Y, nd->y);
-				input_event(input, EV_ABS, ABS_PRESSURE, value);
+				ntrig_single_touch_emit(input, nd);
 			}
+
 			break;
 		case 0xff000002:
 			/*
-			 * we receive this when the device is in multitouch
+			 * Conclusion of a single multitouch contact.
+			 * We receive this when the device is in multitouch
 			 * mode. The first of the three values tagged with
 			 * this usage tells if the contact point is real
-			 * or a placeholder
+			 * or a placeholder and if its the last contact
+			 * of the set.
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
+				nd->touch_end_count = nd->touch_end_slack;
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
+			if (!(nd->confidence && nd->mt_footer[0])) {
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
 			}
-			input_mt_sync(field->hidinput->input);
-			nd->reading_a_point = 0;
-			nd->found_contact_id = 0;
+			break;
+
+		case HID_DG_CONTACTCOUNT:
+			/* This marks the end of the multitouch group */
+			nd->contact_count = value;
+			nd->reading_mt = 0;
+			ntrig_conclude_mt(input, nd);
 			break;
 
 		default:
@@ -231,32 +550,99 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 	}
 
 	/* we have handled the hidinput part, now remains hiddev */
-        if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
-                hid->hiddev_hid_event(hid, field, usage, value);
+	if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
+		hid->hiddev_hid_event(hid, field, usage, value);
 
 	return 1;
 }
 
+static int ntrig_event(struct hid_device *hid, struct hid_field *field,
+		       struct hid_usage *usage, __s32 value)
+{
+	switch (field->application) {
+	case HID_DG_PEN:
+		return ntrig_pen_event(hid, field, usage, value);
+	case HID_DG_TOUCHSCREEN:
+		return ntrig_touchscreen_event(hid, field, usage, value);
+	}
+	return -1;
+}
+
 static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
 	struct ntrig_data *nd;
+	struct hid_input *hidinput;
+	struct input_dev *input;
+
+	if (id->driver_data)
+		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
 
 	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
 	if (!nd) {
 		dev_err(&hdev->dev, "cannot allocate N-Trig data\n");
 		return -ENOMEM;
 	}
-	nd->reading_a_point = 0;
-	nd->found_contact_id = 0;
+	nd->id = 0;
+	nd->reading_mt = 0;
+	nd->contact_count = 0;
+	nd->prev_contact_count = 0;
+	nd->max_width = 0x500;
+	nd->max_height = 0x500;
+	nd->groups_suppressed = 0;
+	nd->touch_suppress = 1;
+	nd->touch_end_slack = 4;
+	nd->touch_end_count = 0;
+	nd->emit_ghosts = 0;
+
 	hid_set_drvdata(hdev, nd);
 
 	ret = hid_parse(hdev);
 	if (!ret)
 		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 
-	if (ret)
-		kfree (nd);
+	if (ret) {
+		kfree(nd);
+		return ret;
+	}
+
+	if (0) {
+		list_for_each_entry(hidinput, &hdev->inputs, list) {
+			input = hidinput->input;
+
+			input->absfuzz[ABS_X] = 4;
+			input->absfuzz[ABS_Y] = 4;
+
+			switch (hidinput->report->field[0]->application) {
+			case HID_DG_PEN:
+				input->name = "N-Trig Pen";
+				set_bit(BTN_STYLUS, input->keybit);
+				set_bit(BTN_TOUCH, input->keybit);
+				set_bit(BTN_0, input->keybit);
+				set_bit(BTN_1, input->keybit);
+				set_bit(BTN_2, input->keybit);
+				break;
+			case HID_DG_TOUCHSCREEN:
+				/* Multitouch has many more fields than the single
+				 * touch input.  Use that to determine the name. */
+				input->name = (hidinput->report->maxfield > 10)
+				    ? "N-Trig MultiTouch" :
+				    "N-Trig Touchscreen";
+				set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
+				set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
+				set_bit(BTN_TOOL_QUADTAP, input->keybit);
+				set_bit(BTN_TOUCH, input->keybit);
+				set_bit(ABS_MT_TRACKING_ID, input->absbit);
+				set_bit(ABS_MT_ORIENTATION, input->absbit);
+				set_bit(ABS_MT_TOUCH_MAJOR, input->absbit);
+				set_bit(ABS_MT_TOUCH_MINOR, input->absbit);
+				set_bit(BTN_0, input->keybit);
+				set_bit(BTN_1, input->keybit);
+				set_bit(BTN_2, input->keybit);
+				break;
+			}
+		}
+	}
 
 	return ret;
 }
@@ -268,15 +654,17 @@ static void ntrig_remove(struct hid_device *hdev)
 }
 
 static const struct hid_device_id ntrig_devices[] = {
+
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN),
-		.driver_data = NTRIG_DUPLICATE_USAGES },
+	  .driver_data = NTRIG_DUPLICATE_USAGES },
 	{ }
 };
+
 MODULE_DEVICE_TABLE(hid, ntrig_devices);
 
 static const struct hid_usage_id ntrig_grabbed_usages[] = {
 	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1 }
 };
 
 static struct hid_driver ntrig_driver = {
-- 
1.6.6

