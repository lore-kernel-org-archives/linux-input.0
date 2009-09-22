From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [PATCH] input: make gpio-keys use IRQF_SHARED
Date: Tue, 22 Sep 2009 20:50:33 +0200
Message-ID: <87k4zq3jba.fsf@tac.ki.iif.hu>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
	<20090916162853.GA4970@core.coreip.homeip.net>
	<bc64b4640909161141j3dfae8c8ncc02d0fe8c95ee07@mail.gmail.com>
	<bc64b4640909180444v46f49175ob215ffc43e3d109@mail.gmail.com>
	<20090922164206.GB22639@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:46664 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbZIVSud convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 14:50:33 -0400
In-Reply-To: <20090922164206.GB22639@core.coreip.homeip.net> (Dmitry
	Torokhov's message of "Tue, 22 Sep 2009 09:42:06 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Fri, Sep 18, 2009 at 03:44:41PM +0400, Dmitry Eremin-Solenikov wro=
te:
>> On Wed, Sep 16, 2009 at 10:41 PM, Dmitry Eremin-Solenikov
>> <dbaryshkov@gmail.com> wrote:
>>> On Wed, Sep 16, 2009 at 8:28 PM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>> On Wed, Sep 16, 2009 at 07:03:18PM +0400, Dmitry Eremin-Solenikov =
wrote:
>>>>> There is nothing that disallows gpio-keys to share it's IRQ line
>>>>> w/ other drivers. Make it use IRQF_SHARED in request_irq().
>>>>>
>>>>> An example of other driver with which I'd like to share IRQ line
>>>>> for GPIO buttons is ledtrig-gpio.
>>>>>
>>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>>> ---
>>>>> =C2=A0drivers/input/keyboard/gpio_keys.c | =C2=A0 =C2=A01 +
>>>>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/k=
eyboard/gpio_keys.c
>>>>> index efed0c9..9fc2fab 100644
>>>>> --- a/drivers/input/keyboard/gpio_keys.c
>>>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>>>> @@ -147,6 +147,7 @@ static int __devinit gpio_keys_probe(struct p=
latform_device *pdev)
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>>
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D reques=
t_irq(irq, gpio_keys_isr,
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_SHARED |
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_TRIGGER_RISIN=
G | IRQF_TRIGGER_FALLING,
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 button->desc ? but=
ton->desc : "gpio_keys",
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bdata);
>>>>
>>>> How will you determine which device generated the interrupt? Becau=
se you
>>>> can't return IRQ_HANDLED unconditionally and expect both devices w=
ork
>>>> reliably.
>>>
>>> It's a single device (gpio pin). However I'd like to be able to att=
ach
>>> several handlers to it.
>>> E.g. one isr is gpio-keys (for reporting event to userspace), anoth=
er
>>> isr will be from
>>> ledtrig-gpio (controlling the LED). Another can be some kind of
>>> battery driver, etc.
>>>
>>> All these drivers will provide different kinds of response for sing=
le GPIO pin.
>>=20
>> So, what about this patch?
>
> OK, will apply.

I still think it's dangerous.  But I am not a kernel hacker and a very
beginner on this whole field, so please let me explain why, and please
correct my conclusions as needed.

I met this problem playing with an embedded platform (brcm47xx), where
I wanted to employ the gpio_keys driver.  Registering the gpio_keys
platform device wasn't enough, because the gpio_keys module still
couldn't be loaded as the serial console already used the same
interrupt line of the Sonics Silicon Backplane.  (Also, it used
shared, but level triggered interrupts, so simply adding in
IRQF_SHARED wouldn't have helped either, besides breaking both
devices).  Anyway, such platforms may have several GPIO buttons,
typically using the same interrupt line, so there must be a way to
tell them apart, which looks impossible without some GPIO access to
acknowledge (change polarity of) the correct button.  So I plan to put
forward some changes in this area, like switching to level triggered
interrupts to facilitate sharing.  I've got some proof of concept
code, but still have to learn the ropes.

Apart from this, adding in IRQF_SHARED like above for being able to
attach several handlers looks fishy big time.  Would the rest be
invoked at all once you returned IRQ_HANDLED from the first (it's a
question of fact in Linux interrupt handling, I just down't know, but
would guess yes, for level triggered interrupts at least)?  Is this
common practice?
--=20
Thanks,
=46eri.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
