From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/4] iio: hid_sensor_hub: update parameters to set feature report
Date: Wed,  7 Jan 2015 10:31:48 -0800
Message-ID: <1420655508-6736-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420655508-6736-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31015 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672AbbAGScp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 13:32:45 -0500
In-Reply-To: <1420655508-6736-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The new sensor_hub_set_feature can set multiple values, this
resulted in the change in API. Update the API usage here.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 11 +++++------
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c    |  9 +++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index e1435e9..e81f434 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -212,9 +212,8 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 		else
 			value = 0;
 	}
-	ret = sensor_hub_set_feature(st->hsdev,
-		st->poll.report_id,
-		st->poll.index, value);
+	ret = sensor_hub_set_feature(st->hsdev, st->poll.report_id,
+				     st->poll.index, sizeof(value), &value);
 	if (ret < 0 || value < 0)
 		ret = -EINVAL;
 
@@ -254,9 +253,9 @@ int hid_sensor_write_raw_hyst_value(struct hid_sensor_common *st,
 	value = convert_to_vtf_format(st->sensitivity.size,
 				st->sensitivity.unit_expo,
 				val1, val2);
-	ret = sensor_hub_set_feature(st->hsdev,
-		st->sensitivity.report_id,
-		st->sensitivity.index, value);
+	ret = sensor_hub_set_feature(st->hsdev, st->sensitivity.report_id,
+				     st->sensitivity.index, sizeof(value),
+				     &value);
 	if (ret < 0 || value < 0)
 		ret = -EINVAL;
 
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index ef0c495..910e82a 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -64,15 +64,16 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 	if (state_val >= 0) {
 		state_val += st->power_state.logical_minimum;
 		sensor_hub_set_feature(st->hsdev, st->power_state.report_id,
-					st->power_state.index,
-					(s32)state_val);
+				       st->power_state.index, sizeof(state_val),
+				       &state_val);
 	}
 
 	if (report_val >= 0) {
 		report_val += st->report_state.logical_minimum;
 		sensor_hub_set_feature(st->hsdev, st->report_state.report_id,
-					st->report_state.index,
-					(s32)report_val);
+				       st->report_state.index,
+				       sizeof(report_val),
+				       &report_val);
 	}
 
 	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
-- 
1.9.3

