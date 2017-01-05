From: Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH v2 2/2] iio: Add linear accel sensor hid support
Date: Thu,  5 Jan 2017 19:03:04 +0800
Message-ID: <1483614184-1038-2-git-send-email-hongyan.song@intel.com>
References: <1483614184-1038-1-git-send-email-hongyan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:64993 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754625AbdAECkg (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 4 Jan 2017 21:40:36 -0500
In-Reply-To: <1483614184-1038-1-git-send-email-hongyan.song@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com, Song Hongyan <hongyan.song@intel.com>

Linear acceleration is a soft sensor it differs from a standard
accel sensor, it provides a three-dimensional vector representing
acceleration along each device axis, excluding gravity.
The sensor data is derives from standard accelerometer device
by filtering out the acceleration which is caused by the force
of Earth’s gravity.

The value can be used to perform gesture detection, it can also
serve as input to an inertial navigation system, which uses
dead reckoning.

More information can be found in:
http://www.usb.org/developers/hidpage/HUTRR59_-_Usages_for_Wearables.pdf

Linear accel sensor, gravity sensor and accelerometer have similar
channels and share channel usage ids. So the most of the code for
accel_3d can be reused.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
changes: unify name not use underline as separator.

 drivers/iio/accel/hid-sensor-accel-3d.c | 42 +++++++++++++++++++++++++++++++++
 include/linux/hid-sensor-ids.h          |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 9edd574..8829dad 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -91,6 +91,41 @@ struct accel_3d_state {
 };
 
 /* Channel definitions */
+static const struct iio_chan_spec linearaccel_3d_channels[] = {
+	{
+		.type = IIO_LINEARACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.scan_index = CHANNEL_SCAN_INDEX_X,
+	}, {
+		.type = IIO_LINEARACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.scan_index = CHANNEL_SCAN_INDEX_Y,
+	}, {
+		.type = IIO_LINEARACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.scan_index = CHANNEL_SCAN_INDEX_Z,
+	}
+};
+
+/* Channel definitions */
 static const struct iio_chan_spec gravity_channels[] = {
 	{
 		.type = IIO_GRAVITY,
@@ -354,6 +389,10 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		name = "accel_3d";
 		channel_spec = accel_3d_channels;
 		channel_size = sizeof(accel_3d_channels);
+	} else if (hsdev->usage == HID_USAGE_SENSOR_LINEARACCEL_3D) {
+		name = "linearaccel_3d";
+		channel_spec = linearaccel_3d_channels;
+		channel_size = sizeof(linearaccel_3d_channels);
 	} else {
 		name = "gravity";
 		channel_spec = gravity_channels;
@@ -452,6 +491,9 @@ static int hid_accel_3d_remove(struct platform_device *pdev)
 	{	/* gravity sensor */
 		.name = "HID-SENSOR-20007b",
 	},
+	{	/* linear_accel sensor */
+		.name = "HID-SENSOR-20007c",
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, hid_accel_3d_ids);
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index b6778fd2..bab8375 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -55,6 +55,9 @@
 /* Gravity vector */
 #define HID_USAGE_SENSOR_GRAVITY_VECTOR				0x20007B
 
+/* linear accel */
+#define HID_USAGE_SENSOR_LINEARACCEL_3D			0x20007C
+
 /* ORIENTATION: Compass 3D: (200083) */
 #define HID_USAGE_SENSOR_COMPASS_3D				0x200083
 #define HID_USAGE_SENSOR_DATA_ORIENTATION			0x200470
-- 
1.9.1

