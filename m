From: Ben Nizette <bn@niasdigital.com>
Subject: [PATCH 5/9] tsc2007: Use disable_irq_nosync() from within irq
	handlers.
Date: Thu, 16 Apr 2009 15:54:51 +1000
Message-ID: <1239861291.29831.122.camel@linux-51e8.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outbound.icp-qv1-irony-out3.iinet.net.au ([203.59.1.148]:7409
	"EHLO outbound.icp-qv1-irony-out3.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756164AbZDPFzT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2009 01:55:19 -0400
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
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 4ab0702..536668f 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -235,7 +235,7 @@ static irqreturn_t tsc2007_irq(int irq, void *handle)
 	spin_lock_irqsave(&ts->lock, flags);
 
 	if (likely(ts->get_pendown_state())) {
-		disable_irq(ts->irq);
+		disable_irq_nosync(ts->irq);
 		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
 					HRTIMER_MODE_REL);
 	}
-- 
1.6.0.2



