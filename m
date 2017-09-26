From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] Input: pr_err() strings should end with newlines
Date: Tue, 26 Sep 2017 12:27:34 +0530
Message-ID: <37719309957fe9a62a83bca52d82fa2528ded6dd.1506408984.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36096 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965840AbdIZG6k (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 02:58:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index d268fdc..ffb8642 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2436,7 +2436,7 @@ static int __init input_init(void)
 	err = register_chrdev_region(MKDEV(INPUT_MAJOR, 0),
 				     INPUT_MAX_CHAR_DEVICES, "input");
 	if (err) {
-		pr_err("unable to register char major %d", INPUT_MAJOR);
+		pr_err("unable to register char major %d\n", INPUT_MAJOR);
 		goto fail2;
 	}
 
-- 
1.9.1

