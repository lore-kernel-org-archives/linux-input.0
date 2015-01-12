From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 2/2] HID: hid-sensor-hub: Enhance feature report set API
Date: Sun, 11 Jan 2015 17:55:14 -0800
Message-ID: <1421027714-25726-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1421027714-25726-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60026 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbbALB4P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jan 2015 20:56:15 -0500
In-Reply-To: <1421027714-25726-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jic23@kernel.org, jkosina@suse.cz
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Current API only allows setting one offset in the field. This API
is extended to set multiple offsets in the field report.
Also update parameters in the users of this API.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c                       | 22 ++++++++++++++++++++--
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 11 +++++------
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  9 +++++----
 include/linux/hid-sensor-hub.h                     |  5 +++--
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index d17aa67..8bed109 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -194,10 +194,14 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
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
@@ -206,7 +210,21 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
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
 
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index e1435e9..e81f434 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -212,9 +212,8 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 		else
 			value = 0;
 	}
-	ret = sensor_hub_set_feature(st->hsdev,
-		st->poll.report_id,
-		st->poll.index, value);
+	ret = sensor_hub_set_feature(st->hsdev, st->poll.report_id,
+				     st->poll.index, sizeof(value), &value);
 	if (ret < 0 || value < 0)
 		ret = -EINVAL;
 
@@ -254,9 +253,9 @@ int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
 	value = convert_to_vtf_format(st->sensitivity.size,
 				st->sensitivity.unit_expo,
 				val1, val2);
-	ret = sensor_hub_set_feature(st->hsdev,
-		st->sensitivity.report_id,
-		st->sensitivity.index, value);
+	ret = sensor_hub_set_feature(st->hsdev, st->sensitivity.report_id,
+				     st->sensitivity.index, sizeof(value),
+				     &value);
 	if (ret < 0 || value < 0)
 		ret = -EINVAL;
 
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index ef0c495..910e82a 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -64,15 +64,16 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 	if (state_val >= 0) {
 		state_val += st->power_state.logical_minimum;
 		sensor_hub_set_feature(st->hsdev, st->power_state.report_id,
-					st->power_state.index,
-					(s32)state_val);
+				       st->power_state.index, sizeof(state_val),
+				       &state_val);
 	}
 
 	if (report_val >= 0) {
 		report_val += st->report_state.logical_minimum;
 		sensor_hub_set_feature(st->hsdev, st->report_state.report_id,
-					st->report_state.index,
-					(s32)report_val);
+				       st->report_state.index,
+				       sizeof(report_val),
+				       &report_val);
 	}
 
 	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 1995bbd..a51c768 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -190,13 +190,14 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
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
1.9.3

