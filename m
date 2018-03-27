From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH] Input: add bu21029 touch driver
Date: Tue, 27 Mar 2018 06:52:31 +0000
Message-ID: <bf2aff8ab685473c836012bbed96c693@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
List-Id: linux-input@vger.kernel.org

Hello Rob,

> > +* Rohm BU21029 Touch Screen Controller
> > +
> > +Required properties:
> > + - compatible              : must be "rohm,bu21029"
> > + - reg                     : i2c device address of the chip
>=20
> What the valid value(s)?

The chip itself can be wired to 0x40 or 0x41. The driver can work with
any valid I2C address.

Is this what you are looking for?

- reg                     : i2c device address of the chip (0x40 or 0x41)

> > + - interrupt-parent        : the phandle for the gpio controller
> > + - interrupts              : (gpio) interrupt to which the chip is con=
nected
> > + - reset-gpios             : gpio pin to reset the chip
>=20
> Active high or low?

The chip itself needs an active low reset. But depending on whether
there is an inverter between the touch screen controller and the CPU or
not, the CPU's GPIO might need to be active high or active low. This
shall be configured by the polarity given in the device tree. The
driver uses this information to drive the reset appropriately.

Are you looking for documenting the required polarity of the touch
controller itself?

- reset-gpios             : gpio pin to reset the chip (active low)

> > +Example:
> > +
> > +	&i2c1 {
> > +		/* ... */
> > +
> > +		bu21029: bu21029@40 {
> > +			compatible =3D "rohm,bu21029";
> > +			reg =3D <0x40>;
> > +			interrupt-parent =3D <&gpio1>;
> > +			interrupts =3D <4 IRQ_TYPE_EDGE_FALLING>;
> > +			reset-gpios =3D <&gpio6 16 GPIO_ACTIVE_LOW>;
> > +			rohm,x-plate-ohms =3D <600>;
> > +			touchscreen-max-pressure =3D <4095>;
> > +		};
> > +
> > +		/* ... */
> > +	};

Greetings,
Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
