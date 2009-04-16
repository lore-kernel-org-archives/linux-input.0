From: Ben Nizette <bn@niasdigital.com>
Subject: [PATCH 6/9] ucb1400: Use disable_irq_nosync() from within irq
	handlers.
Date: Thu, 16 Apr 2009 15:54:58 +1000
Message-ID: <1239861298.29831.124.camel@linux-51e8.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outbound.icp-qv1-irony-out2.iinet.net.au ([203.59.1.107]:64546
	"EHLO outbound.icp-qv1-irony-out2.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756207AbZDPFzZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2009 01:55:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org


disable_irq() should wait for all running handlers to complete
before returning.  As such, if it's used to disable an interrupt
from that interrupt's handler it will deadlock.  This replaces
the dangerous instances with the _nosync() variant which doesn't
have this problem.

Signed-off-by: Ben Nizette <bn@niasdigital.com>
---
diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index e868264..f100c7f 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -256,7 +256,7 @@ static irqreturn_t ucb1400_hard_irq(int irqnr, void *devid)
 	struct ucb1400_ts *ucb = devid;
 
 	if (irqnr == ucb->irq) {
-		disable_irq(ucb->irq);
+		disable_irq_nosync(ucb->irq);
 		ucb->irq_pending = 1;
 		wake_up(&ucb->ts_wait);
 		return IRQ_HANDLED;
-- 
1.6.0.2



