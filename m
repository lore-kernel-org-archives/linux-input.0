From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] Fix sh_keysc double free
Date: Fri, 21 Mar 2008 20:14:46 +0900
Message-ID: <20080321111446.13134.8863.sendpatchset@rx1.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:9543 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbYCULOS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Mar 2008 07:14:18 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1473489wff.4
        for <linux-input@vger.kernel.org>; Fri, 21 Mar 2008 04:14:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, dmitry.torokhov@gmail.com, akpm@linux-foundation.org, linux-sh@vger.kernel.org

Avoid double free situation from happening by removing input_free_device() 
after input_unregister_device(). Suggested by Dmitry Torokhov.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/input/keyboard/sh_keysc.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2008-03-21 10:58:20.000000000 +0900
@@ -238,7 +238,6 @@ static int __devexit sh_keysc_remove(str
 
 	input_unregister_device(priv->input);
 	free_irq(platform_get_irq(pdev, 0), pdev);
-	input_free_device(priv->input);
 	iounmap(priv->iomem_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
