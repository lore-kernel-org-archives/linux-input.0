From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 2/5] Documentation: Detail permitted DT properties for
 the imx6ul_tsc
Date: Fri, 21 Aug 2015 11:27:25 +0200
Message-ID: <20150821092725.GB706@pengutronix.de>
References: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
 <1438077521-12857-3-git-send-email-haibo.chen@freescale.com>
 <20150819055434.GF11161@pengutronix.de>
 <BY1PR03MB1388BBEF576297D76E7E3F839A650@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BY1PR03MB1388BBEF576297D76E7E3F839A650-+AXFdSrsDrYz5L6Zd4zdsmP7xZHs9kq/vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen Bough <Haibo.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org" <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, "christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org" <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2015 at 08:30:16AM +0000, Chen Bough wrote:
> Hi Markus,
>=20
> > -----Original Message-----
> > From: Markus Pargmann [mailto:mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org]
> > Sent: Wednesday, August 19, 2015 1:55 PM
> > To: Chen Haibo-B51421
> > Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pawel.moll-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
> > ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; shawnguo-DgEjT+Ai2yhQFI55V6+gNQ@public.gmane.org=
g;
> > kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org; dmitry.torokhov-Re5JQEeQqe8@public.gmane.org=
m;
> > devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org;
> > mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org; christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> > scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> > jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org; benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> > hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org; hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org; sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org;
> > mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > Subject: Re: [PATCH v2 2/5] Documentation: Detail permitted DT properti=
es
> > for the imx6ul_tsc
> >=20
> > Hi,
> >=20
> > On Tue, Jul 28, 2015 at 05:58:38PM +0800, Haibo Chen wrote:
> > > Here we apply required documentation for the imx6ul touch screen
> > > controller driver which describe available properties and how to use
> > > them.
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > >  .../bindings/input/touchscreen/imx6ul_tsc.txt      | 36
> > ++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> > > b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> > > new file mode 100644
> > > index 0000000..ac41c32
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.t
> > > +++ xt
> > > @@ -0,0 +1,36 @@
> > > +* Freescale i.MX6UL Touch Controller
> > > +
> > > +Required properties:
> > > +- compatible: must be "fsl,imx6ul-tsc".
> > > +- reg: this touch controller address and the ADC2 address.
> >=20
> > This suggests that this driver is using a unit ADC2. Which also means
> > that there are more than one ADC which are probably identical?
> >=20
> > Shouldn't these ADCs be properly described by their own device nodes
> > instead of these two register ranges, two interrupts and two clocks?
> >=20
> > Is 'ADC2' usable without tsc? Then ADC1/ADC2 should perhaps get a proper
> > IIO driver.
>=20
> For i.MX6UL, there are two ADC. ADC1 is a normal ADC, and ADC2 can only w=
orks for
> TSC, the channels of ADC2 are connected to TSC directly. TSC and ADC2 sho=
uld work
> together as a touch screen controller.=20

But as I understand these are two different units. Wouldn't it be better
to abstract it that way in the DT?

Best regards,

Markus

>=20
> For ADC1, it share the driver vf610_adc.c (drivers/iio/adc/vf610_adc.c).=
=20
>=20
> Best Regards
>=20
> Haibo=20
> =20
> >=20
> > Unfortunately I don't have the reference manual to have a look how this
> > all works.
> >=20
> > Best regards,
> >=20
> > Markus
> >=20
> > > +- interrupts: the interrupt of this touch controller and ADC2.
> > > +- clocks: the root clock of touch controller and ADC2.
> > > +- clock-names; must be "tsc" and "adc".
> > > +- xnur-gpio: the X- gpio this controller connect to.
> > > +  This xnur-gpio returns to high once the finger leave the touch
> > > +screen (The
> > > +  last touch event the touch controller capture).
> > > +
> > > +Optional properties:
> > > +- measure-delay-time: the value of measure delay time.
> > > +  Before X-axis or Y-axis measurement, the screen need some time
> > > +before
> > > +  even potential distribution ready.
> > > +  This value depends on the touch screen.
> > > +- pre-charge-time: the touch screen need some time to precharge.
> > > +  This value depends on the touch screen.
> > > +
> > > +Example:
> > > +	tsc: tsc@02040000 {
> > > +		compatible =3D "fsl,imx6ul-tsc";
> > > +		reg =3D <0x02040000 0x4000>, <0x0219c000 0x4000>;
> > > +		interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> > > +			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> > > +		clocks =3D <&clks IMX6UL_CLK_IPG>,
> > > +			 <&clks IMX6UL_CLK_ADC2>;
> > > +		clock-names =3D "tsc", "adc";
> > > +		pinctrl-names =3D "default";
> > > +		pinctrl-0 =3D <&pinctrl_tsc>;
> > > +		xnur-gpio =3D <&gpio1 3 GPIO_ACTIVE_HIGH>;
> > > +		measure-delay-time =3D <0xfff>;
> > > +		pre-charge-time =3D <0xffff>;
> > > +		status =3D "okay";
> > > +	};
> > > --
> > > 1.9.1
> > >
> > >
> > >
> >=20
> > --
> > Pengutronix e.K.                           |
> > |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/
> > |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> > |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> > |

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1u78AAoJEEpcgKtcEGQQznUQAIkpM8cO8ADjnh+jSxgcTb4l
T/HFVVpUwxi9ghuB/Cd+Shdq7Xr8A1QZifpl+7i/ZZFWO1NxmZe3+iHgrkOu2QGu
e+StHrgcEWei+oIQBkiGWKbB3XEuayUZkVEHYaoUIRYze06SfrUh5VzSz4ayVqij
rEjk+YqAQiq5hpgKVHUwMApshnmMzQ39MBcpVz6bN9Tbznf9u83eBNQTfHwoAJe+
h4r51cqX5kcUA5i0aPliIjbz/QgvpKm3Qy4/JjY3Aomywh3hNM+rnzZ5Y4kq7yRB
Ro50WDhesAR8CISKpOhV9PMef7/TMoWRL9q6CC74F2Cdu21g2Gv1zpxpptOWWlkY
caegvJMEbx35WyLjxW8qgZd+DPfPSc8EOR0v6yPuUGT2J01uxjaUrDo7HS3K2rLV
eydOwT+q7JkNjpWM9oSCTq5a6LNg/71YvssAESF3EkiAiYZLgkihyRarSARz0CqT
v0I1ZPOJGsgKMYxLuB8WjJoxbFUmhXt8eeS8LEvAZQbn4mDHAugzpyA32l8CsYFA
8PkereHE66MZMyB70TFQo1IooKS2FbxEtJCjblizVy3HhqrjFNTAvQHiTh2RqBZI
4Ys7KDfanCJdXVwCDnI0L9lgx42M+t5tXWvdKHVhQJ1sVjLfAkAxJohkg0Y2Ng57
a/Yps+bsznjs1ACXwylL
=3cBv
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
