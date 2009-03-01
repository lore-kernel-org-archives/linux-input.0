From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Sun, 1 Mar 2009 14:54:21 -0800
Message-ID: <200903011454.22280.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902281405.42080.david-b@pacbell.net> <alpine.LFD.2.00.0903011035360.29264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:24186 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758322AbZCAWyZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Mar 2009 17:54:25 -0500
In-Reply-To: <alpine.LFD.2.00.0903011035360.29264@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl

On Sunday 01 March 2009, Thomas Gleixner wrote:
> On Sat, 28 Feb 2009, David Brownell wrote:
> > That seems to presume a hardirq-to-taskirq handoff.  But the
> > problem case is taskirq-to-taskirq chaining, through e.g.
> > what set_irq_chip_and_handler() provided.  (Details not very
> > amenable to brief emails, just UTSL.)
> > 
> > Thing is, I'm not sure a per-IRQ thread can work easily with
> > that chaining.  The chained IRQs can need to be handled before
> > the top-level IRQ gets re-enabled.  That's why the twl4030-irq
> > code uses just one taskirq thread for all incoming events.
> 
> This can be solved by a completion as well.

One of many potential solutions; it's probably a better
use case for a counting semaphore though, especially if
they were all going in parallel.  And of course there's
the issue of where that synch code lives...

Though I still don't see any real issue with keeping it
simple and serializing them without creating new threads.
In terms of resource consumption, that simple solution is
clearly superior.


> > (Which of course is rarely more than one at a time, so there's
> > little reason not to share that task between the demuxing code
> > and the events being demuxed.  Interrupts that need processing
> > via I2C/SPI/etc are more or less by definition not frequent or
> > performance-critical.)
> 
> Then all we need to provide in the generic code is a function which
> does not go through the handle_IRQ_event() logic and calls the action
> handler directly.

That is, something to replace handle_simple_irq() and
handle_edge_irq() flow handlers?  (irq_desc.handle_irq)


> Not rocket science to do that and better than using 
> a facility which is designed to run in hardirq context and expect that
> it works in thread context without complaints.

The main "complaint" is the pre-existing lockdep breakage.  :)

The need to call irq_desc.handle_irq() with IRQs disabled is a
bit strange, but not really a problem; and it ensures consistent
locking for the irq_desc statistics and flag updates.

- Dave


