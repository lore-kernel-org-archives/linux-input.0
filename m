From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] Input: davinci_keyscan: Free memory occupied by davinci key scan device
Date: Tue, 14 Nov 2017 19:15:14 +0530
Message-ID: <9203eaebf020cbebf5224221d789a0163490d654.1510666872.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:50297 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbdKNNqL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 08:46:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Here, key_dev is NULL in input_free_device() and It will not free
memory occupied by davinci key scan device. Move "key_dev = NULL"
after input_free_device().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/keyboard/davinci_keyscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index b20a5d0..22cb8d2 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -290,13 +290,13 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
 	free_irq(davinci_ks->irq, davinci_ks);
 fail5:
 	input_unregister_device(davinci_ks->input);
-	key_dev = NULL;
 fail4:
 	iounmap(davinci_ks->base);
 fail3:
 	release_mem_region(davinci_ks->pbase, davinci_ks->base_size);
 fail2:
 	input_free_device(key_dev);
+	key_dev = NULL;
 fail1:
 	kfree(davinci_ks);
 
-- 
1.9.1

