From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] Re: [PATCH] input: axp20x-pek: Fix reporting button
 state as inverted
Date: Wed, 24 Jun 2015 09:42:25 +0800
Message-ID: <CAGb2v64AF3bnd-QBRCszjD7MSfCnGSvfu3wUT2W+7fNTE76d5g@mail.gmail.com>
References: <1434278541-21355-1-git-send-email-hdegoede@redhat.com> <20150622213051.GD2350@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:38556 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbbFXBnF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 21:43:05 -0400
In-Reply-To: <20150622213051.GD2350@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Carlo Caione <carlo@caione.org>, Chen-Yu Tsai <wens@csie.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

On Tue, Jun 23, 2015 at 5:30 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Jun 14, 2015 at 12:42:21PM +0200, Hans de Goede wrote:
>> Currently we are reporting the button state as inverted on all boards with
>> an axp209 pmic, tested on a ba10-tvbox, bananapi, bananapro, cubietruck and
>> utoo-p66 tablet.
>>
>> The axp209 datasheet clearly states that the power button must be connected
>> between the PWRON key and ground. Which means that on a press we will get
>> a falling edge (dbf) irq not a rising one, and likewise on release we will
>> get a rising edge (dbr) irq, not a falling one.
>>
>> This commit swaps the check for the 2 irqs fixing the inverted reporting of
>> the power button state.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Carlo, Chen-Yu, could you please give this patch a spin and let us know
> if it works on your boards?

I've not actually tested this patch on my boards, but I can confirm that
the original code had the state inverted, by checking /proc/interrupts
counters, before and after releasing the power button.

Acked-by: Chen-Yu Tsai <wens@csie.org>

> Thanks!
>
>> ---
>>  drivers/input/misc/axp20x-pek.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
>> index f1c8447..10e140a 100644
>> --- a/drivers/input/misc/axp20x-pek.c
>> +++ b/drivers/input/misc/axp20x-pek.c
>> @@ -167,9 +167,13 @@ static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
>>       struct input_dev *idev = pwr;
>>       struct axp20x_pek *axp20x_pek = input_get_drvdata(idev);
>>
>> -     if (irq == axp20x_pek->irq_dbr)
>> +     /*
>> +      * The power-button is connected to ground so a falling edge (dbf)
>> +      * means it is pressed.
>> +      */
>> +     if (irq == axp20x_pek->irq_dbf)
>>               input_report_key(idev, KEY_POWER, true);
>> -     else if (irq == axp20x_pek->irq_dbf)
>> +     else if (irq == axp20x_pek->irq_dbr)
>>               input_report_key(idev, KEY_POWER, false);
>>
>>       input_sync(idev);
>> --
>> 2.4.3
>>
>
> --
> Dmitry
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
