From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/4] Input: twl4030-pwrbutton - pass the IRQF_ONESHOT flag
Date: Fri, 15 May 2015 18:43:08 -0300
Message-ID: <1431726191-11466-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36692 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbbEOVnW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 17:43:22 -0400
Received: by ykep21 with SMTP id p21so38040461yke.3
        for <linux-input@vger.kernel.org>; Fri, 15 May 2015 14:43:22 -0700 (PDT)
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
 drivers/input/misc/twl4030-pwrbutton.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index e98cc81..603fc2f 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -71,7 +71,8 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 	pwr->dev.parent = &pdev->dev;
 
 	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
-			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
+			IRQF_ONESHOT,
 			"twl4030_pwrbutton", pwr);
 	if (err < 0) {
 		dev_err(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
-- 
1.9.1

