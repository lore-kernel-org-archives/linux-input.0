From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: sensor-hub: Fix packing of result buffer for feature report
Date: Thu, 27 Oct 2016 16:49:20 -0700
Message-ID: <1477612160-23621-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59908 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033390AbcJ0Xtj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 19:49:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, jic23@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When report count is more than one and report size is not 4 bytes, then we
need some packing into result buffer from the caller of function
sensor_hub_get_feature.
By default the value extracted from a field is 4 bytes from hid core
(using hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT)), even
if report size if less than 4 byte. So when we copy data to user buffer in
sensor_hub_get_feature, we need to only copy report size bytes even
when report count is more than 1. This is
not an issue for most of the sensor hub fields as report count will be 1
where we already copy only report size bytes, but some string fields
like description, it is a problem as the report count will be more than 1.
For example:
    Field(6)
      Physical(Sensor.OtherCustom)
      Application(Sensor.Sensor)
      Usage(11)
        Sensor.0306
        Sensor.0306
        Sensor.0306
        Sensor.0306
        Sensor.0306
        Sensor.0306
        Sensor.0306
        Sensor.0306
        Sensor.0306
        Sensor.0306
        Sensor.0306
      Report Size(16)
      Report Count(11)

Here since the report size is 2 bytes, we will have 2 additional bytes of
0s copied into user buffer, if we directly copy to user buffer from
report->field[]->value

This change will copy report size bytes into the buffer of caller for each
usage report->field[]->value. So for example without this change, the
data displayed for a custom sensor field "sensor-model":

76 00 101 00 110 00 111 00 118 00 111
(truncated to report count of 11)

With change

76 101 110 111 118 111 32 89 111 103 97
("Lenovo Yoga" in ASCII )

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 658a607..c5c3d61 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -251,6 +251,9 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
 	int report_size;
 	int ret = 0;
+	u8 *val_ptr;
+	int buffer_index = 0;
+	int i;
 
 	mutex_lock(&data->mutex);
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
@@ -271,7 +274,17 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 		goto done_proc;
 	}
 	ret = min(report_size, buffer_size);
-	memcpy(buffer, report->field[field_index]->value, ret);
+
+	val_ptr = (u8 *)report->field[field_index]->value;
+	for (i = 0; i < report->field[field_index]->report_count; ++i) {
+		if (buffer_index >= ret)
+			break;
+
+		memcpy(&((u8 *)buffer)[buffer_index], val_ptr,
+		       report->field[field_index]->report_size / 8);
+		val_ptr += sizeof(__s32);
+		buffer_index += (report->field[field_index]->report_size / 8);
+	}
 
 done_proc:
 	mutex_unlock(&data->mutex);
-- 
2.7.4

