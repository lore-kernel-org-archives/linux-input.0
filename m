From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] HID: hid-sensor-hub: Fix sensor_hub_probe error handling
Date: Fri, 14 Sep 2012 06:05:12 +0800
Message-ID: <1347573912.8974.4.camel@phoenix>
References: <1347573801.8974.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65048 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab2IMWFR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 18:05:17 -0400
Received: by oago6 with SMTP id o6so2334821oag.19
        for <linux-input@vger.kernel.org>; Thu, 13 Sep 2012 15:05:17 -0700 (PDT)
In-Reply-To: <1347573801.8974.2.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org

Fix below issues in sensor_hub_probe error handling:
1. In the case of goto err_close, hid_hw_stop(hdev) is called twice. Fix it.
2. If fails to allocate MFD device name, we also need to free all
   sucessfully allocated names in previous iterations.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-sensor-hub.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 1faacf2..f9d6209 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -580,7 +580,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
 				hid_err(hdev,
 					"Failed MFD device name\n");
 					ret = -ENOMEM;
-					goto err_free_cells;
+					goto err_free_names;
 			}
 			sd->hid_sensor_hub_client_devs[
 				sd->hid_sensor_client_cnt].name = name;
@@ -604,10 +604,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
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
-- 
1.7.9.5



