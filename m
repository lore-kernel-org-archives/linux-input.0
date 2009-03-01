From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Sun, 1 Mar 2009 14:11:43 -0800
Message-ID: <200903011411.43881.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902281202.36804.david-b@pacbell.net> <alpine.LFD.2.00.0902282149290.29264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:36565 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755282AbZCAWLr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Mar 2009 17:11:47 -0500
In-Reply-To: <alpine.LFD.2.00.0902282149290.29264@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl

On Saturday 28 February 2009, Thomas Gleixner wrote:
> > Got a version that applies to mainline GIT?
> 
> http://tglx.de/~tglx/patches.tar.bz2

Very lightly tested patch appended ... it works
with the RTC IRQs, and there's no reason to think
any of the other not-chained-any-longer IRQs would
fail.  This doesn't change anything the irqthread
does, just how it's created and accessed.

- Dave


=====
Minimalist patch to twl4030-irq.c to use the new threaded IRQ
stuff.  For review, not merge; the original irq thread isn't
properly formatted any more -- to make the patch be as small as
possible.

This makes creating the IRQ thread a bit simpler, but the lack
of irq chaining support makes /proc/interrupts be wrong.  The
quickcheck code path necessarily grew longer than the previous
irq_desc.handle() code path.

---
 drivers/mfd/twl4030-irq.c |   88 +++++++++++---------------------------------
 1 file changed, 23 insertions(+), 65 deletions(-)

--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -172,46 +172,23 @@ static const struct sih sih_modules[6] =
 
 static unsigned twl4030_irq_base;
 
-static struct completion irq_event;
-
 /*
- * This thread processes interrupts reported by the Primary Interrupt Handler.
+ * Threaded IRQ handler, processing interrupts reported by
+ * the Primary Interrupt Handler module.
  */
-static int twl4030_irq_thread(void *data)
+static irqreturn_t twl4030_pih_handler(int irq, void *unused)
 {
-	long irq = (long)data;
-	struct irq_desc *desc = irq_to_desc(irq);
-	static unsigned i2c_errors;
-	const static unsigned max_i2c_errors = 100;
-
-	if (!desc) {
-		pr_err("twl4030: Invalid IRQ: %ld\n", irq);
-		return -EINVAL;
-	}
-
-	current->flags |= PF_NOFREEZE;
-
-	while (!kthread_should_stop()) {
 		int ret;
 		int module_irq;
 		u8 pih_isr;
 
-		/* Wait for IRQ, then read PIH irq status (also blocking) */
-		wait_for_completion_interruptible(&irq_event);
-
+		ret = IRQ_NONE;
 		ret = twl4030_i2c_read_u8(TWL4030_MODULE_PIH, &pih_isr,
 					  REG_PIH_ISR_P1);
 		if (ret) {
 			pr_warning("twl4030: I2C error %d reading PIH ISR\n",
 					ret);
-			if (++i2c_errors >= max_i2c_errors) {
-				printk(KERN_ERR "Maximum I2C error count"
-						" exceeded.  Terminating %s.\n",
-						__func__);
-				break;
-			}
-			complete(&irq_event);
-			continue;
+			goto done;
 		}
 
 		/* these handlers deal with the relevant SIH irq status */
@@ -225,7 +202,7 @@ static int twl4030_irq_thread(void *data
 				if (!d) {
 					pr_err("twl4030: Invalid SIH IRQ: %d\n",
 					       module_irq);
-					return -EINVAL;
+					continue;
 				}
 
 				/* These can't be masked ... always warn
@@ -234,44 +211,31 @@ static int twl4030_irq_thread(void *data
 				if (d->status & IRQ_DISABLED)
 					note_interrupt(module_irq, d,
 							IRQ_NONE);
-				else
+				else {
 					d->handle_irq(module_irq, d);
+					ret = IRQ_HANDLED;
+				}
 			}
 		}
 		local_irq_enable();
 
-		desc->chip->unmask(irq);
-	}
-
-	return 0;
+done:
+	/* unmask the IRQ; it retriggers as needed */
+	enable_irq(irq);
+	return ret;
 }
 
 /*
- * handle_twl4030_pih() is the desc->handle method for the twl4030 interrupt.
- * This is a chained interrupt, so there is no desc->action method for it.
  * Now we need to query the interrupt controller in the twl4030 to determine
  * which module is generating the interrupt request.  However, we can't do i2c
  * transactions in interrupt context, so we must defer that work to a kernel
- * thread.  All we do here is acknowledge and mask the interrupt and wakeup
+ * thread.  All we do here is mask the active-low interrupt and wakeup
  * the kernel thread.
  */
-static void handle_twl4030_pih(unsigned int irq, irq_desc_t *desc)
-{
-	/* Acknowledge, clear *AND* mask the interrupt... */
-	desc->chip->ack(irq);
-	complete(&irq_event);
-}
-
-static struct task_struct *start_twl4030_irq_thread(long irq)
+static irqreturn_t twl4030_pih_quickcheck(int irq, void *unused)
 {
-	struct task_struct *thread;
-
-	init_completion(&irq_event);
-	thread = kthread_run(twl4030_irq_thread, (void *)irq, "twl4030-irq");
-	if (!thread)
-		pr_err("twl4030: could not create irq %ld thread!\n", irq);
-
-	return thread;
+	disable_irq(irq);
+	return IRQ_WAKE_THREAD;
 }
 
 /*----------------------------------------------------------------------*/
@@ -691,7 +655,6 @@ int twl_init_irq(int irq_num, unsigned i
 
 	int			status;
 	int			i;
-	struct task_struct	*task;
 
 	/*
 	 * Mask and clear all TWL4030 interrupts since initially we do
@@ -733,18 +696,13 @@ int twl_init_irq(int irq_num, unsigned i
 		goto fail;
 	}
 
-	/* install an irq handler to demultiplex the TWL4030 interrupt */
-	task = start_twl4030_irq_thread(irq_num);
-	if (!task) {
-		pr_err("twl4030: irq thread FAIL\n");
-		status = -ESRCH;
-		goto fail;
-	}
-
-	set_irq_data(irq_num, task);
-	set_irq_chained_handler(irq_num, handle_twl4030_pih);
+	/* FIXME should be a "chained" handler else irq statistics lie */
+	status = request_threaded_irq(irq_num,
+			twl4030_pih_handler, twl4030_pih_quickcheck,
+			IRQF_THREADED, "twl4030", NULL);
 
-	return status;
+	if (status == 0)
+		return status;
 
 fail:
 	for (i = irq_base; i < irq_end; i++)
