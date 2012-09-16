From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH RFT] HID: sensor-hub: don't hold spin lock while calling
 kzalloc with GFP_KERNEL
Date: Sun, 16 Sep 2012 10:58:25 +0800
Message-ID: <1347764305.3748.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57206 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab2IPC6d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Sep 2012 22:58:33 -0400
Received: by pbbrr13 with SMTP id rr13so7438440pbb.19
        for <linux-input@vger.kernel.org>; Sat, 15 Sep 2012 19:58:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org

kzalloc might cause sleep, so don't hold spin lock while calling kzalloc with
GFP_KERNEL.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-sensor-hub.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 4ac759c..162bf6a 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -173,14 +173,17 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
 			spin_unlock(&pdata->dyn_callback_lock);
 			return -EINVAL;
 		}
+	spin_unlock(&pdata->dyn_callback_lock);
+
 	callback = kzalloc(sizeof(*callback), GFP_KERNEL);
-	if (!callback) {
-		spin_unlock(&pdata->dyn_callback_lock);
+	if (!callback)
 		return -ENOMEM;
-	}
+
 	callback->usage_callback = usage_callback;
 	callback->usage_id = usage_id;
 	callback->priv = NULL;
+
+	spin_lock(&pdata->dyn_callback_lock);
 	list_add_tail(&callback->list, &pdata->dyn_callback_list);
 	spin_unlock(&pdata->dyn_callback_lock);
 
-- 
1.7.9.5



