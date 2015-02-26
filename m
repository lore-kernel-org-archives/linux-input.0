From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
Date: Thu, 26 Feb 2015 16:32:51 +0100
Message-ID: <20150226153251.GD10070@pengutronix.de>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
 <20150216133829.GG14545@x1>
 <CAOMZO5AwbNeEhVgUuLUi-_QT0DesPBBCTvvebuA91y-P2_CNzg@mail.gmail.com>
 <20150218080156.GA5781@x1>
 <CAOMZO5BjVrcb3t1=kQQYf=-PztzDpGk8S5ApsTThGekT1yTTnA@mail.gmail.com>
 <20150218120844.GC22296@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41405 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbbBZPc6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 10:32:58 -0500
Content-Disposition: inline
In-Reply-To: <20150218120844.GC22296@x1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 12:08:44PM +0000, Lee Jones wrote:
> On Wed, 18 Feb 2015, Fabio Estevam wrote:
>=20
> > On Wed, Feb 18, 2015 at 6:01 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > > On Tue, 17 Feb 2015, Fabio Estevam wrote:
> > >
> > >> On Mon, Feb 16, 2015 at 11:38 AM, Lee Jones <lee.jones@linaro.org> w=
rote:
> > >>
> > >> >> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> > >> >> +                             struct mx25_tsadc *tsadc)
> > >> >> +{
> > >> >> +     struct device *dev =3D &pdev->dev;
> > >> >> +     struct device_node *np =3D dev->of_node;
> > >> >> +     int irq;
> > >> >> +
> > >> >> +     irq =3D platform_get_irq(pdev, 0);
> > >> >> +     if (irq < 0) {
> > >> >
> > >> > What if 0 is returned?
> > >>
> > >> Then  imx25.dtsi would be passing irq=3D0 for the ADC, which would be
> > >> totally wrong.
> > >
> > > Exactly, so it should be <=3D.
> >=20
> > imx25.dtsi passes interrupts =3D <46>; for the touch screen controller,
> > so the irq number will never be zero.
>=20
> It doesn't matter what happens to be passed at the moment.  The
> correct thing to do is enforce correct/full error checking.  Yes <0 is
> an error, but so is =3D0, so encompass it in the checks.

I now changed all irq < 0 checks to irq <=3D 0 under the assumption that
irq 0 is always an error.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7zyjAAoJEEpcgKtcEGQQkGkQAJSBKMc5TfJ5j20Zg1/YlQkv
r2pSu8sy2Y8DCaOEqk0M6nu76282+S5BblWzXtZxpYUHqFpVnX4eAKSUa24orQ9J
SJZB+6G9ueXxhSYttthBnFDHeCNSH5EpH/BeIV4qphDlXpqvyFpdu4uF9GJqX1Pp
tXWW4NXzneeWfDavmdxdg6VIhAVOglXoA1b0xTgdP14+4+DtNLOBM/sMQqVqC6dq
fU67wOHqI4+4qA6C405VKLthc7RMHeJ1SgroL1saOTxetYGZ9alVsEZcl+ZzBjdI
CXoasdmAf8oWZNn1DoN/qSotMahwf6/I6x8Dhqi87PZ9nM0yO0cgCSsfUQLwN499
KVhJ6gU2K50MJbr2MYaaUUU8XGsvWoafSgC9VnnjBXi2M/Y08AX5/49FOpWVpyI3
Zu2hQzPGn5d42SUumiVNe+sSNvb8ou/J1On11O67ybA0g+Scd7sl5XxNoJLWyAVS
2C+XDNweCq4sRP5Tf0uc/3f8bSD6TMcciU1qzeKoU3tq5XnI7xRHhxwu+v5pbk+x
D7XKfczHgaZooaK1q+v82u3BoUnrPHSWFNZr4xyEzSM0f48iSESIRZzbKPXmoJ3g
6I3SwLmxh/0eYLelXWRWh1MxRMHFRqnpBqV21zju5dD4rRMto1z8JmW4HfHHKlmz
qzGqyvBhZDt94qHXbycs
=IPP2
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
