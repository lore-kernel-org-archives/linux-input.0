From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/3] HID: multitouch: Properly deal with Win8 PTP reports with 0 touches
Date: Tue,  7 Nov 2017 13:40:26 +0100
Message-ID: <20171107124027.26984-2-hdegoede@redhat.com>
References: <20171107124027.26984-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdKGMkf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Nov 2017 07:40:35 -0500
In-Reply-To: <20171107124027.26984-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

The Windows Precision Touchpad spec "Figure 4 Button Only Down and Up"
and "Table 9 Report Sequence for Button Only Down and Up" indicate
that the first packet of a (possibly hybrid mode multi-packet) frame
may contain a contact-count of 0 if only a button is pressed and no
fingers are detected.

This means that a value of 0 for contact-count is a valid value and
should be used as expected contact count when it is the first packet
(num_received == 0), as extra check to make sure that this is the first
packet of a buttons only frame, we also check that the timestamp is
different.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch in v2 of this patch-set

Changes in v3:
-Also check timestamps to make sure we're dealing with the first-packet
 of a frame
---
 drivers/hid/hid-multitouch.c | 34 ++++++++++++++++++++++++++++++++--
 include/linux/hid.h          |  1 +
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index bb939f6990f1..5d3904d0e89d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -117,6 +117,9 @@ struct mt_device {
 	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
 	int cc_index;	/* contact count field index in the report */
 	int cc_value_index;	/* contact count value index in the field */
+	int scantime_index;	/* scantime field index in the report */
+	int scantime_val_index;	/* scantime value index in the field */
+	int prev_scantime;	/* scantime reported in the previous packet */
 	unsigned last_slot_field;	/* the last field of a slot */
 	unsigned mt_report_id;	/* the report ID of the multitouch device */
 	unsigned long initial_quirks;	/* initial quirks state */
@@ -595,6 +598,14 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			/* we don't set td->last_slot_field as contactcount and
 			 * contact max are global to the report */
 			return -1;
+		case HID_DG_SCANTIME:
+			/* Ignore if indexes are out of bounds. */
+			if (field->index >= field->report->maxfield ||
+			    usage->usage_index >= field->report_count)
+				return 1;
+			td->scantime_index = field->index;
+			td->scantime_val_index = usage->usage_index;
+			return 1;
 		case HID_DG_TOUCH:
 			/* Legacy devices use TIPSWITCH and not TOUCH.
 			 * Let's just ignore this field. */
@@ -812,9 +823,10 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
+	__s32 cls = td->mtclass.name;
 	struct hid_field *field;
 	unsigned count;
-	int r, n;
+	int r, n, scantime = 0;
 
 	/* sticky fingers release in progress, abort */
 	if (test_and_set_bit(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
@@ -824,12 +836,29 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 	 * Includes multi-packet support where subsequent
 	 * packets are sent with zero contactcount.
 	 */
+	if (td->scantime_index >= 0) {
+		field = report->field[td->scantime_index];
+		scantime = field->value[td->scantime_val_index];
+	}
 	if (td->cc_index >= 0) {
 		struct hid_field *field = report->field[td->cc_index];
 		int value = field->value[td->cc_value_index];
-		if (value)
+
+		/*
+		 * For Win8 PTPs the first packet (td->num_received == 0) may
+		 * have a contactcount of 0 if there only is a button event.
+		 * We double check that this is not a continuation packet
+		 * of a possible multi-packet frame be checking that the
+		 * timestamp has changed.
+		 */
+		if ((cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL) &&
+		    td->num_received == 0 && td->prev_scantime != scantime)
+			td->num_expected = value;
+		/* A non 0 contact count always indicates a first packet */
+		else if (value)
 			td->num_expected = value;
 	}
+	td->prev_scantime = scantime;
 
 	for (r = 0; r < report->maxfield; r++) {
 		field = report->field[r];
@@ -1285,6 +1314,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	td->maxcontact_report_id = -1;
 	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
 	td->cc_index = -1;
+	td->scantime_index = -1;
 	td->mt_report_id = -1;
 	hid_set_drvdata(hdev, td);
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index ab05a86269dc..47dd962d9a7a 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -289,6 +289,7 @@ struct hid_item {
 #define HID_DG_DEVICEINDEX	0x000d0053
 #define HID_DG_CONTACTCOUNT	0x000d0054
 #define HID_DG_CONTACTMAX	0x000d0055
+#define HID_DG_SCANTIME		0x000d0056
 #define HID_DG_BUTTONTYPE	0x000d0059
 #define HID_DG_BARRELSWITCH2	0x000d005a
 #define HID_DG_TOOLSERIALNUMBER	0x000d005b
-- 
2.14.3

