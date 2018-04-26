From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH v2] Input: add bu21029 touch driver
Date: Thu, 26 Apr 2018 06:40:10 +0000
Message-ID: <04ff5fe9c5c3449b887eb9b269be1038@de.bosch.com>
References: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
 <1523897378-23207-1-git-send-email-mark.jonas@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523897378-23207-1-git-send-email-mark.jonas@de.bosch.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
List-Id: linux-input@vger.kernel.org

Hello,

> Betreff: [PATCH v2] Input: add bu21029 touch driver
>=20
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
>=20
> Add Rohm BU21029 resistive touch panel controller support with I2C
> interface.
>=20
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> Reviewed-by: Heiko Schocher <hs@denx.de>
> ---
> Changes in v2:
>  - make ABS_PRESSURE proportionally rising with finger pressure
>  - fix race between interrupt and timer during shutdown
>  - use infrastructure from include/linux/input/touchscreen.h
>  - add SPDX tag for the driver
>  - improve binding documentation
>  - fix multi-line comments

In the mean time I received a Reviewed-by from Rob Herring.

How shall I proceed? I am convinced that we did all the requested
changes and published them 2018-04-16 in the cited patch above.=20

Greetings,
Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
