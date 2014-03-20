From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv4 2/5] Input: edt-ft5x06: Add DT support
Date: Thu, 20 Mar 2014 13:21:56 +0000
Message-ID: <20140320132156.GD22115@e106331-lin.cambridge.arm.com>
References: <1395234563-11034-1-git-send-email-LW@KARO-electronics.de>
 <1395234563-11034-3-git-send-email-LW@KARO-electronics.de>
 <20140320093719.GB14420@e106331-lin.cambridge.arm.com>
 <20140320124055.53d469e7@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140320124055.53d469e7@ipc1.ka-ro>
Sender: linux-doc-owner@vger.kernel.org
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fugang Duan <B38611@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Henrik Rydberg <rydberg@euromail.se>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jg1.han@samsung.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <Pawel.Moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Rob Landley <rob@landley.net>, Sachin Kamat <sachin.kamat@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Budig <simon.budig@kernelconcepts.de>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 20, 2014 at 11:40:55AM +0000, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Mark Rutland wrote:
> > On Wed, Mar 19, 2014 at 01:09:20PM +0000, Lothar Wa=C3=9Fmann wrote=
:
> > >=20
> > > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > > ---
> > >  .../bindings/input/touchscreen/edt-ft5x06.txt      |   41 ++++++
> > >  drivers/input/touchscreen/edt-ft5x06.c             |  144 ++++++=
+++++++++-----
> > >  2 files changed, 154 insertions(+), 31 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/input/touch=
screen/edt-ft5x06.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/=
edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/ed=
t-ft5x06.txt
> > > new file mode 100644
> > > index 0000000..e5adc76
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5=
x06.txt
> > > @@ -0,0 +1,41 @@
> > > +FocalTech EDT-FT5x06 Polytouch driver
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Required properties:
> > > + - compatible:  "edt,edt-ft5x06"
> >=20
> > Is the 'x' part of a particular product name, or is this a class of
> > devices?
> >=20
> The FT5x06 datasheet lists 3 variants for different panel sizes.
> I'll add distinct compatible strings for those chips, though their SW
> interface is (currently) identical:
> |Required properties:
> | - compatible:  "edt,edt-ft5206", "edt,edt-ft5x06"
> |           or:  "edt,edt-ft5306", "edt,edt-ft5x06"
> |           or:  "edt,edt-ft5406", "edt,edt-ft5x06"

Drop the "edt,edt-ft5x06" string. If they really appear to be identical
from a programmer's perspective, choose a particular variant to be used
as the fallback.

There could be a future variant that would appear to match the x string
yet was completely incompatible with the expected programming interface=
=2E

> > > + - reg:         I2C slave address of the chip (0x38)
> > > + - interrupt-parent: a phandle pointing to the interrupt control=
ler
> > > +                     serving the interrupt for this chip
> > > + - interrupts:       interrupt specification for this chip
> >=20
> > How many? What are they for?
> >
> I'll change it to:=20
> | - interrupts:       interrupt specification for the touchdetect
> |                     interrupt

That sounds fine to me.

> > > + - report_rate: allows setting the report rate in the range from=
 3 to
> > > +                14.
> >=20
> > However, why can the kernel not decide the report rate? This doesn'=
t
> > sound like something that needs to vary per-board.
> >=20
> > Also, s/_/-/ in property names, please.
> >=20
> OK, I'll drop the property, which also simplyfies the code a bit.

Sounds good to me.

>=20
> > > +#define EDT_GET_PROP(name, reg) {					\
> > > +	const u32 *prop =3D of_get_property(np, #name, NULL);		\
> > > +	if (prop)							\
> > > +		edt_ft5x06_register_write(tsdata, reg, be32_to_cpu(*prop)); \
> > > +}
> >=20
> > Use of_property_read_u32, it'll handle endianness conversion for yo=
u.
> >=20
> > Use of of_get_property is almost always wrong.
> >=20
> Sure.

Cheers,
Mark.
