From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH] Input: twl4030 - convert to using managed resources
Date: Sun, 5 Jan 2014 04:47:12 +0100
Message-ID: <20140105034710.GA17291@earth.universe>
References: <20140104090147.GA16680@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:44299 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbaAEDrT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Jan 2014 22:47:19 -0500
Content-Disposition: inline
In-Reply-To: <20140104090147.GA16680@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Fugang Duan <B38611@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, ".linux-kernel"@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 04, 2014 at 01:01:48AM -0800, Dmitry Torokhov wrote:
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>=20
> Compile-tested only.
>=20
>  drivers/input/keyboard/twl4030_keypad.c | 70 +++++++++++----------------=
------
>  1 file changed, 22 insertions(+), 48 deletions(-)

I have successfully booted dtor/input.git:master with this patch on
top and the addition of twl4030-keypad DT nodes in omap3-n900.dts on
my N900.

Tested-by: Sebastian Reichel <sre@debian.org>

-- Sebastian

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSyNW+AAoJENju1/PIO/qaIgQP/0u4ZEdDxgc6tJjWKaHgO/jE
KzP5ZvAFIKmMZIsrRsWO1iLvwaAcOvpQxgHYxR1OPM/b8mR1NWUEs0OwthHSp7dw
2l7JjRRIYaKB6/wGWj6YT/V8JbWb8hFfckgwShp/A3v9DxIuJ+rtAWOstVCytmD7
fV9o7RCbTeWC7kh0RsreSRcIlrokYaOHMzx8VJW2BBcB2DXyfIPqrIepcQsu4Z8j
C2RFMt+CFUcs1IMUqDD/5baRflW5VNGvy4xjA+TkZgkDGQTGChUKyXn5sQxnlgS/
IvhYKTQTUEusNvz0QJ4mWJIe9HOJcOlxNk4NNiaFtVDgfPOWZP8zI7WYwzx1meS1
GIca+vZtvYgO5MYp9XS3gFcRFIXH0Q9lcX+tHpXW3k0lV9U24aWpd6J2/Qx5/V2h
7msppuIi+sF0qEsAtYp/zq6KVClXX5e+4t4LTy/lDadPrKFmCgCWGNrvjukhaCyd
JpTQ2gq0LLeBhy2TgKUPjjxJM3meF7Un1K3p0PMBqkJk16l3vWKC68wAPzqVMKko
mvxJspLAFU4dfu6d2mierrtRVbuANXq1S9fSeQzgtaumxNEl/C/oCjHQAL5nDfXO
82DTA5AmPY5YUF13Lu98uY26E1AF+vVX6nb+v7fFEHEJBhxTdcYRe5Hvky2HUEzk
yBnFpvo0vUER4QYZYFFb
=kMpw
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
