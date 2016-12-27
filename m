From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: sensor-hub: Move the memset to sensor_hub_get_feature()
Date: Tue, 27 Dec 2016 08:57:59 -0800
Message-ID: <1482857879-161873-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:28827 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933027AbcL0Q6N (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Dec 2016 11:58:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, jic23@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Stable <stable@vger.kernel.org#4.9+>

While applying patch d443a0aa3a29: "HID: hid-sensor-hub: clear memory to
avoid random data", there was some issues in applying correct version of
the patch. This resulted in the breakage of sensor functions as all
request like power-up will be reset by the memset() in the function
sensor_hub_set_feature().
The reset of caller buffer should be in the function
sensor_hub_get_feature(), not in the sensor_hub_set_feature().

Fixes: d443a0aa3a29 ("HID: hid-sensor-hub: clear memory to avoid random data")
Cc: Stable <stable@vger.kernel.org> # 4.9+
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 5c92522..4ef7337 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -212,7 +212,6 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	__s32 value;
 	int ret = 0;
 
-	memset(buffer, 0, buffer_size);
 	mutex_lock(&data->mutex);
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
 	if (!report || (field_index >= report->maxfield)) {
@@ -256,6 +255,8 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	int buffer_index = 0;
 	int i;
 
+	memset(buffer, 0, buffer_size);
+
 	mutex_lock(&data->mutex);
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
 	if (!report || (field_index >= report->maxfield) ||
-- 
2.7.4

