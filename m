From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] hid: sensor-hub, fix potential memory leak
Date: Mon, 30 Jun 2014 11:34:48 +0200
Message-ID: <1404120888-10692-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:51224 "EHLO
	ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754976AbaF3Jez (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2014 05:34:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jirislaby@gmail.com, Jiri Slaby <jslaby@suse.cz>, srinivas pandruvada <srinivas.pandruvada@intel.com>

hsdev is not freed in sensor_hub_probe when kasprintf inside the for
loop fails. This is because hsdev is not set to platform_data yet (to
be freed by the code in the err_no_mem label). So free the memory
explicitly in the 'if' branch, as this is the only place where this is
(and will) be needed.

Reported-by: coverity
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-sensor-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index a8d5c8faf8cf..584e17ce80e4 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -632,6 +632,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
 			if (name == NULL) {
 				hid_err(hdev, "Failed MFD device name\n");
 					ret = -ENOMEM;
+					kfree(hsdev);
 					goto err_no_mem;
 			}
 			sd->hid_sensor_hub_client_devs[
-- 
2.0.0

