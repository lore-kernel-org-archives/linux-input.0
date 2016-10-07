From: Gary King <gary.king@oculus.com>
Subject: Re: [PATCH] hidraw: fix list->buffer race condition
Date: Fri, 7 Oct 2016 10:30:19 -0700
Message-ID: <alpine.OSX.1.10.1610071027351.23556@cromulentg-mba.local>
References: <1475628266-4767-1-git-send-email-gary.king@oculus.com> <alpine.LNX.2.00.1610071038340.31629@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757021AbcJGRbA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Oct 2016 13:31:00 -0400
In-Reply-To: <alpine.LNX.2.00.1610071038340.31629@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Gary King <gary.king@oculus.com>, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org

Hi Jiri,

> > hidraw input events are stored for each file descriptor in a lockless
> > circular queue. 
> 
> Well, there is a per-hidraw device list_lock; but you're right that it's 
> usage throughout hidraw.c is probably incomplete and that should be fixed.

The complication with list_lock is that it is a spin-lock (and IRQ-safe
at that), and I did not want to introduce multiple IRQ-safe spinlock
acquires in hidraw_read (either via list_lock or by addings a per-fd
spinlock) without a substantially better test configuration than my
environment is able to accommodate.

> > ---
> >  drivers/hid/hidraw.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> > index f0e2757..dc3465f 100644
> > --- a/drivers/hid/hidraw.c
> > +++ b/drivers/hid/hidraw.c
> > @@ -53,6 +53,7 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
> >  	mutex_lock(&list->read_mutex);
> >  
> >  	while (ret == 0) {
> > +		smp_rmb();
> 
> Which _wmb() does this one pair with?

The _rmb() operations don't really pair with the _wmb(), and aren't
needed for correctness (I should have cleaned this up before providing 
the patch, sorry). Using _rmb() here (and below) reduces rare chances
that the buffer is incorrectly detected as full / empty due to reads
being reordered across loop iterations when a second core enters
_read() / _report_event().

> >  		if (list->head == list->tail) {
> >  			add_wait_queue(&list->hidraw->wait, &wait);
> >  			set_current_state(TASK_INTERRUPTIBLE);
> > @@ -98,7 +99,9 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
> >  
> >  		kfree(list->buffer[list->tail].value);
> >  		list->buffer[list->tail].value = NULL;
> > +		smp_wmb();
> >  		list->tail = (list->tail + 1) & (HIDRAW_BUFFER_SIZE - 1);
> > +		smp_wmb();
> 
> This is completely confusing; it seems like you imply that those two 
> _wmb() should pair together, but that makes no sense. Please always, when 
> using SMP barriers, document which _rmb() pairs to which _wmb(), otherwise 
> the rules become quickly totally unclear.

Upon further review, I believe the second _wmb is unnecessary, and
redundant with memory barrier operations performed either by subsequent
loop iterations or by the mutex_unlock operation (I originally included it
to reduce the window in which a free entry in the circular queue was
unobservable to other cores, forgetting that the barrier would also be
provided by subsequent loop iterations or the mutex_unlock below).

The fundamental problem we encountered was that changes to the list->tail 
and list->head values were visible on other processors before the 
corresponding changes to list->buffer and list->buffer[N].

> >  	}
> >  out:
> >  	mutex_unlock(&list->read_mutex);
> > @@ -487,7 +490,7 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
> >  	spin_lock_irqsave(&dev->list_lock, flags);
> >  	list_for_each_entry(list, &dev->list, node) {
> >  		int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
> > -
> > +		smp_rmb();
> >  		if (new_head == list->tail)
> 
> Again, which _wmb() does this one pair with please?
>
> >  			continue;
> >  
> > @@ -496,7 +499,9 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
> >  			break;
> >  		}
> >  		list->buffer[list->head].len = len;
> > +		smp_wmb();
> >  		list->head = new_head;
> > +		smp_wmb();
> 
> Same as in hidraw_read(), I completely fail to see the point of having two 
> here. Which read side does each of those pair with?
> 
> I think this is just papering the real problem (missing list_lock) over in 
> an odd way; could you please look into whether locking list_lock properly 
> would resolve the crashes you're able to trigger on your ARM system?

list_lock does not appear to be a good solution for this, since it is
currently an IRQ-safe spinlock on the device. Using it would cause 
_read() to have unnecessary lock contention if the device is opened 
and read simultaneously from multiple fds, and every loop iteration would 
need to acquire the spinlock / disable interrupts at least once.

(Separately, the current locking design seems dangerous to me, since the 
amount of time spent with interrupts disabled in the current 
implementation may be arbitrarily long (the device may be opened
multiple times, and the hidraw event buffer that is kmemdup'd for each
open fd may be large), but I wanted to supply a patch that fixed the
crash before embarking on any more substantial changes to the stack.)

The patch I supplied should be functionally correct when reduced to just 
two calls to smp_wmb(): one preceding the update to list->tail in 
_read(), one preceding the update to list-head in _report_event(). I'm 
happy to make and test this change.

- Gary
