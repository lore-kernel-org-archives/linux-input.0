From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/4] hid-sensor-hub: fix style of comments
Date: Wed, 14 Aug 2013 11:07:08 +0300
Message-ID: <1376467631-20857-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:17884 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754917Ab3HNIH0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Aug 2013 04:07:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch fixes the style of the comments to be like following
	/* The commentary */

There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c   | 2 +-
 include/linux/hid-sensor-hub.h | 2 +-
 include/linux/hid-sensor-ids.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index ca749810..ffc80cf 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -416,7 +416,7 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 		return 1;
 
 	ptr = raw_data;
-	ptr++; /*Skip report id*/
+	ptr++; /* Skip report id */
 
 	spin_lock_irqsave(&pdata->lock, flags);
 
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index ecefb73..32ba451 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -172,7 +172,7 @@ struct hid_sensor_common {
 	struct hid_sensor_hub_attribute_info sensitivity;
 };
 
-/*Convert from hid unit expo to regular exponent*/
+/* Convert from hid unit expo to regular exponent */
 static inline int hid_sensor_convert_exponent(int unit_expo)
 {
 	if (unit_expo < 0x08)
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 6f24446..4f945d3 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -37,7 +37,7 @@
 #define HID_USAGE_SENSOR_ANGL_VELOCITY_Y_AXIS			0x200458
 #define HID_USAGE_SENSOR_ANGL_VELOCITY_Z_AXIS			0x200459
 
-/*ORIENTATION: Compass 3D: (200083) */
+/* ORIENTATION: Compass 3D: (200083) */
 #define HID_USAGE_SENSOR_COMPASS_3D				0x200083
 #define HID_USAGE_SENSOR_ORIENT_MAGN_HEADING			0x200471
 #define HID_USAGE_SENSOR_ORIENT_MAGN_HEADING_X			0x200472
-- 
1.8.4.rc2

