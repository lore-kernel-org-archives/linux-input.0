From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] Revert "input: ab8500-ponkey: Create AB8500 domain IRQ mapping"
Date: Mon, 6 Aug 2012 13:11:49 +0200
Message-ID: <1344251509-16008-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:40656 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755801Ab2HFLMP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Aug 2012 07:12:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>

From: Linus Walleij <linus.walleij@linaro.org>

This reverts commit ca3b3faf9bee4dc5df4f10eae2d1e48f7de0a8ad.

I don't understand this patch. The platform_get_irq_by_name()
used above already performs the irqdomain remapping, atleast
when using non-devicetree boots. I get the remapped IRQ
numbers out, and without reverting this the boot bombs,
because the code is trying to remap already remapped IRQs.

It looks to me like the ab8500_irq_get_virq() API is
completely pointless so something fishy is going on here,
did some infrastructure change in the v3.6 merge window?
Let's revert it for now.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/misc/ab8500-ponkey.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index f06231b..84ec691 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -74,8 +74,8 @@ static int __devinit ab8500_ponkey_probe(struct platform_device *pdev)
 
 	ponkey->idev = input;
 	ponkey->ab8500 = ab8500;
-	ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, irq_dbf);
-	ponkey->irq_dbr = ab8500_irq_get_virq(ab8500, irq_dbr);
+	ponkey->irq_dbf = irq_dbf;
+	ponkey->irq_dbr = irq_dbr;
 
 	input->name = "AB8500 POn(PowerOn) Key";
 	input->dev.parent = &pdev->dev;
-- 
1.7.11.3

