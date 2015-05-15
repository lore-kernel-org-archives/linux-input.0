From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/4] Input: wm831x-on - pass the IRQF_ONESHOT flag
Date: Fri, 15 May 2015 18:43:11 -0300
Message-ID: <1431726191-11466-4-git-send-email-festevam@gmail.com>
References: <1431726191-11466-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:34214 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711AbbEOVna (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 17:43:30 -0400
Received: by yhom41 with SMTP id m41so35449795yho.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2015 14:43:29 -0700 (PDT)
In-Reply-To: <1431726191-11466-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Julia.Lawall@lip6.fr, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 1c6c69525b40eb76de8adf039409722015927dc3 ("genirq: Reject
bogus threaded irq requests") threaded IRQs without a primary handler
need to be requested with IRQF_ONESHOT, otherwise the request will fail.

So pass the IRQF_ONESHOT flag in this case.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/irqf_oneshot.cocci.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/misc/wm831x-on.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index 59d4f7b..1b44de2 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -99,7 +99,8 @@ static int wm831x_on_probe(struct platform_device *pdev)
 	wm831x_on->dev->dev.parent = &pdev->dev;
 
 	ret = request_threaded_irq(irq, NULL, wm831x_on_irq,
-				   IRQF_TRIGGER_RISING, "wm831x_on",
+				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				   "wm831x_on",
 				   wm831x_on);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to request IRQ: %d\n", ret);
-- 
1.9.1

