From: Josh <joshua.taylor0@gmail.com>
Subject: [PATCH] Input: keyboard: omap-keypad: Fixed coding style issue.
Date: Thu, 23 Aug 2012 20:20:21 -0400
Message-ID: <1345767621-27816-1-git-send-email-joshua.taylor0@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:55666 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab2HXAU3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Aug 2012 20:20:29 -0400
Received: by qaas11 with SMTP id s11so184249qaa.19
        for <linux-input@vger.kernel.org>; Thu, 23 Aug 2012 17:20:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Josh <joshua.taylor0@gmail.com>

Fixed spacing error on if statements and fixed tab error.
Signed-off-by: Josh <joshua.taylor0@gmail.com>
---
 drivers/input/keyboard/omap-keypad.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index a0222db..b03c5b9 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -214,7 +214,7 @@ static void omap_kp_tasklet(unsigned long data)
 	memcpy(keypad_state, new_state, sizeof(keypad_state));
 
 	if (key_down) {
-                int delay = HZ / 20;
+		int delay = HZ / 20;
 		/* some key is pressed - keep irq disabled and use timer
 		 * to poll the keypad */
 		if (spurious)
@@ -413,7 +413,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 	}
 	return 0;
 err5:
-	for (i = irq_idx - 1; i >=0; i--)
+	for (i = irq_idx - 1; i >= 0; i--)
 		free_irq(row_gpios[i], omap_kp);
 err4:
 	input_unregister_device(omap_kp->input);
@@ -421,10 +421,10 @@ err4:
 err3:
 	device_remove_file(&pdev->dev, &dev_attr_enable);
 err2:
-	for (i = row_idx - 1; i >=0; i--)
+	for (i = row_idx - 1; i >= 0; i--)
 		gpio_free(row_gpios[i]);
 err1:
-	for (i = col_idx - 1; i >=0; i--)
+	for (i = col_idx - 1; i >= 0; i--)
 		gpio_free(col_gpios[i]);
 
 	kfree(omap_kp);
-- 
1.7.9.5

