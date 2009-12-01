From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Tue, 01 Dec 2009 01:07:12 +0100
Message-ID: <87bpij36bz.fsf@tac.ki.iif.hu>
References: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
	<87hbsd2b17.fsf@tac.ki.iif.hu>
	<20091130082737.GA27979@gw.healthdatacare.com>
	<20091130091420.GE10295@core.coreip.homeip.net>
	<20091130093757.GB27979@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:55858 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082AbZLAAHI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 19:07:08 -0500
In-Reply-To: <20091130093757.GB27979@gw.healthdatacare.com> (Mika Westerberg's
	message of "Mon, 30 Nov 2009 11:37:57 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Mika Westerberg <mika.westerberg@iki.fi> writes:

> On Mon, Nov 30, 2009 at 01:14:20AM -0800, Dmitry Torokhov wrote:
>
>> On Mon, Nov 30, 2009 at 10:27:37AM +0200, Mika Westerberg wrote:
>> 
>>> BTW: maybe this sharing the IRQ line between multiple buttons could be
>>> implemented with threaded irq handler? Then it can go to sleep if, for
>>> some reason, gpio_get_value() sleeps. Unfortunately I don't have such
>>> hardware so I can't test it.
>> 
>> We still need debounce support there so you still need a timer and a
>> workqueue. In the current form theraded IRQ will not buy us anything.
>
> Yes, but with threaded irq handler it should be possible to find
> out which gpio line caused the irq (via gpio_get_value()) so we can
> schedule the correct workqueue handler, right?

The principal problem is not sharing an IRQ between multiple GPIO
buttons, but between GPIO buttons and other devices.  Even if you use
threaded IRQs, you have to decide in atomic context whether the handler
thread should be woken up, and that already involves gpio_get_value()
calls.  Of course you can wake up the handler thread unconditionally,
but then

 1. you're running your handlers with IRQs enabled (IRQF_ONESHOT is not
    an option, because it isn't allowed to be shared), which could mean
    retriggering the IRQ before you could acknowledge it, and

 2. you're potentially wasting resources by waking up the handler thread
    needlessly (think about sharing the IRQ with a 115 kbaud serial
    line).

Maybe a good middle ground would be switching to threaded interrupts
only if some of the given GPIOs can sleep, and hope that in this case
the IRQ is not shared with anything speedy (or disallow it, even).  But
I'm pretty much a rookie on this field, so I won't jump on this until
the plan is acked by some authority (Dmitry? :).  This hasn't happened
yet, but critique hasn't been raised either.
-- 
Cheers,
Feri.
