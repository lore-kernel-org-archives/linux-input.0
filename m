From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] mfd: fsl imx25 Touchscreen ADC driver
Date: Fri, 21 Feb 2014 11:18:39 +0100
Message-ID: <20140221101839.GD24758@pengutronix.de>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1392913312-9030-2-git-send-email-mpa@pengutronix.de>
 <CAOMZO5BDyyvXs9CxJQOkuEpxZ8fqamCPB67sNhJxES+XU2XkXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5BDyyvXs9CxJQOkuEpxZ8fqamCPB67sNhJxES+XU2XkXQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On Thu, Feb 20, 2014 at 02:17:33PM -0300, Fabio Estevam wrote:
> Hi Markus,
>=20
> On Thu, Feb 20, 2014 at 1:21 PM, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wro=
te:
> > This is the core driver for imx25 touchscreen/adc driver. The module
> > has one shared ADC and two different conversion queues which use the
> > ADC. The two queues are identical. Both can be used for general purpose
> > ADC but one is meant to be used for touchscreens.
> >
> > This driver is the core which manages the central components and
> > registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> > the correct components.
> >
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> That's great :-) Nice work!
>=20
> > ---
> >  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  46 ++++
> >  drivers/mfd/Kconfig                                |   9 +
> >  drivers/mfd/Makefile                               |   2 +
> >  drivers/mfd/fsl-imx25-tsadc.c                      | 234 +++++++++++++=
++++++++
> >  include/linux/mfd/imx25-tsadc.h                    | 138 ++++++++++++
> >  5 files changed, 429 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsa=
dc.txt
> >  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
> >  create mode 100644 include/linux/mfd/imx25-tsadc.h
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt =
b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > new file mode 100644
> > index 0000000..a857af0e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > @@ -0,0 +1,46 @@
> > +Freescale mx25 ADC/TSC multifunction device
> > +
> > +This device combines two general purpose conversion queues one used fo=
r general
> > +ADC and the other used for touchscreens.
> > +
> > +Required properties:
> > + - compatible: Should be "fsl,imx25-tsadc".
> > + - reg: Memory range of the device.
> > + - interrupts: Interrupt for this device as described in
> > +   interrupts/interrupts.txt
> > + - clocks: An 'ipg' clock defined as described in clocks/clock.txt
> > + - interrupt-controller: This device is an interrupt controller. It co=
ntrols
> > +   the interrupts of both conversion queues.
> > + - #interrupt-cells: Should be '<1>'.
> > + - #address-cells: Should be '<1>'.
> > + - #size-cells: Should be '<1>'.
> > + - ranges
> > +
> > +This device includes two conversion queues which can be added as subno=
des.
> > +The first queue is for the touchscreen, the second for general purpose=
 ADC.
> > +
> > +Example:
> > +       tscadc: tscadc@50030000 {
> > +               compatible =3D "fsl,imx25-tsadc";
> > +               reg =3D <0x50030000 0xc>;
> > +               interrupts =3D <46>;
> > +               clocks =3D <&clks 119>;
> > +               clock-names =3D "ipg";
> > +               interrupt-controller;
> > +               #interrupt-cells =3D <1>;
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <1>;
> > +               ranges;
> > +
> > +               tsc: tcq@50030400 {
> > +                       compatible =3D "fsl,imx25-tcq";
> > +                       reg =3D <0x50030400 0x60>;
> > +                       ...
> > +               };
> > +
> > +               adc: gcq@50030800 {
> > +                       compatible =3D "fsl,imx25-gcq";
> > +                       reg =3D <0x50030800 0x60>;
> > +                       ...
> > +               };
> > +       };
>=20
> The meaning of 'tcq' and 'gcq' acronyms are not obvious. Could they be
> written more explicitily?
>=20
> Also, what does the '...' mean?

I forgot to answer this one. The bindings for tcq and gcq are described
in the other files, so I didn't want to show any details that are not
relevant for this driver.

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJTByf/AAoJEEpcgKtcEGQQiXUP93rS5tDu5ityARC/KWbvzdMM
F1kYSB5OC6Xq1mzNvZp50/1XdvBwTlgbI99L97IND2FkSffQ6af/vvGNPrfXqlz8
eA8meJNcVTUcG0NKFyZaTRTKs8hNHgU0L6VsGUaIbwf2FJWfuFmQApkZcj7twIO/
feIlH6Qhws3PG4GjcXo7dIUr4fMsU/6URYrJ8HFpDgCmFvR81dP9sI9GDziD2n9X
lDJoI456mIfGcYqp2njge3MfP2LqnPj404KuEcRjkcI+TdNc6ytmeahyCnIt7tdL
zdx3FoFhM8TnEvrlni6oWpcorjDpldQCw3rpZ1qMOsbvuiFcfxTxas3BWFqoT0Eo
wvI/747v51PH8N+n0OT7/tTbXi+r1oprYDNhls5g1eHdxEAPD4z+1+Lr82lC5t9a
oZTeTsr+78GWyEnb/8/GVAdMfHzngu7TD8mcI4CecrV6Btpf9vEvouExkxmaeSgP
jU2WpjLcimz978A3YirMOCX9XqQ3HK6eg+luFvjbNV9Nd2XQ+xrR6zCbwmeYKaoR
PrOtjo1eoeGFWv5hMUfiAfzgoTxI6vbqSIEXEECMcYCndU+SMHJb0IRUp6Vq6Ptq
2d0xXPF4T5jc11poNIT/BEvJHcQSrFMMUzq19Rp1PKEgPmnjquvQH2jWsTls8zif
YKbgnclHf4aC4LEuLwo=
=y+Ov
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
