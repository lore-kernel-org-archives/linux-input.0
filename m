From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
Date: Mon, 2 Mar 2015 20:12:01 +0100
Message-ID: <20150302191201.GA26884@pengutronix.de>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
 <20150217191438.GF19388@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37515 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090AbbCBTMR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2015 14:12:17 -0500
Content-Disposition: inline
In-Reply-To: <20150217191438.GF19388@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-iio@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Denis Carikli <denis@eukrea.com>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 17, 2015 at 08:14:38PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Markus,
>=20
> On Sat, Jan 24, 2015 at 03:01:38PM +0100, Markus Pargmann wrote:
> > +config MFD_MX25_TSADC
> > +	tristate "Freescale i.MX25 integrated Touchscreen and ADC unit"
> > +	select REGMAP_MMIO
> > +	depends on SOC_IMX25
> Can you make that:
>=20
> 	depends on SOC_IMX25 || COMPILE_TEST
>=20
> ?

Yes, changed.

>=20
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> Which version of the GPL is your code licensed under?

GPLv2 as described by MODULE_LICENSE. Will change the header
accordingly.

>=20
> > +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> > +				struct mx25_tsadc *tsadc)
> > [...]
> > +	irq_set_chained_handler(irq, mx25_tsadc_irq_handler);
> > +	irq_set_handler_data(irq, tsadc);
> Do you need to reverse the order of these two calls to prevent the
> handler being called while handler_data is still unset?

Yes that's probably better although the subdevices which may cause
interrupts here are not populated at this point.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9LYBAAoJEEpcgKtcEGQQTa8QAIvVq8nneBnZyXTeRaEaiQ9C
ib3PxhTW3aXduGlXyBhULXJAW9hE97rVQeKUuYSZbW7SU3G55SuNq/J1DhIhLu3j
ueC0j/kdALDAIUYr3YF5VDHCB7zJ3G5UmT+heD+sQzDv3qP6AAx93TU7eIDyM2GL
ZN57p4NdjNSdI3x9301eGwgcnDMUI7KgfEtxJNV1+tU7/umQq7A5GDZ46+7/SE8j
wRnvdKXjxqpEzygf9MF7vlYoeJuWie/2/9/pm7EZl8u4ibQvn4i5CLCCTM2GNNwn
CrUhdTJpolARkFoJ/Ie4ieJd/PIYicinUayDsYWvTDnL7B8g6wJ0ZR1AcipIrBHw
cYjcf8SHFWpnKmAmADw6Nxu6AvEoVf9Cc2vFl7fixirDJgrEkhvGVl/T3vuLQSBo
EG38XTf5Kjgt5PJqosXigAGak0gYxZ12+qM2eS7MWKC5L+1NJs6UdF0TTKKyEHh6
kfqBwfp1ZSRDgxaCzANMozxuFctLGETG3AoOgxsZ1ATu4l38rjCTjSIYzrs5CGyM
3LPXQE6cWH1CvtZN5zR0plGYNTxh+L8+6I03tU4aCcPQ2ZdlX0qeaO28TT336C5g
5uA5M+PZegvxfS/r2YzUWA+EyHBO6ouZalp23fUPYmNZEYd+9vxbXksbwf/O9alz
9vx/g7EUWbO6jcqta2OE
=IqLz
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
