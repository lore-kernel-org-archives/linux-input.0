From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/7] HID: logitech-hidpp: allow non HID++ devices to be handled by this module
Date: Fri,  7 Sep 2018 12:34:44 +0200
Message-ID: <20180907103450.13890-2-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Simon Wood <simon@mungewell.org>, Olivier Gay <ogay@logitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On the gaming mice, there are 2 interfaces, one for the mouse and one
for the macros. Better allow everybody to go through hid-logitech-hidpp
than trying to be smarter.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 77 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5f0c080059c6..37abae63bb1a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2730,6 +2730,9 @@ static int hidpp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
+	if (!hidpp)
+		return 0;
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_input_mapping(hdev, hi, field, usage, bit, max);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560 &&
@@ -2745,6 +2748,9 @@ static int hidpp_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
+	if (!hidpp)
+		return 0;
+
 	/* Ensure that Logitech G920 is not given a default fuzz/flat value */
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
 		if (usage->type == EV_ABS && (usage->code == ABS_X ||
@@ -2778,6 +2784,9 @@ static int hidpp_input_configured(struct hid_device *hdev,
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 	struct input_dev *input = hidinput->input;
 
+	if (!hidpp)
+		return 0;
+
 	hidpp_populate_input(hidpp, input, true);
 
 	return 0;
@@ -2847,6 +2856,9 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 	int ret = 0;
 
+	if (!hidpp)
+		return 0;
+
 	/* Generic HID++ processing. */
 	switch (data[0]) {
 	case REPORT_ID_HIDPP_VERY_LONG:
@@ -2895,7 +2907,13 @@ static int hidpp_event(struct hid_device *hdev, struct hid_field *field,
 	 * restriction imposed in hidpp_usages.
 	 */
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
-	struct hid_scroll_counter *counter = &hidpp->vertical_wheel_counter;
+	struct hid_scroll_counter *counter;
+
+	if (!hidpp)
+		return 0;
+
+	counter = &hidpp->vertical_wheel_counter;
+
 	/* A scroll event may occur before the multiplier has been retrieved or
 	 * the input device set, or high-res scroll enabling may fail. In such
 	 * cases we must return early (falling back to default behaviour) to
@@ -3153,6 +3171,41 @@ static const struct attribute_group ps_attribute_group = {
 	.attrs = sysfs_attrs
 };
 
+static bool hidpp_validate_report(struct hid_device *hdev, int id, int size,
+		bool optional)
+{
+	struct hid_report_enum *re;
+	struct hid_report *report;
+
+	if (id >= HID_MAX_IDS || id < 0) {
+		hid_err(hdev, "invalid HID report id %u\n", id);
+		return false;
+	}
+
+	re = &(hdev->report_enum[HID_OUTPUT_REPORT]);
+	report = re->report_id_hash[id];
+
+	if (!report)
+		return optional;
+
+	if (report->field[0]->report_count < size) {
+		hid_warn(hdev, "not enough values in hidpp report %d\n", id);
+		return false;
+	}
+
+	return true;
+}
+
+static bool hidpp_validate_device(struct hid_device *hdev)
+{
+	return hidpp_validate_report(hdev, REPORT_ID_HIDPP_SHORT,
+				     HIDPP_REPORT_SHORT_LENGTH - 1, false) &&
+	       hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
+				     HIDPP_REPORT_LONG_LENGTH - 1, true) &&
+	       hidpp_validate_report(hdev, REPORT_ID_HIDPP_VERY_LONG,
+				     HIDPP_REPORT_VERY_LONG_LENGTH - 1, true);
+}
+
 static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hidpp_device *hidpp;
@@ -3160,6 +3213,18 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	bool connected;
 	unsigned int connect_mask = HID_CONNECT_DEFAULT;
 
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "%s:parse failed\n", __func__);
+		return ret;
+	}
+
+	/*
+	 * Make sure the device is HID++ capable, otherwise treat as generic HID
+	 */
+	if (!hidpp_validate_device(hdev))
+		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
 	hidpp = devm_kzalloc(&hdev->dev, sizeof(struct hidpp_device),
 			GFP_KERNEL);
 	if (!hidpp)
@@ -3203,12 +3268,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_warn(hdev, "Cannot allocate sysfs group for %s\n",
 			 hdev->name);
 
-	ret = hid_parse(hdev);
-	if (ret) {
-		hid_err(hdev, "%s:parse failed\n", __func__);
-		goto hid_parse_fail;
-	}
-
 	if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
 		connect_mask &= ~HID_CONNECT_HIDINPUT;
 
@@ -3284,7 +3343,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_hw_stop(hdev);
 	}
 hid_hw_start_fail:
-hid_parse_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
@@ -3297,6 +3355,9 @@ static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
+	if (!hidpp)
+		return hid_hw_stop(hdev);
+
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-- 
2.14.3
