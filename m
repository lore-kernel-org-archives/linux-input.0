From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/8] iio: hid-sensor-gyro-3d: Introduce PM
Date: Tue,  6 Jan 2015 16:58:42 -0800
Message-ID: <1420592328-9942-19-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13667 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbbAGA7o (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2015 19:59:44 -0500
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Use common hid sensor iio pm functions. Also the poll time read and
wait is part of power up function of hid sensor iio pm function, so
remove from the client drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index bdcd105..b5883b6 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -111,19 +111,12 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
-	s32 poll_value;
 
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
 	case 0:
-		poll_value = hid_sensor_read_poll_value(
-					&gyro_state->common_attributes);
-		if (poll_value < 0)
-			return -EINVAL;
-
 		hid_sensor_power_state(&gyro_state->common_attributes, true);
-		msleep_interruptible(poll_value * 2);
 		report_id = gyro_state->gyro[chan->scan_index].report_id;
 		address = gyro_3d_addresses[chan->scan_index];
 		if (report_id >= 0)
@@ -417,6 +410,7 @@ static struct platform_driver hid_gyro_3d_platform_driver = {
 	.id_table = hid_gyro_3d_ids,
 	.driver = {
 		.name	= KBUILD_MODNAME,
+		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_gyro_3d_probe,
 	.remove		= hid_gyro_3d_remove,
-- 
1.9.1

