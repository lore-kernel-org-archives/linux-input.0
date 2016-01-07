From: Timo Teras <timo.teras@iki.fi>
Subject: Re: [PATCH] Input: rotary-encoder: use request_any_context_irq and
 gpio_get_value_cansleep
Date: Thu, 7 Jan 2016 22:25:25 +0200
Message-ID: <20160107222525.27fde1f4@vostro>
References: <1450896115-12422-1-git-send-email-timo.teras@iki.fi>
	<20160107180816.GB12332@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36673 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbcAGUZd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2016 15:25:33 -0500
Received: by mail-lf0-f47.google.com with SMTP id z124so334564963lfa.3
        for <linux-input@vger.kernel.org>; Thu, 07 Jan 2016 12:25:32 -0800 (PST)
In-Reply-To: <20160107180816.GB12332@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, 7 Jan 2016 10:08:16 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Wed, Dec 23, 2015 at 08:41:55PM +0200, Timo Ter=C3=A4s wrote:
> > This allows to use GPIO expanders behind I2C or SPI bus.
> >=20
> > Signed-off-by: Timo Ter=C3=A4s <timo.teras@iki.fi>
> > ---
> >  drivers/input/misc/rotary_encoder.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/input/misc/rotary_encoder.c
> > b/drivers/input/misc/rotary_encoder.c index 8aee719..8bedd7b 100644
> > --- a/drivers/input/misc/rotary_encoder.c
> > +++ b/drivers/input/misc/rotary_encoder.c
> > @@ -48,8 +48,8 @@ struct rotary_encoder {
> > =20
> >  static int rotary_encoder_get_state(const struct
> > rotary_encoder_platform_data *pdata) {
> > -	int a =3D !!gpio_get_value(pdata->gpio_a);
> > -	int b =3D !!gpio_get_value(pdata->gpio_b);
> > +	int a =3D !!gpio_get_value_cansleep(pdata->gpio_a);
> > +	int b =3D !!gpio_get_value_cansleep(pdata->gpio_b);
> > =20
> >  	a ^=3D pdata->inverted_a;
> >  	b ^=3D pdata->inverted_b;
> > @@ -335,18 +335,18 @@ static int rotary_encoder_probe(struct
> > platform_device *pdev) goto exit_free_gpio_b;
> >  	}
> > =20
> > -	err =3D request_irq(encoder->irq_a, handler,
> > -			  IRQF_TRIGGER_RISING |
> > IRQF_TRIGGER_FALLING,
> > -			  DRV_NAME, encoder);
> > -	if (err) {
> > +	err =3D request_any_context_irq(encoder->irq_a, handler,
> > +				      IRQF_TRIGGER_RISING |
> > IRQF_TRIGGER_FALLING,
> > +				      DRV_NAME, encoder);
> > +	if (err < 0) { =20
>=20
> This is wrong. If you are saying that you can use any context IRQ you
> can get hard irq, but in rotary_encoder_get_state() (which is called
> from IRQ handler) you are using sleeping gpio accessors.
>=20
> I guess you need to explicitly request threaded IRQs.

This was based on commit 94a8cab8caaa56824981c17b6898b73627e8382f which
did the exact same change for gpio_keys.c.

I think this was based on the assumption that gpio_get_value_cansleep()
never sleeps when it's hard irq based. And I thought this is why
gpio_get_value_cansleep() can really sleep only when the irq is running
in the threaded context in first place.

And that's what I followed.

Then again looking again, seems that all similar uses have been changed
to use workqueue or timer - but primarily due for debouncing - not
that the above code would have been incorrect (at least according to
commitlog).=20

But on second thought, I wonder if there's any races due to having two
gpios affect the rotary encoder state. What if the IRQs run on
different CPUs on SMP box.

Would it make sense to convert the actual state reading code to be work
item, and just schedule the work in an any context irq?

Thanks,
Timo
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
