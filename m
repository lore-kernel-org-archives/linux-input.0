From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: gpio_get_value in atomic context
Date: Wed, 09 Dec 2009 14:33:22 +0100
Message-ID: <873a3kgtlp.fsf@tac.ki.iif.hu>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
	<87eip6jkzr.fsf_-_@tac.ki.iif.hu>
	<d6200be20910140440t2357cb4fx5f7aeba0d4b15943@mail.gmail.com>
	<200911271708.01727.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:38284 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755659AbZLINdT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 08:33:19 -0500
In-Reply-To: <200911271708.01727.david-b@pacbell.net> (David Brownell's
	message of "Fri, 27 Nov 2009 17:08:01 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, linux-input@vger.kernel.org

David Brownell <david-b@pacbell.net> writes:

> On Wednesday 14 October 2009, Arve Hj=C3=B8nnev=C3=A5g wrote:
>
>>> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>>>
>>>> On Mon, Oct 12, 2009 at 07:09:50PM +0200, Ferenc Wagner wrote:
>>>>
>>>>> =C2=A0 =C2=A0 The gpio_get_value function may sleep, so it should=
 not be
>>>>> =C2=A0 =C2=A0 called in a timer function.
>>>>>
>>>>> So is drivers/staging/dream/gpio_input.c in error, too?
>>>>
>>>> I guess so. Initially gpio method did not sleep but that has
>>>> changed.
>>=20
>> If gpio_get_value may sleep, then what is gpio_get_value_cansleep fo=
r?
>
> To tell if this is one of the GPIOs for which it may sleep.

Isn't that gpio_cansleep()?

> Whether the GPIO is atomic vs cansleep is an attribute of the
> GPIO itself, not the routine it's called with.

My reading of Documentation/gpio.txt implies that actually it is,
because gpio_get_value() is ignored for GPIOs which can sleep:

    Other than the fact that these (gpio_[sg]et_value_cansleep) calls
    might sleep, and will not be ignored for GPIOs that can't be
    accessed from IRQ handlers, these calls act the same as the
    spinlock-safe calls.

>> The gpio documentation claims gpio_get_value and gpio_set_value are
>> safe to use from interrupt context, but a call to gpio_cansleep is
>> probably needed in probe.
>
> They're safe to use there ... if that GPIO is safe.  Yes, make sure
> you know the answer before you call gpio_get_value() instead of
> the always-safe gpio_get_value_cansleep().

Always-safe, meaning never ignored?  They surely aren't safe to use in
atomic context...

>> The matrix driver also need to change the direction of the gpio from
>> the timer, so it would be useful to have a standard way to check if
>> this is allowed as well.
>
> If gpio_{set,get}_value() can sleep, so can gpio_direction_*().

As above, in my reading gpio_[sg]et_value() cannot sleep, but are
ignored for the sleepy GPIOs.  Also, from the documentation:

    Also, using these calls for GPIOs that can't safely be accessed
    without sleeping is an error.

I'd deeply appreciate some further clarification of the above, and
possibly on the problems outlined in the thread
http://thread.gmane.org/gmane.linux.kernel.input/8775/focus=3D9153.  Is=
 it
possible to use level triggered shared IRQs for GPIOs which can sleep?
If yes, how?

Using a nested handler would be a possibility, if I could assume that
the irqchips belonging to sleepy GPIOs are always sleepy as well
(ie. their dispatchers run in a separate thread with the IRQ disabled).
Is that the case by any chance?
--=20
Thanks,
=46eri.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
