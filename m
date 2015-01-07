From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/8] iio: hid-sensor-accel-3d: Introduce PM
Date: Wed,  7 Jan 2015 10:55:54 -0800
Message-ID: <1420656960-7365-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420656960-7365-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40338 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750AbbAGS5E (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 13:57:04 -0500
In-Reply-To: <1420656960-7365-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Use common hid sensor iio pm functions. Also the poll time read and
wait is part of power up function of hid sensor iio pm function, so
remove from the client drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 0085c2f..2b4fad6 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -111,19 +111,12 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
-	s32 poll_value;
 
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
 	case 0:
-		poll_value = hid_sensor_read_poll_value(
-					&accel_state->common_attributes);
-		if (poll_value < 0)
-			return -EINVAL;
-
 		hid_sensor_power_state(&accel_state->common_attributes, true);
-		msleep_interruptible(poll_value * 2);
 		report_id = accel_state->accel[chan->scan_index].report_id;
 		address = accel_3d_addresses[chan->scan_index];
 		if (report_id >= 0)
@@ -420,6 +413,7 @@ static struct platform_driver hid_accel_3d_platform_driver = {
 	.id_table = hid_accel_3d_ids,
 	.driver = {
 		.name	= KBUILD_MODNAME,
+		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_accel_3d_probe,
 	.remove		= hid_accel_3d_remove,
-- 
1.9.3

