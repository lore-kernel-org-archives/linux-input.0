From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] usbhid: Fix lockdep unannotated irqs-off warning
Date: Wed, 30 Sep 2015 09:35:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509300918090.30132@pobox.suse.cz>
References: <1443427804-2957-1-git-send-email-sedat.dilek@gmail.com> <alpine.LNX.2.00.1509281329261.30132@pobox.suse.cz> <CA+icZUWXcNue2kx0nLzAmJeaYVgcpqT3Zz8cuRkQDcT93n4U+w@mail.gmail.com> <alpine.LNX.2.00.1509291117280.30132@pobox.suse.cz>
 <CA+icZUWH2vR_vpYu4hCS578U3ssmoiF0pLYUfM-Xo-57e8uN=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42200 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754817AbbI3HfX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 03:35:23 -0400
In-Reply-To: <CA+icZUWH2vR_vpYu4hCS578U3ssmoiF0pLYUfM-Xo-57e8uN=g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Wed, 30 Sep 2015, Sedat Dilek wrote:

> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > index 36712e9..aaae42e 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -38,6 +38,8 @@
> >  #include <linux/hidraw.h>
> >  #include "usbhid.h"
> >
> > +#include <linux/lockdep.h>
> > +
> >  /*
> >   * Version Information
> >   */
> > @@ -725,6 +727,9 @@ void usbhid_close(struct hid_device *hid)
> >
> >         mutex_lock(&hid_open_mut);
> >
> > +       if(WARN_ON(irqs_disabled()))
> > +               print_irqtrace_events(current);
> > +
> >         /* protecting hid->open to make sure we don't restart
> >          * data acquistion due to a resumption we no longer
> >          * care about
> >
> > --
> 
> "-7" CLANG-compiled and "-8" GCC-compiled.

So, my warning didn't trigger in neither of the kernels. That directly 
implies that usbbhid_close() is being called with IRQs enabled, and 
therefore once it calls hid_cancel_delayed_stuff(), they are enabled 
again. That makes the previous warnings invalid, and I would dare to blame 
compiler on that.

Now, in this case, clang apparently got it right (because the original 
warning didn't trigger) in usbhid_close(), but moved the bug elsewhere 
somehow. Now the warning looks like this:

>  BUG: sleeping function called from invalid context at kernel/workqueue.c:2678
>  in_atomic(): 0, irqs_disabled(): 1, pid: 1474, name: acpid

So again, IRQs disabled.

>  3 locks held by acpid/1474:
>   #0:  (&evdev->mutex){+.+...}, at: [<ffffffff8174c98c>] evdev_release+0xbc/0xf0
>   #1:  (&dev->mutex#2){+.+...}, at: [<ffffffff817440a7>] input_close_device+0x27/0x70
>   #2:  (hid_open_mut){+.+...}, at: [<ffffffffa0056388>] usbhid_close+0x28/0xf0 [usbhid]

No spinlock held, so all _irqsave() / _irqrestore() pairs have been 
executed.

>  irq event stamp: 3332
>  hardirqs last  enabled at (3331): [<ffffffff8192ccd2>] _raw_spin_unlock_irq+0x32/0x60
>  hardirqs last disabled at (3332): [<ffffffff81122127>] del_timer_sync+0x37/0x110

del_timer_sync() is being blamed to be the one leaking IRQs disabled. The 
only two things that this function does (even if you look at all functions 
that could be potentially inlined into it) wrt. IRQs are

(1)        local_irq_save(flags);
           lock_map_acquire(&timer->lockdep_map);
           lock_map_release(&timer->lockdep_map);
           local_irq_restore(flags);

(2)	   lock_timer_base() calls spin_lock_irqsave() and 
	   spin_unlock_irqrestore() in pairs in a loop, but it's 
	   guaranteed to return with IRQs disabled, and corresponding 
	   spin_unlock_irqrestore() is then perfomed in the callee 
	   (try_to_del_timer_sync())

In either case, there is no IRQ state leakage. Therefore I would dare to 
blame compiler on getting it wrong here as well.

The generated assembly really needs to be inspected to see how does clang 
manage to leak the IRQ state (probably some incorrect reordering, i.e. not 
respecting the "memory" clobber while fiddling with flags).

[ ... snip a lot of stuff ... ]
> What shall I do... play with lockdep (print_irqtrace_events) in
> del_timer_sync()?

I'd suggest showing this to clang folks.

Thanks,

-- 
Jiri Kosina
SUSE Labs

