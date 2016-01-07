From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: rotary-encoder: use request_any_context_irq and gpio_get_value_cansleep
Date: Thu, 7 Jan 2016 12:46:40 -0800
Message-ID: <CAKdAkRTc__1UXOcYcJ74MJ2S54+5S4p9ZDm_dJ+VZRsKFbQOgQ@mail.gmail.com>
References: <1450896115-12422-1-git-send-email-timo.teras@iki.fi>
	<20160107180816.GB12332@dtor-ws>
	<20160107222525.27fde1f4@vostro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35740 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbcAGUql convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2016 15:46:41 -0500
Received: by mail-lb0-f169.google.com with SMTP id bc4so213751099lbc.2
        for <linux-input@vger.kernel.org>; Thu, 07 Jan 2016 12:46:41 -0800 (PST)
In-Reply-To: <20160107222525.27fde1f4@vostro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Timo Teras <timo.teras@iki.fi>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Jan 7, 2016 at 12:25 PM, Timo Teras <timo.teras@iki.fi> wrote:
> On Thu, 7 Jan 2016 10:08:16 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
>> On Wed, Dec 23, 2015 at 08:41:55PM +0200, Timo Ter=C3=A4s wrote:
>> > This allows to use GPIO expanders behind I2C or SPI bus.
>> >
>> > Signed-off-by: Timo Ter=C3=A4s <timo.teras@iki.fi>
>> > ---
>> >  drivers/input/misc/rotary_encoder.c | 20 ++++++++++----------
>> >  1 file changed, 10 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/drivers/input/misc/rotary_encoder.c
>> > b/drivers/input/misc/rotary_encoder.c index 8aee719..8bedd7b 10064=
4
>> > --- a/drivers/input/misc/rotary_encoder.c
>> > +++ b/drivers/input/misc/rotary_encoder.c
>> > @@ -48,8 +48,8 @@ struct rotary_encoder {
>> >
>> >  static int rotary_encoder_get_state(const struct
>> > rotary_encoder_platform_data *pdata) {
>> > -   int a =3D !!gpio_get_value(pdata->gpio_a);
>> > -   int b =3D !!gpio_get_value(pdata->gpio_b);
>> > +   int a =3D !!gpio_get_value_cansleep(pdata->gpio_a);
>> > +   int b =3D !!gpio_get_value_cansleep(pdata->gpio_b);
>> >
>> >     a ^=3D pdata->inverted_a;
>> >     b ^=3D pdata->inverted_b;
>> > @@ -335,18 +335,18 @@ static int rotary_encoder_probe(struct
>> > platform_device *pdev) goto exit_free_gpio_b;
>> >     }
>> >
>> > -   err =3D request_irq(encoder->irq_a, handler,
>> > -                     IRQF_TRIGGER_RISING |
>> > IRQF_TRIGGER_FALLING,
>> > -                     DRV_NAME, encoder);
>> > -   if (err) {
>> > +   err =3D request_any_context_irq(encoder->irq_a, handler,
>> > +                                 IRQF_TRIGGER_RISING |
>> > IRQF_TRIGGER_FALLING,
>> > +                                 DRV_NAME, encoder);
>> > +   if (err < 0) {
>>
>> This is wrong. If you are saying that you can use any context IRQ yo=
u
>> can get hard irq, but in rotary_encoder_get_state() (which is called
>> from IRQ handler) you are using sleeping gpio accessors.
>>
>> I guess you need to explicitly request threaded IRQs.
>
> This was based on commit 94a8cab8caaa56824981c17b6898b73627e8382f whi=
ch
> did the exact same change for gpio_keys.c.
>
> I think this was based on the assumption that gpio_get_value_cansleep=
()
> never sleeps when it's hard irq based. And I thought this is why
> gpio_get_value_cansleep() can really sleep only when the irq is runni=
ng
> in the threaded context in first place.
>
> And that's what I followed.
>
> Then again looking again, seems that all similar uses have been chang=
ed
> to use workqueue or timer - but primarily due for debouncing - not
> that the above code would have been incorrect (at least according to
> commitlog).

Yes, commit log did not address why the call was changed to
cansleep(), but because it is called from workqueue context it is OK
to be used.

>
> But on second thought, I wonder if there's any races due to having tw=
o
> gpios affect the rotary encoder state. What if the IRQs run on
> different CPUs on SMP box.

Yes, you are right, there is a race.

>
> Would it make sense to convert the actual state reading code to be wo=
rk
> item, and just schedule the work in an any context irq?

Or make them both threaded IRQs and protect form concurrent execution
with a mutex.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
