From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] Input: Fix cleaning up KEY_STROBEs after error in tosakbd_probe()
Date: Fri, 21 Aug 2009 16:05:44 +0200
Message-ID: <4A8EA9B8.2090302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:40985 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626AbZHUOBC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2009 10:01:02 -0400
Received: by ewy3 with SMTP id 3so659663ewy.18
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2009 07:01:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Direct to fail2 to gpio_free() the KEY_STROBEs as well as the KEY_SENSEs.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Or is there an obscure reason why this shouldn't happen?

diff --git a/drivers/input/keyboard/tosakbd.c b/drivers/input/keyboard/tosakbd.c
index 677276b..72c06ef 100644
--- a/drivers/input/keyboard/tosakbd.c
+++ b/drivers/input/keyboard/tosakbd.c
@@ -344,7 +344,7 @@ static int __devinit tosakbd_probe(struct platform_device *pdev) {
 				" direction for GPIO %d, error %d\n",
 				gpio, error);
 			gpio_free(gpio);
-			goto fail;
+			goto fail2;
 		}
 
 	}
@@ -353,7 +353,7 @@ static int __devinit tosakbd_probe(struct platform_device *pdev) {
 	if (error) {
 		printk(KERN_ERR "tosakbd: Unable to register input device, "
 			"error: %d\n", error);
-		goto fail;
+		goto fail2;
 	}
 
 	printk(KERN_INFO "input: Tosa Keyboard Registered\n");
