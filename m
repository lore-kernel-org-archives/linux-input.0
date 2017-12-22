From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 02/14] iio: Add channel for Position
Date: Fri, 22 Dec 2017 17:07:09 +0200
Message-ID: <1513955241-10985-3-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Add new channel type for position on a pad.

These type of analog sensor represents the position of a pen
on a touchpad, and is represented as a voltage, which can be
converted to a position on X and Y axis on the pad.

The channel can then be consumed by a touchscreen driver or
read as-is for a raw indication of the touchpen on a touchpad.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a478740..d2b9e2f 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -190,6 +190,17 @@ Description:
 		but should match other such assignments on device).
 		Units after application of scale and offset are m/s^2.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_position_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_position_y_raw
+KernelVersion:	4.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Position in direction x or y on a pad (may be arbitrarily
+		assigned but should match other such assignments on device).
+		Units after application of scale and offset are millipercents
+		from the pad's size in both directions. Should be calibrated by
+		the consumer.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_raw
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2e8e36f..a4fa49b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_COUNT] = "count",
 	[IIO_INDEX] = "index",
 	[IIO_GRAVITY]  = "gravity",
+	[IIO_POSITION]  = "position",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 4213cdf..35e17da 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -44,6 +44,7 @@ enum iio_chan_type {
 	IIO_COUNT,
 	IIO_INDEX,
 	IIO_GRAVITY,
+	IIO_POSITION,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b61245e..0c2b317 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_GRAVITY] = "gravity",
+	[IIO_POSITION] = "position",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -151,6 +152,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_PH:
 	case IIO_UVINDEX:
 	case IIO_GRAVITY:
+	case IIO_POSITION:
 		break;
 	default:
 		return false;
-- 
2.7.4
