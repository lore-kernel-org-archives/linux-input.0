From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 5/9] iio: hid-sensor-prox: Adjust parameter for attribute read
Date: Wed,  7 Jan 2015 10:47:59 -0800
Message-ID: <1420656483-7093-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420656483-7093-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The new API added a flag for sync/async mode. Added sync mode flag.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iio/light/hid-sensor-prox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
1.9.3
