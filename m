From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/9] HID: hid-sensor-hub: Extend API for async reads
Date: Tue,  6 Jan 2015 16:58:31 -0800
Message-ID: <1420592328-9942-8-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13667 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754248AbbAGA7m (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2015 19:59:42 -0500
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Add additional flag to read in async mode. In this mode the caller
need to register for events and match attribute usage id for result.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c   | 15 ++++++++++++++-
 include/linux/hid-sensor-hub.h | 19 +++++++++++++------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 8d177f0..84290e5 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -269,13 +269,26 @@ EXPORT_SYMBOL_GPL(sensor_hub_get_feature);
 
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
1.9.1

