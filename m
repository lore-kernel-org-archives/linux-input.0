From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH 04/14] platform/chrome: chromeos_laptop - add SPDX
 identifier
Date: Mon, 19 Mar 2018 18:53:43 -0700
Message-ID: <fb93ae08-ba3c-deda-8b56-7dbc0cb2d6af@google.com>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-5-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CDD0W7KMiVtBHwigNwtyxHBdQsn2gPdgm"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180312190907.174301-5-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Benson Leung <bleung@google.com>
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CDD0W7KMiVtBHwigNwtyxHBdQsn2gPdgm
Content-Type: multipart/mixed; boundary="a5InQserBIsiHabvug6Z9Ofz1UDUvqG8q";
 protected-headers="v1"
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
 linux-kernel@vger.kernel.org, Benson Leung <bleung@google.com>
Message-ID: <fb93ae08-ba3c-deda-8b56-7dbc0cb2d6af@google.com>
Subject: Re: [PATCH 04/14] platform/chrome: chromeos_laptop - add SPDX
 identifier
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
 <20180312190907.174301-5-dmitry.torokhov@gmail.com>
In-Reply-To: <20180312190907.174301-5-dmitry.torokhov@gmail.com>

--a5InQserBIsiHabvug6Z9Ofz1UDUvqG8q
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable



On 03/12/2018 12:08 PM, Dmitry Torokhov wrote:
> Replace the original license statement with the SPDX identifier.
> Add also one line of description as recommended by the COPYING file.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to my working branch for atmel_mxt_ts + chromeos_laptop.c for
v4.17. Thanks!

> ---
>  drivers/platform/chrome/chromeos_laptop.c | 27 +++++------------------=

>  1 file changed, 5 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platfo=
rm/chrome/chromeos_laptop.c
> index d8599736a41a2..54a13c70e1d8f 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -1,25 +1,8 @@
> -/*
> - *  chromeos_laptop.c - Driver to instantiate Chromebook i2c/smbus dev=
ices.
> - *
> - *  Author : Benson Leung <bleung@chromium.org>
> - *
> - *  Copyright (C) 2012 Google, Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modi=
fy
> - *  it under the terms of the GNU General Public License as published =
by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-13=
07  USA
> - *
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Driver to instantiate Chromebook i2c/smbus devices.
> +//
> +// Copyright (C) 2012 Google, Inc.
> +// Author: Benson Leung <bleung@chromium.org>
> =20
>  #include <linux/dmi.h>
>  #include <linux/i2c.h>
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org


--a5InQserBIsiHabvug6Z9Ofz1UDUvqG8q--

--CDD0W7KMiVtBHwigNwtyxHBdQsn2gPdgm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqwaacACgkQHwn1ewov
5ljamw//Z5Mh4PfidpISHfcFw9wI9fSa/x0gIBtXJHMgoY+PoPLhE6ENaZHE/gLg
wG5b8pTj6rg7xf9/VyWdyQGx8iPZiO/ky8+tE0/wUvKcYVK42ESeOhXDEJNNKWUK
JlgxcwMazRg4PdaxybJEGFOQAEBKv0LnzOYeOw8KO7ves2+bY+qT/Z0Mk1scZiPV
3u+X9Htk3ufQ4bONvlJZDqiC0tOR2W4C6mJ5KF3PHU3teIZkGpW/YbrV/4n9EwU1
9aOHJg7/GonD6TInoXpQBLyP/3Z2PiLcRKg/i+uoLd5ih33/4gxuaINtuIYje1xI
Tc0D/XMdtC1MX32ame1fa7qqNUhOEBrfAwIC6Q27i+eijbu+Ou5sU6CqKJdjN6cd
KXr5im3Vjy/Q4NXsS3avtWP5srNm7BVF5JDOuHK6mKNjD5Kz8vpTt/Grj1tC+vII
zFsOtcugifKG04lqIzxGOV6kjtFmvLJZX5ctR6p8ERU6/ekXbTr+5r70MHWCQXAg
gkZmPjMj34+roECqfDjmXZ2avw3TKwxzE7MpuSEjihNcI354GfTWy3Q4HagFEd65
lohnYXw0b23VtbCuli1samZuW0siEwPUqK8vppZWGghDQeuZfOsgHbPsHDp+6uhA
6XOZ1yySNMgaJyT5W+w71H/LP0DnNe3GRprk2N04Xhi65YpIee4=
=sMNK
-----END PGP SIGNATURE-----

--CDD0W7KMiVtBHwigNwtyxHBdQsn2gPdgm--
