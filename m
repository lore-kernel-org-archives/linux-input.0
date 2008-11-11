From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] atkbd: cancel delayed work before freeing its structure
Date: Tue, 11 Nov 2008 11:30:38 -0500
Message-ID: <20081111112741.ZZRA012@mailhub.coreip.homeip.net>
References: <20081105153140.25132ca1@psychotron.englab.brq.redhat.com> <20081107154325.GD9368@redhat.com> <20081111145155.GA24881@anvil.corenet.prv> <20081111172050.GC18214@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:42362 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYKKQal (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 11:30:41 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1910973rnd.17
        for <linux-input@vger.kernel.org>; Tue, 11 Nov 2008 08:30:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081111172050.GC18214@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Pirko <jpirko@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Nov 11, 2008 at 06:20:50PM +0100, Oleg Nesterov wrote:
> On 11/11, Dmitry Torokhov wrote:
> >
> > On Fri, Nov 07, 2008 at 04:43:25PM +0100, Oleg Nesterov wrote:
> > >
> > > While we are here, what is the reason for atkbd_schedule_event_work()->wmb() ?
> > > It looks absolutely bogus. Is it for atkbd_event_work() ? In that case it
> > > is not needed, it must see all previous STOREs because both queue_work() and
> > > run_workqueue() take cwq->lock. And in any case,
> > > test_and_set_bit(WORK_STRUCT_PENDING) implies mb().
> >
> > I wanted to be sure that event_mask is set before we schedule event_work
> > and I don't want to rely on details of queue_delayed_work
> > implementation. If the fact that queue_delayed_work acts as a barrier
> > would be listed part of its published spec I would gladly remove wmb()
> > from atkbd.
> 
> Yes, queue_delayed_work() acts as a barrier for the work->func(), otherwise
> almost any code which uses wqs is broken.
> 
> But let me repeat, if queue_delayed_work() fails becuase this work is
> already queued we (in this particular case) need mb(), not wmb(). Or
> atkbd_schedule_event_work() can miss a bit in ->event_mask. So I think
> this wmb() is misleading.

Could you please explain why wmb() is not enough and full mb() is
needed in this case? I thought that if write happens before we decide
whether to schedule event_work or not it would be enough.

> And unneeded because queue_work() implies mb(),
> but this is not really documented.
> 

It would be great if we can get it documented and then i'd drop *mb()
from atkbd.

Thanks.

-- 
Dmitry
