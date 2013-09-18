From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/3] IIO: call sensor hub open close function
Date: Wed, 18 Sep 2013 10:13:18 -0700
Message-ID: <1379524399-16995-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379524399-16995-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Call hid_sensor_hub_device_open when user space opens device and call
hid_sensor_hub_device_close when device is closed. This helps in
saving power.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 87419c4..b6e77e0 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -34,6 +34,12 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
 	int state_val;
 
+	if (state) {
+		if (sensor_hub_device_open(st->hsdev))
+			return -EIO;
+	} else
+		sensor_hub_device_close(st->hsdev);
+
 	state_val = state ? 1 : 0;
 	if (IS_ENABLED(CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS))
 		++state_val;
-- 
1.8.3.1
