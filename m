From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v7 3/5] power: max77843_battery: Add Max77843 fuel gauge
 device driver
Date: Sat, 7 Mar 2015 21:14:26 +0100
Message-ID: <20150307201426.GG5233@earth>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-4-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56613 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbbCGUOl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 7 Mar 2015 15:14:41 -0500
Content-Disposition: inline
In-Reply-To: <1425291038-18269-4-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 02, 2015 at 07:10:36PM +0900, Jaewon Kim wrote:
> From: Beomho Seo <beomho.seo@samsung.com>
>=20
> This patch adds device driver of max77843 fuel gauge.
> The driver support for battery fuel gauge in Maxim Max77843.
> It is fuel-gauge systems for lithuum-ion batteries in handled and
> portable devices.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>

Reviewed-By: Sebastian Reichel <sre@kernel.org>

I can't take it as is, since it depends on the private header file
of PATCH 1.

-- Sebastian

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+1wiAAoJENju1/PIO/qag90P/jrQp+3wSY+B/QzYHaacCvVB
CBf5m2/ZCi93bGK4KdfgeK/8w+9de+/3REo4PSTVhLfC4IEz6oP7vYmOBQD8RwtC
rvdbmZi3PsBMuKKgXx1KoQpgl03zEKnowfDBdHB95rX7mf1YZvbYl8EhrwuZzQfR
m7jDzF+NRspXhoPjOdBwUB3u8d0hnqk7gjdBoBxkVE1joaSFxzGqOUURLfFquDh0
5exQGEGdiNArHdp6LJAMkYYSRlFBVvMudtOoLg7TEhqYUJcRHo+QP6U7WQIIrW8k
1dZ4TXS5eOO6diToSeGOwdo/wnukWt7lzdAMu5MMVGJy/aWA3ai+QDux/spS50ZA
ynLs7rJ4jY6mo/2N+WmBjgNa69hD8X3PWmybhDAm3BCErChD+TgkCcppdUFWnKF6
WbjuXTlRhdYQwipIvBnq5SS+M46P7EFiuqtfzo3+DARyhHEsNydDlRTbM5pf5rLw
78VhiAPccgnE7NggmDn5pz3JjjkcsvJn0rFTmQBpWW4recx3+yPmjH1EBNWQ9phs
+BsOFpJ4bg448EwmjgHG1Ctg9AASsb3XHUxGipkS7H2tigQDPxSB/PdZLGKnlIxN
zAaqZj0jzHLpG02f+I7sLFw565Q1bstEsuUkd8U3oCfqHzVB2zyHJanB9CYmW1Ff
8ex/gGg6wO8DwBX7juDz
=19Tc
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
