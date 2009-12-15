From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] Input: Fix test of unsigned in altera_ps2_probe()
Date: Tue, 15 Dec 2009 18:02:56 +0100
Message-ID: <4B27C140.6000105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:46208 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZLORBJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2009 12:01:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

ps2if->irq is unsigned so the test does not work.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found using coccinelle: http://coccinelle.lip6.fr/

diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index f479ea5..3aa8f2e 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -83,7 +83,7 @@ static int altera_ps2_probe(struct platform_device *pdev)
 {
 	struct ps2if *ps2if;
 	struct serio *serio;
-	int error;
+	int error, irq;
 
 	ps2if = kzalloc(sizeof(struct ps2if), GFP_KERNEL);
 	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
@@ -108,11 +108,13 @@ static int altera_ps2_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
-	ps2if->irq  = platform_get_irq(pdev, 0);
-	if (ps2if->irq < 0) {
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		error = -ENXIO;
 		goto err_free_mem;
 	}
+	ps2if->irq = irq;
 
 	if (!request_mem_region(ps2if->iomem_res->start,
 				resource_size(ps2if->iomem_res), pdev->name)) {
