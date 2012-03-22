From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] input: keyboard: lm8333: add driver
Date: Thu, 22 Mar 2012 10:11:45 +0100
Message-ID: <20120322091145.GA2424@pengutronix.de>
References: <20120322035244.GB20427@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41280 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab2CVJLq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Mar 2012 05:11:46 -0400
Content-Disposition: inline
In-Reply-To: <20120322035244.GB20427@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

thanks for the immediate review!

> > This driver adds support for the keypad part of the LM8333 and provides
> > hooks for possible GPIO/PWM drivers. Note that this is not a MFD device
> > beause you cannot disable the keypad functionality which, thus, has to
> > be handled by the core anyhow.
>=20
> So it's like lm8323... In this case we should just add PWM handling
> directly to this driver.=20

Not sure. There is a PWM framework in the making.

> > +
> > +/* The accessors try twice because the first access may be needed for =
wakeup */
> > +
> > +int lm8333_read8(struct lm8333 *lm8333, u8 cmd)
> > +{
> > +	int repeated =3D 0, ret;
> > +
> > +	do {
> > +		ret =3D i2c_smbus_read_byte_data(lm8333->client, cmd);
> > +	} while (ret < 0 && !repeated++);
>=20
> So there is 1 retry... Why don't you have
>=20
> 	do {
> 		...
> 	} while (ret < 0 && retries++ < LM8333_NUM_RETRIES);
>=20
> to make it completely obvious.

I thought '!repeated' was readable, but will change that.

> > +	lm8333 =3D devm_kzalloc(&client->dev, sizeof(*lm8333), GFP_KERNEL);
> > +	input =3D input_allocate_device();
> > +	if (!lm8333 || !input)
>=20
> You leak memory here if input_allocate_device() succeeds but
> devm_kzalloc fails. Situations like this is why I do not like devm_*
> interface.

I see. Okay, the true flaw is that one should check for error cases
seperately, but with devm_* one is tempted to combine that.

> > +static int __devexit lm8333_remove(struct i2c_client *client)
> > +{
> > +	struct lm8333 *lm8333 =3D i2c_get_clientdata(client);
> > +
> > +	input_unregister_device(lm8333->input);
> > +	input_free_device(lm8333->input);
>=20
> Also you need to free IRQ before you unregister (and free) input device,
> otherwise you risk dereferencing already freed memory. Another example
> why I hate devm_*.

Understood. The problem here is mixing devm_* setup with non_devm. So,
it is an either-or-thingie? Hmmm...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9q7NAACgkQD27XaX1/VRuJ8QCglSEyAQRYQaixhpBIcOBgxoox
Gw4An1RTYGaAWU1wHRIKSKGOi6yEM4vL
=7EtC
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
