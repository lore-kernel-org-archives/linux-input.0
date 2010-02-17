From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] input: polldev can cause crash in case of polling
	disabled
Date: Wed, 17 Feb 2010 17:28:47 +0100
Message-ID: <20100217162847.GA10249@redhat.com>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com> <20100216175047.GB15376@core.coreip.homeip.net> <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com> <20100216214309.GC15376@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64713 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab0BQQ3j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 11:29:39 -0500
Content-Disposition: inline
In-Reply-To: <20100216214309.GC15376@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: samu.p.onkalo@nokia.com, linux-input@vger.kernel.org

On 02/16, Dmitry Torokhov wrote:
>
> On Tue, Feb 16, 2010 at 07:37:49PM +0100, samu.p.onkalo@nokia.com wrote:
> >
> > Queue_delayed_work updates the work struct. Workqueue itself is ok.
> >
> > I think that the sequence goes about this way (no other polled devices open):
> > 1. Polled device is opened with polling enabled
> > 2. It first creates workqueue and then queue the first polling. Kernels
> > Workqueue functions updates current workqueue information to the work-struct
> > 3. polled device is closed
> > 4. workqueue is destroyed
> >
> > 5. polling interval is set to 0
> > 6. device is reopened
> > 7. New workqueue is created
> > 8. polled device is closed without queueing a work
> > 9. work struct for polled device contains pointer to the old (created in 2.) wq
> > 10. cancel_workqueue... can access unallocated memory causing crash.
> >
>
> Ah, I see. In this case I think it should be fixed in workqueue code by
> clearing work data so it does not point to the [potentially] non-existing
> workqueue when we cancel

I think yes, cancel_() can clear ->data. Instead of work_clear_pending()
__cancel_work_timer() should do something like
"work->data &= ~WORK_STRUCT_STATIC", but we should somehow do this
atomically, to avoid the race with test_and_set_bit(PENDING).

> or complete work.

No, run_workqueue() can't do this.

First of all, we shouldn't clear work->data before work->func() returns,
and when it returns we must not use this pointer: the work can be already
freed/reused.

But even if we could do this, it would be wrong. This can break flush
or cancel, the same work can be queued/running again (on the same or
other CPUs).

Oleg.

