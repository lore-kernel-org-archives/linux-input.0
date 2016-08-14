From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 1/2] i2c: cros-ec-tunnel: Fix usage of
 cros_ec_cmd_xfer()
Date: Mon, 15 Aug 2016 00:24:08 +0200
Message-ID: <20160814222408.GE10501@katana>
References: <1470861439-129201-1-git-send-email-briannorris@chromium.org>
 <1470861439-129201-2-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470861439-129201-2-git-send-email-briannorris@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "# 9798ac6d32c1 mfd : cros_ec : Add cros_ec_cmd_xfer_status helper" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2016 at 01:37:18PM -0700, Brian Norris wrote:
> cros_ec_cmd_xfer returns success status if the command transport
> completes successfully, but the execution result is incorrectly ignored.
> In many cases, the execution result is assumed to be successful, leading
> to ignored errors and operating on uninitialized data.
>=20
> We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid t=
hese
> problems. Let's use it.
>=20
> [Regarding the 'Fixes' tag; there is significant refactoring since the dr=
iver's
> introduction, but the underlying logical error exists throughout I believ=
e]
>=20
> Fixes: 9d230c9e4f4e ("i2c: ChromeOS EC tunnel driver")
> Cc: <stable@vger.kernel.org> # 9798ac6d32c1 mfd: cros_ec: Add cros_ec_cmd=
_xfer_status() helper
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-current, thanks!


--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXsO+HAAoJEBQN5MwUoCm2H7YP/R26ooFIx47DxmKCPhPWKzwh
SeUcoMn+BFpEqXdprAdL1Zz9j8GcKfAWTs+Vz+OqWRCWtTBZZXBDwPCim0udRalT
Hikg1ZzaljyUCYhlHb0KAljoRVrtBZ7DWAPzMcf85RYQtE5E9CjtFAKoezA5fkNE
EgtJoBbe2tE58X8F8RtfG9oGJKsAMBQDKnXBJVCIr9qyOuVLQiYeurO0vvt1CxUQ
0XCdi1us3TmocLiTpbUAd5xBmEAISPeJ/GeibeYoFCIc++VF6uoycMHzsBJbOVSC
/vheVOYeHpiCok0dGkv2oBjYyxkzzR7oJg7ZXXzC9lr3i25WAP/tqFoBdoYkE9hX
HsacHvQ0h2QXUy2NaBtsvLZm32QAhoz/QLcHLiKBE7wHH7FSmTaHSfvhX1GhlMxi
yDHh6QXieidr2ves38GhOi5OKRAU7z7I7IeIEBwVWxckMo06OctCzrd1w+V18uSP
4Cq38gFf3ncSjSpRqtbBFNfJZMf98P7MTGbPNIKmLDu5h+VW9OHLn2AMgRkjGQ5c
sVk+3h36Du2HMGKNqn3rrKFjaW2IhDGxk1UGayHsrJWRP7C/QzLFJRWpHio9yfyW
RH7pIVq/69+MiBG21XBgK68vRP3QzZvi6fo2uDiyR0UHwp8pQqRT77eB0a7fQBxf
rLE7pyMuXz5WvkZKTnWp
=FLB3
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
