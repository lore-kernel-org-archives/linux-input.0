From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] HID: hid-sensor-hub: Enhance feature report set API
Date: Tue,  6 Jan 2015 16:58:28 -0800
Message-ID: <1420592328-9942-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50780 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592AbbAGA7l (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2015 19:59:41 -0500
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Current API only allows setting one offset in the field. This API
is extended to set multiple offsets in the field report.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c   | 22 ++++++++++++++++++++--
 include/linux/hid-sensor-hub.h |  5 +++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 0ad5813..8e77e93c 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -208,10 +208,14 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 EXPORT_SYMBOL_GPL(sensor_hub_remove_callback);
 
 int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
-				u32 field_index, s32 value)
+			   u32 field_index, int buffer_size, void *buffer)
 {
 	struct hid_report *report;
 	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
+	__s32 *buf32 = (__s32 *)buffer;
+	int i = 0;
+	int remaining_bytes;
+	__s32 value;
 	int ret = 0;
 
 	mutex_lock(&data->mutex);
@@ -220,7 +224,21 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 		ret = -EINVAL;
 		goto done_proc;
 	}
-	hid_set_field(report->field[field_index], 0, value);
+
+	remaining_bytes = do_div(buffer_size, sizeof(__s32));
+	if (buffer_size) {
+		for (i = 0; i < buffer_size; ++i) {
+			hid_set_field(report->field[field_index], i,
+				      cpu_to_le32(*buf32));
+			++buf32;
+		}
+	}
+	if (remaining_bytes) {
+		value = 0;
+		memcpy(&value, (u8 *)buf32, remaining_bytes);
+		hid_set_field(report->field[field_index], i,
+			      cpu_to_le32(value));
+	}
 	hid_hw_request(hsdev->hdev, report, HID_REQ_SET_REPORT);
 	hid_hw_wait(hsdev->hdev);
 
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index dfdf6ef..e899c67 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -166,13 +166,14 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 * @hsdev:	Hub device instance.
 * @report_id:	Report id to look for
 * @field_index:	Field index inside a report
-* @value:	Value to set
+* @buffer_size: size of the buffer
+* @buffer:	buffer to use in the feature set
 *
 * Used to set a field in feature report. For example this can set polling
 * interval, sensitivity, activate/deactivate state.
 */
 int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
-			u32 field_index, s32 value);
+			   u32 field_index, int buffer_size, void *buffer);
 
 /**
 * sensor_hub_get_feature() - Feature get request
-- 
1.9.1

