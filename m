From: Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH v2] hid: hid-sensor-prox: Add more data field for hysteresis parsing
Date: Wed, 22 Feb 2017 17:23:33 +0800
Message-ID: <1487755413-31421-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:29021 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753114AbdBVBA4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 20:00:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com, Song Hongyan <hongyan.song@intel.com>

Add HID_USAGE_SENSOR_HUMAN_PRESENCE support for Human Presence sensitivity
parsing, in case some implementation uses it as sensitivity modifier.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
change: adding Srinivas ack

 drivers/iio/light/hid-sensor-prox.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 45ca056..73fced8 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -240,6 +240,13 @@ static int prox_parse_report(struct platform_device *pdev,
 			st->common_attributes.sensitivity.index,
 			st->common_attributes.sensitivity.report_id);
 	}
+	if (st->common_attributes.sensitivity.index < 0)
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_HUMAN_PRESENCE,
+			&st->common_attributes.sensitivity);
+
 	return ret;
 }
 
-- 
1.9.1

