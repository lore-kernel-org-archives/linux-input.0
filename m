From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/9] HID: hid-sensor-hub: Extend API for async reads
Date: Wed,  7 Jan 2015 10:47:55 -0800
Message-ID: <1420656483-7093-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420656483-7093-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add additional flag to read in async mode. In this mode the caller
need to register for events and match attribute usage id for result.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/hid/hid-sensor-hub.c   | 15 ++++++++++++++-
 include/linux/hid-sensor-hub.h | 19 +++++++++++++------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 8bed109..7403b25 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -275,13 +275,26 @@ EXPORT_SYMBOL_GPL(sensor_hub_get_feature);
 
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
-					u32 attr_usage_id, u32 report_id)
+					u32 attr_usage_id, u32 report_id,
+					enum sensor_hub_read_flags flag)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
 	unsigned long flags;
 	struct hid_report *report;
 	int ret_val = 0;
 
+	if (flag == SENSOR_HUB_ASYNC) {
+		report = sensor_hub_report(report_id, hsdev->hdev,
+					   HID_INPUT_REPORT);
+		if (!report)
+			return -EINVAL;
+
+		mutex_lock(&data->mutex);
+		hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
+		mutex_unlock(&data->mutex);
+		return 0;
+	}
+
 	mutex_lock(&hsdev->mutex);
 	memset(&hsdev->pending, 0, sizeof(hsdev->pending));
 	init_completion(&hsdev->pending.ready);
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index a51c768..d48e91f 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -171,20 +171,27 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 			struct hid_sensor_hub_attribute_info *info);
 
 /**
-* sensor_hub_input_attr_get_raw_value() - Synchronous read request
+* sensor_hub_input_attr_get_raw_value() - Attribute read request
 * @hsdev:	Hub device instance.
 * @usage_id:	Attribute usage id of parent physical device as per spec
 * @attr_usage_id:	Attribute usage id as per spec
 * @report_id:	Report id to look for
+* @flag:	Synchronour or asynchronous read
 *
-* Issues a synchronous read request for an input attribute. Returns
-* data upto 32 bits. Since client can get events, so this call should
-* not be used for data paths, this will impact performance.
+* Issues a synchronous or asynchronous read request for an input attribute.
+* Returns data upto 32 bits.
 */
 
+enum sensor_hub_read_flags {
+	SENSOR_HUB_SYNC,
+	SENSOR_HUB_ASYNC,
+};
+
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
-			u32 usage_id,
-			u32 attr_usage_id, u32 report_id);
+					u32 usage_id,
+					u32 attr_usage_id, u32 report_id,
+					enum sensor_hub_read_flags flag
+);
 /**
 * sensor_hub_set_feature() - Feature set request
 * @hsdev:	Hub device instance.
-- 
1.9.3
