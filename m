From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 05/17] ARM: dts: sunxi: Enable thermal sensor support for
 RTP on sun[457]i
Date: Tue, 6 Jan 2015 16:52:58 +0100
Message-ID: <20150106155258.GQ7853@lukather>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-6-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aX6oBa4COn3eIhlv"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420511727-8242-6-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--aX6oBa4COn3eIhlv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:15AM +0800, Chen-Yu Tsai wrote:
> Now that the resistive touchpanel driver supports thermal sensors,
> add the "#thermal-sensor-cells" property as required by the thermal
> framework.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--aX6oBa4COn3eIhlv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrATaAAoJEBx+YmzsjxAgs90P/3Qxg/scVgYEEgV2xxA5kM7O
Nv0Z6GUqBOjfvF2MnUHiU1MG5huz/x1Qqn96Yr9f1hLy9dXlPGaCd+bKFdJ/F8D0
Zyc7MvqS340y9UhTNDbA3tnbAXfOX9+Hni+U00uZnzdvZ6qWp5vOrx9NC3A8pPEd
WHkTkkE/xVaf7VrM/7xEvXIc//9sIWYyH0raXxw8hPsDdDJ9/wNRCad11D/ZTY1s
iZ/iBVrauDQtyO0Dg/SUuP7KR+dyQS+oUG/6dLGd/VzDVX5/ZPmlVU+X3CTtHvrw
i2+Ns767Y2P2xLczNjm+rmzckIQEqxFOe0C3Pd2f1ndmP3muuDDMwupAEZ9nuk0y
BamHMF3+0zSFmn/5y8yHyKJifaqgTL8NNU/Ua4tXYeHi7HyKyiRZ1iy/4/nqgybc
eiGdIYCPc4s10glxg0HOKlAEn5h31m0C5H2lvUBpaVuRm8DDGQx0devGY2xRt0/y
63nwOL4xLVqrglray0Pkrlr18rvPgKGCaZsDUUp46wFYhO+CjQ+PCIuzoSi1tfm+
Hml5F7ec8yJn1qF0ux2kE4CNRDs6i00GBdiSbqurFTZUnjtHb8olYtTZDEVvtGFG
LUv2OEheRWo9Ax+UfY60iy4cuTDwvzui5/E+kV8ddGg/Qp7CybXoLQn+CyU8opQw
6SZdktUbyHuZbURZm19f
=mRWd
-----END PGP SIGNATURE-----

--aX6oBa4COn3eIhlv--
