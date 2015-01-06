From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 17/17] ARM: multi_v7_defconfig: Enable TOUCHSCREEN_SUN4I,
 CPU_THERMAL
Date: Tue, 6 Jan 2015 11:31:14 -0400
Message-ID: <20150106153111.GF6276@developer>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-18-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:63545 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360AbbAFPcL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 10:32:11 -0500
Content-Disposition: inline
In-Reply-To: <1420511727-8242-18-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:27AM +0800, Chen-Yu Tsai wrote:
> This patch enables TOUCHSCREEN_SUN4I and CPU_THERMAL to enable cpufreq
> support with passive cpu cooling (thermal throttling) on sunxi by default.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

for the CPU_THERMAL

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi=
_v7_defconfig
> index 2328fe752e9c..0e7159ad269b 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -189,6 +189,7 @@ CONFIG_MOUSE_PS2_ELANTECH=3Dy
>  CONFIG_INPUT_TOUCHSCREEN=3Dy
>  CONFIG_TOUCHSCREEN_ATMEL_MXT=3Dy
>  CONFIG_TOUCHSCREEN_STMPE=3Dy
> +CONFIG_TOUCHSCREEN_SUN4I=3Dy
>  CONFIG_INPUT_MISC=3Dy
>  CONFIG_INPUT_MPU3050=3Dy
>  CONFIG_SERIO_AMBAKMI=3Dy
> @@ -267,6 +268,7 @@ CONFIG_POWER_RESET_SUN6I=3Dy
>  CONFIG_SENSORS_LM90=3Dy
>  CONFIG_SENSORS_LM95245=3Dy
>  CONFIG_THERMAL=3Dy
> +CONFIG_CPU_THERMAL=3Dy
>  CONFIG_ARMADA_THERMAL=3Dy
>  CONFIG_ST_THERMAL_SYSCFG=3Dy
>  CONFIG_ST_THERMAL_MEMMAP=3Dy
> --=20
> 2.1.4
>=20

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUq/+3AAoJEMLUO4d9pOJWj8UH/3zKrtxyu0XntPvx4HeYUdCY
vhmreGiUF8V8DKMFFbfL4+kb7jX/+4Je/luGZ5Jp/MfqDpPeOAQS8dDNiHojdYz4
QEANZQHKYe2+LltpBG2sW52Es0EUJCckxCM8JNkJ83u1kfNcxBIriCj5og8lu+l5
x00NynBRMpkRCzybH4du/bEnp4hs0s/YcfXIO8hW80Dh8IM1B0qvi/+Kotvolc8g
MSE6d+xQWc5NOsFEDc+yq+0TCGMbLqz+OVqicWfYnq5v9Ivn4g0/eSHiw+Tlrog+
V92O6L9ZQFii4a7keWSVYgz9tQMO8OF6dyWg0NsI2afiX32rN8B/cv2vaXzKlgs=
=vqw7
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
