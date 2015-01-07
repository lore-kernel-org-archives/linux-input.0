From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 8/9] iio: hid-sensor-press: Adjust parameter for attribute read
Date: Tue,  6 Jan 2015 16:58:38 -0800
Message-ID: <1420592328-9942-15-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24890 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755469AbbAGA7o (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2015 19:59:44 -0500
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The new API added a flag for sync/async mode. Added sync mode flag.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/pressure/hid-sensor-press.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 7649286..ac150f0 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -108,7 +108,8 @@ static int press_read_raw(struct iio_dev *indio_dev,
 			*val = sensor_hub_input_attr_get_raw_value(
 				press_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PRESSURE, address,
-				report_id);
+				report_id,
+				SENSOR_HUB_SYNC);
 			hid_sensor_power_state(&press_state->common_attributes,
 						false);
 		} else {
-- 
1.9.1

