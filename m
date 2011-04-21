From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] input: sh_keysc: Runtime PM support
Date: Thu, 21 Apr 2011 22:35:14 +0900
Message-ID: <20110421133514.8688.44489.sendpatchset@t400s>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38524 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab1DUN2a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Apr 2011 09:28:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-sh@vger.kernel.org, dmitry.torokhov@gmail.com, rjw@sisk.pl, lethal@linux-sh.org, simon@horms.net, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Convert the KEYSC driver from MSTP bit control through
a magic clock string to making use of Runtime PM.

Also, update the system suspend/resume callbacks to drop
the Runtime PM reference in the case of wakeup disabled.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/sh_keysc.c |   40 +++++++++++++------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2011-04-21 22:26:54.000000000 +0900
@@ -20,7 +20,7 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/bitmap.h>
-#include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
@@ -37,7 +37,6 @@ static const struct {
 
 struct sh_keysc_priv {
 	void __iomem *iomem_base;
-	struct clk *clk;
 	DECLARE_BITMAP(last_keys, SH_KEYSC_MAXKEYS);
 	struct input_dev *input;
 	struct sh_keysc_info pdata;
@@ -169,7 +168,6 @@ static int __devinit sh_keysc_probe(stru
 	struct sh_keysc_info *pdata;
 	struct resource *res;
 	struct input_dev *input;
-	char clk_name[8];
 	int i;
 	int irq, error;
 
@@ -210,19 +208,11 @@ static int __devinit sh_keysc_probe(stru
 		goto err1;
 	}
 
-	snprintf(clk_name, sizeof(clk_name), "keysc%d", pdev->id);
-	priv->clk = clk_get(&pdev->dev, clk_name);
-	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
-		error = PTR_ERR(priv->clk);
-		goto err2;
-	}
-
 	priv->input = input_allocate_device();
 	if (!priv->input) {
 		dev_err(&pdev->dev, "failed to allocate input device\n");
 		error = -ENOMEM;
-		goto err3;
+		goto err2;
 	}
 
 	input = priv->input;
@@ -244,7 +234,7 @@ static int __devinit sh_keysc_probe(stru
 	error = request_irq(irq, sh_keysc_isr, 0, pdev->name, pdev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto err4;
+		goto err3;
 	}
 
 	for (i = 0; i < SH_KEYSC_MAXKEYS; i++)
@@ -254,10 +244,11 @@ static int __devinit sh_keysc_probe(stru
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register input device\n");
-		goto err5;
+		goto err4;
 	}
 
-	clk_enable(priv->clk);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	sh_keysc_write(priv, KYCR1, (sh_keysc_mode[pdata->mode].kymd << 8) |
 		       pdata->scan_timing);
@@ -267,12 +258,10 @@ static int __devinit sh_keysc_probe(stru
 
 	return 0;
 
- err5:
-	free_irq(irq, pdev);
  err4:
-	input_free_device(input);
+	free_irq(irq, pdev);
  err3:
-	clk_put(priv->clk);
+	input_free_device(input);
  err2:
 	iounmap(priv->iomem_base);
  err1:
@@ -292,8 +281,8 @@ static int __devexit sh_keysc_remove(str
 	free_irq(platform_get_irq(pdev, 0), pdev);
 	iounmap(priv->iomem_base);
 
-	clk_disable(priv->clk);
-	clk_put(priv->clk);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	platform_set_drvdata(pdev, NULL);
 	kfree(priv);
@@ -311,14 +300,13 @@ static int sh_keysc_suspend(struct devic
 	value = sh_keysc_read(priv, KYCR1);
 
 	if (device_may_wakeup(dev)) {
-		value |= 0x80;
+		sh_keysc_write(priv, KYCR1, value | 0x80);
 		enable_irq_wake(irq);
 	} else {
-		value &= ~0x80;
+		sh_keysc_write(priv, KYCR1, value & ~0x80);
+		pm_runtime_put_sync(dev);
 	}
 
-	sh_keysc_write(priv, KYCR1, value);
-
 	return 0;
 }
 
@@ -329,6 +317,8 @@ static int sh_keysc_resume(struct device
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(irq);
+	else
+		pm_runtime_get_sync(dev);
 
 	return 0;
 }
