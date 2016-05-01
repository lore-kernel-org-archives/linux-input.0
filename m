From: Muhammad Falak R Wani <falakreyaz@gmail.com>
Subject: [PATCH] Input: use RCU_INIT_POINTER() when NULLing.
Date: Sun,  1 May 2016 17:55:40 +0530
Message-ID: <1462105540-8835-1-git-send-email-falakreyaz@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32890 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbcEAMZr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 May 2016 08:25:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

It is safe to use RCU_INIT_POINTER() to NULL a pointer, instead of
rcu_assign_pointer().
This results in slightly smaller/faster code.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/input/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index b87ffbd..e59ac56 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -548,7 +548,7 @@ static void __input_release_device(struct input_handle *handle)
 	grabber = rcu_dereference_protected(dev->grab,
 					    lockdep_is_held(&dev->mutex));
 	if (grabber == handle) {
-		rcu_assign_pointer(dev->grab, NULL);
+		RCU_INIT_POINTER(dev->grab, NULL);
 		/* Make sure input_pass_event() notices that grab is gone */
 		synchronize_rcu();
 
-- 
1.9.1

