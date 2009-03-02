From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 13:37:20 -0800
Message-ID: <200903021337.20887.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021304.56881.david-b@pacbell.net> <1236028617.18955.14.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n27.bullet.mail.mud.yahoo.com ([68.142.206.222]:47663 "HELO
	n27.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752634AbZCBVhZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 16:37:25 -0500
In-Reply-To: <1236028617.18955.14.camel@twins>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com

On Monday 02 March 2009, Peter Zijlstra wrote:
> On Mon, 2009-03-02 at 13:04 -0800, David Brownell wrote:
> > On Monday 02 March 2009, Peter Zijlstra wrote:
> > > IRQF_DISABLED is bonkers,
> > 
> > Hmm, after all the work that's been done to get Linux
> > to the point where *most* drivers run without IRQs

Typo:  "drivers run *with* IRQs enabled".  Not "without".
Should be evident from context.


> > enabled ... that sentiment surprises me.
> > 
> > And I suspect it would surprise most driver developers.
> 
> How so?, its the natural extension of that work.

Not the work to shrink the amount of time IRQ latencies
by shrinking the amount of time IRQs are disabled by
IRQ handlers.


> > > we should simply always disable interrupts for 
> > > interrupt handlers.
> > 
> > That would be why you have refused to fix the bug
> > in lockdep, whereby it forcibly enables that flag?
> > 
> > I've been wondering for some months now why you've
> > left that bug unfixed.
> 
> Because running irq handlers with irqs enabled it plain silly.

Not if you have hardware-prioritized IRQs, which are
fairly common in some environments ... handling an IRQ
for high priority device A needn't interfere with the
handler for lower priority device B, and the system
overall can work better.

Not if you need to shrink IRQ latencies by minimizing
irqs-off critical sections everywhere ... IRQ handlers
being common offenders for keeping IRQs off too long.

Not when IRQs can be disabled selectively around the
real critical sections ... so drivers can leave IRQs
enabled except in those brief sections.
 


