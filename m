From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 27/26] HID: wiimote: init EXT/MP during device detection
Date: Sun, 26 May 2013 22:55:02 +0200
Message-ID: <1369601704-2311-1-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:54751 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab3EZU4C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 May 2013 16:56:02 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so3292678bkc.20
        for <linux-input@vger.kernel.org>; Sun, 26 May 2013 13:56:00 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

We normally get EXT hotplug events or poll for MP hotplugging so we
don't need to force extension port initialization during device setup.
But for gen20 devices, we disable MP polling because MP is always
present. However, this prevents MP initialization during device setup
and users need to plug another extension to trigger EXT/MP detection.

Therefore, we now trigger EXT/MP detection during device setup
automatically. This also avoids slightly delayed extension detection
and provides sysfs child-devices prior to the "changed"-uevent during
device setup.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
Hi Jiri

Three trivial fixes for the pending series. If there are any issues, please
let me know. And thanks for reviewing them!

Cheers
David

 drivers/hid/hid-wiimote-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 89118e9..f54595c 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1247,7 +1247,7 @@ static void wiimote_init_worker(struct work_struct *work)
 		changed = true;
 	}
 
-	if (!wiimote_init_check(wdata))
+	if (changed || !wiimote_init_check(wdata))
 		wiimote_init_hotplug(wdata);
 
 	if (changed)
-- 
1.8.2.3

