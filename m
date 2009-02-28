From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Fri, 27 Feb 2009 22:17:44 -0800
Message-ID: <200902272217.44688.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902272046.50572.david-b@pacbell.net> <20090227211203.4ebb0524.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:26642 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751014AbZB1GRs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 01:17:48 -0500
In-Reply-To: <20090227211203.4ebb0524.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl, tglx@linutronix.de

On Friday 27 February 2009, Andrew Morton wrote:
> On Fri, 27 Feb 2009 20:46:50 -0800 David Brownell <david-b@pacbell.net> wrote:
> 
> >   drivers/mfd/twl4030-irq.c
> > 
> > Where you'll observe twl_init_irq() at line 688 setting
> > up the thread and the Primary IRQ Handler (PIH) dispatch.
> > That's pretty much bog-standard chained IRQ setup code,
> > except that it chains through a thread.
> 
> OK, that's clever.  I never knew that anyone was doing that.  afaict
> MFD is the only such place...

This is the Mark II code, which can look clever
because it uses genirq better than the fairly
ugly Mark I code (and doesn't clone the same
logic into three separate drivers).

What's unique about this particular code is that
it chains those IRQs, instead of creating its own
little irq core (like menelaus.c in that directory)
or only needing to handle one IRQ (as with RTC
alarm drivers).


> Yes, it's regrettable that it's a private-to-mfd implementation.

More like:  private-to-twl4030.  If a more generic
version (Mark III) comes along at some point, I'd
hope switching would be easy...


> I expect a lot of i2c clients (at least) would like this.

I2C, SPI, maybe some more ... yes.  RTC alarm handling,
as one fairly routine example.


> Perhaps it would be somewhat less dirty to do something like

Yeah, that #ifdef is pretty ugly.

Thomas sent some threaded IRQ patches around sometime
last fall, which handled the top level dispatch but
ISTR not the chaining part.  This kind of thing would
be appropriate for the chained IRQs.  Maybe the flag
would better be named IRQF_THREADED.

(However, this flavor hack wouldn't address the lockdep
breakage for drivers like the AT91 and OMAP1 MMC hosts.)

- Dave


> --- a/kernel/irq/manage.c~a
> +++ a/kernel/irq/manage.c
> @@ -689,7 +689,8 @@ int request_irq(unsigned int irq, irq_ha
>  	/*
>  	 * Lockdep wants atomic interrupt handlers:
>  	 */
> -	irqflags |= IRQF_DISABLED;
> +	if (!(irqflags & IRQF_NO_LOCKDEP_HACK))
> +		irqflags |= IRQF_DISABLED;
>  #endif
>  	/*
>  	 * Sanity-check: shared interrupts must pass in a real dev-ID,
> 


