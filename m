From: Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH] iio: hid-sensor-trigger: Change get poll value function order to avoid sensor properties losing after resume from S3
Date: Wed, 22 Feb 2017 17:17:38 +0800
Message-ID: <1487755058-31310-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13460 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753114AbdBVAzF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 19:55:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com, Song Hongyan <hongyan.song@intel.com>

In function _hid_sensor_power_state(), when hid_sensor_read_poll_value()
is called, sensor's all properties will be updated by the value from
sensor hardware/firmware.
In some implementation, sensor hardware/firmware will do a power cycle
during S3. In this case, after resume, once hid_sensor_read_poll_value()
is called, sensor's all properties which are kept by driver during S3
will be changed to default value.
But instead, if a set feature function is called first, sensor
hardware/firmware will be recovered to the last status. So change the
sensor_hub_set_feature() calling order to behind of set feature function
to avoid sensor properties lose.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index a3cce3a..ecf592d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -51,8 +51,6 @@ static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 			st->report_state.report_id,
 			st->report_state.index,
 			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM);
-
-		poll_value = hid_sensor_read_poll_value(st);
 	} else {
 		int val;
 
@@ -89,7 +87,9 @@ static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
 			       st->power_state.index,
 			       sizeof(state_val), &state_val);
-	if (state && poll_value)
+	if (state)
+		poll_value = hid_sensor_read_poll_value(st);
+	if (poll_value > 0)
 		msleep_interruptible(poll_value * 2);
 
 	return 0;
-- 
1.9.1

