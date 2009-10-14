From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH] input: make gpio-keys use IRQF_SHARED
Date: Wed, 14 Oct 2009 13:25:22 +0200
Message-ID: <87aazujjz1.fsf@tac.ki.iif.hu>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
	<20090916162853.GA4970@core.coreip.homeip.net>
	<87hbuvggfl.fsf@tac.ki.iif.hu>
	<20090922164136.GA22639@core.coreip.homeip.net>
	<87fxae3ile.fsf@tac.ki.iif.hu>
	<20090928170301.GG21455@core.coreip.homeip.net>
	<87fxa3xleg.fsf@tac.ki.iif.hu> <877hv0y1wh.fsf@tac.ki.iif.hu>
	<20091014080437.GF5318@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:39763 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbZJNL0A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2009 07:26:00 -0400
In-Reply-To: <20091014080437.GF5318@core.coreip.homeip.net> (Dmitry Torokhov's
	message of "Wed, 14 Oct 2009 01:04:38 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Mon, Oct 12, 2009 at 07:09:50PM +0200, Ferenc Wagner wrote:
>
>> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>>
>>> On Tue, Sep 22, 2009 at 09:06:05PM +0200, Ferenc Wagner wrote:
>>>
>>>> Please read my other reply in this thread before the following.
>>>> All this seems to mean that using level triggered interrupts on
>>>> such devices is impossible, unless we find a way to acknowledge th=
e
>>>> interrupt without GPIO access.
>>>
>>> You probably want to look into threaded interrupt handlers and
>>> IRQF_ONESHOT. These can't be shared though, so it looks like you
>>> need nested IRQ handlers infrastructure.
>>
>> This sounds like a job for the irqchip setup code, if I understand
>> http://lkml.org/lkml/2009/8/15/133 correctly, that is, no driver
>> business.  Doesn't that apply only when the irqchip itself is on a
>> slow bus?  I find IRQF_ONESHOT more relevant, and sharing such a bea=
st
>> would be possible in principle, although a little complicated, as
>> http://lkml.org/lkml/2009/8/15/131 asserts.  But still, how would th=
e
>> somewhat more latency-sensitive serial port on the same interrupt li=
ne
>> tolerate its interrupt staying masked for a considerable period?  Ev=
en
>> if there was no hardware which shared interrupts between slow and fa=
st
>> devices (which I hope), a driver blindly using oneshot interrupts
>> would unnecessarily add the scheduling delay to the masked period
>> instead of acknowledging and unmasking the line from hardirq context=
=2E
>> Please correct me if I got these wrong.

I'd appreciate hearing your opinion on the above, too.

>> On the other hand, querying gpio_cansleep could be used to avoid thi=
s,
>> and I can't conceive how the IRQ core could find out and do what's
>> best for the driver in such cases.

And on this...

>>>> But level triggering is needed for sharing.
>>>
>>> I believe that both level and edge-triggered interrupts can be shar=
ed.
>>
>> Sure, but all parties must agree on the trigger type, and level
>> triggering seems to be the norm (I've read
>> http://lkml.org/lkml/1998/8/7/30 on the unreliability of shared edge
>> triggered interrupts, but I don't buy Linus' argument, because the
>> system should keep asking the devices until none of them needs
>> servicing -- ineffective, but reliable).  Anyway, in my (and therefo=
re
>> the most important) case the serial console grabs the interrupt firs=
t,
>> and although it's willing to share it, it uses level triggering, so
>> I've got no choice.

This scheme depends on triggering on the falling edge or otherwise
polling until the line goes inactive again, so that new interrupts can
be registered.  Sounds not so good.  But anyway, it's mostly academic
pondering, as we're dealing with level-triggered interrupts now.

>>>>> On Tue, Sep 22, 2009 at 05:14:22PM +0200, Ferenc Wagner wrote:
>>>>>
>>>>>> Also, commit 57ffe9d539e0eb741bb9ca8f2834d210e70ee2e3 removed th=
e
>>>>>> possibility of telling apart different keys, so that should be
>>>>>> reverted during the process.  I already asked Uwe Kleine-K=C3=B6=
nig
>>>>>> about the whys, but didn't get a reply.
>>>>>
>>>>> I don't see why you say that... You request IRQ per button and yo=
u get
>>>>> that button structure as argument in the interrupt handler.
>>>>=20
>>>> In practice, several buttons often share a single IRQ line, possib=
ly
>>>> even with other hardware, like the serial port in my case (as
>>>> described in my other reply).  So generally you need the full plat=
form
>>>> data for all GPIO buttons in the handler, to find out which genera=
ted
>>>> the interrupt.
>>>
>>> Your interrupt handler will get called for every button on that IRQ=
 line
>>> and you can query button state I think.
>>
>> Well, yes, if I register the handler once for each button.  Is that
>> really preferable?  It didn't occur to me as the current code does n=
ot
>> use shared interrupts, so it's out of question.  Sigh, the generic
>> GPIO interface is already rather inefficient, accessing only a singl=
e
>> bit per call (cf. the first block comment in tosakbd.c)...
>
> I think it simplifies thigs a bit. After all we are not talking about
> device delivering interrupts constantly at a very high rate so
> simplicity may be preferable over ultimate performance here.

I see, but I also feel like the simplification is at most negligible.
The very same code which installs the one-button-handlers could be
used in a single handler to test each gpio in turn.  And we don't go
against common practice.
--=20
Thanks,
=46eri.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
