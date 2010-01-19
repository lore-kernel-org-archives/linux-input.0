From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] input: update sh_keysc driver with mode 4 and mode 5 support
Date: Tue, 19 Jan 2010 23:29:14 +0900
Message-ID: <20100119142914.18659.97781.sendpatchset@rxone.opensource.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:51467 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab0ASOfk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2010 09:35:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add Mode 4 and Mode 5 support to the SH_KEYSC driver.
These modes allow slightly larger key pad matrixes.
While at it, make use of resource_size().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/sh_keysc.c |    6 +++---
 include/linux/input/sh_keysc.h    |    5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

--- 0001/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2010-01-19 16:29:17.000000000 +0900
@@ -36,6 +36,8 @@ static const struct {
 	[SH_KEYSC_MODE_1] = { 0, 6, 5 },
 	[SH_KEYSC_MODE_2] = { 1, 5, 6 },
 	[SH_KEYSC_MODE_3] = { 2, 4, 7 },
+	[SH_KEYSC_MODE_4] = { 3, 6, 6 },
+	[SH_KEYSC_MODE_5] = { 4, 6, 7 },
 };
 
 struct sh_keysc_priv {
@@ -122,8 +124,6 @@ static irqreturn_t sh_keysc_isr(int irq,
 	return IRQ_HANDLED;
 }
 
-#define res_size(res) ((res)->end - (res)->start + 1)
-
 static int __devinit sh_keysc_probe(struct platform_device *pdev)
 {
 	struct sh_keysc_priv *priv;
@@ -164,7 +164,7 @@ static int __devinit sh_keysc_probe(stru
 	memcpy(&priv->pdata, pdev->dev.platform_data, sizeof(priv->pdata));
 	pdata = &priv->pdata;
 
-	priv->iomem_base = ioremap_nocache(res->start, res_size(res));
+	priv->iomem_base = ioremap_nocache(res->start, resource_size(res));
 	if (priv->iomem_base == NULL) {
 		dev_err(&pdev->dev, "failed to remap I/O memory\n");
 		error = -ENXIO;
--- 0001/include/linux/input/sh_keysc.h
+++ work/include/linux/input/sh_keysc.h	2010-01-19 16:29:17.000000000 +0900
@@ -1,10 +1,11 @@
 #ifndef __SH_KEYSC_H__
 #define __SH_KEYSC_H__
 
-#define SH_KEYSC_MAXKEYS 30
+#define SH_KEYSC_MAXKEYS 42
 
 struct sh_keysc_info {
-	enum { SH_KEYSC_MODE_1, SH_KEYSC_MODE_2, SH_KEYSC_MODE_3 } mode;
+	enum { SH_KEYSC_MODE_1, SH_KEYSC_MODE_2, SH_KEYSC_MODE_3,
+	       SH_KEYSC_MODE_4, SH_KEYSC_MODE_5 } mode;
 	int scan_timing; /* 0 -> 7, see KYCR1, SCN[2:0] */
 	int delay;
 	int kycr2_delay;
