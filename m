From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH v5] Input: add bu21029 touch driver
Date: Fri, 15 Jun 2018 14:26:19 +0000
Message-ID: <df1d4c275c554533944cc17cec7e93ed@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "D_ZHU Yi (BT-FIR/ENG1-Zhu)" <D_Yi.Zhu5@cn.bosch.com>, "ZHANG Kevin (BT-FIR/ENG1-Zhu)" <Kevin.Zhang3@cn.bosch.com>, Zhu Yi <zhuyi882004@126.com>, "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

> > > > [PATCH v5] Input: add bu21029 touch driver
> > > >
> > > > Add Rohm BU21029 resistive touch panel controller support with I2C
> > > > interface.
> > >
> > > Is the patch ready to be pushed upstream? Is there anything I still n=
eed to do?
> >
> > I would like to kindly remind you of the BU21029 touch screen driver.
> > Could you please forward it to the mainline kernel?
>=20
> Sorry for the delay. Could you please tell me if the patch below (shoudl
> apply on top of your v5 version) works?

Yes, the patch works. We applied and compiled it with 4.14 and
4.17-rc3. We tested on our hardware with 4.14.

Only for 4.14 an #include <linux/regulator/consumer.h> was missing. I
Guess the API changed here a little in the meantime.

Because we do not have a controllable power supply on our board we see
the following complaint. But I think it is intentional and ok, right?

	[    1.715963] bu21029 0-0040: 0-0040 supply vdd not found, using dummy re=
gulator
	[    1.723806] input: bu21029 as /devices/soc0/soc/2100000.aips-bus/21a000=
0.i2c/i2c-0/0-0040/input/input0=20

> + - vdd-supply              : power supply for the controoler

There is a typo in controller.

What's the next step?

Greetings,
Mark

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
