From: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/3] iio: hid-sensor-rotation: Add "scale" and "offset" properties parse support
Date: Sun,  7 May 2017 18:24:26 +0800
Message-ID: <1494152666-25632-3-git-send-email-hongyan.song@intel.com>
References: <1494152666-25632-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1494152666-25632-1-git-send-email-hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add orientation sensor "scale" and "offset" parse support.
These two properties are needed for exponent data conversion.

Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Xu Even <even.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c   |  6 ++++++
 drivers/iio/orientation/hid-sensor-rotation.c        | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 01e02b9..420f28f 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -62,6 +62,12 @@
 	{HID_USAGE_SENSOR_TIME_TIMESTAMP, 0, 1000000000, 0},
 	{HID_USAGE_SENSOR_TIME_TIMESTAMP, HID_USAGE_SENSOR_UNITS_MILLISECOND,
 		1000000, 0},
+
+	{HID_USAGE_SENSOR_DEVICE_ORIENTATION, 0, 1, 0},
+
+	{HID_USAGE_SENSOR_RELATIVE_ORIENTATION, 0, 1, 0},
+
+	{HID_USAGE_SENSOR_GEOMAGNETIC_ORIENTATION, 0, 1, 0},
 };
 
 static int pow_10(unsigned power)
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 60d3517..e9fa86c 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -31,6 +31,10 @@ struct dev_rot_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info quaternion;
 	u32 sampled_vals[4];
+	int scale_pre_decml;
+	int scale_post_decml;
+	int scale_precision;
+	int value_offset;
 };
 
 /* Channel definitions */
@@ -41,6 +45,8 @@ struct dev_rot_state {
 		.channel2 = IIO_MOD_QUATERNION,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					BIT(IIO_CHAN_INFO_OFFSET) |
+					BIT(IIO_CHAN_INFO_SCALE) |
 					BIT(IIO_CHAN_INFO_HYSTERESIS)
 	}
 };
@@ -80,6 +86,15 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
 		} else
 			ret_type = -EINVAL;
 		break;
+	case IIO_CHAN_INFO_SCALE:
+		vals[0] = rot_state->scale_pre_decml;
+		vals[1] = rot_state->scale_post_decml;
+		return rot_state->scale_precision;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*vals = rot_state->value_offset;
+		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret_type = hid_sensor_read_samp_freq_value(
 			&rot_state->common_attributes, &vals[0], &vals[1]);
@@ -199,6 +214,11 @@ static int dev_rot_parse_report(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "dev_rot: attrib size %d\n",
 				st->quaternion.size);
 
+	st->scale_precision = hid_sensor_format_scale(
+				hsdev->usage,
+				&st->quaternion,
+				&st->scale_pre_decml, &st->scale_post_decml);
+
 	/* Set Sensitivity field ids, when there is no individual modifier */
 	if (st->common_attributes.sensitivity.index < 0) {
 		sensor_hub_input_get_attribute_info(hsdev,
-- 
1.9.1
