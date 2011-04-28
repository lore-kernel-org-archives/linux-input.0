From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: omap-keypad - fix a wrong free_irq() parameter
Date: Thu, 28 Apr 2011 11:23:26 +0800
Message-ID: <1303961006.8127.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46619 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1D1DXf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Apr 2011 23:23:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Timo =?ISO-8859-1?Q?Ter=E4s?= <ext-timo.teras@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-input@vger.kernel.org

In current implementation, free_irq() was using NULL rather than the
driver data as the data pointer so free_irq() wouldn't have matched.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/keyboard/omap-keypad.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 0e2a19c..f23a743 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -413,7 +413,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 	return 0;
 err5:
 	for (i = irq_idx - 1; i >=0; i--)
-		free_irq(row_gpios[i], NULL);
+		free_irq(row_gpios[i], omap_kp);
 err4:
 	input_unregister_device(omap_kp->input);
 	input_dev = NULL;
@@ -444,11 +444,11 @@ static int __devexit omap_kp_remove(struct platform_device *pdev)
 			gpio_free(col_gpios[i]);
 		for (i = 0; i < omap_kp->rows; i++) {
 			gpio_free(row_gpios[i]);
-			free_irq(gpio_to_irq(row_gpios[i]), NULL);
+			free_irq(gpio_to_irq(row_gpios[i]), omap_kp);
 		}
 	} else {
 		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
-		free_irq(omap_kp->irq, NULL);
+		free_irq(omap_kp->irq, omap_kp);
 	}
 
 	del_timer_sync(&omap_kp->timer);
-- 
1.7.1



