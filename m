From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v5 3/6] iio: adc: fsl,imx25-gcq driver
Date: Fri, 30 Jan 2015 08:27:39 +0100
Message-ID: <20150130072739.GB16879@pengutronix.de>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-4-git-send-email-mpa@pengutronix.de>
 <CAOMZO5DdeQ+7wwytyRiTd6og2DarS9vBoMhq04gfvMfhS+UPag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35132 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158AbbA3H1s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 02:27:48 -0500
Content-Disposition: inline
In-Reply-To: <CAOMZO5DdeQ+7wwytyRiTd6og2DarS9vBoMhq04gfvMfhS+UPag@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On Thu, Jan 29, 2015 at 12:51:36PM -0200, Fabio Estevam wrote:
> Hi Markus,
>=20
> On Sat, Jan 24, 2015 at 12:01 PM, Markus Pargmann <mpa@pengutronix.de> wr=
ote:
>=20
> > +       priv->irq =3D platform_get_irq(pdev, 0);
> > +       if (priv->irq <=3D 0) {
>=20
> This should be: if (priv->irq < 0) {

Thanks, fixed in both drivers.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyzJrAAoJEEpcgKtcEGQQKwAP+gO9SCEISn9plIpFjFiI4kvG
lSKKmd3fRS6R/vLhX4XigfGr0wMHYIJAbiQlL+sT8ldpei2p0LGyC9irHO4dpgJu
d+uKATAoHB42BluXP1iTp25TKOYwhCHgjvyTbJ0MqGW+Rp1+QSLOYTsnbPvyKnlz
BOmyhSlVEISRparuvguM3bAQPmSBAeviQKKgxCU3nXM9xjr4ov5Rugb7QvvTsyg7
I5oyh2Js+Lhcjo03WXu45xUJYbfsoTtaMIpSiRNcgzALj+4xRuscDe8nrLh6BAJ8
rlcb/gEwJEjA8mycCOx4RAvqajWNHJb6MCkyFda6WzyAdPn6tAZVUKY62tNYqz1F
4QlbN8x1qnyApHh5olvl4CvXjjYOJCUZ1enwu5dmu4DbaL0Ws76v1Nmg3EMQUgmL
Zd6D0QUC1V4/jPDF2xRn4cRgg95z5B8OOcRuhRvxOQrlGzm35qkZEuJzklwuwvBp
NDZwt1uZxH61nEf6+asSm8un0KhhC7c2xiw345pTsXRV1lHqV/rieQARm0kZc2ul
iMPUlUGLuky+RZ04oGWC5vBeCrJO0d+VSo2Dz0UBKWoNqJsEombMRfdDDdVa8A7U
L77ZJmWWRpJYJ2Fv/HK5rOCLF2Y5FDwaZ+oruYV6nCge7HCn93FACKoi4A+9135O
roHecXsxYWOXby6GUjS4
=VUYO
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
