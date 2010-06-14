From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [PATCH 2/3 V2] gpio: add STMPE811 gpio controller support
Date: Mon, 14 Jun 2010 14:09:43 +0200
Message-ID: <20100614120943.GB12027@pengutronix.de>
References: <1276251195-22981-1-git-send-email-l.fu@pengutronix.de> <1276511558-27121-3-git-send-email-l.fu@pengutronix.de> <20100614115123.GB14604@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54010 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab0FNMJq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 08:09:46 -0400
Content-Disposition: inline
In-Reply-To: <20100614115123.GB14604@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Luotao Fu <l.fu@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

thaks for the review.

On Mon, Jun 14, 2010 at 12:51:23PM +0100, Mark Brown wrote:
> On Mon, Jun 14, 2010 at 12:32:37PM +0200, Luotao Fu wrote:
>=20
> > +static struct gpio_chip gpio_chip =3D {
> > +	.label =3D STMPE811_GPIO_NAME,
> > +	.owner =3D THIS_MODULE,
> > +	.direction_input =3D stmpe811_gpio_direction_in,
> > +	.get =3D stmpe811_gpio_get,
> > +	.direction_output =3D stmpe811_gpio_direction_out,
> > +	.set =3D stmpe811_gpio_set,
> > +	.request =3D stmpe811_gpio_request,
> > +	.can_sleep =3D 1,
> > +};
>=20
> Assuming you're able to do interrupts on the GPIOs you should now be
> able to implement to_irq() as well.

The chip can indeed generate irqs on the GPIO line. I, however, kept out
the irq stuff for now because i want to get the core functionalies done
for this turn. I'd like to add the irq stuff with a separate patch later.

Thanks

cheers
Luotao Fu
--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwWHAcACgkQkLuxfMCkDTYqPwCfTEB7xfSloWD/mabpXQhOEOlc
pTcAniFiHphROvbjxro+w1doeWVfscLC
=nAru
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
