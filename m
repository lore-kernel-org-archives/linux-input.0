From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] Input: pxa27x_keypad - Use resource_size
Date: Fri, 18 Sep 2009 09:13:41 +0200
Message-ID: <1253258021-7817-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.zhaw.ch ([160.85.104.51]:49074 "EHLO mx2.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbZIRHNj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 03:13:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-input@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>

Use resource size from linux/ioport.h instead of the private macro
res_size.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/keyboard/pxa27x_keypad.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 0d2fc64..911cebc 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -425,8 +425,6 @@ static int pxa27x_keypad_resume(struct platform_device *pdev)
 #define pxa27x_keypad_resume	NULL
 #endif
 
-#define res_size(res)	((res)->end - (res)->start + 1)
-
 static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
 {
 	struct pxa27x_keypad *keypad;
@@ -461,14 +459,14 @@ static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
 		goto failed_free;
 	}
 
-	res = request_mem_region(res->start, res_size(res), pdev->name);
+	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (res == NULL) {
 		dev_err(&pdev->dev, "failed to request I/O memory\n");
 		error = -EBUSY;
 		goto failed_free;
 	}
 
-	keypad->mmio_base = ioremap(res->start, res_size(res));
+	keypad->mmio_base = ioremap(res->start, resource_size(res));
 	if (keypad->mmio_base == NULL) {
 		dev_err(&pdev->dev, "failed to remap I/O memory\n");
 		error = -ENXIO;
@@ -540,7 +538,7 @@ failed_put_clk:
 failed_free_io:
 	iounmap(keypad->mmio_base);
 failed_free_mem:
-	release_mem_region(res->start, res_size(res));
+	release_mem_region(res->start, resource_size(res));
 failed_free:
 	kfree(keypad);
 	return error;
@@ -562,7 +560,7 @@ static int __devexit pxa27x_keypad_remove(struct platform_device *pdev)
 	iounmap(keypad->mmio_base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res_size(res));
+	release_mem_region(res->start, resource_size(res));
 
 	platform_set_drvdata(pdev, NULL);
 	kfree(keypad);
-- 
1.6.0.4

