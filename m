From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] input: sh_keysc suspend can use to_platform_device()
Date: Wed, 11 Mar 2009 17:04:23 +0900
Message-ID: <20090311080423.2006.22858.sendpatchset@rx1.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:11412 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZCKIGw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2009 04:06:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: soni.trilok@gmail.com, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch changes sh_keysc to use to_platform_device()
for suspend. Thanks to Trilok Soni for this suggestion.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/input/keyboard/sh_keysc.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2009-03-11 13:33:14.000000000 +0900
@@ -257,13 +257,10 @@ static int __devexit sh_keysc_remove(str
 
 static int sh_keysc_suspend(struct device *dev)
 {
-	struct platform_device *pdev;
-	struct sh_keysc_priv *priv;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_keysc_priv *priv = platform_get_drvdata(pdev);
 	unsigned short value;
 
-	pdev = container_of(dev, struct platform_device, dev);
-	priv = platform_get_drvdata(pdev);
-
 	value = ioread16(priv->iomem_base + KYCR1_OFFS);
 
 	if (device_may_wakeup(dev))
