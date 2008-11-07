From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] atkbd: cancel delayed work before freeing its structure
Date: Fri, 7 Nov 2008 16:43:25 +0100
Message-ID: <20081107154325.GD9368@redhat.com>
References: <20081105153140.25132ca1@psychotron.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:51433 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbYKGOmh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Nov 2008 09:42:37 -0500
Content-Disposition: inline
In-Reply-To: <20081105153140.25132ca1@psychotron.englab.brq.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, Jiri Pirko <jpirko@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On 11/05, Jiri Pirko wrote:
>
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 22016ca..f3bbf49 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -824,7 +824,7 @@ static void atkbd_disconnect(struct serio *serio)
>  	atkbd_disable(atkbd);
>
>  	/* make sure we don't have a command in flight */
> -	flush_scheduled_work();
> +	cancel_delayed_work_sync(&atkbd->event_work);

Ping. Dmitry, could you take a look?


While we are here, what is the reason for atkbd_schedule_event_work()->wmb() ?
It looks absolutely bogus. Is it for atkbd_event_work() ? In that case it
is not needed, it must see all previous STOREs because both queue_work() and
run_workqueue() take cwq->lock. And in any case,
test_and_set_bit(WORK_STRUCT_PENDING) implies mb(). If schedule_delayed_work()
fails we can race with the soon-to-be-executed atkbd_event_work(), in that
case that test_and_set_bit() + test_and_clear_bit(->event_mask) save us,
but wmb() can't help again.

Another question is why do we need ->event_mutex? OK, it can serialize
multiple instances of atkbd_event_work() running on the different CPUs,
but in that case atkbd_reconnect() needs this lock too? It also calls
atkbd_set_repeat_rate/atkbd_set_leds.

I don't understand this code, don't take my words too seriously, just
curious.

Oleg.

