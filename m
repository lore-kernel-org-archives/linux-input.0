From: Allen Hung <allen_hung@dell.com>
Subject: [PATCH 2/2] HID: multitouch: enable palm rejection for Windows Precision Touchpad
Date: Thu, 23 Jun 2016 16:31:30 +0800
Message-ID: <1466670690-77458-2-git-send-email-allen_hung@dell.com>
References: <1466670690-77458-1-git-send-email-allen_hung@dell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:27575 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcFWIbv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 04:31:51 -0400
In-Reply-To: <1466670690-77458-1-git-send-email-allen_hung@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Allen Hung <allen_hung@dell.com>

The usage Confidence is mandary to Windows Precision Touchpad devices. If
it is examined in input_mapping on a WIndows Precision Touchpad, a new add
quirk MT_QUIRK_CONFIDENCE desgned for such devices will be applied to the
device. A touch with the confidence bit is not set is determined as
invalid.

Tested on Dell XPS13 9343

Signed-off-by: Allen Hung <allen_hung@dell.com>
---
 drivers/hid/hid-multitouch.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4ef7006..fb6f1f4 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -61,6 +61,7 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_ALWAYS_VALID		(1 << 4)
 #define MT_QUIRK_VALID_IS_INRANGE	(1 << 5)
 #define MT_QUIRK_VALID_IS_CONFIDENCE	(1 << 6)
+#define MT_QUIRK_CONFIDENCE		(1 << 7)
 #define MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE	(1 << 8)
 #define MT_QUIRK_NO_AREA		(1 << 9)
 #define MT_QUIRK_IGNORE_DUPLICATES	(1 << 10)
@@ -78,6 +79,7 @@ struct mt_slot {
 	__s32 contactid;	/* the device ContactID assigned to this slot */
 	bool touch_state;	/* is the touch valid? */
 	bool inrange_state;	/* is the finger in proximity of the sensor? */
+	bool confidence_state;  /* is the touch made by a finger? */
 };
 
 struct mt_class {
@@ -502,6 +504,9 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_DG_CONFIDENCE:
+			if (cls->name == MT_CLS_WIN_8 &&
+				field->application == HID_DG_TOUCHPAD)
+				cls->quirks |= MT_QUIRK_CONFIDENCE;
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_DG_TIPSWITCH:
@@ -614,6 +619,7 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 		return;
 
 	if (td->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
+		int active;
 		int slotnum = mt_compute_slot(td, input);
 		struct mt_slot *s = &td->curdata;
 		struct input_mt *mt = input->mt;
@@ -628,10 +634,14 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 				return;
 		}
 
+		if (!(td->mtclass.quirks & MT_QUIRK_CONFIDENCE))
+			s->confidence_state = 1;
+		active = (s->touch_state || s->inrange_state) &&
+							s->confidence_state;
+
 		input_mt_slot(input, slotnum);
-		input_mt_report_slot_state(input, MT_TOOL_FINGER,
-			s->touch_state || s->inrange_state);
-		if (s->touch_state || s->inrange_state) {
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, active);
+		if (active) {
 			/* this finger is in proximity of the sensor */
 			int wide = (s->w > s->h);
 			/* divided by two to match visual scale of touch */
@@ -696,6 +706,8 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 			td->curdata.touch_state = value;
 			break;
 		case HID_DG_CONFIDENCE:
+			if (quirks & MT_QUIRK_CONFIDENCE)
+				td->curdata.confidence_state = value;
 			if (quirks & MT_QUIRK_VALID_IS_CONFIDENCE)
 				td->curvalid = value;
 			break;
-- 
2.7.4

