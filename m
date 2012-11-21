From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] hid: usbhid: Return -ENOMEM instead of -1 for memory allocation failure
Date: Wed, 21 Nov 2012 11:50:29 +0530
Message-ID: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59725 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2KUG0q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 01:26:46 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1840080pad.19
        for <linux-input@vger.kernel.org>; Tue, 20 Nov 2012 22:26:46 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, jic23@kernel.org, sachin.kamat@linaro.org, patches@linaro.org

Silences the following smatch warning:
drivers/hid/usbhid/hiddev.c:897 hiddev_connect() warn:
returning -1 instead of -ENOMEM is sloppy

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/hid/usbhid/hiddev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 14599e2..50e2ab8 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -894,7 +894,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 	}
 
 	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
-		return -1;
+		return -ENOMEM;
 
 	init_waitqueue_head(&hiddev->wait);
 	INIT_LIST_HEAD(&hiddev->list);
-- 
1.7.4.1

