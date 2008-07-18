From: Tetsuya Mukawa <mukawa@igel.co.jp>
Subject: [PATCH] sh_keysc: Remove request_mem_region() and release_mem_region()
Date: Fri, 18 Jul 2008 17:38:36 +0900
Message-ID: <20080718083836.29015.8503.sendpatchset@localhost.localdomain>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailhost.igel.co.jp ([219.106.231.130]:53679 "EHLO
	mailhost.igel.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbYGRJIq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jul 2008 05:08:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-sh@vger.kernel.org, dmitry.torokhov@gmail.com, magnus.damm@gmail.com, Tetsuya Mukawa <mukawa@igel.co.jp>, lethal@linux-sh.org, akpm@linux-foundation.org

Remove request_mem_region() and release_mem_region() from sh_keysc driver.
Those functions can find resource conflict, but it is already checked in 
platform_device_add().

Signed-off-by: Tetsuya Mukawa <mukawa@igel.co.jp>
---

 drivers/input/keyboard/sh_keysc.c |   27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index 8486abc..c600ab7 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -158,25 +158,18 @@ static int __devinit sh_keysc_probe(struct platform_device *pdev)
 	memcpy(&priv->pdata, pdev->dev.platform_data, sizeof(priv->pdata));
 	pdata = &priv->pdata;
 
-	res = request_mem_region(res->start, res_size(res), pdev->name);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to request I/O memory\n");
-		error = -EBUSY;
-		goto err1;
-	}
-
 	priv->iomem_base = ioremap_nocache(res->start, res_size(res));
 	if (priv->iomem_base == NULL) {
 		dev_err(&pdev->dev, "failed to remap I/O memory\n");
 		error = -ENXIO;
-		goto err2;
+		goto err1;
 	}
 
 	priv->input = input_allocate_device();
 	if (!priv->input) {
 		dev_err(&pdev->dev, "failed to allocate input device\n");
 		error = -ENOMEM;
-		goto err3;
+		goto err2;
 	}
 
 	input = priv->input;
@@ -194,7 +187,7 @@ static int __devinit sh_keysc_probe(struct platform_device *pdev)
 	error = request_irq(irq, sh_keysc_isr, 0, pdev->name, pdev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto err4;
+		goto err3;
 	}
 
 	for (i = 0; i < SH_KEYSC_MAXKEYS; i++) {
@@ -206,7 +199,7 @@ static int __devinit sh_keysc_probe(struct platform_device *pdev)
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register input device\n");
-		goto err5;
+		goto err4;
 	}
 
 	iowrite16((sh_keysc_mode[pdata->mode].kymd << 8) |
@@ -214,14 +207,12 @@ static int __devinit sh_keysc_probe(struct platform_device *pdev)
 	iowrite16(0, priv->iomem_base + KYOUTDR_OFFS);
 	iowrite16(KYCR2_IRQ_LEVEL, priv->iomem_base + KYCR2_OFFS);
 	return 0;
- err5:
-	free_irq(irq, pdev);
  err4:
-	input_free_device(input);
+	free_irq(irq, pdev);
  err3:
-	iounmap(priv->iomem_base);
+	input_free_device(input);
  err2:
-	release_mem_region(res->start, res_size(res));
+	iounmap(priv->iomem_base);
  err1:
 	platform_set_drvdata(pdev, NULL);
 	kfree(priv);
@@ -232,7 +223,6 @@ static int __devinit sh_keysc_probe(struct platform_device *pdev)
 static int __devexit sh_keysc_remove(struct platform_device *pdev)
 {
 	struct sh_keysc_priv *priv = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	iowrite16(KYCR2_IRQ_DISABLED, priv->iomem_base + KYCR2_OFFS);
 
@@ -240,9 +230,6 @@ static int __devexit sh_keysc_remove(struct platform_device *pdev)
 	free_irq(platform_get_irq(pdev, 0), pdev);
 	iounmap(priv->iomem_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res_size(res));
-
 	platform_set_drvdata(pdev, NULL);
 	kfree(priv);
 	return 0;
