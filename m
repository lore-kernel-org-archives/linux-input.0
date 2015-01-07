From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 9/9] drivers/rtc/rtc-hid-sensor-time.c: Adjust parameter for attribute read
Date: Tue,  6 Jan 2015 16:58:39 -0800
Message-ID: <1420592328-9942-16-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13667 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755691AbbAGA7o (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2015 19:59:44 -0500
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The new API added a flag for sync/async mode. Added sync mode flag.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/rtc/rtc-hid-sensor-time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
index ae7c2ba..af4f85a 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -213,7 +213,7 @@ static int hid_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	/* get a report with all values through requesting one value */
 	sensor_hub_input_attr_get_raw_value(time_state->common_attributes.hsdev,
 			HID_USAGE_SENSOR_TIME, hid_time_addresses[0],
-			time_state->info[0].report_id);
+			time_state->info[0].report_id, SENSOR_HUB_SYNC);
 	/* wait for all values (event) */
 	ret = wait_for_completion_killable_timeout(
 			&time_state->comp_last_time, HZ*6);
-- 
1.9.1

