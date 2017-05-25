From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] gpio: adp5588: move header file out of I2C realm
Date: Thu, 25 May 2017 19:09:43 +0200
Message-ID: <20170525170943.GA3546@katana>
References: <20170521215727.1243-1-wsa@the-dreams.de>
 <20170521215727.1243-4-wsa@the-dreams.de>
 <20170522234026.GD12016@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170522234026.GD12016@dtor-ws>
Sender: linux-i2c-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-i2c@vger.kernel.org, Steven Miao <realmz6@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 04:40:26PM -0700, Dmitry Torokhov wrote:
> On Sun, May 21, 2017 at 11:57:27PM +0200, Wolfram Sang wrote:
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> >=20
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >=20
> > This driver could also go via the input-tree or my tree. I don't really=
 care
> > and just picked some subsystem :) Let me know if you are okay with that.
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Linus, will you take it?


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlknD9IACgkQFA3kzBSg
KbYimw//RsW4wCCJ0312bmrqaupgxs7BcZhL4rVRiG/UPUzLRDVB/qgLhErKc+82
V0C6fp9wXTcVNiznG0Nx+BwHzmh2MFzjgDosLQk1pFzn4r1Huf14P/aaanmASDL1
11hE6u4OHwA82vbJSP2f3Lt56b4t3DGpK9/wmEXZetk0d3bLRTauWVhkcouGeD1j
pB/5Rxlw6jo2uN5QwaXKRc+GsAdh8oebxc/FQjfUgNFf5IX/bdIC+eev7BTKI80u
GyqMO58xKDeiUou+WpQxSttDumnpXBxnES6fL8QUfn2Ud27o6atSocue1YOv6reI
mIEY16DGZmY68bR7Ho93g5e+o7nUcI+p1G0HtOP2bHkzUc1iWa7ds3Oi1VCUv0z3
TDOOn93/k+YBMF0ho5PhkgUGO7lTh+0xRboMIegt7Re6Scn0K6UgRDcLE+q/ZpVG
d/i7y9B+/k1HluwA8rsr425PcagVlrUmsDWa/atk5m5t5v/TDG6qdCA93SHdOUWs
93hxFH0QwPczGuymg/6r9dxuF4s+mUdMGFYXAi1kgbVE+J2GBXIWtd1KsMXAXBbL
iOVaxKI2szIiEYscUHS3e4gPRgDSP/vFW4U7j9EPP2ONlDV87c2Ecb2WRGgYU54U
kbSBzkKycyA6n8d3K+uHKs3Yij3rcCpUSMFel82NvhEpi59ic20=
=bFxc
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
