From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH] input: make gpio-keys use IRQF_SHARED
Date: Thu, 01 Oct 2009 16:02:15 +0200
Message-ID: <87fxa3xleg.fsf@tac.ki.iif.hu>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
	<20090916162853.GA4970@core.coreip.homeip.net>
	<87hbuvggfl.fsf@tac.ki.iif.hu>
	<20090922164136.GA22639@core.coreip.homeip.net>
	<87fxae3ile.fsf@tac.ki.iif.hu>
	<20090928170301.GG21455@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:40866 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756320AbZJAOCP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2009 10:02:15 -0400
In-Reply-To: <20090928170301.GG21455@core.coreip.homeip.net> (Dmitry
	Torokhov's message of "Mon, 28 Sep 2009 10:03:01 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-input@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Tue, Sep 22, 2009 at 09:06:05PM +0200, Ferenc Wagner wrote:
>
>> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>>=20
>>> On Tue, Sep 22, 2009 at 05:14:22PM +0200, Ferenc Wagner wrote:
>>>
>>>>     The gpio_get_value function may sleep, so it should not be
>>>>     called in a timer function.
>>>>=20
>>>> But I don't see why it could sleep, is that really the case?
>>>
>>> There are things like i2c gpio extenders that require access to
>>> slow buses and can sleep.
>>
>> Please read my other reply in this thread before the following.
>> All this seems to mean that using level triggered interrupts on
>> such devices is impossible, unless we find a way to acknowledge the
>> interrupt without GPIO access.
>
> You probably want to look into threaded interrupt handlers and
> IRQF_ONESHOT. These can't be shared though, so it looks like you
> need nested IRQ handlers infrastructure.

This sounds like a job for the irqchip setup code, if I understand
http://lkml.org/lkml/2009/8/15/133 correctly, that is, no driver
business.  Doesn't that apply only when the irqchip itself is on a
slow bus?  I find IRQF_ONESHOT more relevant, and sharing such a beast
would be possible in principle, although a little complicated, as
http://lkml.org/lkml/2009/8/15/131 asserts.  But still, how would the
somewhat more latency-sensitive serial port on the same interrupt line
tolerate its interrupt staying masked for a considerable period?  Even
if there was no hardware which shared interrupts between slow and fast
devices (which I hope), a driver blindly using oneshot interrupts
would unnecessarily add the scheduling delay to the masked period
instead of acknowledging and unmasking the line from hardirq context.
Please correct me if I got these wrong.

On the other hand, querying gpio_cansleep could be used to avoid this,
and I can't conceive how the IRQ core could find out and do what's
best for the driver in such cases.

>> But level triggering is needed for sharing.
>
> I believe that both level and edge-triggered interrupts can be shared=
=2E

Sure, but all parties must agree on the trigger type, and level
triggering seems to be the norm (I've read
http://lkml.org/lkml/1998/8/7/30 on the unreliability of shared edge
triggered interrupts, but I don't buy Linus' argument, because the
system should keep asking the devices until none of them needs
servicing -- ineffective, but reliable).  Anyway, in my (and therefore
the most important) case the serial console grabs the interrupt first,
and although it's willing to share it, it uses level triggering, so
I've got no choice.

>>>> Also, commit 57ffe9d539e0eb741bb9ca8f2834d210e70ee2e3 removed the
>>>> possibility of telling apart different keys, so that should be
>>>> reverted during the process.  I already asked Uwe Kleine-K=C3=B6ni=
g
>>>> about the whys, but didn't get a reply.
>>>
>>> I don't see why you say that... You request IRQ per button and you =
get
>>> that button structure as argument in the interrupt handler.
>>=20
>> In practice, several buttons often share a single IRQ line, possibly
>> even with other hardware, like the serial port in my case (as
>> described in my other reply).  So generally you need the full platfo=
rm
>> data for all GPIO buttons in the handler, to find out which generate=
d
>> the interrupt.
>
> Your interrupt handler will get called for every button on that IRQ l=
ine
> and you can query button state I think.

Well, yes, if I register the handler once for each button.  Is that
really preferable?  It didn't occur to me as the current code does not
use shared interrupts, so it's out of question.  Sigh, the generic
GPIO interface is already rather inefficient, accessing only a single
bit per call (cf. the first block comment in tosakbd.c)...
Or did I get you wrong again?
--=20
Thanks,
=46eri.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
