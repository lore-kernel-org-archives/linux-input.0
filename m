From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] atkbd: cancel delayed work before freeing its structure
Date: Tue, 11 Nov 2008 09:51:56 -0500
Message-ID: <20081111145155.GA24881@anvil.corenet.prv>
References: <20081105153140.25132ca1@psychotron.englab.brq.redhat.com> <20081107154325.GD9368@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:32294 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479AbYKKOwB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 09:52:01 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1176476yxm.1
        for <linux-input@vger.kernel.org>; Tue, 11 Nov 2008 06:52:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081107154325.GD9368@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Pirko <jpirko@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Nov 07, 2008 at 04:43:25PM +0100, Oleg Nesterov wrote:
> On 11/05, Jiri Pirko wrote:
> >
> > diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> > index 22016ca..f3bbf49 100644
> > --- a/drivers/input/keyboard/atkbd.c
> > +++ b/drivers/input/keyboard/atkbd.c
> > @@ -824,7 +824,7 @@ static void atkbd_disconnect(struct serio *serio)
> >  	atkbd_disable(atkbd);
> >
> >  	/* make sure we don't have a command in flight */
> > -	flush_scheduled_work();
> > +	cancel_delayed_work_sync(&atkbd->event_work);
> 
> Ping. Dmitry, could you take a look?
> 

Applied, thank you.

> 
> While we are here, what is the reason for atkbd_schedule_event_work()->wmb() ?
> It looks absolutely bogus. Is it for atkbd_event_work() ? In that case it
> is not needed, it must see all previous STOREs because both queue_work() and
> run_workqueue() take cwq->lock. And in any case,
> test_and_set_bit(WORK_STRUCT_PENDING) implies mb().

I wanted to be sure that event_mask is set before we schedule event_work
and I don't want to rely on details of queue_delayed_work
implementation. If the fact that queue_delayed_work acts as a barrier
would be listed part of its published spec I would gladly remove wmb()
from atkbd.

> If schedule_delayed_work()
> fails we can race with the soon-to-be-executed atkbd_event_work(), in that
> case that test_and_set_bit() + test_and_clear_bit(->event_mask) save us,
> but wmb() can't help again.
> 
> Another question is why do we need ->event_mutex? OK, it can serialize
> multiple instances of atkbd_event_work() running on the different CPUs,
> but in that case atkbd_reconnect() needs this lock too? It also calls
> atkbd_set_repeat_rate/atkbd_set_leds.

Probably, I will need to thiknk about it a bit more.

-- 
Dmitry
