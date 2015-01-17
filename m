From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/2] HID: hid-sensor-hub: Enhance get feature report API
Date: Fri, 16 Jan 2015 16:39:24 -0800
Message-ID: <1421455165-3944-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1421455165-3944-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421455165-3944-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Some hid sensor feature report can contain more than one reports.
This API can now support receiving multiple values from the feature
report.
Also update the parameters in the users of this API.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/hid/hid-sensor-hub.c                           | 15 +++++++++++++--
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 13 +++++++------
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c    |  4 ++--
 include/linux/hid-sensor-hub.h                         |  8 +++++---
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index e54ce10..4d22bd4 100644
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
@@ -247,7 +248,17 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	}
 	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
 	hid_hw_wait(hsdev->hdev);
-	*value = report->field[field_index]->value[0];
+
+	/* calculate number of bytes required to read this field */
+	report_size = DIV_ROUND_UP(report->field[field_index]->report_size,
+				   8) *
+				   report->field[field_index]->report_count;
+	if (!report_size) {
+		ret = -EINVAL;
+		goto done_proc;
+	}
+	ret = min(report_size, buffer_size);
+	memcpy(buffer, report->field[field_index]->value, ret);
 
 done_proc:
 	mutex_unlock(&data->mutex);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 25b01e1..e1435e9 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -153,8 +153,8 @@ s32 hid_sensor_read_poll_value(struct hid_sensor_common *st)
 	int ret;
 
 	ret = sensor_hub_get_feature(st->hsdev,
-		st->poll.report_id,
-		st->poll.index, &value);
+				     st->poll.report_id,
+				     st->poll.index, sizeof(value), &value);
 
 	if (ret < 0 || value < 0) {
 		return -EINVAL;
@@ -174,8 +174,8 @@ int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
 	int ret;
 
 	ret = sensor_hub_get_feature(st->hsdev,
-		st->poll.report_id,
-		st->poll.index, &value);
+				     st->poll.report_id,
+				     st->poll.index, sizeof(value), &value);
 	if (ret < 0 || value < 0) {
 		*val1 = *val2 = 0;
 		return -EINVAL;
@@ -229,8 +229,9 @@ int hid_sensor_read_raw_hyst_value(struct hid_sensor_common *st,
 	int ret;
 
 	ret = sensor_hub_get_feature(st->hsdev,
-		st->sensitivity.report_id,
-		st->sensitivity.index, &value);
+				     st->sensitivity.report_id,
+				     st->sensitivity.index, sizeof(value),
+				     &value);
 	if (ret < 0 || value < 0) {
 		*val1 = *val2 = 0;
 		return -EINVAL;
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 92068cd..ef0c495 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -76,8 +76,8 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 	}
 
 	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
-					st->power_state.index,
-					&state_val);
+			       st->power_state.index,
+			       sizeof(state_val), &state_val);
 	return 0;
 }
 EXPORT_SYMBOL(hid_sensor_power_state);
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
