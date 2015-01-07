From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5/8] iio: hid-sensor-prox: Introduce PM
Date: Wed,  7 Jan 2015 10:55:57 -0800
Message-ID: <1420656960-7365-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420656960-7365-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57436 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085AbbAGS5F (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 13:57:05 -0500
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
 drivers/iio/light/hid-sensor-prox.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index db9c60e..91ecc46 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -75,7 +75,6 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 	int report_id = -1;
 	u32 address;
 	int ret_type;
-	s32 poll_value;
 
 	*val = 0;
 	*val2 = 0;
@@ -92,16 +91,8 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		if (report_id >= 0) {
-			poll_value = hid_sensor_read_poll_value(
-					&prox_state->common_attributes);
-			if (poll_value < 0)
-				return -EINVAL;
-
 			hid_sensor_power_state(&prox_state->common_attributes,
 						true);
-
-			msleep_interruptible(poll_value * 2);
-
 			*val = sensor_hub_input_attr_get_raw_value(
 				prox_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PROX, address,
@@ -374,6 +365,7 @@ static struct platform_driver hid_prox_platform_driver = {
 	.id_table = hid_prox_ids,
 	.driver = {
 		.name	= KBUILD_MODNAME,
+		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_prox_probe,
 	.remove		= hid_prox_remove,
-- 
1.9.3

