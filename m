From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/4] Input: twl6040-vibra - pass the IRQF_ONESHOT flag
Date: Fri, 15 May 2015 18:43:10 -0300
Message-ID: <1431726191-11466-3-git-send-email-festevam@gmail.com>
References: <1431726191-11466-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33844 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbbEOVn1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 17:43:27 -0400
Received: by ykft189 with SMTP id t189so38194308ykf.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2015 14:43:27 -0700 (PDT)
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
 drivers/input/misc/twl6040-vibra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 0e0d094..ea63fad 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -308,7 +308,8 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 	mutex_init(&info->mutex);
 
 	error = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
-					  twl6040_vib_irq_handler, 0,
+					  twl6040_vib_irq_handler,
+					  IRQF_ONESHOT,
 					  "twl6040_irq_vib", info);
 	if (error) {
 		dev_err(info->dev, "VIB IRQ request failed: %d\n", error);
-- 
1.9.1

