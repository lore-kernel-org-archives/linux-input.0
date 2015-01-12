From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1] HID: hid-sensor-hub: Extend API for async reads
Date: Sun, 11 Jan 2015 17:57:06 -0800
Message-ID: <1421027826-25785-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1421027826-25785-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421027826-25785-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add additional flag to read in async mode. In this mode the caller will get
reply via registered callback for capture_sample. Callbacks can be registered
using sensor_hub_register_callback function. The usage id parameter of the
capture_sample can be matched with the usage id of the requested attribute.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/hid/hid-sensor-hub.c                  | 15 ++++++++++++++-
 drivers/iio/accel/hid-sensor-accel-3d.c       |  3 ++-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         |  3 ++-
 drivers/iio/light/hid-sensor-als.c            |  3 ++-
 drivers/iio/light/hid-sensor-prox.c           |  3 ++-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |  3 ++-
 drivers/iio/orientation/hid-sensor-incl-3d.c  |  3 ++-
 drivers/iio/pressure/hid-sensor-press.c       |  3 ++-
 drivers/rtc/rtc-hid-sensor-time.c             |  2 +-
 include/linux/hid-sensor-hub.h                | 19 +++++++++++++------
 10 files changed, 42 insertions(+), 15 deletions(-)

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
diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index d5d9531..0085c2f 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -130,7 +130,8 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 					accel_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_ACCEL_3D, address,
-					report_id);
+					report_id,
+					SENSOR_HUB_SYNC);
 		else {
 			*val = 0;
 			hid_sensor_power_state(&accel_state->common_attributes,
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index a3ea1e8..bdcd105 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -130,7 +130,8 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 					gyro_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_GYRO_3D, address,
-					report_id);
+					report_id,
+					SENSOR_HUB_SYNC);
 		else {
 			*val = 0;
 			hid_sensor_power_state(&gyro_state->common_attributes,
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index a5283d7..321862d 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -109,7 +109,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 					als_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_ALS, address,
-					report_id);
+					report_id,
+					SENSOR_HUB_SYNC);
 			hid_sensor_power_state(&als_state->common_attributes,
 						false);
 		} else {
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index f5a5146..db9c60e 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -105,7 +105,8 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 				prox_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PROX, address,
-				report_id);
+				report_id,
+				SENSOR_HUB_SYNC);
 			hid_sensor_power_state(&prox_state->common_attributes,
 						false);
 		} else {
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 6294575..4d299f3 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -178,7 +178,8 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 				magn_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_COMPASS_3D, address,
-				report_id);
+				report_id,
+				SENSOR_HUB_SYNC);
 		else {
 			*val = 0;
 			hid_sensor_power_state(&magn_state->common_attributes,
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 1ff181b..45bed08 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -132,7 +132,8 @@ static int incl_3d_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 				incl_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_INCLINOMETER_3D, address,
-				report_id);
+				report_id,
+				SENSOR_HUB_SYNC);
 		else {
 			hid_sensor_power_state(&incl_state->common_attributes,
 						false);
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 7649286..ac150f0 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -108,7 +108,8 @@ static int press_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 				press_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PRESSURE, address,
-				report_id);
+				report_id,
+				SENSOR_HUB_SYNC);
 			hid_sensor_power_state(&press_state->common_attributes,
 						false);
 		} else {
diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
index ae7c2ba..af4f85a 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -213,7 +213,7 @@ static int hid_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	/* get a report with all values through requesting one value */
 	sensor_hub_input_attr_get_raw_value(time_state->common_attributes.hsdev,
 			HID_USAGE_SENSOR_TIME, hid_time_addresses[0],
-			time_state->info[0].report_id);
+			time_state->info[0].report_id, SENSOR_HUB_SYNC);
 	/* wait for all values (event) */
 	ret = wait_for_completion_killable_timeout(
 			&time_state->comp_last_time, HZ*6);
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
