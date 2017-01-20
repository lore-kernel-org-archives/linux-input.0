From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 6/7] Input: pwm-beeper - add optional amplifier
 regulator
Date: Fri, 20 Jan 2017 11:19:16 +0100
Message-ID: <20170120101916.GF3824@ulmo.ba.sec>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
 <20170119224057.9995-6-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33462 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbdATKTV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 05:19:21 -0500
Content-Disposition: inline
In-Reply-To: <20170119224057.9995-6-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, David Lechner <david@lechnology.com>, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 02:40:56PM -0800, Dmitry Torokhov wrote:
[...]
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-bee=
per.c
> index 9964c46468d3..7b213e0ab06c 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -14,6 +14,7 @@
>   */
> =20
>  #include <linux/input.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> @@ -25,30 +26,59 @@
>  struct pwm_beeper {
>  	struct input_dev *input;
>  	struct pwm_device *pwm;
> +	struct regulator *amplifier;
>  	struct work_struct work;
>  	unsigned long period;
>  	bool suspended;
> +	bool amplifier_on;

Why do you need to track this? I thought regulator_enable() and
regulator_disable() were already reference counted?

Thierry

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB5CQACgkQ3SOs138+
s6HGuBAAju0w3qIr3QdO1QeK7EWy1Cupcmk/uedZUczmbYF/tlwGwMZnjojGOn80
J4M126+FsJD/WXJyMm0IrlaWOg3zqYHAqPT9GzW4SUxNiNUaLRKx6DdwXLgRmrvH
2cCTfwm+T4Tj+jroUEV6T/0ayNCNBsRY5v4tJAxP1tuvG9n9ASe07k6cm5Ahg/2d
SXkxbm9l5v/E1uyXHfcDsgMtjp0iNX1SHaHUMjeI/3oqoXHzqH1pp3UdKsP4Xyy5
NnmL02h/Jx/tp/L61YhoZrpnWnO3VpK9q8jkfQqF/IBapdkh0FHu76Xk994ynofl
p8ukgyijoxeFlcp2K2CTpUY58RXPnx/82h5W2RRUzdlTl5uCsHe3iCK5pTRolH9+
R0RQi17I2HsXcmIwFt5zcLhM2AHuV49g+40A60lsz1bO55cgWm/UlaRyLaDu8pUl
56rrYfoc6gKxqLIcbG+P9o62TsUQqov6htMBWTz451zV9ct14qG5qgsovREb+woD
RAgKmOvRJ4zY7r49GEmHcI/QBXs998qmbMx8unu7WZLWnpiCDHmN7KpT6qjKKfa6
z3HwMtL4EQEDh8jD5Oh6OpIG+SF12MTJDrj5thtedrFLX7qDjlppJA03eGIuRKZZ
csYDtXdtJbqJBu3gaEoiJIDUKRUL1+K54kmtfr9ej6aW87mgBX8=
=gqjw
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
