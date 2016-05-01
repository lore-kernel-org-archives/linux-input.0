From: Muhammad Falak R Wani <falakreyaz@gmail.com>
Subject: [PATCH] Input: evdev - use RCU_INIT_POINTER() when NULLing
Date: Sun,  1 May 2016 17:47:23 +0530
Message-ID: <1462105043-8642-1-git-send-email-falakreyaz@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33002 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbcEAMRs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 May 2016 08:17:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Muhammad Falak R Wani <falakreyaz@gmail.com>

It is safe to use RCU_INIT_POINTER() to NULL a pointer, instead of
rcu_assign_pointer().
This results in slightly smaller/faster code.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/input/evdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..51875b5 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -392,7 +392,7 @@ static int evdev_ungrab(struct evdev *evdev, struct evdev_client *client)
 	if (grab != client)
 		return  -EINVAL;
 
-	rcu_assign_pointer(evdev->grab, NULL);
+	RCU_INIT_POINTER(evdev->grab, NULL);
 	synchronize_rcu();
 	input_release_device(&evdev->handle);
 
-- 
1.9.1

