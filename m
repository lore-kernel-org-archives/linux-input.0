From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 0/3] mfd: mc13xxx: Fixes and enhancements for NXP's
 mc34708
Date: Mon, 30 Sep 2019 09:51:59 +0200
Message-ID: <20190930095159.64e1001a@jawa>
References: <20190909214440.30674-1-lukma@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_//YIL_V9Fmub+k=zkc2GyIA6"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190909214440.30674-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

--Sig_//YIL_V9Fmub+k=zkc2GyIA6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Lee,

> This patch set provides several enhancements to mc13xxx MFD family
> of devices by introducing mc34708 as a separate device.
>=20
> This IC has dedicated pen detection feature, which allows better
> touchscreen experience.
>=20
> This is the fifth version of this code (v5).
> Discussion regarding previous versions can be found here:
> https://lkml.org/lkml/2018/4/12/351
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1661934.html
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1664296.html
> https://lkml.org/lkml/2019/7/17/705

Gentle ping on this patch series. It is now 3 weeks without any reply...

>=20
> Sascha Hauer (3):
>   mfd: mc13xxx: Add mc34708 adc support
>   input: touchscreen mc13xxx: Make platform data optional
>   input: touchscreen mc13xxx: Add mc34708 support
>=20
>  drivers/input/touchscreen/mc13783_ts.c | 63 ++++++++++++++---
>  drivers/mfd/mc13xxx-core.c             | 98
> +++++++++++++++++++++++++- include/linux/mfd/mc34708.h            |
> 37 ++++++++++ 3 files changed, 185 insertions(+), 13 deletions(-)
>  create mode 100644 include/linux/mfd/mc34708.h
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_//YIL_V9Fmub+k=zkc2GyIA6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2RtB8ACgkQAR8vZIA0
zr3vHwgAqDghkSGOToJcjlxmTxbnkF2JdYSKUD0tR0Je2c3CGbGL6jtDYe2rqWk8
8lPDns6dgzA3mlbibBXjhPbx5AAtkEtDGB5FPUigq/y/XomIoEOm33G2QuY97Jsi
NEfhV3HzIcdhHGro/q1N3ATBGouI5xpVyKirKlmkQuJzXmseGjkJ05v4FtaIbmuP
eFRrvytW+Bkkdarko2KWcQHDkqJtsU/mSMXh680PRX4sxZyDrkmOkm19wY9zBrhz
CW8/j4N89iovIEq1xiJuVR/5zdxN7+tqAmjsoDvku7yGfXWRQ9pUcqJ0SnzN8hV9
OAZjBte9hOBG9CZvPuv3sx7n4oZiLg==
=YCsb
-----END PGP SIGNATURE-----

--Sig_//YIL_V9Fmub+k=zkc2GyIA6--
