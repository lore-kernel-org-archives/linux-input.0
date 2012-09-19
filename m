From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] HID: hid-sensor-hub: Remove hdev->claimed setting
Date: Wed, 19 Sep 2012 08:30:49 -0700
Message-ID: <1348068650-1723-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26165 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932204Ab2ISPaz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Sep 2012 11:30:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jic23@kernel.org
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, axel.lin@gmail.com@vger.kernel.orgAxel Lin <axel.lin@gmail.com>

From: Axel Lin <[mailto:axel.lin@gmail.com]>

Current implementation of hid_hw_start() allows connect_mask to be 0.
Setting hdev->claimed = HID_CLAIMED_INPUT before calling hid_hw_start()
is not necessary. Remove it.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 80033dc..ffa91cf 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -530,7 +530,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	}
 	INIT_LIST_HEAD(&hdev->inputs);
 
-	hdev->claimed = HID_CLAIMED_INPUT;
 	ret = hid_hw_start(hdev, 0);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
@@ -618,7 +617,6 @@ static void sensor_hub_remove(struct hid_device *hdev)
 	int i;
 
 	hid_dbg(hdev, " hardware removed\n");
-	hdev->claimed &= ~HID_CLAIMED_INPUT;
 	hid_hw_stop(hdev);
 	hid_hw_close(hdev);
 	spin_lock_irqsave(&data->lock, flags);
-- 
1.7.11.4

