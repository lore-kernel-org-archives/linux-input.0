From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] iio: hid-sensors: Fix power and report state
Date: Wed, 27 Nov 2013 14:19:43 -0800
Message-ID: <1385590783-27604-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1385590783-27604-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15572 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755553Ab3K0WVE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Nov 2013 17:21:04 -0500
In-Reply-To: <1385590783-27604-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

In the original HID sensor hub firmwares all Named array enums were
to 0-based. But the most recent hub implemented as 1-based,
because of the implementation by one of the major OS vendor.
Using logical minimum for the field as the base of enum. So we add
logical minimum to the selector values before setting those fields.
Some sensor hub FWs already changed logical minimum from 0 to 1
to reflect this and hope every other vendor will follow.
There is no easy way to add a common HID quirk for NAry elements,
even if the standard specifies these field as NAry, the collection
used to describe selectors is still just "logical".

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/Kconfig              |  9 ---------
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 20 +++++++++++++++-----
 include/linux/hid-sensor-ids.h                      | 12 ++++++++++++
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/Kconfig b/drivers/iio/common/hid-sensors/Kconfig
index 1178121..39188b7 100644
--- a/drivers/iio/common/hid-sensors/Kconfig
+++ b/drivers/iio/common/hid-sensors/Kconfig
@@ -25,13 +25,4 @@ config HID_SENSOR_IIO_TRIGGER
 	  If this driver is compiled as a module, it will be named
 	  hid-sensor-trigger.
 
-config HID_SENSOR_ENUM_BASE_QUIRKS
-	bool "ENUM base quirks for HID Sensor IIO drivers"
-	depends on HID_SENSOR_IIO_COMMON
-	help
-	  Say yes here to build support for sensor hub FW using
-	  enumeration, which is using 1 as base instead of 0.
-	  Since logical minimum is still set 0 instead of 1,
-	  there is no easy way to differentiate.
-
 endmenu
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index b6e77e0..781d3fa 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -33,24 +33,34 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
 	int state_val;
+	int report_val;
 
 	if (state) {
 		if (sensor_hub_device_open(st->hsdev))
 			return -EIO;
-	} else
+		state_val =
+		HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM;
+		report_val =
+		HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM;
+
+	} else {
 		sensor_hub_device_close(st->hsdev);
+		state_val =
+		HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM;
+		report_val =
+		HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM;
+	}
 
-	state_val = state ? 1 : 0;
-	if (IS_ENABLED(CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS))
-		++state_val;
 	st->data_ready = state;
+	state_val += st->power_state.logical_minimum;
+	report_val += st->report_state.logical_minimum;
 	sensor_hub_set_feature(st->hsdev, st->power_state.report_id,
 					st->power_state.index,
 					(s32)state_val);
 
 	sensor_hub_set_feature(st->hsdev, st->report_state.report_id,
 					st->report_state.index,
-					(s32)state_val);
+					(s32)report_val);
 
 	return 0;
 }
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 4f945d3..8323775 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -117,4 +117,16 @@
 #define HID_USAGE_SENSOR_PROP_REPORT_STATE			0x200316
 #define HID_USAGE_SENSOR_PROY_POWER_STATE			0x200319
 
+/* Power state enumerations */
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM		0x00
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM		0x01
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D1_LOW_POWER_ENUM		0x02
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D2_STANDBY_WITH_WAKE_ENUM	0x03
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D3_SLEEP_WITH_WAKE_ENUM	0x04
+#define HID_USAGE_SENSOR_PROP_POWER_STATE_D4_POWER_OFF_ENUM		0x05
+
+/* Report State enumerations */
+#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM		0x00
+#define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM		0x01
+
 #endif
-- 
1.8.3.2

