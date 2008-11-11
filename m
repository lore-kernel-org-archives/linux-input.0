From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] atkbd: cancel delayed work before freeing its structure
Date: Tue, 11 Nov 2008 18:20:50 +0100
Message-ID: <20081111172050.GC18214@redhat.com>
References: <20081105153140.25132ca1@psychotron.englab.brq.redhat.com> <20081107154325.GD9368@redhat.com> <20081111145155.GA24881@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753719AbYKKQU1@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081111145155.GA24881@anvil.corenet.prv>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Pirko <jpirko@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 11/11, Dmitry Torokhov wrote:
>
> On Fri, Nov 07, 2008 at 04:43:25PM +0100, Oleg Nesterov wrote:
> >
> > While we are here, what is the reason for atkbd_schedule_event_work()->wmb() ?
> > It looks absolutely bogus. Is it for atkbd_event_work() ? In that case it
> > is not needed, it must see all previous STOREs because both queue_work() and
> > run_workqueue() take cwq->lock. And in any case,
> > test_and_set_bit(WORK_STRUCT_PENDING) implies mb().
>
> I wanted to be sure that event_mask is set before we schedule event_work
> and I don't want to rely on details of queue_delayed_work
> implementation. If the fact that queue_delayed_work acts as a barrier
> would be listed part of its published spec I would gladly remove wmb()
> from atkbd.

Yes, queue_delayed_work() acts as a barrier for the work->func(), otherwise
almost any code which uses wqs is broken.

But let me repeat, if queue_delayed_work() fails becuase this work is
already queued we (in this particular case) need mb(), not wmb(). Or
atkbd_schedule_event_work() can miss a bit in ->event_mask. So I think
this wmb() is misleading. And unneeded because queue_work() implies mb(),
but this is not really documented.

Oleg.
