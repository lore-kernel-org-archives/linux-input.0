From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] input: make gpio-keys use IRQF_SHARED
Date: Fri, 18 Sep 2009 15:44:41 +0400
Message-ID: <bc64b4640909180444v46f49175ob215ffc43e3d109@mail.gmail.com>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
	 <20090916162853.GA4970@core.coreip.homeip.net>
	 <bc64b4640909161141j3dfae8c8ncc02d0fe8c95ee07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:49784 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbZIRLoi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 07:44:38 -0400
Received: by ywh5 with SMTP id 5so1121151ywh.4
        for <linux-input@vger.kernel.org>; Fri, 18 Sep 2009 04:44:41 -0700 (PDT)
In-Reply-To: <bc64b4640909161141j3dfae8c8ncc02d0fe8c95ee07@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Sep 16, 2009 at 10:41 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> On Wed, Sep 16, 2009 at 8:28 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Wed, Sep 16, 2009 at 07:03:18PM +0400, Dmitry Eremin-Solenikov wr=
ote:
>>> There is nothing that disallows gpio-keys to share it's IRQ line
>>> w/ other drivers. Make it use IRQF_SHARED in request_irq().
>>>
>>> An example of other driver with which I'd like to share IRQ line
>>> for GPIO buttons is ledtrig-gpio.
>>>
>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>> ---
>>> =A0drivers/input/keyboard/gpio_keys.c | =A0 =A01 +
>>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/key=
board/gpio_keys.c
>>> index efed0c9..9fc2fab 100644
>>> --- a/drivers/input/keyboard/gpio_keys.c
>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>> @@ -147,6 +147,7 @@ static int __devinit gpio_keys_probe(struct pla=
tform_device *pdev)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D request_irq(irq, gpio_keys_is=
r,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I=
RQF_SHARED |
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 button->desc ? button->desc : "gpio_keys",
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 bdata);
>>
>> How will you determine which device generated the interrupt? Because=
 you
>> can't return IRQ_HANDLED unconditionally and expect both devices wor=
k
>> reliably.
>
> It's a single device (gpio pin). However I'd like to be able to attac=
h
> several handlers to it.
> E.g. one isr is gpio-keys (for reporting event to userspace), another
> isr will be from
> ledtrig-gpio (controlling the LED). Another can be some kind of
> battery driver, etc.
>
> All these drivers will provide different kinds of response for single=
 GPIO pin.

So, what about this patch?

--=20
With best wishes
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
