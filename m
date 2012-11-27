From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5 v2] Input: bu21013_ts - Move GPIO init and exit
 functions into the driver
Date: Tue, 27 Nov 2012 09:07:37 +0000
Message-ID: <20121127090737.GF7897@gmail.com>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-3-git-send-email-lee.jones@linaro.org>
 <20121122121030.GG4328@gmail.com>
 <20121124074359.GA24711@core.coreip.homeip.net>
 <20121126120143.GK12782@gmail.com>
 <20121126164618.GA14623@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47511 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758430Ab2K0JHm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 04:07:42 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4987936bkw.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 01:07:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121126164618.GA14623@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 26 Nov 2012, Dmitry Torokhov wrote:

> Hi Lee,
>=20
> On Mon, Nov 26, 2012 at 12:01:43PM +0000, Lee Jones wrote:
> >  /**
> > + * bu21013_gpio_board_init() - configures the touch panel
> > + * @reset_pin: reset pin number
> > + *
> > + * This function is used to configure the voltage and
> > + * reset the touch panel controller.
> > + */
> > +static int bu21013_gpio_board_init(int reset_pin)
> > +{
> > +	int retval =3D 0;
> > +
> > +	retval =3D gpio_request_one(reset_pin, GPIOF_INIT_HIGH, "touchp_r=
eset");
>=20
> Also need to specify dircetion (even though it defaults to output).

You do? Okay, I'll do that.

> > +	if (retval) {
> > +		printk(KERN_ERR "Unable to request gpio reset_pin");
> > +		return retval;
> > +	}
> > +
> > +	return retval;
> > +}
> > +
> > +/**
> > + * bu21013_gpio_board_exit() - deconfigures the touch panel contro=
ller
> > + * @reset_pin: reset pin number
> > + *
> > + * This function is used to deconfigure the chip selection
> > + * for touch panel controller.
> > + */
> > +static int bu21013_gpio_board_exit(int reset_pin)
> > +{
> > +	int retval =3D 0;
> > +
> > +	retval =3D gpio_direction_output(reset_pin, 0);
> > +	if (retval < 0) {
> > +		printk(KERN_ERR "%s: gpio direction failed\n",
> > +		       __func__);
> > +		return retval;
>=20
> You should not return here, as gpio has to be freed even if you unabl=
e
> to toggle it.

You're right.

> > +	}
> > +	gpio_set_value(reset_pin, 0);
> > +	gpio_free(reset_pin);
> > +
> > +	return retval;
> > +}
> > +
> > +/**
> >   * bu21013_init_chip() - power on sequence for the bu21013 control=
ler
> >   * @data: device structure pointer
> >   *
> > @@ -449,6 +493,8 @@ static int __devinit bu21013_probe(struct i2c_c=
lient *client,
> >  		return -EINVAL;
> >  	}
> > =20
> > +	pdata->irq =3D gpio_to_irq(pdata->touch_pin);
> > +
>=20
> No, you still can not do it since pdata is a const pointer. Does not
> your compiler throw a warning here?
>=20
> I already sent you a version of the patch that does not have these
> issues, is there a particular reason why you needed to roll your own
> instead of simply trying out the one I sent?

I didn't see the other patch, sorry.

I'll check my mail and apply it.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
