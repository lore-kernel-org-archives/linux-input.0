From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 16/17] ARM: sunxi_defconfig: Enable TOUCHSCREEN_SUN4I,
 CPUFREQ_DT, CPU_THERMAL
Date: Tue, 6 Jan 2015 11:32:29 -0400
Message-ID: <20150106153227.GG6276@developer>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-17-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54416 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525AbbAFPd0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 10:33:26 -0500
Content-Disposition: inline
In-Reply-To: <1420511727-8242-17-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:26AM +0800, Chen-Yu Tsai wrote:
> This patch enables TOUCHSCREEN_SUN4I, CPUFREQ_DT, and CPU_THERMAL to
> enable cpufreq support with passive cpu cooling (thermal throttling)
> by default.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

For the thermal part:

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm/configs/sunxi_defconfig | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_de=
fconfig
> index 7a342d2780a8..46a8688bd49a 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -9,6 +9,8 @@ CONFIG_HIGHMEM=3Dy
>  CONFIG_HIGHPTE=3Dy
>  CONFIG_ARM_APPENDED_DTB=3Dy
>  CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
> +CONFIG_CPU_FREQ=3Dy
> +CONFIG_CPUFREQ_DT=3Dy
>  CONFIG_VFP=3Dy
>  CONFIG_NEON=3Dy
>  CONFIG_PM=3Dy
> @@ -54,6 +56,8 @@ CONFIG_STMMAC_ETH=3Dy
>  # CONFIG_INPUT_MOUSEDEV is not set
>  # CONFIG_INPUT_KEYBOARD is not set
>  # CONFIG_INPUT_MOUSE is not set
> +CONFIG_INPUT_TOUCHSCREEN=3Dy
> +CONFIG_TOUCHSCREEN_SUN4I=3Dy
>  CONFIG_SERIAL_8250=3Dy
>  CONFIG_SERIAL_8250_CONSOLE=3Dy
>  CONFIG_SERIAL_8250_NR_UARTS=3D8
> @@ -71,7 +75,8 @@ CONFIG_GPIO_SYSFS=3Dy
>  CONFIG_POWER_SUPPLY=3Dy
>  CONFIG_POWER_RESET=3Dy
>  CONFIG_POWER_RESET_SUN6I=3Dy
> -# CONFIG_HWMON is not set
> +CONFIG_THERMAL=3Dy
> +CONFIG_CPU_THERMAL=3Dy
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_SUNXI_WATCHDOG=3Dy
>  CONFIG_MFD_AXP20X=3Dy
> --=20
> 2.1.4
>=20

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrAADAAoJEMLUO4d9pOJWxFcH/2LRpq19p9MDCOFm5/xliAuW
hQPmR1toYIPRnHlo9XTluF8yOwIAbBPkEJ4pEVfG3iszamE2qk5uFXz3HG4A87jL
fz+Dvb8zMjQKSl70Lkq6mLEl9QGZwX5wCk3TRrH6od/TXiGYUcoiJSWI+xrhzCGJ
hh/3i47g4BprrpqZfzjIZ2+F4SMSM+A8/qSXi29JJ7NR64NyxPqLnQ/q7ouB26fg
KPI9gbD4spWVzuo/+2+1Wnw7LJMULyXd22WUTwvBdro92bUDrkgmT8ioe/NkVbeD
/hvwsJmDjlO4khmLdffeRxNsIDwghSeaBXBsksKS0tcCmKiqJA3LnEJWDsYKcl4=
=U/zn
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--
