From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Wed, 30 Sep 2015 04:50:17 -0400
Message-ID: <20150930045017.303f24de@gandalf.local.home>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com>
	<alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz>
	<CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com>
	<alpine.LNX.2.00.1509291117280.30132@pobox.suse.cz>
	<CA+icZUWH2vR_vpYu4hCS578U3ssmoiF0pLYUfM-Xo-57e8uN=g@mail.gmail.com>
	<CA+icZUUV5cOpUqsx7PAvfi3hs9pa11=DXH=BEbjGnOJ+kDi_5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:46659 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750953AbbI3IuU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 04:50:20 -0400
In-Reply-To: <CA+icZUUV5cOpUqsx7PAvfi3hs9pa11=DXH=BEbjGnOJ+kDi_5Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Wed, 30 Sep 2015 08:41:57 +0200
Sedat Dilek <sedat.dilek@gmail.com> wrote:

> > What shall I do... play with lockdep (print_irqtrace_events) in
> > del_timer_sync()?
> 
> I recalled that when Jiri was thinking towards a "compiler bug" that
> the part in del_timer_sync() emebedded in the "ifdef CONFIG_LOCKDEP"
> is somehow "mis-compiled".
> Furthermore, I see that try_to_del_timer_sync() is invoked within
> del_timer_sync() which does a spin_unlock_irqrestore().

Which is fine.

> 
> [ kernel/time/timer.c ]
> 
> int del_timer_sync(struct timer_list *timer)
> {
> #ifdef CONFIG_LOCKDEP
> unsigned long flags;
> 
> /*
> * If lockdep gives a backtrace here, please reference
> * the synchronization rules above.
> */
> local_irq_save(flags);
> lock_map_acquire(&timer->lockdep_map);
> lock_map_release(&timer->lockdep_map);
> local_irq_restore(flags);
> #endif
> /*
> * don't use it in hardirq context, because it
> * could lead to deadlock.
> */
> WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
> for (;;) {
> int ret = try_to_del_timer_sync(timer);
> if (ret >= 0)
> return ret;
> cpu_relax();
> }
> }
> EXPORT_SYMBOL(del_timer_sync);
> #endif
> ...
> int try_to_del_timer_sync(struct timer_list *timer)
> {
> struct tvec_base *base;
> unsigned long flags;
> int ret = -1;
> 
> debug_assert_init(timer);
> 
> base = lock_timer_base(timer, &flags);

lock_timer_base() will grab the base->lock and save the current state
of interrupts in flags, and then disable interrupts.

> 
> if (base->running_timer != timer) {
> timer_stats_timer_clear_start_info(timer);
> ret = detach_if_pending(timer, base, true);
> }
> spin_unlock_irqrestore(&base->lock, flags);

this will release the base->lock and put the interrupt state back to
what it was before it took the lock.

I still don't see anything wrong with the code.

-- Steve

> 
> return ret;
> }
> EXPORT_SYMBOL(try_to_del_timer_sync);
> ...
> 
> Is the attached patch suitable for a test?
> 
> I remember I tried to turn lockdep kernel-config for amd64 but that
> was somehow tricky.
> 
> Shall I ask timer folks?
> 
> Thoughts?
> 
> Thanks!
> 
> - Sedat -

