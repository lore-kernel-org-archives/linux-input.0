From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/2] hid: hid-sensor-hub: Add selector api
Date: Thu, 23 Jan 2014 18:50:21 -0800
Message-ID: <1390531822-7640-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

In some report descriptors, they leave holes in the selectors. In
this case if we use hardcoded selector values, this will result
in invalid values. For example, if there is selectors defined for
Power State from OFF to D0 to D3. We can't use indexes of these states
if some states are not implemented or not present in the report decriptors.
In this case, we need to get the indexes from report descriptors.

One API is added to get the index of a selector. This API will
search for usage id in the field usage list and return the index.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/hid/hid-sensor-hub.c   | 22 ++++++++++++++++++++++
 include/linux/hid-sensor-hub.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 46f4480..ad2b869 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -291,6 +291,28 @@ err_free:
 }
 EXPORT_SYMBOL_GPL(sensor_hub_input_attr_get_raw_value);
 
+int hid_sensor_get_usage_index(struct hid_sensor_hub_device *hsdev,
+				u32 report_id, int field_index, u32 usage_id)
+{
+	struct hid_report *report;
+	struct hid_field *field;
+	int i;
+
+	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
+	if (!report || (field_index >= report->maxfield))
+		goto done_proc;
+
+	field = report->field[field_index];
+	for (i = 0; i < field->maxusage; ++i) {
+		if (field->usage[i].hid == usage_id)
+			return field->usage[i].usage_index;
+	}
+
+done_proc:
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(hid_sensor_get_usage_index);
+
 int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 				u8 type,
 				u32 usage_id,
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index b914ca3..205eba0 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -218,4 +218,7 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
 					int *val1, int *val2);
 
+int hid_sensor_get_usage_index(struct hid_sensor_hub_device *hsdev,
+				u32 report_id, int field_index, u32 usage_id);
+
 #endif
-- 
1.8.3.2
