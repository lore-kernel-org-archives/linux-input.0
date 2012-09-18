From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH RESEND 1/2] HID: hid-sensor-hub: Remove setting
 hdev->claimed before calling hid_hw_start()
Date: Tue, 18 Sep 2012 08:52:13 +0800
Message-ID: <1347929533.6562.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59443 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab2IRAwX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 20:52:23 -0400
Received: by obbuo13 with SMTP id uo13so9762405obb.19
        for <linux-input@vger.kernel.org>; Mon, 17 Sep 2012 17:52:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, linux-input@vger.kernel.org

Current implementation of hid_hw_start() allows connect_mask to be 0.
Setting hdev->claimed = HID_CLAIMED_INPUT before calling hid_hw_start() is not
necessary. Remove it.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-sensor-hub.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 4ac759c..1faacf2 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -539,7 +539,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	}
 	INIT_LIST_HEAD(&hdev->inputs);
 
-	hdev->claimed = HID_CLAIMED_INPUT;
 	ret = hid_hw_start(hdev, 0);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
@@ -627,7 +626,6 @@ static void sensor_hub_remove(struct hid_device *hdev)
 	int i;
 
 	hid_dbg(hdev, " hardware removed\n");
-	hdev->claimed &= ~HID_CLAIMED_INPUT;
 	hid_hw_stop(hdev);
 	hid_hw_close(hdev);
 	spin_lock_irqsave(&data->lock, flags);
-- 
1.7.9.5



