From: "Ooi, Joyce" <joyce.ooi@intel.com>
Subject: [PATCH] iio: light and pressure: change data fields for ambient light and pressure sensor
Date: Thu,  3 Nov 2016 18:43:34 +0800
Message-ID: <1478169814-24120-1-git-send-email-joyce.ooi@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31236 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbcKCKoz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 3 Nov 2016 06:44:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ooi Joyce <joyce.ooi@intel.com>, Kweh Hock Leong <hock.leong.kweh@intel.com>, Ong Boon Leong <boon.leong.ong@intel.com>, Lay Kuan Loon <kuan.loon.lay@intel.com>

Sensitivity Percent Relative is added for ambient light sensor as it is
used based on HID Sensor Usages specifications.

Other changes include adding HID_USAGE_SENSOR_LIGHT_ILLUM and
HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE for ambient light and pressure
sensor respectively to be in sync with HID Sensor Usages specifications.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 drivers/iio/light/hid-sensor-als.c      | 10 ++++++++++
 drivers/iio/pressure/hid-sensor-press.c | 10 ++++++++++
 include/linux/hid-sensor-ids.h          |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 8bb1f90..6f3ca18 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -252,6 +252,16 @@ static int als_parse_report(struct platform_device *pdev,
 			st->common_attributes.sensitivity.index,
 			st->common_attributes.sensitivity.report_id);
 	}
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT |
+			HID_USAGE_SENSOR_LIGHT_ILLUM,
+			&st->common_attributes.sensitivity);
+		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
+			st->common_attributes.sensitivity.index,
+			st->common_attributes.sensitivity.report_id);
+	}
 	return ret;
 }
 
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 6848d8c..4cbbf88 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -249,6 +249,16 @@ static int press_parse_report(struct platform_device *pdev,
 			st->common_attributes.sensitivity.index,
 			st->common_attributes.sensitivity.report_id);
 	}
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE,
+			&st->common_attributes.sensitivity);
+		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
+			st->common_attributes.sensitivity.index,
+			st->common_attributes.sensitivity.report_id);
+	}
 	return ret;
 }
 
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index f2ee90a..755f5e2 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -141,6 +141,7 @@
 /* Per data field properties */
 #define HID_USAGE_SENSOR_DATA_MOD_NONE					0x00
 #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		0x1000
+#define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT		0xE000
 
 /* Power state enumerations */
 #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x200850
-- 
1.9.1

