From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 2/8] ARM: dt: Binding documentation for imx25 GCQ
Date: Tue, 17 Nov 2015 08:46:46 +0100
Message-ID: <4058817.g5sPMk6tRK@adelgunde>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de> <1447675269-8831-3-git-send-email-mpa@pengutronix.de> <20151116151255.GA8302@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2036856.9Qh3XhqbLW"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151116151255.GA8302@rob-hp-laptop>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?ISO-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--nextPart2036856.9Qh3XhqbLW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday 16 November 2015 09:12:55 Rob Herring wrote:
> On Mon, Nov 16, 2015 at 01:01:03PM +0100, Markus Pargmann wrote:
> > The documentation describes the bindings for the imx25 GCQ unit whi=
ch is
> > essentially a generic conversion queue using the imx25 ADC.
> >=20
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >=20
> > Notes:
> >     Changes in v6:
> >      - Changed bindings to use adc-refp and adc-refn. Also a bit of=
 cleanup in the
> >        setup routine.
> >    =20
> >     Changes in v5:
> >      - Fixed locking
> >      - Removed module owner
> >=20
> >  .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  | 58 ++++++++++=
++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,i=
mx25-gcq.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gc=
q.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
> > new file mode 100644
> > index 000000000000..b0866d36a307
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
>=20
>=20
> > +Optional properties for subnodes:
> > + - fsl,adc-refp: specifies the positive reference input as defined=
 in
> > +     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
> > + - fsl,adc-refn: specifies the negative reference input as defined=
 in
> > +     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
>=20
> This header should be part of this commit.

Thanks, will fix that.

Best Regards,

Markus

>=20
> > +
> > +Example:
> > +
> > +=09adc: adc@50030800 {
> > +=09=09compatible =3D "fsl,imx25-gcq";
> > +=09=09reg =3D <0x50030800 0x60>;
> > +=09=09interrupt-parent =3D <&tscadc>;
> > +=09=09interrupts =3D <1>;
> > +=09=09#address-cells =3D <1>;
> > +=09=09#size-cells =3D <0>;
> > +
> > +=09=09inaux@5 {
> > +=09=09=09reg =3D <5>;
> > +=09=09=09fsl,adc-refp =3D <MX25_ADC_REFP_INT>;
> > +=09=09=09fsl,adc-refn =3D <MX25_ADC_REFN_NGND>;
> > +=09=09};
> > +=09};
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart2036856.9Qh3XhqbLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWSttmAAoJEEpcgKtcEGQQQ7gP/1qtLuOKTZ00txqoeEeKohmz
+tvZ2FWpGJvx+j79cIAln31sSX3DW6qj955tExQPPgmU8hGS5DjYy4TkSNpkhh5Q
lyR9uwGqV9+rVLH3BhfjINNagtkYoI9mX42dljh8KMRmqqm32gp2k7LSXDXDFAfg
gKsutZwt/WyBk+MY6x0UQ94OBp5SczVp8O1OzDUJfvq9NewEuXufqHSqxQ88bp74
/VaxTjkPT5Kl+oW4O04fMYGU5qIDH94j/7T5B3+Cd1dn4hehyd4WXcwv3ebqpKiB
4gS3pE9jwotlV2Ls+yq8u9e/OEsTmhGn6NSJEFfWVkphjBpXKVAlgR+/xrpFvHOi
B8BqfOYHYNg0TgpHAFCo3nt+xpLd2XKJLQvwMo7fvWNbrMLNBryeZ5My3tyNkoED
KZD489QlK8FFtSrzRB9bO7FmyerNA/r7cjpJRavMnEo1HplnZZy8RF/RpTJsbzLz
DQrr5HzqZbmPf/iYc0tS/gJJAn8H6XHuG8VYZ4wfHxT2IGq4OMCIiDdHLsbuGohw
SiZWB82Sc/KiB7EZWeYMYMDGYdq8zHsOknnKUkaSc8n5HhrJHDmOqhlExi7kbJhN
Fpbqm0y/Pb1IsvwonXau65RCmNsoyhbcb9CUETNPPHfqbxGh2TV5L0NHormlztwv
lPqRGq8oF5dfi6Ub3sct
=wfTm
-----END PGP SIGNATURE-----

--nextPart2036856.9Qh3XhqbLW--
