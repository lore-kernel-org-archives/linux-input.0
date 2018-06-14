From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH v5] Input: add bu21029 touch driver
Date: Thu, 14 Jun 2018 16:23:37 +0000
Message-ID: <267fd38819114d99bbdaabc6afcf28cd@de.bosch.com>
References: <73b4ea3ce1aa453681fae87b7bad5cab@de.bosch.com>
 <20180613222044.GC62746@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180613222044.GC62746@dtor-ws>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "ZHANG Kevin (BT-FIR/ENG1-Zhu)" <Kevin.Zhang3@cn.bosch.com>, Zhu Yi <zhuyi882004@126.com>, "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

> Sorry for the delay. Could you please tell me if the patch below (shoudl
> apply on top of your v5 version) works?

The patch applies cleanly and we will give the code a thorough test.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/bu21029.=
txt
> b/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
> index 030a888365dff..1aaa647cc3eaa 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
> @@ -5,13 +5,14 @@ Required properties:
>   - reg                     : i2c device address of the chip (0x40 or 0x4=
1)
>   - interrupt-parent        : the phandle for the gpio controller
>   - interrupts              : (gpio) interrupt to which the chip is conne=
cted
> - - reset-gpios             : gpio pin to reset the chip (active low)
>   - rohm,x-plate-ohms       : x-plate resistance in Ohm
>=20
>  Optional properties:
> + - reset-gpios             : gpio pin to reset the chip (active low)
>   - touchscreen-size-x      : horizontal resolution of touchscreen (in pi=
xels)
>   - touchscreen-size-y      : vertical resolution of touchscreen (in pixe=
ls)
>   - touchscreen-max-pressure: maximum pressure value
> + - vdd-supply              : power supply for the controoler

There is a typo in controller.

Greetings,
Mark

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
