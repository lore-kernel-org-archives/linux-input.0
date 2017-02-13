From: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] hid: hid-sensor-prox: Add more data field for hysteresis parsing
Date: Mon, 13 Feb 2017 17:54:52 +0800
Message-ID: <1486979692-44878-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add HID_USAGE_SENSOR_HUMAN_PRESENCE support for Human Presence sensitivity
parsing, in case some implementation uses it as sensitivity modifier.

Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
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
