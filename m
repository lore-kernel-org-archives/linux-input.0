From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] HID: hid-sensor-hub: Add logical min and max
Date: Wed, 27 Nov 2013 14:19:42 -0800
Message-ID: <1385590783-27604-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15572 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757886Ab3K0WVD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Nov 2013 17:21:03 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Exporting logical minimum and maximum of HID fields as part of the
hid sensor attribute info. This can be used for range checking and
to calculate enumeration base for NAry fields of HID sensor hub.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c   | 20 ++++++++------------
 include/linux/hid-sensor-hub.h |  2 ++
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index a184e19..d87f7cb 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -112,13 +112,15 @@ static int sensor_hub_get_physical_device_count(
 
 static void sensor_hub_fill_attr_info(
 		struct hid_sensor_hub_attribute_info *info,
-		s32 index, s32 report_id, s32 units, s32 unit_expo, s32 size)
+		s32 index, s32 report_id, struct hid_field *field)
 {
 	info->index = index;
 	info->report_id = report_id;
-	info->units = units;
-	info->unit_expo = unit_expo;
-	info->size = size/8;
+	info->units = field->unit;
+	info->unit_expo = field->unit_exponent;
+	info->size = (field->report_size * field->report_count)/8;
+	info->logical_minimum = field->logical_minimum;
+	info->logical_maximum = field->logical_maximum;
 }
 
 static struct hid_sensor_hub_callbacks *sensor_hub_get_callback(
@@ -325,9 +327,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 			if (field->physical == usage_id &&
 				field->logical == attr_usage_id) {
 				sensor_hub_fill_attr_info(info, i, report->id,
-					field->unit, field->unit_exponent,
-					field->report_size *
-							field->report_count);
+							  field);
 				ret = 0;
 			} else {
 				for (j = 0; j < field->maxusage; ++j) {
@@ -336,11 +336,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 					field->usage[j].collection_index ==
 					collection_index) {
 						sensor_hub_fill_attr_info(info,
-							i, report->id,
-							field->unit,
-							field->unit_exponent,
-							field->report_size *
-							field->report_count);
+							  i, report->id, field);
 						ret = 0;
 						break;
 					}
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index a265af2..fd66e45 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -40,6 +40,8 @@ struct hid_sensor_hub_attribute_info {
 	s32 units;
 	s32 unit_expo;
 	s32 size;
+	s32 logical_minimum;
+	s32 logical_maximum;
 };
 
 /**
-- 
1.8.3.2

