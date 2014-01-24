From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] iio: hid-sensor-hub: Remove hard coded indexes
Date: Thu, 23 Jan 2014 18:50:22 -0800
Message-ID: <1390531822-7640-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1390531822-7640-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54241 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbaAXCuj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 21:50:39 -0500
In-Reply-To: <1390531822-7640-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jic23@kernel.org, jkosina@suse.cz
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Remove the hard coded indexes, instead search for usage id and
use the index to set the power and report state.
This will fix issue, where the report descriptor doesn't contain
the full list of possible selector for power and report state.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 39 ++++++++++++++--------
 include/linux/hid-sensor-ids.h                     | 16 ++++-----
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 7dcf839..dbefbda 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -38,29 +38,40 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	if (state) {
 		if (sensor_hub_device_open(st->hsdev))
 			return -EIO;
-		state_val =
-		HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
-		report_val =
-		HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
-
+		state_val = hid_sensor_get_usage_index(st->hsdev,
+			st->power_state.report_id,
+			st->power_state.index,
+			HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM);
+		report_val = hid_sensor_get_usage_index(st->hsdev,
+			st->report_state.report_id,
+			st->report_state.index,
+			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM);
 	} else {
 		sensor_hub_device_close(st->hsdev);
-		state_val =
-		HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM;
-		report_val =
-		HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM;
+		state_val = hid_sensor_get_usage_index(st->hsdev,
+			st->power_state.report_id,
+			st->power_state.index,
+			HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM);
+		report_val = hid_sensor_get_usage_index(st->hsdev,
+			st->report_state.report_id,
+			st->report_state.index,
+			HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM);
 	}
-
 	st->data_ready = state;
-	state_val += st->power_state.logical_minimum;
-	report_val += st->report_state.logical_minimum;
-	sensor_hub_set_feature(st->hsdev, st->power_state.report_id,
+
+	if (state_val >= 0) {
+		state_val += st->power_state.logical_minimum;
+		sensor_hub_set_feature(st->hsdev, st->power_state.report_id,
 					st->power_state.index,
 					(s32)state_val);
+	}
 
-	sensor_hub_set_feature(st->hsdev, st->report_state.report_id,
+	if (report_val >= 0) {
+		report_val += st->report_state.logical_minimum;
+		sensor_hub_set_feature(st->hsdev, st->report_state.report_id,
 					st->report_state.index,
 					(s32)report_val);
+	}
 
 	return 0;
 }
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index beaf965..f860760 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -130,15 +130,15 @@
 #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		0x1000
 
 /* Power state enumerations */
-#define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM		0x00
-#define HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM		0x01
-#define HID_USAGE_SENSOR_PROP_POWER_STATE_D1_LOW_POWER_ENUM		0x02
-#define HID_USAGE_SENSOR_PROP_POWER_STATE_D2_STANDBY_WITH_WAKE_ENUM	0x03
-#define HID_USAGE_SENSOR_PROP_POWER_STATE_D3_SLEEP_WITH_WAKE_ENUM	0x04
-#define HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM		0x05
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x200850
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM	0x200851
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D1_LOW_POWER_ENUM	0x200852
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D2_STANDBY_WITH_WAKE_ENUM 0x200853
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D3_SLEEP_WITH_WAKE_ENUM 0x200854
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM	0x200855
 
 /* Report State enumerations */
-#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM		0x00
-#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM		0x01
+#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM	0x200840
+#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM	0x200841
 
 #endif
-- 
1.8.3.2

