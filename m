From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v2 2/2] HID: hid-sensor-hub: Fix sensor_hub_probe error
 handling
Date: Tue, 18 Sep 2012 08:53:18 +0800
Message-ID: <1347929598.6562.1.camel@phoenix>
References: <1347929533.6562.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60609 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab2IRAxY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 20:53:24 -0400
Received: by oago6 with SMTP id o6so5444039oag.19
        for <linux-input@vger.kernel.org>; Mon, 17 Sep 2012 17:53:23 -0700 (PDT)
In-Reply-To: <1347929533.6562.0.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, linux-input@vger.kernel.org

Fix below issues:
1. In the case of goto err_close, hid_hw_stop(hdev) is called twice. Fix it.
2. If fails to allocate MFD device name, we also need to free all
   successfully allocated names in previous iterations.
3. In sensor_hub_remove(), Call hid_hw_close() before hid_hw_stop().
4. Adjust unnecessary change lines for hid_err.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-sensor-hub.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 1faacf2..b9ce38e 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -564,8 +564,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
 						sizeof(struct mfd_cell),
 						GFP_KERNEL);
 	if (sd->hid_sensor_hub_client_devs == NULL) {
-		hid_err(hdev,
-			"Failed to allocate memory for mfd cells\n");
+		hid_err(hdev, "Failed to allocate memory for mfd cells\n");
 			ret = -ENOMEM;
 			goto err_close;
 	}
@@ -577,10 +576,9 @@ static int sensor_hub_probe(struct hid_device *hdev,
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
@@ -604,10 +602,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
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
@@ -626,8 +622,8 @@ static void sensor_hub_remove(struct hid_device *hdev)
 	int i;
 
 	hid_dbg(hdev, " hardware removed\n");
-	hid_hw_stop(hdev);
 	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
 	spin_lock_irqsave(&data->lock, flags);
 	if (data->pending.status)
 		complete(&data->pending.ready);
-- 
1.7.9.5



