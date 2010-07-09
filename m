From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] cy8ctmg110: capacitive touchscreen support
Date: Fri, 9 Jul 2010 15:13:10 +0100
Message-ID: <20100709151310.54ed8a2f@linux.intel.com>
References: <20100708161040.23957.36738.stgit@localhost.localdomain>
	<20100708172616.GB6966@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34140 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755814Ab0GIOmJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jul 2010 10:42:09 -0400
In-Reply-To: <20100708172616.GB6966@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


> > +/*
> > + * The touch position structure.
> > + */
> > +struct ts_event {
> > +	int x1;
> > +	int y1;
> > +	int x2;
> > +	int y2;
> > +};
>=20
> Are there more changes to the driver? Currently I do not see the
> reason for having this structure.

With the other clean ups agreed.

> > +/*
> > + * cy8ctmg110_power is the routine that is called when touch
> > hardware
> > + * will powered off or on.
> > + */
> > +static void cy8ctmg110_power(int poweron)
>=20
> bool poweron?

If you prefer - changed


> > +	input_report_key(input, BTN_TOUCH, 1);
> > +	x2 =3D (u16) (y * X_SCALE_FACTOR);
> > +	y2 =3D (u16) (x * Y_SCALE_FACTOR);
>=20
> Why do we scale in kernel? We should be reportig raw coordinates and
> let userspace to scale if needed.

Ok


> > +	} else if (tsc->tc.x1 !=3D x || tsc->tc.y1 !=3D y) {
> > +		tsc->tc.y1 =3D y;
> > +		tsc->tc.x1 =3D x;
> > +		cy8ctmg110_send_event(tsc);
>=20
> Send always, input core will filter out duplicates, if needed.

Done and cleaned up the surrounding bits

> > +	client->irq =3D CY8CTMG110_TOUCH_IRQ;
>=20
> Eww...

Real hardware/firmware isn't always pretty - its a mix of GPIO and I=C2=
=B2C
interfaces.

> Set up input_dev->dev.parent =3D client->...

Done

> Frankly, anything that polls with high frequency in a mobile device i=
s
> plainly not useful. I'd just kill these polling bits altogether.

=46or production hardware yes. I'll split polling out as we can keep th=
at
internally and then burn it when its not needed.

> > +		err =3D gpio_request(CY8CTMG110_IRQ_PIN_GPIO,
> > "touch_irq_key");
>=20
> Always the same GPIO number?

Yes.=20

> Please idnt properly, I do not care about 80 lines limit if the resul=
t
> causes bad identation. We can also drop "cy8ctmg110_ts: " prefixes -
> dev_xxx() shousl give enogh context.

Ok

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
