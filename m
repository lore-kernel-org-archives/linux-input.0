From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 15:20:30 -0800
Message-ID: <200903021520.30826.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021410.25889.david-b@pacbell.net> <1236032722.5330.1675.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757987AbZCBXUq@vger.kernel.org>
In-Reply-To: <1236032722.5330.1675.camel@laptop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de
List-Id: linux-input@vger.kernel.org

On Monday 02 March 2009, Peter Zijlstra wrote:
> On Mon, 2009-03-02 at 14:10 -0800, David Brownell wrote:
> 
> > What's unfortunate is that you prefer not to fix that
> > IRQF_DISABLED bug in lockdep, which you co-"maintain".
> > When running with lockdep, that bug (a) introduces bugs
> > in some drivers and (b) hides bugs in others.  You've
> > rejected even a minimal warning fix, to help minimize
> > the amount of time developers waste on (a) and (b).
> 
> I've come to the conclusion that the only technically sound solution is
> to do as I proposed today, utterly eliminate !IRQF_DISABLED handlers.

As you announced today.  If you truly believe that, then
you should at least submit a warning patch for 2.6.29-rc
("driver X isn't setting IRQF_DISABLED, reimplement!")
with a Documentation/feature-removal-schedule.txt plan
for removing that mechanism.  And maybe updating the
handling of IRQF_SHARED at the same time... most shared
IRQs don't want IRQF_DISABLED.  And ... surely more,
even just to start phasing out such a longstanding
mechanism.

(Or more likely, start a real LKML discussion on that
specific topic.  I suspect it won't complete in time
to merge such a patch with any sort of consensus.)


> Apparently you had enough time to come up with the creative genirq abuse
> of twl4030, I think that with a similar effort you could have
> implemented generic threaded irq stuff like proposed by Thomas.

Actually, I made time to clean that code up a lot;
I didn't come up with that original stuff at all.

Why would you think otherwise, after reading the
copyrights at the top of twl4030-irq.c ??

And when I was doing that cleanup, the Official Plan
was that Thomas' code would be ready for merge into
at least the -next tree soon.  I don't know about
you, but stepping all over his work didn't seem like
it would be at all constructive.  Having a significant
driver be ready to try using it ... seemed like a
more productive approach.

 
> > Attacking folk for having to cope with such bugs escalates
> > things beyond "unfortunate".  If lockdep is "maintained",
> > your response should be fixing that lockdep bug.  Once
> > that's done, all workarounds for that bug can be removed.
> 
> I state there is no lockdep bug in this respect. The bug is trying to
> enable interrupts from hardirq context and running code that assumes
> hardirq context from task context.

Well, I state that you're wrong about those points...

Regardless of what either of us states, the truth of
the matter is that there are drivers that don't work
with CONFIG_LOCKDEP and the *only* reason is the code
removed by the (untested) patchlet below:  semantics
of irqs change when lockdep is enabled.  (That is, your
characterization above is incorrect.)  I call that a
lockdep bug; you don't want to accept that label.

Are those incorrect lockdep assumptions really so hard
to fix?  Where do they surface?  I scanned lockdep.c
briefly, and it talks about "hardirq" in several places.
Is it conflating that with "irqs disabled"?  The two
concepts should be distinct.

- Dave


---
 kernel/irq/manage.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -816,12 +816,6 @@ int request_irq_quickcheck(unsigned int 
 				"guaranteed on shared IRQs\n",
 				irq, devname);
 
-#ifdef CONFIG_LOCKDEP
-	/*
-	 * Lockdep wants atomic interrupt handlers:
-	 */
-	irqflags |= IRQF_DISABLED;
-#endif
 	/*
 	 * Sanity-check: shared interrupts must pass in a real dev-ID,
 	 * otherwise we'll have trouble later trying to figure out
