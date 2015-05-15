From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/4] Input: retu-pwrbutton - pass the IRQF_ONESHOT flag
Date: Fri, 15 May 2015 18:43:09 -0300
Message-ID: <1431726191-11466-2-git-send-email-festevam@gmail.com>
References: <1431726191-11466-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33832 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbbEOVnZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 17:43:25 -0400
Received: by ykft189 with SMTP id t189so38194061ykf.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2015 14:43:24 -0700 (PDT)
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
 drivers/input/misc/retu-pwrbutton.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/retu-pwrbutton.c b/drivers/input/misc/retu-pwrbutton.c
index 0c8ac60..30b459b 100644
--- a/drivers/input/misc/retu-pwrbutton.c
+++ b/drivers/input/misc/retu-pwrbutton.c
@@ -63,7 +63,8 @@ static int retu_pwrbutton_probe(struct platform_device *pdev)
 	input_set_drvdata(idev, rdev);
 
 	error = devm_request_threaded_irq(&pdev->dev, irq,
-					  NULL, retu_pwrbutton_irq, 0,
+					  NULL, retu_pwrbutton_irq,
+					  IRQF_ONESHOT,
 					  "retu-pwrbutton", idev);
 	if (error)
 		return error;
-- 
1.9.1

