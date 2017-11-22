From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 4/4] HID: multitouch: Combine all left-button events in a frame
Date: Wed, 22 Nov 2017 12:57:10 +0100
Message-ID: <20171122115710.9978-4-hdegoede@redhat.com>
References: <20171122115710.9978-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752370AbdKVL51 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Nov 2017 06:57:27 -0500
In-Reply-To: <20171122115710.9978-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

According to the Win8 Precision Touchpad spec, inside the HID_UP_BUTTON
usage-page usage 1 is for a clickpad getting clicked, 2 for an external
left button and 3 for an external right button. Since Linux uses
BTN_LEFT for a clickpad being clicked we end up mapping both usage 1
and 2 to BTN_LEFT and if a single report contains both then we ended
up always reporting the value of both in a single SYN, e.g. :
BTN_LEFT 1, BTN_LEFT 0, SYN. This happens for example with Hantick
HTT5288 i2c mt touchpads.

This commit fixes this by not immediately reporting left button when we
parse the report, but instead storing or-ing together the values and
reporting the result from mt_sync_frame() when we've a complete frame.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
Changes in v2:
-Rewrite of v1 of "HID: multitouch: Fix BTN_LEFT 0-1-0-1 events on Novatek
 mt touchpad" to kill two birds with one stone

Changes in v3:
-Delay reporting for all buttons not just for BTN_LEFT

Changes in v4:
-Back to combining only the value for BTN_LEFT, the other issues are fixed
 with the new "HID: multitouch: Only look at non touch fields in first
 packet of a frame" patch
---
 drivers/hid/hid-multitouch.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 760c4a042e6a..76088f2cf598 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -122,6 +122,7 @@ struct mt_device {
 	int scantime_index;	/* scantime field index in the report */
 	int scantime_val_index;	/* scantime value index in the field */
 	int prev_scantime;	/* scantime reported in the previous packet */
+	int left_button_state;	/* left button state */
 	unsigned last_slot_field;	/* the last field of a slot */
 	unsigned mt_report_id;	/* the report ID of the multitouch device */
 	unsigned long initial_quirks;	/* initial quirks state */
@@ -743,10 +744,16 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
  */
 static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
 {
+	__s32 cls = td->mtclass.name;
+
+	if (cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL)
+		input_event(input, EV_KEY, BTN_LEFT, td->left_button_state);
+
 	input_mt_sync_frame(input);
 	input_event(input, EV_MSC, MSC_TIMESTAMP, td->timestamp);
 	input_sync(input);
 	td->num_received = 0;
+	td->left_button_state = 0;
 	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
 		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
 	else
@@ -857,6 +864,19 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 			    !first_packet)
 				return;
 
+			/*
+			 * For Win8 PTP touchpads we map both the clickpad click
+			 * and any "external" left buttons to BTN_LEFT if a
+			 * device claims to have both we need to report 1 for
+			 * BTN_LEFT if either is pressed, so we or all values
+			 * together and report the result in mt_sync_frame().
+			 */
+			if ((cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL) &&
+			    usage->type == EV_KEY && usage->code == BTN_LEFT) {
+				td->left_button_state |= value;
+				return;
+			}
+
 			if (usage->type)
 				input_event(input, usage->type, usage->code,
 						value);
-- 
2.14.3

