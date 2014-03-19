From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: multitouch: add support for Win 8.1 multitouch touchpads
Date: Wed, 19 Mar 2014 13:39:03 -0700
Message-ID: <1395261543-3103-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [192.147.44.131] ([192.147.44.131]:47408 "EHLO
	us-mx2.synaptics.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932673AbaCSUuG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Mar 2014 16:50:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, jkosina@suse.cz, rydberg@euromail.se
Cc: Andrew Duggan <aduggan@synaptics.com>

Multitouch touchpads built for Win 8.1 need to be sent an input mode feature report
in order to start reporting multitouch events. This is the same process sent
to Win 7 multitouch touchscreens except the value of the feature report is 3 for
touchpads.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 221d503..b428a3d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -68,6 +68,9 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_HOVERING		(1 << 11)
 #define MT_QUIRK_CONTACT_CNT_ACCURATE	(1 << 12)
 
+#define MT_INPUTMODE_TOUCHSCREEN	0x02
+#define MT_INPUTMODE_TOUCHPAD		0x03
+
 struct mt_slot {
 	__s32 x, y, cx, cy, p, w, h;
 	__s32 contactid;	/* the device ContactID assigned to this slot */
@@ -105,6 +108,7 @@ struct mt_device {
 	__s16 inputmode_index;	/* InputMode HID feature index in the report */
 	__s16 maxcontact_report_id;	/* Maximum Contact Number HID feature,
 				   -1 if non-existent */
+	__u8 inputmode_value;  /* InputMode HID feature value */
 	__u8 num_received;	/* how many contacts we received */
 	__u8 num_expected;	/* expected last contact index */
 	__u8 maxcontacts;
@@ -415,8 +419,10 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	 * Model touchscreens providing buttons as touchpads.
 	 */
 	if (field->application == HID_DG_TOUCHPAD ||
-	    (usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON)
+	    (usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
 		td->mt_flags |= INPUT_MT_POINTER;
+		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
+	}
 
 	if (usage->usage_index)
 		prev_usage = &field->usage[usage->usage_index - 1];
@@ -841,7 +847,7 @@ static void mt_set_input_mode(struct hid_device *hdev)
 	re = &(hdev->report_enum[HID_FEATURE_REPORT]);
 	r = re->report_id_hash[td->inputmode];
 	if (r) {
-		r->field[0]->value[td->inputmode_index] = 0x02;
+		r->field[0]->value[td->inputmode_index] = td->inputmode_value;
 		hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
 	}
 }
@@ -973,6 +979,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	td->mtclass = *mtclass;
 	td->inputmode = -1;
 	td->maxcontact_report_id = -1;
+	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
 	td->cc_index = -1;
 	td->mt_report_id = -1;
 	td->pen_report_id = -1;
-- 
1.8.3.2

