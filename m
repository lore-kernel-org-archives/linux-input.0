From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Sun, 1 Mar 2009 10:43:02 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903011035360.29264@localhost.localdomain>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902281202.36804.david-b@pacbell.net> <alpine.LFD.2.00.0902282149290.29264@localhost.localdomain> <200902281405.42080.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:48717 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660AbZCAJoE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Mar 2009 04:44:04 -0500
In-Reply-To: <200902281405.42080.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl

On Sat, 28 Feb 2009, David Brownell wrote:
> That seems to presume a hardirq-to-taskirq handoff.  But the
> problem case is taskirq-to-taskirq chaining, through e.g.
> what set_irq_chip_and_handler() provided.  (Details not very
> amenable to brief emails, just UTSL.)
> 
> Thing is, I'm not sure a per-IRQ thread can work easily with
> that chaining.  The chained IRQs can need to be handled before
> the top-level IRQ gets re-enabled.  That's why the twl4030-irq
> code uses just one taskirq thread for all incoming events.

This can be solved by a completion as well.
 
> (Which of course is rarely more than one at a time, so there's
> little reason not to share that task between the demuxing code
> and the events being demuxed.  Interrupts that need processing
> via I2C/SPI/etc are more or less by definition not frequent or
> performance-critical.)

Then all we need to provide in the generic code is a function which
does not go through the handle_IRQ_event() logic and calls the action
handler directly. Not rocket science to do that and better than using
a facility which is designed to run in hardirq context and expect that
it works in thread context without complaints.

Thanks,

	tglx
