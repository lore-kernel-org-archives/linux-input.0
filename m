From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] HID: hid-sensor-hub: Fix sensor_hub_probe error handling
Date: Wed, 19 Sep 2012 08:30:50 -0700
Message-ID: <1348068650-1723-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1348068650-1723-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29990 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251Ab2ISPa4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Sep 2012 11:30:56 -0400
In-Reply-To: <1348068650-1723-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jic23@kernel.org
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, axel.lin@gmail.com@vger.kernel.orgAxel Lin <axel.lin@gmail.com>

From: Axel Lin <[mailto:axel.lin@gmail.com]>

Fix below issues:
1. In the case of goto err_close, hid_hw_stop(hdev) is called twice. Fix it.
2. If fails to allocate MFD device name, we also need to free all
   successfully allocated names in previous iterations.
3. In sensor_hub_remove(), Call hid_hw_close() before hid_hw_stop().
4. Adjust unnecessary change lines for hid_err.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index ffa91cf..1314380 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -555,8 +555,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
 						sizeof(struct mfd_cell),
 						GFP_KERNEL);
 	if (sd->hid_sensor_hub_client_devs == NULL) {
-		hid_err(hdev,
-			"Failed to allocate memory for mfd cells\n");
+		hid_err(hdev, "Failed to allocate memory for mfd cells\n");
 			ret = -ENOMEM;
 			goto err_close;
 	}
@@ -568,10 +567,9 @@ static int sensor_hub_probe(struct hid_device *hdev,
 			name = kasprintf(GFP_KERNEL, "HID-SENSOR-%x",
 						field->physical);
 			if (name  == NULL) {
-				hid_err(hdev,
-					"Failed MFD device name\n");
+				hid_err(hdev, "Failed MFD device name\n");
 					ret = -ENOMEM;
-					goto err_free_cells;
+					goto err_free_names;
 			}
 			sd->hid_sensor_hub_client_devs[
 				sd->hid_sensor_client_cnt].name = name;
@@ -595,10 +593,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 err_free_names:
 	for (i = 0; i < sd->hid_sensor_client_cnt ; ++i)
 		kfree(sd->hid_sensor_hub_client_devs[i].name);
-err_free_cells:
 	kfree(sd->hid_sensor_hub_client_devs);
 err_close:
-	hid_hw_stop(hdev);
 	hid_hw_close(hdev);
 err_stop_hw:
 	hid_hw_stop(hdev);
@@ -617,8 +613,8 @@ static void sensor_hub_remove(struct hid_device *hdev)
 	int i;
 
 	hid_dbg(hdev, " hardware removed\n");
-	hid_hw_stop(hdev);
 	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
 	spin_lock_irqsave(&data->lock, flags);
 	if (data->pending.status)
 		complete(&data->pending.ready);
-- 
1.7.11.4

