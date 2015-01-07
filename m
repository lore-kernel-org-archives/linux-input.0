From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/4] HID: hid-sensor-hub: Enhance feature report API
Date: Wed,  7 Jan 2015 10:31:45 -0800
Message-ID: <1420655508-6736-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420655508-6736-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420655508-6736-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Some hid sensor feature report can contain more than one reports.
This API can now support receiving multiple values from the feature
report.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/hid/hid-sensor-hub.c   | 16 ++++++++++++++--
 include/linux/hid-sensor-hub.h |  8 +++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 83b6e15..d17aa67 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -218,10 +218,11 @@ done_proc:
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
@@ -233,7 +234,18 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
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
index 0b21c4f..1995bbd 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -203,13 +203,15 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
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
1.9.3
