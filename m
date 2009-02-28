From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Fri, 27 Feb 2009 18:30:36 -0800
Message-ID: <200902271830.37207.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <20090227153204.fc9c579c.akpm@linux-foundation.org> <20090227160110.8cf8cd6e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757587AbZB1Caw@vger.kernel.org>
In-Reply-To: <20090227160110.8cf8cd6e.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl, tglx@linutronix.de
List-Id: linux-input@vger.kernel.org

On Friday 27 February 2009, Andrew Morton wrote:
> On Fri, 27 Feb 2009 15:32:04 -0800
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > Why does this function:
> > 
> > static irqreturn_t powerbutton_irq(int irq, void *dev_id)
> > {
> > 	... threaded irq handler body elided ...
> > }
> > 
> > Which is connected up via this statement:
> > 
> > 	err = request_irq(irq, powerbutton_irq,
> > 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> > 			"twl4030-pwrbutton", NULL);
> > 
> > reenable local interrupts?

Because threaded IRQ handlers are, well, threaded.  And all
the twl4030 IRQ handlers are threaded -- must be.  But when
CONFIG_LOCKDEP is enabled, it goofs such handlers ... as well
as a bunch of other perfectly functional driver code.

In the absense of the lockdep IRQF_DISABLED goofage, the IRQs
are properly dispatched -- IRQs stay enabled while these
handlers run, all the relevant locking invariants are obeyed.


> ah, OK, twl4030_i2c_read_u8() does i2c I/O.
> 
> Can't do that. 

Threaded IRQ handlers *can* do that.  That's the point.

Now, if you were to say "keep waiting a few more years
until some threaded IRQ framework finally merges" ...
the question comes up, "What to do in the meanwhile".
(Ditto, "well, we've been waiting a long time now to
see those threaded IRQs, what's up with them?")

"Nothing" is not an option.  The "something" being done
here is a reasonably clean approach, and doesn't call
for any surgery to kernel/irq/* ... the *only* problem
is the lockdep bug, which causes trouble for a variety
of other drivers too.


> If some random process currently holds 
> mutex_lock(&twl->xfer_lock) and an interrupt occurs then this interrupt
> handler will try to acquire mutex_lock(&twl->xfer_lock).  Deadlock.

No, no, no.  *THREADED IRQ HANDLER* at work here.  Bzzt.

Threaded IRQ handler.

The relevant mutexes are *never* accessed outside of a
thread context.  Not by this code.  Not by any other code.
