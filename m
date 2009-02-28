From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Fri, 27 Feb 2009 20:46:50 -0800
Message-ID: <200902272046.50572.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902271830.37207.david-b@pacbell.net> <20090227183949.90f231e6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758045AbZB1ErP@vger.kernel.org>
In-Reply-To: <20090227183949.90f231e6.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl, tglx@linutronix.de
List-Id: linux-input@vger.kernel.org

On Friday 27 February 2009, Andrew Morton wrote:
> On Fri, 27 Feb 2009 18:30:36 -0800 David Brownell <david-b@pacbell.net> wrote:
> 
> > > ah, OK, twl4030_i2c_read_u8() does i2c I/O.
> > > 
> > > Can't do that. 
> > 
> > Threaded IRQ handlers *can* do that.  That's the point.
> > 
> > Now, if you were to say "keep waiting a few more years
> > until some threaded IRQ framework finally merges" ...
> > the question comes up, "What to do in the meanwhile".
> > (Ditto, "well, we've been waiting a long time now to
> > see those threaded IRQs, what's up with them?")
> 
> I don't have a clue what you're talking about.  Where is this "threaded
> irq handler" implementation of which you speak?  File and line?

You quoted the entirety of the *handler* a few messages ago
in this thread, where you asked the question which you
answer "ah, OK..." above.

Now, where is that being set up as being threaded?  I
referenced that a message or two earlier:

  drivers/mfd/twl4030-irq.c

Where you'll observe twl_init_irq() at line 688 setting
up the thread and the Primary IRQ Handler (PIH) dispatch.
That's pretty much bog-standard chained IRQ setup code,
except that it chains through a thread.

When an IRQ comes in, handle_twl4030_pih() acks and masks
that top level IRQ.  Then it wakes twl4030_irq_thread(),
which issues I2C operations to read the IRQ status from
the chip ... first PIH to find out which SIH modules are
raising an IRQ, then SIH to dispatch that status.  Then
handle_irq() from that thread to invoke the handler in
that thread context; it will issue more I2C ops.

And the lockdep thing kicks in through handle_irq(),
where the IRQ handler wrongly gets invoked with the
IRQs disabled -- iff lockdep is enabled.  Otherwise,
that IRQ thread is just like any other thread.

- Dave
