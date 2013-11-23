From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [git pull] Input updates for 3.13-rc0 (2nd)
Date: Sat, 23 Nov 2013 16:07:12 +0100
Message-ID: <5290C4A0.80600@butterbrot.org>
References: <20131122225700.GC12800@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qU1eleVcrMO0mv68P69Vv9AWt59uNclG3"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:59142 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab3KWPHT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Nov 2013 10:07:19 -0500
In-Reply-To: <20131122225700.GC12800@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qU1eleVcrMO0mv68P69Vv9AWt59uNclG3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

great - thanks again for your help and for amending the missing config
option. Had entirely missed that one.

BR, Florian

On 22.11.2013 23:57, Dmitry Torokhov wrote:
> Hi Linus,
>=20
> Please pull from:
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus=

> or
> 	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus
>=20
> to receive 2nd round of updates for the input subsystem. You will get a=

> new driver for Surface 2.0/Pixelsense touchscreen and a couple of drive=
r
> fixups.
>=20
> Changelog:
> ---------
>=20
> Dan Carpenter (1):
>       Input: hp_sdc_rtc - unlock on error in hp_sdc_rtc_read_i8042timer=
()
>=20
> Dmitry Torokhov (1):
>       Input: atmel-wm97xx - fix compile error
>=20
> Florian Echtler (1):
>       Input: add sur40 driver for Samsung SUR40 (aka MS Surface 2.0/Pix=
elsense)
>=20
> Haiyang Zhang (1):
>       MAINTAINERS - add keyboard driver to Hyper-V file list
>=20
> Xie XiuQi (1):
>       Input: cyttsp4 -  remove unnecessary work pending test
>=20
>=20
> Diffstat:
> --------
>=20
>  drivers/input/misc/hp_sdc_rtc.c          |   5 +-
>  drivers/input/touchscreen/Kconfig        |  11 +
>  drivers/input/touchscreen/Makefile       |   1 +
>  drivers/input/touchscreen/atmel-wm97xx.c |   2 +-
>  drivers/input/touchscreen/cyttsp4_core.c |   3 +-
>  drivers/input/touchscreen/sur40.c        | 466 +++++++++++++++++++++++=
++++++++
>  6 files changed, 484 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/input/touchscreen/sur40.c
>=20


--=20
SENT FROM MY DEC VT50 TERMINAL


--qU1eleVcrMO0mv68P69Vv9AWt59uNclG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlKQxKAACgkQ7CzyshGvatjcEgCgs1DeRTYY5Jsjbiuk2Bize5fA
+UcAoO8/UWgzOfKdmVRlH6pvwBl3nIc2
=b3IY
-----END PGP SIGNATURE-----

--qU1eleVcrMO0mv68P69Vv9AWt59uNclG3--
