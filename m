From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 17/17] ARM: multi_v7_defconfig: Enable TOUCHSCREEN_SUN4I,
 CPU_THERMAL
Date: Tue, 6 Jan 2015 17:12:57 +0100
Message-ID: <20150106161257.GW7853@lukather>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-18-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FmwJltL8yKUx7YXQ"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45486 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752019AbbAFQPX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 11:15:23 -0500
Content-Disposition: inline
In-Reply-To: <1420511727-8242-18-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--FmwJltL8yKUx7YXQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:27AM +0800, Chen-Yu Tsai wrote:
> This patch enables TOUCHSCREEN_SUN4I and CPU_THERMAL to enable cpufreq
> support with passive cpu cooling (thermal throttling) on sunxi by default.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--FmwJltL8yKUx7YXQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrAmJAAoJEBx+YmzsjxAgg/gP/jf5gVM4sxtWCydemrfSoMwg
1GBviQE/zcudOJb5Icl3AmUDdjyHl8sPx06AYHx/NbCv0bXjnQ8hFbCkKYqDrF4y
CBcZvGhr92j9ywzio0ervmpYS/1CJISLzCIEKsymMM6Cb22nniAfEtLY5uEnqKqR
ZP9qRxrcvAds2E7JIJyyQlZvE6M3e/32gQasZmMw5r5grpsUfO5AEz1JjZd52QMH
kkEb07QyE+M4GKqlMGAzXKvcVqKwabEvJxuL6y10HDyI7wp1GQERbNXlOrSVmr1I
huW4Afv0JDU1H52H82P9dU5jaApPs5UpDnYZZSVNUzB/wsnRbI3q8SLO1aPEDM37
ufl0N9A+TmSEUI64I1fXFyc2uQ2HcfWqXbVbuHdncMyLCVrtUVtwCi3EGf4p0uVE
/Ex87NfPrKdDtafkzhs2Zls2gASnlD0f1zq0wvATc0EGQPDbTfWB1Z31rXP3Mxt/
+43HyqA/sjZZ2dmHgVDjMYhO0Fse9BUJgpObhF8/Boo+Mb1Mf0zfuBlzOk1iPL7Q
0oFLomzG/Sy6nhvCqOq0JCWpeKLrPP1Eqg1sJdMsxNEEN5UMFFDen6tEPxcKmmBG
gvY/fE4L9yEvA4LDxfA8VenP/UYL0JV/y9xNtptUR4uH3EPUKeYOuyH3XWK8jlkh
AAHF5y5OyLOzu+V5lUST
=Wrk8
-----END PGP SIGNATURE-----

--FmwJltL8yKUx7YXQ--
