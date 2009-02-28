From: David Brownell <david-b@pacbell.net>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Sat, 28 Feb 2009 14:37:05 -0800
Message-ID: <200902281437.05827.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <alpine.LFD.2.00.0902282149290.29264@localhost.localdomain> <alpine.LFD.2.00.0902282209450.29264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:33666 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753407AbZB1WhJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 17:37:09 -0500
In-Reply-To: <alpine.LFD.2.00.0902282209450.29264@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, a.p.zijlstra@chello.nl

On Saturday 28 February 2009, Thomas Gleixner wrote:
> > needs to run in a thread as well. Usually demux handlers just have a
> > fast path kicking the particular real handlers.
> 
> I looked at the code in twl4030-irq.c and I don't think that the demux
> handler needs to be setup as a chained handler at all. 
> 
> Just register it as a standard handler and let it wakeup the other irq
> threads

Not clear what you mean by that.  Did I miss a "wakeup an
irq thread" operation?  You've coupled the task to the
irqaction, not to the irq_desc.


> or is there a particular requirement that the demuxed handlers 
> need to run in the same thread context as the demux handler itself ?

The toplevel IRQ shouldn't be re-enabled until all the chained
handlers have actually handled their events ... some of those
events are level triggered too.  That needs synchronization, and
the simplest synch is to just process those demuxed events in
the same thread.

The TWL4030 family chips are a little bit quirky with respect
to IRQ handling (PIH vs SIH, SIH_CTRL.COR inconsistency, etc),
but they aren't the only chips with such requirements for their
internal IRQ controllers.

- Dave
