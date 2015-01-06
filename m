From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 16/17] ARM: sunxi_defconfig: Enable TOUCHSCREEN_SUN4I,
 CPUFREQ_DT, CPU_THERMAL
Date: Tue, 6 Jan 2015 17:13:15 +0100
Message-ID: <20150106161315.GX7853@lukather>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-17-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ggEtdcIX3XIOBw6T"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45491 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753889AbbAFQPX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 11:15:23 -0500
Content-Disposition: inline
In-Reply-To: <1420511727-8242-17-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--ggEtdcIX3XIOBw6T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:26AM +0800, Chen-Yu Tsai wrote:
> This patch enables TOUCHSCREEN_SUN4I, CPUFREQ_DT, and CPU_THERMAL to
> enable cpufreq support with passive cpu cooling (thermal throttling)
> by default.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ggEtdcIX3XIOBw6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrAmbAAoJEBx+YmzsjxAgGeQP/2j9LHph7zf3yak+QD9/flUM
IOuYZWn71DhZ89sp/Ooai31v0QG4kFQc8U/6cf+aGqmxVRpDoqFPk31UK3nvAHJ3
QPNLUCLO9Ww3mfFCf1ZMuLB2xprG8HCha1Qr2rmuT+ttycfKh6ZGyGjdHVRCE5qW
4C0r2/cpIJ1HORPazlReHBaP7HFF2KWeAX5eE/ocLKICbLoRlA/P8ffaPc04uA8t
lLVM91xV34djOBtnwEA0/uHUuGqAMBdOqtPfv65D/RsyFHGvGkaGFHKs3UP3e5+X
vfmoAYFcjXaxgt7WVIYMOHQep/NbBAill73Q+PzhcyhZ+wWbqgegKM/QL4xT9lPP
rA7pLs9mB4//IHmvPk3B/7/iGT0y/1lD6KoWk0YQehFiHOz9NFmVtBovj4Hs6VjU
CnRpRcDtUI6+MS5dmVDi6ZsZ5hWPNcGLgQ+kKxXN8i7S2CuCOvamUuzTutzmTOnX
Jr7h8T4hg0qzzrPF+NJkNsLqvYnL9LY3++qp9YbYtvqXQpQ/MPHtmbcXubCwEK0f
bE/iRSYGcnokw15dQ/oLwcWuIyHR+WpSZpssZJ2tGBVPiPAizgjd+oy0PsoBnMFt
pZocO1VUJRn4rvAtCPy3JjTA/lPdLVYDI7Htl+rK7nAjWg2Cj/kK2Udv2cE/uJkF
t2rzUxM4LOgx+iYO1q+q
=HAdu
-----END PGP SIGNATURE-----

--ggEtdcIX3XIOBw6T--
