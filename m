From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH 2/4] hid-ntrig.c: removed unnecessary tool switching
Date: Thu, 11 Feb 2010 22:14:06 -0500
Message-ID: <1265944448-23436-2-git-send-email-rafi@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu>
 <1265944448-23436-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:45353 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850Ab0BLDOi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 22:14:38 -0500
In-Reply-To: <1265944448-23436-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, chatty@enac.fr
Cc: Rafi Rubin <rafi@seas.upenn.edu>

With the pen and touch split apart, we no longer need to inject
additional tool switching events.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |   41 +----------------------------------------
 1 files changed, 1 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 38b2364..1bda3a4 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -27,9 +27,6 @@
 struct ntrig_data {
 	__s32 x, y, id, w, h;
 	bool reading_a_point, found_contact_id;
-	bool pen_active;
-	bool finger_active;
-	bool inverted;
 };
 
 /*
@@ -47,7 +44,6 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 0;
 
 	switch (usage->hid & HID_USAGE_PAGE) {
-
 	case HID_UP_GENDESK:
 		switch (usage->hid) {
 		case HID_GD_X:
@@ -111,6 +107,7 @@ static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 	/* No special mappings needed for the pen */
 	if (field->application == HID_DG_PEN)
 		return 0;
+
 	if (usage->type == EV_KEY || usage->type == EV_REL
 			|| usage->type == EV_ABS)
 		clear_bit(usage->code, *bit);
@@ -136,18 +133,6 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 
         if (hid->claimed & HID_CLAIMED_INPUT) {
 		switch (usage->hid) {
-
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
 		case HID_GD_X:
 			nd->x = value;
 			nd->reading_a_point = 1;
@@ -171,32 +156,8 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * to emit a normal (X, Y) position
 			 */
 			if (!nd->found_contact_id) {
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
-				}
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
-				input_event(input, EV_ABS, ABS_PRESSURE, value);
 			}
 			break;
 		case 0xff000002:
-- 
1.6.6.1

