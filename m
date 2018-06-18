From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH v3] Input: add bu21029 touch driver
Date: Mon, 18 Jun 2018 09:35:40 +0000
Message-ID: <d790eaf934274cc6a489c177d1f42674@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>, "ZHANG Kevin (BT-FIR/ENG1-Zhu)" <Kevin.Zhang3@cn.bosch.com>, "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "zhuyi882004@126.com" <zhuyi882004@126.com>
List-Id: linux-input@vger.kernel.org

Hi kbuild test robot,

> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on v4.17-rc4]
> [also build test WARNING on next-20180615]
> [cannot apply to input/next]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Mark-Jonas/Input-add-bu2=
1029-
> touch-driver/20180512-091305
> reproduce:
>         # apt-get install sparse
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D-D__CHECK_ENDIAN__
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
> >> drivers/input/touchscreen/bu21029_ts.c:293:13: sparse: restricted __be=
16
> degrades to integer
[..]
>    288		if (error < 0) {
>    289			dev_err(&i2c->dev, "failed to read HW ID\n");
>    290			goto out;
>    291		}
>    292
>  > 293		if (cpu_to_be16(hwid) !=3D SUPPORTED_HWID) {
>    294			dev_err(&i2c->dev, "unsupported HW ID 0x%x\n", hwid);
>    295			error =3D -ENODEV;
>    296			goto out;
>    297		}

Thank you for your effort. The reported problem was already fixed.
Please have a look at the most recent v5 patch posted on this list.

Greetings,
Mark

 Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster=20
