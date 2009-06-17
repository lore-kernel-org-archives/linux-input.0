From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH] ntrig tool separation and pen usages
Date: Wed, 17 Jun 2009 18:48:06 -0400
Message-ID: <1245278886-11659-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.SEAS.upenn.edu ([158.130.12.194]:35290 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbZFQWsN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 18:48:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: chatty@enac.fr, Rafi Rubin <rafi@seas.upenn.edu>

When both touch and pen are active send a tool announcement before
sending any status changes so that event users may differentiate
which tool is changing.

Restored three usage codes used by the pen.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 75ed9d2..7765970 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -27,6 +27,9 @@
 struct ntrig_data {
 	__s32 x, y, id, w, h;
 	char reading_a_point, found_contact_id;
+	char pen_active;
+	char finger_active;
+	char inverted;
 };
 
 /*
@@ -63,10 +66,7 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	case HID_UP_DIGITIZER:
 		switch (usage->hid) {
 		/* we do not want to map these for now */
-		case HID_DG_INVERT: /* value is always 0 */
-		case HID_DG_ERASER: /* value is always 0 */
 		case HID_DG_CONTACTID: /* value is useless */
-		case HID_DG_BARRELSWITCH:  /* doubtful */
 		case HID_DG_INPUTMODE:
 		case HID_DG_DEVICEINDEX:
 		case HID_DG_CONTACTCOUNT:
@@ -125,6 +125,18 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 
         if (hid->claimed & HID_CLAIMED_INPUT) {
 		switch (usage->hid) {
+
+		case HID_DG_INRANGE:
+			if(field->application & 0x3)
+				nd->pen_active = value!=0;
+			else
+				nd->finger_active = value!=0;
+			return 0;
+
+		case HID_DG_INVERT:
+			nd->inverted = value;
+			return 0;
+
 		case HID_GD_X:
 			nd->x = value;
 			nd->reading_a_point = 1;
@@ -148,6 +160,10 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * to emit a normal (X, Y) position
 			 */
 			if (! nd->found_contact_id) {
+				if(nd->pen_active && nd->finger_active) {
+					input_report_key(input, BTN_TOOL_DOUBLETAP, 0);
+					input_report_key(input, BTN_TOOL_DOUBLETAP, 1);
+				}
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
@@ -159,6 +175,14 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * to emit a normal (X, Y) position
 			 */
 			if (! nd->found_contact_id) {
+				if(nd->pen_active && nd->finger_active) {
+					input_report_key(input,
+							nd->inverted ? BTN_TOOL_RUBBER : BTN_TOOL_PEN
+							, 0);
+					input_report_key(input,
+							nd->inverted ? BTN_TOOL_RUBBER : BTN_TOOL_PEN
+							, 1);
+				}
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 				input_event(input, EV_ABS, ABS_PRESSURE, value);
@@ -233,6 +257,7 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (ret)
 		kfree (nd);
+
 	return ret;
 }
 
-- 
1.6.3.1

