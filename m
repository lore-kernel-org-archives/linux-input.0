From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v6 6/8] input: touchscreen: imx25 tcq driver
Date: Thu, 26 Feb 2015 15:30:51 +0100
Message-ID: <20150226143051.GA10070@pengutronix.de>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-7-git-send-email-mpa@pengutronix.de>
 <54CA4320.4030607@gmail.com>
 <20150130185721.GA11695@dtor-ws>
 <20150202160539.GS16879@pengutronix.de>
 <20150202175134.GB23909@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32794 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447AbbBZObG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 09:31:06 -0500
Content-Disposition: inline
In-Reply-To: <20150202175134.GB23909@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 02, 2015 at 09:51:34AM -0800, Dmitry Torokhov wrote:
> On Mon, Feb 02, 2015 at 05:05:39PM +0100, Markus Pargmann wrote:
> > Hi,
> >=20
> > On Fri, Jan 30, 2015 at 10:57:21AM -0800, Dmitry Torokhov wrote:
> > > On Thu, Jan 29, 2015 at 07:56:40PM +0530, Varka Bhadram wrote:
> > > > Hi,
> > > >=20
> > > > On Thursday 29 January 2015 07:39 PM, Markus Pargmann wrote:
> > > > >This is a driver for the imx25 ADC/TSC module. It controls the
> > > > >touchscreen conversion queue and creates a touchscreen input devic=
e.
> > > > >The driver currently only supports 4 wire touchscreens. The driver=
 uses
> > > > >a simple conversion queue of precharge, touch detection, X measure=
ment,
> > > > >Y measurement, precharge and another touch detection.
> > > > >
> > > > >This driver uses the regmap from the parent to setup some touch sp=
ecific
> > > > >settings in the core driver and setup a idle configuration with to=
uch
> > > > >detection.
> > > > >
> > > > >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > >Signed-off-by: Denis Carikli <denis@eukrea.com>
> > > > >Acked-by: Dmitry Torokhov <dtor@vmware.com>
> > > > >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > >---
> > > > >  drivers/input/touchscreen/Kconfig         |   6 +
> > > > >  drivers/input/touchscreen/Makefile        |   1 +
> > > > >  drivers/input/touchscreen/fsl-imx25-tcq.c | 587 ++++++++++++++++=
++++++++++++++
> > > > >  3 files changed, 594 insertions(+)
> > > > >  create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
> > > > >
> > > > (...)
> > > >=20
> > > > >+	ret =3D request_threaded_irq(priv->irq, mx25_tcq_irq, mx25_tcq_i=
rq_thread,
> > > > >+				   IRQF_ONESHOT, pdev->name, priv);
> > > >=20
> > > > We can use devres API for request_thread_irq()...
> > > >=20
> > > > >+	if (ret) {
> > > > >+		dev_err(dev, "Failed requesting IRQ\n");
> > > > >+		goto err_clk_unprepare;
> > > > >+	}
> > > > >+
> > > > >+	ret =3D mx25_tcq_init(priv);
> > > > >+	if (ret) {
> > > > >+		dev_err(dev, "Failed to init tcq\n");
> > > > >+		goto error_free_irq;
> > > > >+	}
> > > > >+
> > > > >+	platform_set_drvdata(pdev, priv);
> > > > >+
> > > > >+	return 0;
> > > > >+
> > > > >+error_free_irq:
> > > > >+	free_irq(priv->irq, priv);
> > > >=20
> > > > This is not required if we use devres API
> > >=20
> > > Yes it does - you do not really want to stop clocks in the middle of
> > > servicing interrupt.
> >=20
> > Thanks, I missed the clocks. I will not use devm here then.
>=20
> Actually, you still can if you move clock enabling/disabling and
> mx25_tcq_init() into input_dev->open() and ->close() callbacks. Close
> will be called during input device un-registration which happens (given
> your current sequence) after freeing irq by devm.

Thank you. I now moved that code into open() and close(), replaced the
irq_request() with devm_irq_request. mx25_tcq_remove() is gone now.

>=20
> By the way, I used my old @vmware address by accident. Can you please
> replace the original acked by with:
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Replaced it.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7y4bAAoJEEpcgKtcEGQQ5K8P/2OQsxrAuCynIXRsWX4v/lgM
qzGWwcyy76b5P/u4+JQUBk0MSXeYFVL5q70/Bd6bvT0sc9K4O2TcIFOuKhpQHjsB
D2vTB1cE+WV7F83nCUyiHUO5ylNJfsWS2ZZvB28u+y2p/Q7DpGSio1IdI8juED4o
pIHBfdXFjy6ilQ2H5yy8MX4LBSC5u2ZyvMXV1Aw+1J3oqy3rdFlMJm/42uULbc9R
GeMNQWqc8VsKbb367cXT7asDBYnHNjKy9yQq8M8yiZkk2fwFY4ScphnmzwVZ+U9w
lXmJMJ3nT36rLE7NzgrogyrYOlq07xw8Wbrf8+0N/ePM11i1CuKwUtDxYTUUaBOc
qo0ReVAwcM8+QuERGS0UuXTAuUWpTMDbkkU21c3H521KaK9Rrh2YeM+HZ2JBPQyY
IJKFy6C7azlxmvev3lUq77lN5lYrp2VjD+4P+S91WkY2EJVXhTkvuomj8VEVkQxV
jH7ZByI7qWT7/2AlDgUmmPVYjZgxyLUDmm4+mvcccRME+ZEFxyfNTeyZ0XryP8RN
BbiJoArDkQTzfAc5sLu4N9qiYySQGAoaCjw0X2Rv9+jIJlYWtBmI1yFzrMYtdaLc
59u47WBBfx8zQ1MMwaQL2pvGOFcQUl/vcx2Q+D7MM4Lzmcnr3I8cvNqTDIzDx/LO
Ac4HluBGLED45gCNZuIA
=oSst
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
