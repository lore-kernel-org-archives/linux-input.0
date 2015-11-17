From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 3/8] ARM: dt: Binding documentation for imx25 touchscreen controller
Date: Tue, 17 Nov 2015 09:54:03 +0100
Message-ID: <2927401.FasWCEIy4W@adelgunde>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de> <1447675269-8831-4-git-send-email-mpa@pengutronix.de> <20151116141609.GA6167@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10441568.fBDciVvhji"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151116141609.GA6167@rob-hp-laptop>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?ISO-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--nextPart10441568.fBDciVvhji
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

On Monday 16 November 2015 08:16:09 Rob Herring wrote:
> On Mon, Nov 16, 2015 at 01:01:04PM +0100, Markus Pargmann wrote:
> > This is the touchscreen conversion queue binding documentation. It =
uses
> > the shared imx25 ADC.
> >=20
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >=20
> > Notes:
> >     Changes in v5:
> >      - Fix signed/unsigned comparison
> >      - Fix unused variable settling_time by putting it in the corre=
ct argument list
> >      - Use continous conversion queue with the repeat feature and a=
 proper
> >        repeat-wait. Previously the touchscreen caused massive numbe=
r of interrupts.
> >=20
> >  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 29 ++++++++++=
++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchsc=
reen/fsl-mx25-tcq.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/fs=
l-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fs=
l-mx25-tcq.txt
> > new file mode 100644
> > index 000000000000..89ab47a3acc1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-=
tcq.txt
> > @@ -0,0 +1,29 @@
> > +Freescale mx25 TS conversion queue module
> > +
> > +mx25 touchscreen conversion queue module which controls the ADC un=
it of the
> > +mx25 for attached touchscreens.
> > +
> > +Required properties:
> > + - compatible: Should be "fsl,imx25-tcq".
> > + - reg: Memory range of the device.
> > + - interrupts: Should be the interrupt number associated with this=
 module within
> > +   the tscadc unit (<0>).
> > + - interrupt-parent: Should be a phandle to the tscadc unit.
> > + - fsl,wires: Should be '<4>' or '<5>'
> > +
> > +Optional properties:
> > + - fsl,pen-debounce: Pen debounce time in nanoseconds.
> > + - fsl,pen-threshold: Pen-down threshold for the touchscreen.
> > + - fsl,settling-time: Settling time in nanoseconds.
>=20
> Don't we have standard properties for these? If not, these should hav=
e=20
> units.

I just found properties like 'debounce_timeout' without a vendor prefix=
 but
they don't seem to be standard properties:
=09Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touch=
screen.txt

For fsl,pen-threshold there is no real unit. It is the ratio between th=
e
internal voltage reference and the measured voltage after one of the
touchscreen plates was precharged. However there are limits, I will add=
 a
better description.

>=20
> I don't understand the difference between debounce and settling times=
.=20
> Please make that clear in the doc.

The settling time is the time waited after charging the touchscreen pla=
tes. The
pen-debounce time is a delay after a pen down has been detected.

Best Regards,

Markus

>=20
> Rob
>=20
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

--nextPart10441568.fBDciVvhji
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWSusrAAoJEEpcgKtcEGQQU2EP/1CGedi07KtAR2aaCUTKMmHC
wuX8qHJpsh6sbcr9Y4azI7q6eiW4ONVxJEbt4cxON8rCHhqI1OmlYGucyDG9x0HR
N3itvHvir8szFvs0Z7AbEepz03X6ahMWNX4Y9+OOrtJNuL+AjseXV3vRvhxSOSPV
VcCEzzkvEcUB3vL4GGzJv8ijvzThwRgxnlsrSttGFWDrESihcvBHvQsTeq97Y5EB
gvn6tuQSGH7+9z6eAwP6fKKg5cDs0nkib/spwhzBTsYUCBBDRzPWc4cEHR8QU287
lFxwdA9mVBe/jBlqcfq6pV7qQhKpjkxAITIhbSFhh0JGGJyF25BWJamTb8XHrULO
DO/Dksb01/i95of01fXEbMrMUsbi8F82PUpdV4xQsSEmxH1NYhtYd9dWPuTC+XSd
W3UdnB+V0acbBF3S2p7cCt57i/SuIP3jDJOr67KQV9m7ENX5asTjwgbSQuYyoyGF
WzVlcqq5H3hvuJvoEh/tp7GdSYD19a+wJCsbDnA6JKhhqnM4xjiaYyFzr2SbogB1
AkR2DP9cwIwnnzcyDHq4tHjcL66F7AMjVjPdfdPYlya+ZK5mkmwTHtaMA9sU5CDJ
bpRgNEBWVqrj57FTgT4+fvvAcFiLbbw3VIHFoPhjh125g2ZwpdkCnkZefDXg/pZz
7vMzMpxLcno2B9vyl0zN
=/Fbw
-----END PGP SIGNATURE-----

--nextPart10441568.fBDciVvhji--
