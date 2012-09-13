From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] HID: hid-sensor-hub: Call hid_hw_close() before
 hid_hw_stop()
Date: Fri, 14 Sep 2012 06:06:41 +0800
Message-ID: <1347574001.8974.6.camel@phoenix>
References: <1347573801.8974.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41451 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab2IMWGq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 18:06:46 -0400
Received: by obbuo13 with SMTP id uo13so5329845obb.19
        for <linux-input@vger.kernel.org>; Thu, 13 Sep 2012 15:06:46 -0700 (PDT)
In-Reply-To: <1347573801.8974.2.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org

Also adjust unnecessary change lines for hid_err.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-sensor-hub.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index f9d6209..b9ce38e 100644
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
@@ -577,8 +576,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
 			name = kasprintf(GFP_KERNEL, "HID-SENSOR-%x",
 						field->physical);
 			if (name  == NULL) {
-				hid_err(hdev,
-					"Failed MFD device name\n");
+				hid_err(hdev, "Failed MFD device name\n");
 					ret = -ENOMEM;
 					goto err_free_names;
 			}
@@ -624,8 +622,8 @@ static void sensor_hub_remove(struct hid_device *hdev)
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



