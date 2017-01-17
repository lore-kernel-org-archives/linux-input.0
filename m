From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 12/17] HID: logitech-hidpp: allow non HID++ devices to be handled by this module
Date: Tue, 17 Jan 2017 15:35:42 +0100
Message-ID: <20170117143547.30488-13-benjamin.tissoires@redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On the gaming mice, there are 2 interfaces, one for the mouse and one
for the macros. Better allow everybody to go through hid-logitech-hidpp
than trying to be smarter.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 69 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 033ef4c..a5d37a4 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2380,6 +2380,9 @@ static int hidpp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
+	if (!hidpp)
+		return 0;
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_input_mapping(hdev, hi, field, usage, bit, max);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560 &&
@@ -2395,6 +2398,9 @@ static int hidpp_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
+	if (!hidpp)
+		return 0;
+
 	/* Ensure that Logitech G920 is not given a default fuzz/flat value */
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
 		if (usage->type == EV_ABS && (usage->code == ABS_X ||
@@ -2423,6 +2429,9 @@ static int hidpp_input_configured(struct hid_device *hdev,
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 	struct input_dev *input = hidinput->input;
 
+	if (!hidpp)
+		return 0;
+
 	hidpp_populate_input(hidpp, input, true);
 
 	return 0;
@@ -2476,6 +2485,9 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 	int ret = 0;
 
+	if (!hidpp)
+		return 0;
+
 	/* Generic HID++ processing. */
 	switch (data[0]) {
 	case REPORT_ID_HIDPP_VERY_LONG:
@@ -2747,6 +2759,41 @@ static struct attribute_group ps_attribute_group = {
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
@@ -2754,6 +2801,18 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
@@ -2794,12 +2853,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
 
@@ -2872,7 +2925,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_hw_stop(hdev);
 	}
 hid_hw_start_fail:
-hid_parse_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
@@ -2885,6 +2937,9 @@ static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
+	if (!hidpp)
+		return hid_hw_stop(hdev);
+
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-- 
2.9.3
