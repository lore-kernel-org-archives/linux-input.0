From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 3/3] Input: altera_ps2 - switch to using managed resources
Date: Fri, 31 Oct 2014 13:41:31 +0100
Message-ID: <1414759291-23164-3-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:33025 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758816AbaJaMlg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 08:41:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Use them devm_ managed resources API to simplify error handling in
altera_ps2_probe() and to reduce the size of altera_ps2_remove() and the
ps2if struct.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/serio/altera_ps2.c | 81 ++++++++++++----------------------------
 1 file changed, 24 insertions(+), 57 deletions(-)

diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index 58781c8..f50325a 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -24,9 +24,7 @@
 
 struct ps2if {
 	struct serio *io;
-	struct resource *iomem_res;
 	void __iomem *base;
-	unsigned irq;
 };
 
 /*
@@ -83,16 +81,34 @@ static void altera_ps2_close(struct serio *io)
 static int altera_ps2_probe(struct platform_device *pdev)
 {
 	struct ps2if *ps2if;
+	struct resource *res;
 	struct serio *serio;
 	int error, irq;
 
-	ps2if = kzalloc(sizeof(struct ps2if), GFP_KERNEL);
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!ps2if || !serio) {
-		error = -ENOMEM;
-		goto err_free_mem;
+	ps2if = devm_kzalloc(&pdev->dev, sizeof(struct ps2if), GFP_KERNEL);
+	if (!ps2if)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ps2if->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ps2if->base))
+		return PTR_ERR(ps2if->base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENXIO;
+
+	error = devm_request_irq(&pdev->dev, irq, altera_ps2_rxint, 0,
+				 pdev->name, ps2if);
+	if (error) {
+		dev_err(&pdev->dev, "could not request IRQ %d\n", irq);
+		return error;
 	}
 
+	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!serio)
+		return -ENOMEM;
+
 	serio->id.type		= SERIO_8042;
 	serio->write		= altera_ps2_write;
 	serio->open		= altera_ps2_open;
@@ -103,56 +119,12 @@ static int altera_ps2_probe(struct platform_device *pdev)
 	serio->dev.parent	= &pdev->dev;
 	ps2if->io		= serio;
 
-	ps2if->iomem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (ps2if->iomem_res == NULL) {
-		error = -ENOENT;
-		goto err_free_mem;
-	}
-
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		error = -ENXIO;
-		goto err_free_mem;
-	}
-	ps2if->irq = irq;
-
-	if (!request_mem_region(ps2if->iomem_res->start,
-				resource_size(ps2if->iomem_res), pdev->name)) {
-		error = -EBUSY;
-		goto err_free_mem;
-	}
-
-	ps2if->base = ioremap(ps2if->iomem_res->start,
-			      resource_size(ps2if->iomem_res));
-	if (!ps2if->base) {
-		error = -ENOMEM;
-		goto err_free_res;
-	}
-
-	error = request_irq(ps2if->irq, altera_ps2_rxint, 0, pdev->name, ps2if);
-	if (error) {
-		dev_err(&pdev->dev, "could not allocate IRQ %d: %d\n",
-			ps2if->irq, error);
-		goto err_unmap;
-	}
-
-	dev_info(&pdev->dev, "base %p, irq %d\n", ps2if->base, ps2if->irq);
+	dev_info(&pdev->dev, "base %p, irq %d\n", ps2if->base, irq);
 
 	serio_register_port(ps2if->io);
 	platform_set_drvdata(pdev, ps2if);
 
 	return 0;
-
- err_unmap:
-	iounmap(ps2if->base);
- err_free_res:
-	release_mem_region(ps2if->iomem_res->start,
-			   resource_size(ps2if->iomem_res));
- err_free_mem:
-	kfree(ps2if);
-	kfree(serio);
-	return error;
 }
 
 /*
@@ -163,11 +135,6 @@ static int altera_ps2_remove(struct platform_device *pdev)
 	struct ps2if *ps2if = platform_get_drvdata(pdev);
 
 	serio_unregister_port(ps2if->io);
-	free_irq(ps2if->irq, ps2if);
-	iounmap(ps2if->base);
-	release_mem_region(ps2if->iomem_res->start,
-			   resource_size(ps2if->iomem_res));
-	kfree(ps2if);
 
 	return 0;
 }
-- 
2.0.1


