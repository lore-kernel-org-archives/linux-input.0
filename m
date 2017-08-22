From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH] HID: hid-multitouch: forward MSC_TIMESTAMP
Date: Tue, 22 Aug 2017 09:10:11 +0800
Message-ID: <20170822011011.39112-1-drinkcat@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36858 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754482AbdHVBNy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Aug 2017 21:13:54 -0400
Received: by mail-pf0-f169.google.com with SMTP id c28so18800895pfe.3
        for <linux-input@vger.kernel.org>; Mon, 21 Aug 2017 18:13:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, dtor@chromium.org

Computes and forwards the device timestamp according to the
specification.

Many devices use a 16-bit timestamp field, with a resolution
of 100us, therefore rolling around very frequently (every
6.5 seconds). To make sure there is no ambiguity, the
timestamp reported to the input stack reset to 0 whenever
the time between 2 received events is greater than
MAX_TIMESTAMP_INTERVAL (1 second).

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Inspired from Benjamin Tissoires's patch here:
https://patchwork.kernel.org/patch/1742181/, and changing the
logic to resynchronize the timestamps to use received time
instead of a potentially more fragile difference between
the 2 deltas.

 drivers/hid/hid-multitouch.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h          |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 440b999304a5..996bdc9bf0e5 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/input/mt.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 
@@ -136,6 +137,9 @@ struct mt_device {
 	bool serial_maybe;	/* need to check for serial protocol */
 	bool curvalid;		/* is the current contact valid? */
 	unsigned mt_flags;	/* flags to pass to input-mt */
+	__s32 dev_time;		/* the scan time provided by the device */
+	unsigned long jiffies;	/* the frame's jiffies */
+	int timestamp;		/* the timestamp to be sent */
 };
 
 static void mt_post_parse_default_settings(struct mt_device *td);
@@ -177,6 +181,12 @@ static void mt_post_parse(struct mt_device *td);
 #define MT_DEFAULT_MAXCONTACT	10
 #define MT_MAX_MAXCONTACT	250
 
+/*
+ * Resync device and local timestamps after that many microseconds without
+ * receiving data.
+ */
+#define MAX_TIMESTAMP_INTERVAL	1000000
+
 #define MT_USB_DEVICE(v, p)	HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH, v, p)
 #define MT_BT_DEVICE(v, p)	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_MULTITOUCH, v, p)
 
@@ -583,6 +593,12 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 				cls->sn_pressure);
 			mt_store_field(usage, td, hi);
 			return 1;
+		case HID_DG_SCANTIME:
+			hid_map_usage(hi, usage, bit, max,
+				EV_MSC, MSC_TIMESTAMP);
+			input_set_capability(hi->input, EV_MSC, MSC_TIMESTAMP);
+			mt_store_field(usage, td, hi);
+			return 1;
 		case HID_DG_CONTACTCOUNT:
 			/* Ignore if indexes are out of bounds. */
 			if (field->index >= field->report->maxfield ||
@@ -718,6 +734,7 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
 {
 	input_mt_sync_frame(input);
+	input_event(input, EV_MSC, MSC_TIMESTAMP, td->timestamp);
 	input_sync(input);
 	td->num_received = 0;
 	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
@@ -727,6 +744,28 @@ static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
 	clear_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags);
 }
 
+static int mt_compute_timestamp(struct mt_device *td, struct hid_field *field,
+		__s32 value)
+{
+	long delta = value - td->dev_time;
+	unsigned long jdelta = jiffies_to_usecs(jiffies - td->jiffies);
+
+	td->jiffies = jiffies;
+	td->dev_time = value;
+
+	if (delta < 0)
+		delta += field->logical_maximum;
+
+	/* HID_DG_SCANTIME is expressed in 100us, we want it in us. */
+	delta *= 100;
+
+	if (jdelta > MAX_TIMESTAMP_INTERVAL)
+		/* No data received for a while, resync the timestamp. */
+		return 0;
+	else
+		return td->timestamp + delta;
+}
+
 static int mt_touch_event(struct hid_device *hid, struct hid_field *field,
 				struct hid_usage *usage, __s32 value)
 {
@@ -787,6 +826,9 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 		case HID_DG_HEIGHT:
 			td->curdata.h = value;
 			break;
+		case HID_DG_SCANTIME:
+			td->timestamp = mt_compute_timestamp(td, field, value);
+			break;
 		case HID_DG_CONTACTCOUNT:
 			break;
 		case HID_DG_TOUCH:
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
2.14.1.480.gb18f417b89-goog

