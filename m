From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH 4/4] hid-ntrig: Contact tracking
Date: Thu, 11 Feb 2010 22:14:08 -0500
Message-ID: <1265944448-23436-4-git-send-email-rafi@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu>
 <1265944448-23436-1-git-send-email-rafi@seas.upenn.edu>
 <1265944448-23436-2-git-send-email-rafi@seas.upenn.edu>
 <1265944448-23436-3-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:45357 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757883Ab0BLDOm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 22:14:42 -0500
In-Reply-To: <1265944448-23436-3-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, chatty@enac.fr
Cc: Rafi Rubin <rafi@seas.upenn.edu>

Added contact tracking to compensate for the lack of tracking in
hardware.  The approach is simplistic and leaves considerable
room for improvement.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |  216 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 183 insertions(+), 33 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 3da7287..ba092f6 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -64,7 +64,9 @@ struct ntrig_data {
 
 	/* Collected state for 2 full sets of contacts */
 	struct ntrig_contact contacts[NTRIG_MAX_CONTACTS];
+	struct ntrig_contact prev_contacts[NTRIG_MAX_CONTACTS];
 	__u8 contact_count;
+	__u8 prev_contact_count;
 
 	__u8 mt_footer[4];
 	__u8 mt_foot_count;
@@ -117,18 +119,15 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	case HID_UP_DIGITIZER:
 		switch (usage->hid) {
 		/* we do not want to map these for now */
-		case HID_DG_CONTACTID: /* value is useless */
 		case HID_DG_INPUTMODE:
 		case HID_DG_DEVICEINDEX:
-		case HID_DG_CONTACTCOUNT:
 		case HID_DG_CONTACTMAX:
 			return -1;
 
-		/* original mapping by Rafi Rubin */
-		case HID_DG_CONFIDENCE:
-			nt_map_key_clear(BTN_TOOL_DOUBLETAP);
+		case HID_DG_CONTACTID:
+			hid_map_usage(hi, usage, bit, max, EV_ABS,
+					ABS_MT_TRACKING_ID);
 			return 1;
-
 		/* width/height mapped on TouchMajor/TouchMinor/Orientation */
 		case HID_DG_WIDTH:
 			hid_map_usage(hi, usage, bit, max,
@@ -166,43 +165,191 @@ static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
-static void ntrig_conclude_mt(struct input_dev *input, struct ntrig_data *nd)
+static void ntrig_single_touch_emit(struct input_dev *input,
+				    struct ntrig_data *nd)
 {
-	int i;
-	struct ntrig_contact *contact = &nd->contacts[0];
-
-	/* Emit single touch events */
-	if (contact->confidence) {
+	if (nd->confidence) {
 		switch (nd->contact_count) {
 		case 0:	/* for single touch devices */
 		case 1:
-			input_report_key(nd->st_input, BTN_TOOL_DOUBLETAP, 1);
+			input_report_key(input, BTN_TOOL_DOUBLETAP, 1);
 			break;
 		case 2:
-			input_report_key(nd->st_input, BTN_TOOL_TRIPLETAP, 1);
+			input_report_key(input, BTN_TOOL_TRIPLETAP, 1);
 			break;
 		case 3:
 		default:
-			input_report_key(nd->st_input, BTN_TOOL_QUADTAP, 1);
+			input_report_key(input, BTN_TOOL_QUADTAP, 1);
+		}
+		input_report_key(input, BTN_TOUCH, 1);
+		input_event(input, EV_ABS, ABS_X, nd->x);
+		input_event(input, EV_ABS, ABS_Y, nd->y);
+	} else {
+		/* No active fingers, clear all state */
+		input_report_key(input, BTN_TOUCH, 0);
+		input_report_key(input, BTN_TOOL_DOUBLETAP, 0);
+		input_report_key(input, BTN_TOOL_TRIPLETAP, 0);
+		input_report_key(input, BTN_TOOL_QUADTAP, 0);
+	}
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
+static inline void nt_map_match(struct ntrig_data *nd, __s8 *contact_map,
+		int new, int old)
+{
+	nd->contacts[new].logical_id = nd->prev_contacts[old].logical_id;
+	contact_map[nd->contacts[new].logical_id] = new;
+}
+
+static void ntrig_conclude_mt(struct input_dev *input, struct ntrig_data *nd)
+{
+	__s8 contact_map[nd->max_contacts];
+	int i, j, k;
+	int matched = 0;
+	int first_free_id = 0;
+	int count = nd->contact_count;
+	int prev_count = nd->prev_contact_count;
+	struct ntrig_contact *contact;
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
+	/* Contact tracking logic */
+
+	/* Initialize and empty logical id map */
+	for (i = 0; i < nd->max_contacts; i++)
+		contact_map[i] = -1;
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
+		for (j = 0; j < prev_count &&
+		     (nd->contacts[i].logical_id < 0); j++) {
+
+			/* Check the map to avoid reusing an old contact
+			 * for multiple current contacts */
+			if ((contact_map[nd->prev_contacts[j].logical_id] < 0)
+			    && nt_match_points(nd, i, j)) {
+				nt_map_match(nd, contact_map, i, j);
+				matched++;
+			}
 		}
-		input_report_key(nd->st_input, BTN_TOUCH, 1);
-		input_event(nd->st_input, EV_ABS, ABS_X, contact->x);
-		input_event(nd->st_input, EV_ABS, ABS_Y, contact->y);
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
+			       && first_free_id < nd->max_contacts)
+				first_free_id++;
+			if (first_free_id >= nd->max_contacts) {
+				printk(KERN_ERR
+				       "hid-ntrig: exceeded contacts limit\n");
+				break;
+			}
+			nd->contacts[i].logical_id = first_free_id;
+			contact_map[first_free_id++] = i;
+			matched++;
+		}
+	}
+
+	k = -1;			/* Lowest id contact */
+	j = -1;			/* Highest id contact */
+	if (nd->emit_ghosts < 2) {
+		for (i = 0; i < nd->max_contacts; i++)
+			if (contact_map[i] >= 0) {
+				j = i;
+				if (k < 0)
+					k = i;
+			}
 	} else {
-		input_report_key(nd->st_input, BTN_TOUCH, 0);
-		input_report_key(nd->st_input, BTN_TOOL_DOUBLETAP, 0);
-		input_report_key(nd->st_input, BTN_TOOL_TRIPLETAP, 0);
-		input_report_key(nd->st_input, BTN_TOOL_QUADTAP, 0);
+		j = nd->max_contacts - 1;
+		for (i = 0; i < nd->max_contacts; i++)
+			if (contact_map[i] >= 0) {
+				k = i;
+				break;
+			}
+	}
+
+	/* Update the classic touchscreen state */
+	if (count) {
+		nd->x = nd->contacts[contact_map[k]].x;
+		nd->y = nd->contacts[contact_map[k]].y;
+		nd->confidence = nd->contacts[contact_map[k]].confidence;
+		ntrig_single_touch_emit(nd->st_input, nd);
+	} else {
+		/* Hit the end of activity, clear state */
+		nd->confidence = 0;
+		ntrig_single_touch_emit(nd->st_input, nd);
 	}
 
 	/* Multitouch doesn't need to send an end of activity notice. */
-	if (!(nd->contact_count && nd->contacts[0].confidence))
+	if (!(count && nd->contacts[0].confidence)) {
+		/* Only need to tag this group as empty, don't have
+		 * to worry about preserving all the empty state */
+		nd->prev_contact_count = 0;
 		return;
+	}
 
 	/* Emit multitouch events */
-	for (i = 0; i <= nd->max_contacts && i < NTRIG_MAX_CONTACTS; i++) {
-		if (nd->contacts[i].confidence) {
-			struct ntrig_contact *contact = &nd->contacts[i];
+	for (i = 0; i <= j; i++) {
+		/* Valid contact, send real values */
+		if (contact_map[i] >= 0
+		    && nd->contacts[contact_map[i]].confidence) {
+			contact = &nd->contacts[contact_map[i]];
 			input_event(input, EV_ABS, ABS_MT_TRACKING_ID, i);
 			input_event(input, EV_ABS, ABS_MT_POSITION_X,
 					contact->x);
@@ -226,6 +373,11 @@ static void ntrig_conclude_mt(struct input_dev *input, struct ntrig_data *nd)
 			input_mt_sync(input);
 		}
 	}
+
+	/* Age the current state to previous. */
+	for (i = 0; i < count; i++)
+		nd->prev_contacts[i] = nd->contacts[i];
+	nd->prev_contact_count = nd->contact_count;
 }
 
 /*
@@ -234,7 +386,7 @@ static void ntrig_conclude_mt(struct input_dev *input, struct ntrig_data *nd)
  * decide whether we are in multi or single touch mode
  * and call input_mt_sync after each point if necessary
  */
-static int ntrig_event (struct hid_device *hid, struct hid_field *field,
+static int ntrig_event(struct hid_device *hid, struct hid_field *field,
 		                        struct hid_usage *usage, __s32 value)
 {
 	struct input_dev *input = field->hidinput->input;
@@ -244,7 +396,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 	if (field->application == HID_DG_PEN)
 		return 0;
 
-        if (hid->claimed & HID_CLAIMED_INPUT) {
+	if (hid->claimed & HID_CLAIMED_INPUT) {
 		switch (usage->hid) {
 		case 0xff000001:
 			/* Tag indicating the start of a multitouch group */
@@ -275,8 +427,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * to emit a normal (X, Y) position
 			 */
 			if (!nd->reading_mt) {
-				input_event(input, EV_ABS, ABS_X, nd->x);
-				input_event(input, EV_ABS, ABS_Y, nd->y);
+				ntrig_single_touch_emit(input, nd);
 			}
 			break;
 		case 0xff000002:
@@ -307,8 +458,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 
 			/* If the contact was invalid */
 			if (!(nd->confidence && nd->mt_footer[0])
-					|| nd->w <= 250
-					|| nd->h <= 190) {
+					|| nd->w <= 250 || nd->h <= 190) {
 				nd->contacts[nd->id].x = 0;
 				nd->contacts[nd->id].y = 0;
 				nd->contacts[nd->id].confidence = 0;
@@ -373,6 +523,7 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	nd->id = 0;
 	nd->reading_mt = 0;
 	nd->contact_count = 0;
+	nd->prev_contact_count = 0;
 	nd->max_width = 0x500;
 	nd->max_height = 0x500;
 	nd->max_contacts = 5;
@@ -392,7 +543,6 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
-
 	list_for_each_entry(hidinput, &hdev->inputs, list) {
 		input = hidinput->input;
 		switch (hidinput->report->field[0]->application) {
-- 
1.6.6.1

