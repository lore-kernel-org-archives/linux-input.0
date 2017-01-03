From: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] iio: Add support for linear accel
Date: Tue,  3 Jan 2017 23:13:49 +0800
Message-ID: <1483456430-6980-1-git-send-email-hongyan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add new channel types support for linear accel sensor.

Linear acceleration differs from a standard accelerometor,
its value depends on standard accel sensor and gravity sensor.
Conceptually, this three sensors have following relationship:
linear acceleration = acceleration - acceleration due to gravity

At rest, standard accelerometer displays 1g due to earth’s
gravitational pull while a liner accelerometer will show 0g.

More information can be found in:
http://www.usb.org/developers/hidpage/HUTRR59_-_Usages_for_Wearables.pdf

Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 60b7406..8091f3d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -170,6 +170,16 @@ Description:
 		Has all of the equivalent parameters as per voltageY. Units
 		after application of scale and offset are m/s^2.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_z_raw
+KernelVersion:	4.11
+Contact:	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+Description:
+		Linear Acceleration in direction x, y or z (may be arbitrarily assigned
+		but should match other such assignments on device).
+		Has all of the equivalent parameters as per voltageY. Units
+		after application of scale and offset are m/s^2.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_y_raw
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 72fc96a..da78c26 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -82,6 +82,7 @@ struct bus_type iio_bus_type = {
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
 	[IIO_GRAVITY]  = "gravity",
+	[IIO_LINEAR_ACCEL] = "linearaccel",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index d3f7ba7..d6df101 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -41,6 +41,7 @@ enum iio_chan_type {
 	IIO_UVINDEX,
 	IIO_ELECTRICALCONDUCTIVITY,
 	IIO_GRAVITY,
+	IIO_LINEAR_ACCEL,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b61245e..116644a 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -58,6 +58,7 @@
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_GRAVITY] = "gravity",
+	[IIO_LINEAR_ACCEL] = "linearaccel",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -151,6 +152,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_PH:
 	case IIO_UVINDEX:
 	case IIO_GRAVITY:
+	case IIO_LINEAR_ACCEL:
 		break;
 	default:
 		return false;
-- 
1.9.1
