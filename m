From: Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH v3] hid: hid-sensor-hub: clear memory to avoid random data
Date: Mon, 14 Nov 2016 02:09:54 +0000
Message-ID: <1479089394-30765-1-git-send-email-hongyan.song@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:56297 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753265AbcKNCGr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 13 Nov 2016 21:06:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com, Song Hongyan <hongyan.song@intel.com>

When user tried to read some fields like hysteresis from IIO sysfs on some
systems, it fails. The reason is that this field is a byte field and caller
of sensor_hub_get_feature() passes a buffer of 4 bytes. Here the function
sensor_hub_get_feature() copies the single byte from the report to the
caller buffer and returns "1" as the number of bytes copied. So caller
can use the return value, which is actually not right.

Since this is done by multiple callers, if we change the
sensor_hub_get_feature() can make sure the caller buffer is initialized
with 0s then we don't need to change all functions.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
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

