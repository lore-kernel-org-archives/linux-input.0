From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v6 6/8] input: touchscreen: imx25 tcq driver
Date: Mon, 2 Feb 2015 17:05:39 +0100
Message-ID: <20150202160539.GS16879@pengutronix.de>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-7-git-send-email-mpa@pengutronix.de>
 <54CA4320.4030607@gmail.com>
 <20150130185721.GA11695@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vNrHrykRFvLVX6W3"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42723 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbbBBQFv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 11:05:51 -0500
Content-Disposition: inline
In-Reply-To: <20150130185721.GA11695@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>


--vNrHrykRFvLVX6W3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 30, 2015 at 10:57:21AM -0800, Dmitry Torokhov wrote:
> On Thu, Jan 29, 2015 at 07:56:40PM +0530, Varka Bhadram wrote:
> > Hi,
> >=20
> > On Thursday 29 January 2015 07:39 PM, Markus Pargmann wrote:
> > >This is a driver for the imx25 ADC/TSC module. It controls the
> > >touchscreen conversion queue and creates a touchscreen input device.
> > >The driver currently only supports 4 wire touchscreens. The driver uses
> > >a simple conversion queue of precharge, touch detection, X measurement,
> > >Y measurement, precharge and another touch detection.
> > >
> > >This driver uses the regmap from the parent to setup some touch specif=
ic
> > >settings in the core driver and setup a idle configuration with touch
> > >detection.
> > >
> > >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > >Signed-off-by: Denis Carikli <denis@eukrea.com>
> > >Acked-by: Dmitry Torokhov <dtor@vmware.com>
> > >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > >---
> > >  drivers/input/touchscreen/Kconfig         |   6 +
> > >  drivers/input/touchscreen/Makefile        |   1 +
> > >  drivers/input/touchscreen/fsl-imx25-tcq.c | 587 ++++++++++++++++++++=
++++++++++
> > >  3 files changed, 594 insertions(+)
> > >  create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
> > >
> > (...)
> >=20
> > >+	ret =3D request_threaded_irq(priv->irq, mx25_tcq_irq, mx25_tcq_irq_t=
hread,
> > >+				   IRQF_ONESHOT, pdev->name, priv);
> >=20
> > We can use devres API for request_thread_irq()...
> >=20
> > >+	if (ret) {
> > >+		dev_err(dev, "Failed requesting IRQ\n");
> > >+		goto err_clk_unprepare;
> > >+	}
> > >+
> > >+	ret =3D mx25_tcq_init(priv);
> > >+	if (ret) {
> > >+		dev_err(dev, "Failed to init tcq\n");
> > >+		goto error_free_irq;
> > >+	}
> > >+
> > >+	platform_set_drvdata(pdev, priv);
> > >+
> > >+	return 0;
> > >+
> > >+error_free_irq:
> > >+	free_irq(priv->irq, priv);
> >=20
> > This is not required if we use devres API
>=20
> Yes it does - you do not really want to stop clocks in the middle of
> servicing interrupt.

Thanks, I missed the clocks. I will not use devm here then.

For the gcq (ADC) driver, it would still works to use devm_request_irq as t=
he
interrupt can only trigger when the user requested an ADC conversion. So as
soon as the device is unregistered from the IIO subsystem, there should
not be any interrupts. However I would like to keep free_irq in the gcq
driver as well. Unexpected interrupts wouldn't be a problem and
especially if the driver is extended for continous conversion in the
future, this may be better.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--vNrHrykRFvLVX6W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz6BTAAoJEEpcgKtcEGQQyEwP/joXrI5zucFHv+GED5e6ycSr
CH7NzKmDqk698z4IDjpdVkPU3Kh4vca4m7RIW9CZYtjVo5gLahCVW0zs77ishy1V
EiskEbiv73GJR3oWNzXGbyRdB9LB1jX/DVSxu1amSGYIHkRU0hsYbHI6aUyuNNm1
7qrP8uGUhzF21t0dnWD0km/J/KydjnzyxeleQQI9V39A991hiux3jA3MlB/be7Jw
G3bOG1KSIRoewsTF7DIcG/d36PsokOnTFIfB+69mvf1f5xJuBOy9o7b1X5A/fMyL
oe171U8HpcFomjYs2M1lPDaNuS0d+Wrtw99+MhBV4cVl2S3xrqysPSSfF0wEhDh7
9ZmOZPcmd6ByZNgU4CQTFIBZPFoFckfy5S2BN6rgday1dLdMZGZQ6zUaA3FJct2y
2wg9jXVjBBGeaPQA9H5+dv/RcLC0vewaYgh/gSPoNd3g8Ho156EDpYTzbwOgzmR5
MbCoa9db6oyshB922dMlCt0fv84Ll2BlfG+Mkmp2QGcMQCSXiUEp5vyu64f3hHyd
ELBBxIYvGlBjp1NSNJhn7IlIU44+tPkhzFstZL6MlmcUQc8+dchlzLQcpxzGYKCW
6gXU8zoEGWktW/GnRDHzzAQHXIh9urfH1t77YjZuf6i8SR1W5aeD25Af7F2OhWED
84K3TPwcA/Y5XGvfj/rS
=zHkk
-----END PGP SIGNATURE-----

--vNrHrykRFvLVX6W3--
