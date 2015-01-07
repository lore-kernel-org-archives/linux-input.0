From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] HID: sensor-hub: correct dyn_callback_lock IRQ-safe change
Date: Wed,  7 Jan 2015 10:14:44 -0800
Message-ID: <1420654484-6410-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420654484-6410-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14718 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754647AbbAGSPa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 13:15:30 -0500
In-Reply-To: <1420654484-6410-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Commit 0ccf091d1fbc1f99bb7f93bff8cf346769a9b0cd ("HID: sensor-hub:
make dyn_callback_lock IRQ-safe) was supposed to change locks
in sensor_hub_get_callback(), but missed.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6a58b6c..e54ce10 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -135,8 +135,9 @@ static struct hid_sensor_hub_callbacks *sensor_hub_get_callback(
 {
 	struct hid_sensor_hub_callbacks_list *callback;
 	struct sensor_hub_data *pdata = hid_get_drvdata(hdev);
+	unsigned long flags;
 
-	spin_lock(&pdata->dyn_callback_lock);
+	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
 	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
 		if (callback->usage_id == usage_id &&
 			(collection_index >=
@@ -145,10 +146,11 @@ static struct hid_sensor_hub_callbacks *sensor_hub_get_callback(
 				callback->hsdev->end_collection_index)) {
 			*priv = callback->priv;
 			*hsdev = callback->hsdev;
-			spin_unlock(&pdata->dyn_callback_lock);
+			spin_unlock_irqrestore(&pdata->dyn_callback_lock,
+					       flags);
 			return callback->usage_callback;
 		}
-	spin_unlock(&pdata->dyn_callback_lock);
+	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
 
 	return NULL;
 }
-- 
1.9.3

