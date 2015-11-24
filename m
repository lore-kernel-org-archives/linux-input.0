From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
Date: Tue, 24 Nov 2015 11:44:51 +0100
Message-ID: <6186462.YDum13BH0b@adelgunde>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de> <1447675269-8831-2-git-send-email-mpa@pengutronix.de> <20151123145952.GC31376@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5983557.4qvLmEj1SL"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151123145952.GC31376@x1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric =?ISO-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--nextPart5983557.4qvLmEj1SL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday 23 November 2015 14:59:52 Lee Jones wrote:
> On Mon, 16 Nov 2015, Markus Pargmann wrote:
>=20
> > This documentation describes the devicetree bindings for the
> > ADC/Touchscreen unit of the i.MX25 SoC.
> >=20
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >=20
> > Notes:
> >     Changes in v6:
> >      - Removed adc-ref property and replaced it with refp and refn =
for positive and
> >        negative references. The properties are optional now as the =
default
> >        behaviour is a positive internal reference voltage and ADC G=
ND as negative
> >        reference.
> >=20
> >  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    | 46 ++++++++++=
++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25=
=2Dtsadc.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.=
txt b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > new file mode 100644
> > index 000000000000..a857af0eb68c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > @@ -0,0 +1,46 @@
> > +Freescale mx25 ADC/TSC multifunction device
>=20
> Prefer "MX25" and "MultiFunction Device (MFD)"

Fixed.

>=20
> > +This device combines two general purpose conversion queues one use=
d for general
> > +ADC and the other used for touchscreens.
> > +
> > +Required properties:
> > + - compatible: Should be "fsl,imx25-tsadc".
> > + - reg: Memory range of the device.
>=20
> Not exactly.  More like start location and size.
>=20
> > + - interrupts: Interrupt for this device as described in
> > +   interrupts/interrupts.txt
>=20
> No such file.  In any case, I'd prefer:
>=20
> "(See: ../interrupt-controller/interrupts.txt)".
>=20
> > + - clocks: An 'ipg' clock defined as described in clocks/clock.txt=

>=20
> Didn't you check any of what you've written?
>=20
> "(See: ../clock/clock-bindings.txt)"

Seems I didn't check these, sorry.

>=20
> > + - interrupt-controller: This device is an interrupt controller. I=
t controls
> > +   the interrupts of both conversion queues.
> > + - #interrupt-cells: Should be '<1>'.
> > + - #address-cells: Should be '<1>'.
> > + - #size-cells: Should be '<1>'.
> > + - ranges
>=20
> ?
>=20
> Also, don't think think that this looks better/easier to read?

Yes a bit, changed it.

>=20
> > +Required properties:
> > + - compatible:=09=09Should be "fsl,imx25-tsadc".
> > + - reg:=09=09=09Memory range of the device.
> > + - interrupts:=09=09Interrupt for this device as described in
> > +=09=09=09=09interrupts/interrupts.txt
> > + - clocks:=09=09=09An 'ipg' clock defined as described in clocks/c=
lock.txt
> > + - interrupt-controller:=09This device is an interrupt controller.=
 It controls
> > +   =09=09=09=09the interrupts of both conversion queues.
> > + - #interrupt-cells:=09=09Should be '<1>'.
> > + - #address-cells:=09=09Should be '<1>'.
> > + - #size-cells:=09=09Should be '<1>'.
>=20
> [...]
>=20
> > +This device includes two conversion queues which can be added as s=
ubnodes.
> > +The first queue is for the touchscreen, the second for general pur=
pose ADC.
> > +
> > +Example:
> > +=09tscadc: tscadc@50030000 {
> > +=09=09compatible =3D "fsl,imx25-tsadc";
> > +=09=09reg =3D <0x50030000 0xc>;
> > +=09=09interrupts =3D <46>;
> > +=09=09clocks =3D <&clks 119>;
> > +=09=09clock-names =3D "ipg";
>=20
> I don't think this is required, if you only have a single clock.

I prefer this variation so that you immediately see what the clock is
for. The number is not terribly helpful.

Thanks,

Markus

>=20
> > +=09=09interrupt-controller;
> > +=09=09#interrupt-cells =3D <1>;
> > +=09=09#address-cells =3D <1>;
> > +=09=09#size-cells =3D <1>;
> > +=09=09ranges;
> > +
> > +=09=09tsc: tcq@50030400 {
> > +=09=09=09compatible =3D "fsl,imx25-tcq";
> > +=09=09=09reg =3D <0x50030400 0x60>;
> > +=09=09=09...
> > +=09=09};
> > +
> > +=09=09adc: gcq@50030800 {
> > +=09=09=09compatible =3D "fsl,imx25-gcq";
> > +=09=09=09reg =3D <0x50030800 0x60>;
> > +=09=09=09...
> > +=09=09};
> > +=09};
>=20
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

--nextPart5983557.4qvLmEj1SL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWVD+qAAoJEEpcgKtcEGQQdLEP/i7le0wDFSLtPJSmA/45t7B+
JInh2I9oroXF4F2mpLMe5j+HH8JpiwlrdCnGGHswx1akmK5ky6lLOobpPwpfoWqu
hrArpK3/qkX+s599cAF/HyTrAaNVUaX131aLY6z8g1YdvMy62JiPSnFD8QqcAv7Y
Nnb6ZEovuJ0dJYaoPcJDXMwPv4FsNbmBJmo5KEek3MW6u3uD4QakWYy0Xs2a4sI4
5IHS7tbeRjZyjQnrECy70UJAfQM9Nxcy1gC3QqwY4DF/wS0myn9CvfOf++6YFw72
uNCvw6bfN5s+KgJX6OC430bE9W+gs/kPmu4XUkxIwZ53RKTX0/OJZKrwaUkhoggF
8QZKGQDojUxGca17GFXUq7rIvbibT2P17bFoslZhhym4FeftADwhP/sT0R1FzPrY
drd76llTyLA5RKDLPBSKOX0PPw2KNTD4afEC8g+jSSB6SysG5D/nnOUsyV/EnNsE
eGiK/k+yFdxnrOsDFhLAPuaNmIZZcTlEbi7CNfu3T29cfN2edpsHN500rFLMkeXM
3jruR+PDocuoSdbOeByAOtJmppjiKrRzRB93ZvQPgl3xL8Lp5i8i+sYWoBVzVM7a
BVptoJDVrq+jPnB7x/j60PSKyvsO/wc2Ou3s8zGiakW+it64wqRoa1qI0TcmCFRA
/rwEctToc7wRI3auhWdn
=1bel
-----END PGP SIGNATURE-----

--nextPart5983557.4qvLmEj1SL--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
