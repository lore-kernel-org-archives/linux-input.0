From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] wm97xx-core: Only schedule interrupt handler if not already scheduled
Date: Tue, 15 Apr 2008 15:47:06 +0100
Message-ID: <1208270828-10413-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080415144535.GA20619@rakim.wolfsonmicro.main>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43466 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758462AbYDOOrL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2008 10:47:11 -0400
In-Reply-To: <20080415144535.GA20619@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>, Dmitry Torokhov <dtor@mail.ru>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

As well as clarifying the fact that the driver can cope if a second
interrupt occurs before the IRQ work is scheduled this also ensures
that calls to the machine irq_enable() are balanced, making that easier
to implement.  Normally this is redundant due to the interrupt disabling
but some unusal board configurations can trigger it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm97xx-core.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 2910999..e27b1e0 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -328,18 +328,18 @@ static void wm97xx_pen_irq_worker(struct work_struct *work)
  *
  * We have to disable the codec interrupt in the handler because it
  * can take upto 1ms to clear the interrupt source. We schedule a task
- * in a work queue to do the actual interaction with the chip (it
- * doesn't matter if we end up reenqueing it before it is executed
- * since we don't touch the chip until it has run).  The interrupt is
- * then enabled again in the slow handler when the source has been
- * cleared.
+ * in a work queue to do the actual interaction with the chip.  The
+ * interrupt is then enabled again in the slow handler when the source
+ * has been cleared.
  */
 static irqreturn_t wm97xx_pen_interrupt(int irq, void *dev_id)
 {
 	struct wm97xx *wm = dev_id;
 
-	wm->mach_ops->irq_enable(wm, 0);
-	queue_work(wm->ts_workq, &wm->pen_event_work);
+	if (!work_pending(&wm->pen_event_work)) {
+		wm->mach_ops->irq_enable(wm, 0);
+		queue_work(wm->ts_workq, &wm->pen_event_work);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
1.5.5

