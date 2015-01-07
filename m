From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: hid-sensor-hub: Correct documentation
Date: Tue,  6 Jan 2015 16:58:24 -0800
Message-ID: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8970 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbbAGA7j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2015 19:59:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

During changes to the interface, some documentation field comments
were missed. Added missing comments.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 include/linux/hid-sensor-hub.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 51f7cca..4173a8f 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -33,6 +33,8 @@
  * @units:		Measurment unit for this attribute.
  * @unit_expo:		Exponent used in the data.
  * @size:		Size in bytes for data size.
+ * @logical_minimum:	Logical minimum value for this attribute.
+ * @logical_maximum:	Logical maximum value for this attribute.
  */
 struct hid_sensor_hub_attribute_info {
 	u32 usage_id;
@@ -146,6 +148,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 
 /**
 * sensor_hub_input_attr_get_raw_value() - Synchronous read request
+* @hsdev:	Hub device instance.
 * @usage_id:	Attribute usage id of parent physical device as per spec
 * @attr_usage_id:	Attribute usage id as per spec
 * @report_id:	Report id to look for
@@ -160,6 +163,7 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 			u32 attr_usage_id, u32 report_id);
 /**
 * sensor_hub_set_feature() - Feature set request
+* @hsdev:	Hub device instance.
 * @report_id:	Report id to look for
 * @field_index:	Field index inside a report
 * @value:	Value to set
@@ -172,6 +176,7 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 
 /**
 * sensor_hub_get_feature() - Feature get request
+* @hsdev:	Hub device instance.
 * @report_id:	Report id to look for
 * @field_index:	Field index inside a report
 * @value:	Place holder for return value
-- 
1.9.1

