From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 01/17] ARM: sunxi: Register cpufreq-dt for sun[45678]i
Date: Wed, 7 Jan 2015 11:23:19 +0100
Message-ID: <20150107102319.GH7853@lukather>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2ctSxJPqE6GQjdSc"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420511727-8242-2-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--2ctSxJPqE6GQjdSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:11AM +0800, Chen-Yu Tsai wrote:
> On sun[45678]i, we have one cluster of identical cores sharing a
> clock, which is ideal for using cpufreq-dt. Register a platform
> device for cpufreq-dt.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--2ctSxJPqE6GQjdSc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrQkXAAoJEBx+YmzsjxAgiXEP/RVnuo/EamHWVEQb97QErYZh
3PL8lon+nUg5ZTl2XaH2fJ2hmtmPgeKA+7YaGQCa2Qf+A8D0HEnD44EKIrGCsiin
sPug2udPI1cvR+guCvL/goznyG+w/j1++iq0OFM7Gbp/d7KOcaGLwbEGsB4osd0j
Htbw4clCcP50RV3KYirDc4Y2i8jIShEwTSb8qnYir8g54Okzsm8i16OUdB8Du4mG
z+4m71KHoxVCLxxw/hg/1DCKQHOOKB/5hnQCrFzhvxx/HQ1LcbslpdmQ5/bTg3E/
jFzWINPL7/kXSXwVuoKmdzQVyE2bH7Ywxb+D32/zRgQoaoUE6yfzIryx04Lv0jsD
U7eNvPEmmGBAlGUEwLxueedT9OondGMoqHl3tR6ZQ+71nf1YbYxuSqKlr2oyULaM
g72xAnalZptFXIiltAbTBJNOP1IFj6vv4MoQTpld1cshgxaUTR4Vg8uinH4Z/4nc
g6X4LH2/4C7bDj+aWEV1cZFdp4zoKJWvLOeMHzfMpCkl8CmrhMQJYdgYn5BLJo2u
MVp0vw/Yor98O8lKZxy+KPD8PN9WDRuZBnPxDPL/K7iS5YkNwYhbDt0nHUgws6H0
yBkQdASQjE5uePWiUd4gSBPO9VhH7Q2s7NQDIy66bzmnASOF7D6if9CK7NO3/MNd
LWSN87SbwE2sGajKiipn
=pl9a
-----END PGP SIGNATURE-----

--2ctSxJPqE6GQjdSc--
