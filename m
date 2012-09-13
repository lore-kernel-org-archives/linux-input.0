From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] HID: picolcd_core: Remove setting hdev->claimed before
 calling hid_hw_start()
Date: Fri, 14 Sep 2012 06:15:36 +0800
Message-ID: <1347574536.8974.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62643 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab2IMWPm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 18:15:42 -0400
Received: by oago6 with SMTP id o6so2341444oag.19
        for <linux-input@vger.kernel.org>; Thu, 13 Sep 2012 15:15:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org

Current implementation of hid_hw_start() allows connect_mask to be 0.
Setting hdev->claimed = HID_CLAIMED_INPUT before calling hid_hw_start() is not
necessary. Remove it.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-picolcd_core.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index 8c9ec1f..e30e703 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -583,11 +583,7 @@ static int picolcd_probe(struct hid_device *hdev,
 		goto err_cleanup_data;
 	}
 
-	/* We don't use hidinput but hid_hw_start() fails if nothing is
-	 * claimed. So spoof claimed input. */
-	hdev->claimed = HID_CLAIMED_INPUT;
 	error = hid_hw_start(hdev, 0);
-	hdev->claimed = 0;
 	if (error) {
 		hid_err(hdev, "hardware start failed\n");
 		goto err_cleanup_data;
-- 
1.7.9.5



