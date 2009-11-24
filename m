From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Tue, 24 Nov 2009 19:39:28 +0100
Message-ID: <87k4xfojhb.fsf@tac.ki.iif.hu>
References: <20091120084054.GC3009@core.coreip.homeip.net>
	<cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
	<cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
	<8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com>
	<87y6lxchwf.fsf@tac.ki.iif.hu>
	<20091123172451.GD17813@core.coreip.homeip.net>
	<87tywlcbyr.fsf@tac.ki.iif.hu>
	<20091124063711.GL17675@esdhcp04058.research.nokia.com>
	<87my2cp4h6.fsf@tac.ki.iif.hu>
	<20091124170249.GQ17675@esdhcp04058.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:37298 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932245AbZKXSjY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2009 13:39:24 -0500
In-Reply-To: <20091124170249.GQ17675@esdhcp04058.research.nokia.com> (Mika
	Westerberg's message of "Tue, 24 Nov 2009 19:02:49 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:

> On Tue, Nov 24, 2009 at 12:05:57PM +0100, ext Ferenc Wagner wrote:
>
>>>> Or let for example -1 mean 0, which is ugly, to say the least.
>>>
>>> How about adding (again) new field: bool custom_irqflags?
>> 
>> Thinking about it, since multiple buttons can share a single IRQ, this
>> can't be a per-button field after all.  Perhaps a better solution would
>> be adding a new mapping to the platform data:
>> 
>> struct gpio_keys_irq {
>>         int irq;
>>         int irqflags;
>>         int wakeup;                 /* replace the per-button field */
>> }
>> 
>> struct gpio_keys_platform_data {
>>         struct gpio_keys_button *buttons;
>>         int nbuttons;
>>         unsigned int rep:1;
>>         struct gpio_keys_irq *irqs; /* new member */
>>         int nirqs;                  /* new member */
>> };
>
> OK. This seems reasonable.

But mind the comment below.

>>> In our case, we only have 1:1 mapping between GPIO lines and buttons
>>> so current version works but if there are any (possible) users for
>>> this kind of setup I can implement it.
>> 
>> I quoted (and own) a platform with such arrangement.  I'm somewhat
>> short on time to work on this hobby project, but of course I don't
>> expect you to do the heavy lifting.  Unfortunately I haven't yet
>> managed to get a clear picture about how to properly attack it (the
>> problem is GPIO access from the IRQ handler, if you didn't read the
>> thread), so I couldn't produce acceptable code (even though in my
>> case gpio_get_value can't sleep, so I've got working code).
>> Meanwhile, I'm trying to do my best to not let things go in a
>> direction which makes this change harder that it currently is.  I'm
>> really sorry this hurts your efforts.
>
> Thanks for clarifying things. It really don't hurt my efforts; I get
> paid for doing this :)
>
> So I'll try to implement this gpio-keys muting so that it allows
> also multiple buttons to share single IRQ line.

Thanks.  But you'd better wait for Dmitry's response, because I'm by no
means authoritative in this business.
-- 
Regards,
Feri.
