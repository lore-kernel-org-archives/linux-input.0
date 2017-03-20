From: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iio: hid-sensor-attributes: Fix gravity sensor scale value not right issue
Date: Mon, 20 Mar 2017 17:12:54 +0800
Message-ID: <1490001174-897-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Scale value include two parts: unit conversion and exponent conversion.
Add gravity unit convert table to fix gravity sensor scale value not
right issue.

Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index cc2ce2a..2884783 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -38,6 +38,12 @@
 	{HID_USAGE_SENSOR_ACCEL_3D,
 		HID_USAGE_SENSOR_UNITS_G, 9, 806650000},
 
+	{HID_USAGE_SENSOR_GRAVITY_VECTOR, 0, 9, 806650000},
+	{HID_USAGE_SENSOR_GRAVITY_VECTOR,
+		HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD, 1, 0},
+	{HID_USAGE_SENSOR_GRAVITY_VECTOR,
+		HID_USAGE_SENSOR_UNITS_G, 9, 806650000},
+
 	{HID_USAGE_SENSOR_GYRO_3D, 0, 0, 17453293},
 	{HID_USAGE_SENSOR_GYRO_3D,
 		HID_USAGE_SENSOR_UNITS_RADIANS_PER_SECOND, 1, 0},
-- 
1.9.1
