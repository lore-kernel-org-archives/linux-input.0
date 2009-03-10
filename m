From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] input: add suspend wakeup support to sh_keysc
Date: Tue, 10 Mar 2009 15:24:21 +0900
Message-ID: <20090310062421.22328.68726.sendpatchset@rx1.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:44605 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbZCJG0u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2009 02:26:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds wakeup support to the sh_keysc driver.
With this feature the ".../power/wakeup" file can be
used to enable and disable if the device takes the
system out of suspend. Default is enabled.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/input/keyboard/sh_keysc.c |   29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2009-03-09 19:14:47.000000000 +0900
@@ -219,6 +219,8 @@ static int __devinit sh_keysc_probe(stru
 		  pdata->scan_timing, priv->iomem_base + KYCR1_OFFS);
 	iowrite16(0, priv->iomem_base + KYOUTDR_OFFS);
 	iowrite16(KYCR2_IRQ_LEVEL, priv->iomem_base + KYCR2_OFFS);
+
+	device_init_wakeup(&pdev->dev, 1);
 	return 0;
  err5:
 	free_irq(irq, pdev);
@@ -253,17 +255,36 @@ static int __devexit sh_keysc_remove(str
 	return 0;
 }
 
+static int sh_keysc_suspend(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct sh_keysc_priv *priv;
+	unsigned short value;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	priv = platform_get_drvdata(pdev);
+
+	value = ioread16(priv->iomem_base + KYCR1_OFFS);
+
+	if (device_may_wakeup(dev))
+		value |= 0x80;
+	else
+		value &= ~0x80;
 
-#define sh_keysc_suspend NULL
-#define sh_keysc_resume NULL
+	iowrite16(value, priv->iomem_base + KYCR1_OFFS);
+	return 0;
+}
+
+static struct dev_pm_ops sh_keysc_dev_pm_ops = {
+	.suspend = sh_keysc_suspend,
+};
 
 struct platform_driver sh_keysc_device_driver = {
 	.probe		= sh_keysc_probe,
 	.remove		= __devexit_p(sh_keysc_remove),
-	.suspend	= sh_keysc_suspend,
-	.resume		= sh_keysc_resume,
 	.driver		= {
 		.name	= "sh_keysc",
+		.pm	= &sh_keysc_dev_pm_ops,
 	}
 };
 
