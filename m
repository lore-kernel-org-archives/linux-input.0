From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v7 2/5] power: max77843_charger: Add Max77843 charger
 device driver
Date: Sat, 7 Mar 2015 21:13:40 +0100
Message-ID: <20150307201340.GF5233@earth>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-3-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56545 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbbCGUNz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 7 Mar 2015 15:13:55 -0500
Content-Disposition: inline
In-Reply-To: <1425291038-18269-3-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2015 at 07:10:35PM +0900, Jaewon Kim wrote:
> From: Beomho Seo <beomho.seo@samsung.com>
>=20
> This patch adds device driver of max77843 charger. This driver provide
> initialize each charging mode(e.g. fast charge, top-off mode and constant
> charging mode so on.). Additionally, control charging paramters to use
> i2c interface.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>

Reviewed-By: Sebastian Reichel <sre@kernel.org>

I can't take it as is, since it depends on the private header file
of PATCHv1.

-- Sebastian

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+1vxAAoJENju1/PIO/qaR+sQAKOezF73YNi6TdbcO5ttMyb6
gJ/hjTImgs6uaa7yk5XzFZilSNEZOJPW7A8Vh7uY55H7YnNezPXkzFxRvXg625ao
W82l9S3B89skzff6+LwKe05ftxg33UWl1FZ9cwRkxTpAwZveBN42weUI9HORGezz
qrUFzTD7Nrw4pBWK9F73tydVTdKjuydLgsNeKicrbjPyem/NtLwDqX3IbZDgLMx5
It1A/N/UKvpnVQzjR1CWY9VtTgDC3FDS7U/YFPT5y/n+5e03U+GT9Tg05GKFDm/E
2CCCc+eGal4C4naSm6fpWtADW8PqqFDIfEVm34KKsAHZxIw+896jl3jimv9SEAPb
GnLmFP1ST/jlio6R/LXnBwcw4LW0gMDpiWHQpYC5S1rhjYSc3fEuqkcwTURjwi/3
ZNuy9A7VWyJQUu30KS8uk9DZSBHYnf92f6U/tqy8HSQrxRe1szSPnytoVg3ss3J9
k1ryfbu5dnnc1Rn/Tpi5nA3+6KgKFNwZAOas6TdfSuGH37Yg0y5YdF7Az0zVvYig
qpztELxY07tjmhabt8kpYtL1XSSbZrolSlKazWXZ+LJu4kU2f6laGOFg0cIQaKj4
/9ogHUuGy1c0tTGdDL/V956TW7qZYfEgnwYJbe8MVlip9uU7PsaBsWwMQD5D7274
Ez6Y1AatrUQaO/+dEAa5
=rrc5
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
