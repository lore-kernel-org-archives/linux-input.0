From: Ingo Molnar <mingo@elte.hu>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Tue, 3 Mar 2009 00:26:50 +0100
Message-ID: <20090302232650.GA14515@elte.hu>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021410.25889.david-b@pacbell.net> <1236032722.5330.1675.camel@laptop> <200903021520.30826.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:34594 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbZCBX1R (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 18:27:17 -0500
Content-Disposition: inline
In-Reply-To: <200903021520.30826.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de


* David Brownell <david-b@pacbell.net> wrote:

> On Monday 02 March 2009, Peter Zijlstra wrote:
> > On Mon, 2009-03-02 at 14:10 -0800, David Brownell wrote:
> > 
> > > What's unfortunate is that you prefer not to fix that
> > > IRQF_DISABLED bug in lockdep, which you co-"maintain".
> > > When running with lockdep, that bug (a) introduces bugs
> > > in some drivers and (b) hides bugs in others.  You've
> > > rejected even a minimal warning fix, to help minimize
> > > the amount of time developers waste on (a) and (b).
> > 
> > I've come to the conclusion that the only technically sound solution is
> > to do as I proposed today, utterly eliminate !IRQF_DISABLED handlers.
> 
> As you announced today.  If you truly believe that, then
> you should at least submit a warning patch for 2.6.29-rc
> ("driver X isn't setting IRQF_DISABLED, reimplement!")

i have changed the BUG_ON() to a WARN_ONCE() message so the 
warning is in place now.

> with a Documentation/feature-removal-schedule.txt plan for 
> removing that mechanism. [...]

you are misunderstanding the workings and purpose of 
feature-removal-schedule.txt. It is mainly used for 
functionality that is user-visible. It is sometimes used for 
functionality that a subsystem has exported to a lot of drivers 
consciously and which is being removed.

It is never used for a single driver finding a core kernel 
symbol and abusing it in a way that was never intended. Abuse of 
kernel internals by kernel code was never a 'feature'. Just 
because you find a symbol (which is not even exported to 
drivers) does not mean you can use it like that.

If you want to work on genirq threaded IRQ handlers them please 
check out and test the threaded IRQ handlers patches that are 
being worked on at lkml. See:

[patch 0/4] genirq: add infrastructure for threaded interrupt handlers V2

	Ingo
