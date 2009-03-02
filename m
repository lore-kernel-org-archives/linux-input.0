From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Mon, 2 Mar 2009 14:09:20 -0800
Message-ID: <200903021409.21344.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200903021337.20887.david-b@pacbell.net> <1236030106.5330.1553.camel@laptop>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756478AbZCBWJg@vger.kernel.org>
In-Reply-To: <1236030106.5330.1553.camel@laptop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com
List-Id: linux-input@vger.kernel.org

On Monday 02 March 2009, Peter Zijlstra wrote:
> > > How so?, its the natural extension of that work.
> > 
> > Not the work to shrink the amount of time IRQ latencies
> > by shrinking the amount of time IRQs are disabled by
> > IRQ handlers.
> 
> Ugh, that's done by pushing work out of the hardirq context,

That's one of many techniques currently used.

Tradeoffs don't always favor larger driver updates
and re-validation though.  Sometimes it's simpler
to just leverage the reality that "hardirq context"
does not require using IRQF_DISABLED.


> not by doing silly things like enabling irqs from hardirq context.

Somehow I'm certain you have NOT analysed every one of the
thousands of IRQ handlers in various Linux drivers to know
with certainty that's not the reason IRQ_DISABLED is cleared.

There are also *other* reasons to leave IRQ_DISABLED clear.

- Dave
