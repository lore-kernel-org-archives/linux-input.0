From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 8/8] iio: hid-sensor-press: Introduce PM
Date: Wed,  7 Jan 2015 10:56:00 -0800
Message-ID: <1420656960-7365-9-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420656960-7365-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420656960-7365-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Use common hid sensor iio pm functions. Also the poll time read and
wait is part of power up function of hid sensor iio pm function, so
remove from the client drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iio/pressure/hid-sensor-press.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index ac150f0..7bb8d4c 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -79,7 +79,6 @@ static int press_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
-	s32 poll_value;
 
 	*val = 0;
 	*val2 = 0;
@@ -96,15 +95,8 @@ static int press_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		if (report_id >= 0) {
-			poll_value = hid_sensor_read_poll_value(
-					&press_state->common_attributes);
-			if (poll_value < 0)
-				return -EINVAL;
 			hid_sensor_power_state(&press_state->common_attributes,
 						true);
-
-			msleep_interruptible(poll_value * 2);
-
 			*val = sensor_hub_input_attr_get_raw_value(
 				press_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PRESSURE, address,
@@ -383,6 +375,7 @@ static struct platform_driver hid_press_platform_driver = {
 	.id_table = hid_press_ids,
 	.driver = {
 		.name	= KBUILD_MODNAME,
+		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_press_probe,
 	.remove		= hid_press_remove,
-- 
1.9.3
