From: Wei-Ning Huang <wnhuang@chromium.org>
Subject: [PATCH v3] HID: hid-multitouch: support fine-grain orientation reporting
Date: Thu, 28 Sep 2017 17:42:34 +0800
Message-ID: <20170928094234.7270-1-wnhuang@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:53676 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdI1Jmq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 28 Sep 2017 05:42:46 -0400
Received: by mail-pf0-f179.google.com with SMTP id x78so593668pff.10
        for <linux-input@vger.kernel.org>; Thu, 28 Sep 2017 02:42:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dtor@chromium.org>, Jiri Kosina <jikos@kernel.org>, Wei-Ning Huang <wnhuang@google.com>

The current hid-multitouch driver only allow the report of two
orientations, vertical and horizontal. We use the Azimuth orientation
usage 0x3F under the Digitizer usage page to report orientation if the
device supports it.

Changelog:
  v1 -> v2:
   - Fix commit message.
   - Remove resolution reporting for ABS_MT_ORIENTATION.
  v2 -> v3:
   - Fix commit message.

Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/hid/hid-multitouch.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/hid.h          |  1 +
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 440b999304a5..f9801d1b1eae 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -84,11 +84,12 @@ MODULE_LICENSE("GPL");
 #define MT_IO_FLAGS_PENDING_SLOTS	2
 
 struct mt_slot {
-	__s32 x, y, cx, cy, p, w, h;
+	__s32 x, y, cx, cy, p, w, h, a;
 	__s32 contactid;	/* the device ContactID assigned to this slot */
 	bool touch_state;	/* is the touch valid? */
 	bool inrange_state;	/* is the finger in proximity of the sensor? */
 	bool confidence_state;  /* is the touch made by a finger? */
+	bool has_azimuth;       /* the contact reports azimuth */
 };
 
 struct mt_class {
@@ -591,6 +592,20 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			td->cc_index = field->index;
 			td->cc_value_index = usage->usage_index;
 			return 1;
+		case HID_DG_AZIMUTH:
+			hid_map_usage(hi, usage, bit, max,
+				EV_ABS, ABS_MT_ORIENTATION);
+			/*
+			 * Azimuth has the range of [0, MAX) representing a full
+			 * revolution. Set ABS_MT_ORIENTATION to a quarter of
+			 * MAX according the definition of ABS_MT_ORIENTATION
+			 */
+			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
+				0, field->logical_maximum / 4,
+				cls->sn_move ?
+				field->logical_maximum / cls->sn_move : 0, 0);
+			mt_store_field(usage, td, hi);
+			return 1;
 		case HID_DG_CONTACTMAX:
 			/* we don't set td->last_slot_field as contactcount and
 			 * contact max are global to the report */
@@ -683,6 +698,10 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 			int wide = (s->w > s->h);
 			int major = max(s->w, s->h);
 			int minor = min(s->w, s->h);
+			int orientation = wide;
+
+			if (s->has_azimuth)
+				orientation = s->a;
 
 			/*
 			 * divided by two to match visual scale of touch
@@ -699,7 +718,8 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 			input_event(input, EV_ABS, ABS_MT_TOOL_Y, s->cy);
 			input_event(input, EV_ABS, ABS_MT_DISTANCE,
 				!s->touch_state);
-			input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
+			input_event(input, EV_ABS, ABS_MT_ORIENTATION,
+				orientation);
 			input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p);
 			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
@@ -789,6 +809,17 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 			break;
 		case HID_DG_CONTACTCOUNT:
 			break;
+		case HID_DG_AZIMUTH:
+			/*
+			 * Azimuth is counter-clockwise and ranges from [0, MAX)
+			 * (a full revolution). Convert it to clockwise ranging
+			 * [-MAX/2, MAX/2].
+			 */
+			if (value > field->logical_maximum / 2)
+				value -= field->logical_maximum;
+			td->curdata.a = -value;
+			td->curdata.has_azimuth = true;
+			break;
 		case HID_DG_TOUCH:
 			/* do nothing */
 			break;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index ab05a86269dc..d81b9b6fd83a 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -281,6 +281,7 @@ struct hid_item {
 
 #define HID_DG_DEVICECONFIG	0x000d000e
 #define HID_DG_DEVICESETTINGS	0x000d0023
+#define HID_DG_AZIMUTH		0x000d003f
 #define HID_DG_CONFIDENCE	0x000d0047
 #define HID_DG_WIDTH		0x000d0048
 #define HID_DG_HEIGHT		0x000d0049
-- 
2.12.2

