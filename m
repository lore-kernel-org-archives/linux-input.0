From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] input: Request a shared interrupt for AMBA KMI devices.
Date: Thu,  8 May 2014 13:44:13 +0100
Message-ID: <1399553053-20305-1-git-send-email-broonie@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37884 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbaEHMog (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 08:44:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linaro-kernel@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Mark Brown <broonie@linaro.org>

From: Liviu Dudau <Liviu.Dudau@arm.com>

Recent ARM boards have the KMI devices share one interrupt line rather
than having dedicated IRQs. Update the driver to take that into account.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/input/serio/ambakmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 762b08432de0..8b748d99b934 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -79,7 +79,8 @@ static int amba_kmi_open(struct serio *io)
 	writeb(divisor, KMICLKDIV);
 	writeb(KMICR_EN, KMICR);
 
-	ret = request_irq(kmi->irq, amba_kmi_int, 0, "kmi-pl050", kmi);
+	ret = request_irq(kmi->irq, amba_kmi_int, IRQF_SHARED, "kmi-pl050",
+			  kmi);
 	if (ret) {
 		printk(KERN_ERR "kmi: failed to claim IRQ%d\n", kmi->irq);
 		writeb(0, KMICR);
-- 
2.0.0.rc2

