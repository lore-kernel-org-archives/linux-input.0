From: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] iio: hid-sensor-rotation: Add geomagnetic orientation sensor hid support.
Date: Fri,  5 May 2017 21:39:24 +0800
Message-ID: <1493991565-17947-2-git-send-email-hongyan.song@intel.com>
References: <1493991565-17947-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493991565-17947-1-git-send-email-hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Geomagnetic orientation(AM) sensor is one kind of orientation 6dof sensor.
It gives the device rotation in respect to the earth center and the
magnetic north. The sensor is implemented through use of an accelerometer
and magnetometer do not use gyroscope. It is a standard HID sensor.

More information can be found in:
http://www.usb.org/developers/hidpage/HUTRR59_-_Usages_for_Wearables.pdf

Geomagnetic orientation(AM) sensor and dev rotation sensor have same
channel and share channel usage id. So the most of the code for relative
orientation sensor can be reused.

Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Xu Even <even.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 6 ++++++
 include/linux/hid-sensor-ids.h                | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 5f07a5a..93ec5e8 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -238,6 +238,8 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 		name = "dev_rotation";
 	else if (hsdev->usage == HID_USAGE_SENSOR_RELATIVE_ORIENTATION)
 		name = "relative_orientation";
+	else if (hsdev->usage == HID_USAGE_SENSOR_GEOMAGNETIC_ORIENTATION)
+		name = "geomagnetic_orientation";
 
 	ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
 				&rot_state->common_attributes);
@@ -333,6 +335,10 @@ static int hid_dev_rot_remove(struct platform_device *pdev)
 		/* Relatve orientation(AG) sensor */
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
