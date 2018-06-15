From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH v5] Input: add bu21029 touch driver
Date: Fri, 15 Jun 2018 14:28:27 +0000
Message-ID: <2a68611474694fb2b68146d8d167bf26@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "D_ZHU Yi (BT-FIR/ENG1-Zhu)" <D_Yi.Zhu5@cn.bosch.com>, "ZHANG Kevin (BT-FIR/ENG1-Zhu)" <Kevin.Zhang3@cn.bosch.com>, Zhu Yi <zhuyi882004@126.com>, "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>
List-Id: linux-input@vger.kernel.org

Hi,

Correction:

> Only for 4.14 an #include <linux/regulator/consumer.h> was missing. I
> Guess the API changed here a little in the meantime.

The missing include is #include <linux/irq.h>.

Greetings,
Mark

Building Technologies, Panel Software Fire (BT-FIR/ENG1)
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
