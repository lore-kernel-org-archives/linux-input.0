From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] input: altera_ps2: Store struct serio in struct ps2if
Date: Wed,  7 Mar 2012 14:44:24 +0100
Message-ID: <1331127864-7667-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:49713 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757285Ab2CGNo0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Mar 2012 08:44:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

It doesn't make much sense to allocate struct ps2if and struct serio
separately as they're allocated and used in conjunction.

Also ps2if->io wasn't freed in altera_ps2_remove() even tough it should
have been and thus caused a memory leak. This is also (implicitely)
fixed by this change.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/serio/altera_ps2.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index cc11f4e..fca6196 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -24,10 +24,10 @@
 #define DRV_NAME "altera_ps2"
 
 struct ps2if {
-	struct serio *io;
 	struct resource *iomem_res;
 	void __iomem *base;
 	unsigned irq;
+	struct serio io;
 };
 
 /*
@@ -41,7 +41,7 @@ static irqreturn_t altera_ps2_rxint(int irq, void *dev_id)
 	int handled = IRQ_NONE;
 
 	while ((status = readl(ps2if->base)) & 0xffff0000) {
-		serio_interrupt(ps2if->io, status & 0xff, 0);
+		serio_interrupt(&ps2if->io, status & 0xff, 0);
 		handled = IRQ_HANDLED;
 	}
 
@@ -88,11 +88,11 @@ static int __devinit altera_ps2_probe(struct platform_device *pdev)
 	int error, irq;
 
 	ps2if = kzalloc(sizeof(struct ps2if), GFP_KERNEL);
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!ps2if || !serio) {
+	if (!ps2if) {
 		error = -ENOMEM;
 		goto err_free_mem;
 	}
+	serio = &ps2if->io;
 
 	serio->id.type		= SERIO_8042;
 	serio->write		= altera_ps2_write;
@@ -102,7 +102,6 @@ static int __devinit altera_ps2_probe(struct platform_device *pdev)
 	strlcpy(serio->phys, dev_name(&pdev->dev), sizeof(serio->phys));
 	serio->port_data	= ps2if;
 	serio->dev.parent	= &pdev->dev;
-	ps2if->io		= serio;
 
 	ps2if->iomem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (ps2if->iomem_res == NULL) {
@@ -110,7 +109,6 @@ static int __devinit altera_ps2_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		error = -ENXIO;
@@ -140,7 +138,7 @@ static int __devinit altera_ps2_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "base %p, irq %d\n", ps2if->base, ps2if->irq);
 
-	serio_register_port(ps2if->io);
+	serio_register_port(&ps2if->io);
 	platform_set_drvdata(pdev, ps2if);
 
 	return 0;
@@ -152,7 +150,6 @@ static int __devinit altera_ps2_probe(struct platform_device *pdev)
 			   resource_size(ps2if->iomem_res));
  err_free_mem:
 	kfree(ps2if);
-	kfree(serio);
 	return error;
 }
 
@@ -164,7 +161,7 @@ static int __devexit altera_ps2_remove(struct platform_device *pdev)
 	struct ps2if *ps2if = platform_get_drvdata(pdev);
 
 	platform_set_drvdata(pdev, NULL);
-	serio_unregister_port(ps2if->io);
+	serio_unregister_port(&ps2if->io);
 	free_irq(ps2if->irq, ps2if);
 	iounmap(ps2if->base);
 	release_mem_region(ps2if->iomem_res->start,
-- 
1.7.5.4

