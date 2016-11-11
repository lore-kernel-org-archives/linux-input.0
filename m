From: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] hid: hid-sensor-hub: clear memory to avoid random data
Date: Fri, 11 Nov 2016 00:58:43 +0000
Message-ID: <1478825923-12153-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Initialize user buffer with 0s. This will avoid random data in the buffer,
when the user buffer size is bigger than the actual report size.

Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
Changes in v2:
    -clear memory in get_feature() instead of set_feature()

 drivers/hid/hid-sensor-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 658a607..b74d954 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -252,6 +252,7 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	int report_size;
 	int ret = 0;
 
+	memset(buffer, 0, buffer_size);
 	mutex_lock(&data->mutex);
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
 	if (!report || (field_index >= report->maxfield) ||
-- 
1.9.1
