From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/2] HID: sensors: use GFP_ATOMIC under spinlock
Date: Fri, 14 Sep 2012 09:53:23 +0300
Message-ID: <20120914065323.GD11886@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:32142 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab2INGxg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 02:53:36 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

We're holding a spinlock here so we can't call kmalloc() with
GFP_KERNEL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 4ac759c..0c93b10 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -173,7 +173,7 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
 			spin_unlock(&pdata->dyn_callback_lock);
 			return -EINVAL;
 		}
-	callback = kzalloc(sizeof(*callback), GFP_KERNEL);
+	callback = kzalloc(sizeof(*callback), GFP_ATOMIC);
 	if (!callback) {
 		spin_unlock(&pdata->dyn_callback_lock);
 		return -ENOMEM;
@@ -462,7 +462,7 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 		if (pdata->pending.status && pdata->pending.attr_usage_id ==
 				report->field[i]->usage->hid) {
 			hid_dbg(hdev, "data was pending ...\n");
-			pdata->pending.raw_data = kmalloc(sz, GFP_KERNEL);
+			pdata->pending.raw_data = kmalloc(sz, GFP_ATOMIC);
 			if (pdata->pending.raw_data) {
 				memcpy(pdata->pending.raw_data, ptr, sz);
 				pdata->pending.raw_size  = sz;
