From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 16/16] input: serio: hp_sdc: Use del_timer_sync() in exit path
Date: Sun, 23 Mar 2014 15:09:33 -0000
Message-ID: <20140323150754.381232240@linutronix.de>
References: <20140323150557.288925975@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=input-serio-hp_sdc-use-del_timer_sync.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Make sure that no callback is running before we teardown the module.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: input <linux-input@vger.kernel.org>
---
 drivers/input/serio/hp_sdc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tip/drivers/input/serio/hp_sdc.c
===================================================================
--- tip.orig/drivers/input/serio/hp_sdc.c
+++ tip/drivers/input/serio/hp_sdc.c
@@ -984,7 +984,7 @@ static void hp_sdc_exit(void)
 	free_irq(hp_sdc.irq, &hp_sdc);
 	write_unlock_irq(&hp_sdc.lock);
 
-	del_timer(&hp_sdc.kicker);
+	del_timer_sync(&hp_sdc.kicker);
 
 	tasklet_kill(&hp_sdc.task);
 
