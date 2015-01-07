From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/4] HID: hid-sensor-hub: Enhance feature report API
Date: Tue,  6 Jan 2015 16:58:26 -0800
Message-ID: <1420592328-9942-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50780 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539AbbAGA7l (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2015 19:59:41 -0500
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Some hid sensor feature report can contain more than one reports.
This API can now support receiving multiple values from the feature
report.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c   | 16 ++++++++++++++--
 include/linux/hid-sensor-hub.h |  8 +++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index e54ce10..0ad5813 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -232,10 +232,11 @@ done_proc:
 EXPORT_SYMBOL_GPL(sensor_hub_set_feature);
 
 int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
-				u32 field_index, s32 *value)
+			   u32 field_index, int buffer_size, void *buffer)
 {
 	struct hid_report *report;
 	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
+	int report_size;
 	int ret = 0;
 
 	mutex_lock(&data->mutex);
@@ -247,7 +248,18 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	}
 	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
 	hid_hw_wait(hsdev->hdev);
-	*value = report->field[field_index]->value[0];
+
+	/* calculate number of bytes required to read this field */
+	report_size = report->field[field_index]->report_size / 8;
+	if (report->field[field_index]->report_size % 8)
+		++report_size;
+	report_size *= report->field[field_index]->report_count;
+	if (!report_size) {
+		ret = -EINVAL;
+		goto done_proc;
+	}
+	ret = min(report_size, buffer_size);
+	memcpy(buffer, report->field[field_index]->value, ret);
 
 done_proc:
 	mutex_unlock(&data->mutex);
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 4173a8f..dfdf6ef 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -179,13 +179,15 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 * @hsdev:	Hub device instance.
 * @report_id:	Report id to look for
 * @field_index:	Field index inside a report
-* @value:	Place holder for return value
+* @buffer_size:	size of the buffer
+* @buffer:	buffer to copy output
 *
 * Used to get a field in feature report. For example this can get polling
-* interval, sensitivity, activate/deactivate state.
+* interval, sensitivity, activate/deactivate state. On success it returns
+* number of bytes copied to buffer. On failure, it returns value < 0.
 */
 int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
-			u32 field_index, s32 *value);
+			   u32 field_index, int buffer_size, void *buffer);
 
 /* hid-sensor-attributes */
 
-- 
1.9.1

