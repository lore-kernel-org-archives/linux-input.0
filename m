From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/9] iio: hid-sensor-accel-3d: Adjust parameter for attribute read
Date: Wed,  7 Jan 2015 10:47:56 -0800
Message-ID: <1420656483-7093-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35637 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbbAGSs5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 13:48:57 -0500
In-Reply-To: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org, a.zummo@towertech.it
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, holler@ahsoftware.de, rtc-linux@googlegroups.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The new API added a flag for sync/async mode. Added sync mode flag.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index d5d9531..0085c2f 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -130,7 +130,8 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 					accel_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_ACCEL_3D, address,
-					report_id);
+					report_id,
+					SENSOR_HUB_SYNC);
 		else {
 			*val = 0;
 			hid_sensor_power_state(&accel_state->common_attributes,
-- 
1.9.3

