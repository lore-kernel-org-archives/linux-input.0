From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hidraw: fix list->buffer race condition
Date: Mon, 10 Oct 2016 10:36:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1610101019040.31629@cbobk.fhfr.pm>
References: <1475628266-4767-1-git-send-email-gary.king@oculus.com> <alpine.LNX.2.00.1610071038340.31629@cbobk.fhfr.pm> <alpine.OSX.1.10.1610071027351.23556@cromulentg-mba.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57525 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751076AbcJJJxn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Oct 2016 05:53:43 -0400
In-Reply-To: <alpine.OSX.1.10.1610071027351.23556@cromulentg-mba.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gary King <gary.king@oculus.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org

On Fri, 7 Oct 2016, Gary King wrote:

> > > diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> > > index f0e2757..dc3465f 100644
> > > --- a/drivers/hid/hidraw.c
> > > +++ b/drivers/hid/hidraw.c
> > > @@ -53,6 +53,7 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
> > >  	mutex_lock(&list->read_mutex);
> > >  
> > >  	while (ret == 0) {
> > > +		smp_rmb();
> > 
> > Which _wmb() does this one pair with?
> 
> The _rmb() operations don't really pair with the _wmb()

That unfortunately immediately implies that its usage is incorrect though.

[ ... snip ... ]
> > I think this is just papering the real problem (missing list_lock) over in 
> > an odd way; could you please look into whether locking list_lock properly 
> > would resolve the crashes you're able to trigger on your ARM system?
> 
> list_lock does not appear to be a good solution for this, since it is
> currently an IRQ-safe spinlock on the device. Using it would cause 
> _read() to have unnecessary lock contention if the device is opened 
> and read simultaneously from multiple fds, and every loop iteration would 
> need to acquire the spinlock / disable interrupts at least once.

We could make the spinlock per struct file *, which'd remove the 
contention bottleneck when the same device is accessed from through 
multiple fds, but still maintain the correctness (as the list itself is a 
per-fd thing anyway).

Probably introducing new spinlock would make more sense, as list_lock is 
currently being used mostly to protect accessing of the dev->list linked 
list.

> (Separately, the current locking design seems dangerous to me, since the 
> amount of time spent with interrupts disabled in the current 
> implementation may be arbitrarily long (the device may be opened 
> multiple times, and the hidraw event buffer that is kmemdup'd for each 
> open fd may be large), 

We're memduping with GFP_ATOMIC of course, so there is really no 
bottleneck there.

Thanks,

-- 
Jiri Kosina
SUSE Labs

