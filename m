From: Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH v2 2/3] iio: hid-sensor-rotation: Add geomagnetic orientation sensor hid support.
Date: Sun,  7 May 2017 18:24:25 +0800
Message-ID: <1494152666-25632-2-git-send-email-hongyan.song@intel.com>
References: <1494152666-25632-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:62260 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756726AbdEGWXY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 7 May 2017 18:23:24 -0400
In-Reply-To: <1494152666-25632-1-git-send-email-hongyan.song@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com, Song Hongyan <hongyan.song@intel.com>

Geomagnetic orientation(AM) sensor is one kind of orientation 6dof sensor.
It gives the device rotation in respect to the earth center and the
magnetic north. The sensor is implemented through use of an accelerometer
and magnetometer do not use gyroscope. It is a standard HID sensor.

More information can be found in:
http://www.usb.org/developers/hidpage/HUTRR59_-_Usages_for_Wearables.pdf

Geomagnetic orientation(AM) sensor and dev rotation sensor have same
channel and share channel usage id. So the most of the code for relative
orientation sensor can be reused.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 7 +++++++
 include/linux/hid-sensor-ids.h                | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 4d953c2..60d3517 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -241,6 +241,9 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 	case HID_USAGE_SENSOR_RELATIVE_ORIENTATION:
 		name = "relative_orientation";
 		break;
+	case HID_USAGE_SENSOR_GEOMAGNETIC_ORIENTATION:
+		name = "geomagnetic_orientation";
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -339,6 +342,10 @@ static int hid_dev_rot_remove(struct platform_device *pdev)
 		/* Relative orientation(AG) sensor */
 		.name = "HID-SENSOR-20008e",
 	},
+	{
+		/* Geomagnetic orientation(AM) sensor */
+		.name = "HID-SENSOR-2000c1",
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, hid_dev_rot_ids);
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index b61b985..4fc47e5 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -83,6 +83,7 @@
 
 #define HID_USAGE_SENSOR_DEVICE_ORIENTATION			0x20008A
 #define HID_USAGE_SENSOR_RELATIVE_ORIENTATION			0x20008E
+#define HID_USAGE_SENSOR_GEOMAGNETIC_ORIENTATION		0x2000C1
 #define HID_USAGE_SENSOR_ORIENT_ROTATION_MATRIX			0x200482
 #define HID_USAGE_SENSOR_ORIENT_QUATERNION			0x200483
 #define HID_USAGE_SENSOR_ORIENT_MAGN_FLUX			0x200484
-- 
1.9.1

