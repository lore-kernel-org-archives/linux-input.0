From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v9 3/8] ARM: dt: Binding documentation for imx25 touchscreen controller
Date: Tue, 08 Dec 2015 11:33:39 +0100
Message-ID: <6094071.cpaNNKXzrc@adelgunde>
References: <1449431542-1892-1-git-send-email-mpa@pengutronix.de> <1449431542-1892-4-git-send-email-mpa@pengutronix.de> <20151207204546.GA30936@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart161066863.S5KdsbnWZj"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37827 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932544AbbLHKeE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Dec 2015 05:34:04 -0500
In-Reply-To: <20151207204546.GA30936@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, linux-iio@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Denis Carikli <denis@eukrea.com>, Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>


--nextPart161066863.S5KdsbnWZj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

On Monday 07 December 2015 14:45:46 Rob Herring wrote:
> On Sun, Dec 06, 2015 at 08:52:16PM +0100, Markus Pargmann wrote:
> > This is the touchscreen conversion queue binding documentation. It =
uses
> > the shared imx25 ADC.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >=20
> > Notes:
> >     Changes in v9:
> >      - Updated binding descriptions
> >    =20
> >     Changes in v5:
> >      - Fix signed/unsigned comparison
> >      - Fix unused variable settling_time by putting it in the corre=
ct argument list
> >      - Use continous conversion queue with the repeat feature and a=
 proper
> >        repeat-wait. Previously the touchscreen caused massive numbe=
r of interrupts.
> >=20
> >  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 35 ++++++++++=
++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchsc=
reen/fsl-mx25-tcq.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/fs=
l-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fs=
l-mx25-tcq.txt
> > new file mode 100644
> > index 000000000000..d45e50872114
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-=
tcq.txt
> > @@ -0,0 +1,35 @@
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
>=20
> This and ...
>=20
> > + - fsl,pen-threshold: Pen-down threshold for the touchscreen. This=
 is a value
> > +   between 1 and 4096. It is the ratio between the internal refere=
nce voltage
> > +   and the measured voltage after the plate was precharged. Resist=
ence between
> > +   plates and therefore the voltage decreases with pressure so tha=
t a smaller
> > +   value is equivalent to a higher pressure.
> > + - fsl,settling-time: Settling time in nanoseconds. The settling t=
ime is before
> > +   the actual touch detection to wait for an even charge distribut=
ion in the
> > +   plate.
>=20
> ... this still need units (-ns) appended to the property name.

Thanks. I wasn't aware that the property names itself should include th=
e units.
Will fix that.

Best Regards,

Markus

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart161066863.S5KdsbnWZj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWZrIJAAoJEEpcgKtcEGQQvXQP/j+LCJU18AoxZ5EiUycHkg6m
nIfzkILPYKCD4DpvQGEQa1iu7FnsPbXOtusiknhGuBpWkyJKga+RcQB5z9XzDvID
/nuY3MN9ExNUtYvXl7ehVaaDuBdNYE1JF6PEdR3H7QrqORmPZK57kju/UeAAtPjR
gesaHfK4Ln5iOOxCwu5dxpr0ZUd0l9jL1YgffetQkEToY7/gE4gklfUK0WdSevrl
m+Itq2zyE9f9DYLAf9NcvcCUhviqhCvrNDY7IvV+mQEUjlQ1KPbbl216m7wmw6Tp
ZM59M28j1T/cqeLCsiGc/QtgbKwQP+1a0iWAD1YTN6zr13LG8bJ6aQP/uoTDWeF3
AfNNo1zjWdOJkC3e0SLoHj+ekyHY1oYSMXuSGm/jgEl5n3oSWWaFzVKHJqjT977o
AHozoRBslLvPwOpTqjJyaPjMzwAT2k+Zy5sZf2pM5Yhazs+jvsvffUPEw0oOGN1O
2bq3WpDT4Fr3ZFI6yh9Gm/I3qoxo4kIg2YPL4vVJEfZRi4CMFlU4SaLremrDYhs0
j4cYMzAjv2QFpHcfIjpaSIROWc+8XYq3LkTrR3E++7dWekq8S1dsoFPOnOQqSQPa
V8cMlYzaHWqqfD1oB2+7JU9zkrjREToJKBGmQnjGITsYfHk0iRqNRe4tHF7bNw88
ZVI/DwqVe+1XX6WjfyLG
=xD7q
-----END PGP SIGNATURE-----

--nextPart161066863.S5KdsbnWZj--

