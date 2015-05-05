From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: hid-sensor-hub: Fix debug lock warning
Date: Tue,  5 May 2015 11:39:44 -0700
Message-ID: <1430851184-10402-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60210 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbbEESle (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 May 2015 14:41:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When CONFIG_DEBUG_LOCK_ALLOC is defined, mutex magic is compared and
warned for (l->magic != l), here l is the address of mutex pointer.
In hid-sensor-hub as part of hsdev creation, a per hsdev mutex is
initialized during MFD cell creation. This hsdev, which contains, mutex
is part of platform data for the a cell. But platform_data is copied
in platform_device_add_data() in platform.c. This copy will copy the
whole hsdev structure including mutex. But once copied the magic
will no longer match. So when client driver call
sensor_hub_input_attr_get_raw_value, this will trigger mutex warning.
So to avoid this use mutex pointer, which points to the original
mutex structure, and use this. This will be same even after copy.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c   | 5 +++--
 include/linux/hid-sensor-hub.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 5eb338d..2ee6a3f8 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -294,7 +294,7 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 	if (!report)
 		return -EINVAL;
 
-	mutex_lock(&hsdev->mutex);
+	mutex_lock(hsdev->mutex_ptr);
 	if (flag == SENSOR_HUB_SYNC) {
 		memset(&hsdev->pending, 0, sizeof(hsdev->pending));
 		init_completion(&hsdev->pending.ready);
@@ -328,7 +328,7 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 		kfree(hsdev->pending.raw_data);
 		hsdev->pending.status = false;
 	}
-	mutex_unlock(&hsdev->mutex);
+	mutex_unlock(hsdev->mutex_ptr);
 
 	return ret_val;
 }
@@ -668,6 +668,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
 			hsdev->product_id = hdev->product;
 			hsdev->usage = collection->usage;
 			mutex_init(&hsdev->mutex);
+			hsdev->mutex_ptr = &hsdev->mutex;
 			hsdev->start_collection_index = i;
 			if (last_hsdev)
 				last_hsdev->end_collection_index = i;
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index d48e91f..6f27c6e 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -75,6 +75,7 @@ struct sensor_hub_pending {
  * @start_collection_index: Starting index for a phy type collection
  * @end_collection_index: Last index for a phy type collection
  * @mutex:		synchronizing mutex.
+ * @mutex_ptr:		Pointer to the above synchronizing mutex.
  * @pending:		Holds information of pending sync read request.
  */
 struct hid_sensor_hub_device {
@@ -85,6 +86,7 @@ struct hid_sensor_hub_device {
 	int start_collection_index;
 	int end_collection_index;
 	struct mutex mutex;
+	struct mutex *mutex_ptr;
 	struct sensor_hub_pending pending;
 };
 
-- 
2.1.0

