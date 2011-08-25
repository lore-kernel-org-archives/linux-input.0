From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 6/6] mx31moboard: Add MC13783 power button support
Date: Thu, 25 Aug 2011 11:50:12 +0200
Message-ID: <20110825095012.GR31404@pengutronix.de>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-2-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-3-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-4-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-5-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-6-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-7-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54335 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab1HYJuP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Aug 2011 05:50:15 -0400
Content-Disposition: inline
In-Reply-To: <1311344232-29902-7-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe =?iso-8859-15?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, gaowanlong@cn.fujitsu.com, shawn.guo@freescale.com

On Fri, Jul 22, 2011 at 04:17:12PM +0200, Philippe R=E9tornaz wrote:
> Add the power-on button on mx31moboard using MC13783 PMIC.
>=20
> Signed-off-by: Philippe R=E9tornaz <philippe.retornaz@epfl.ch>

Please ping once the rest is merged.

Sascha

> ---
>  arch/arm/mach-imx/mach-mx31moboard.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx=
/mach-mx31moboard.c
> index 579ca1f..2a43492 100644
> --- a/arch/arm/mach-imx/mach-mx31moboard.c
> +++ b/arch/arm/mach-imx/mach-mx31moboard.c
> @@ -28,6 +28,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
>  #include <linux/memblock.h>
> +#include <linux/input.h>
> =20
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ulpi.h>
> @@ -264,12 +265,19 @@ static struct mc13783_leds_platform_data moboar=
d_leds =3D {
>  	.tc2_period =3D MC13783_LED_PERIOD_10MS,
>  };
> =20
> +static struct mc13783_buttons_platform_data moboard_buttons =3D {
> +	.b1on_flags =3D MC13783_BUTTON_DBNC_750MS | MC13783_BUTTON_ENABLE |
> +			MC13783_BUTTON_POL_INVERT,
> +	.b1on_key =3D KEY_POWER,
> +};
> +
>  static struct mc13xxx_platform_data moboard_pmic =3D {
>  	.regulators =3D {
>  		.regulators =3D moboard_regulators,
>  		.num_regulators =3D ARRAY_SIZE(moboard_regulators),
>  	},
>  	.leds =3D &moboard_leds,
> +	.buttons =3D &moboard_buttons,
>  	.flags =3D MC13XXX_USE_RTC | MC13XXX_USE_ADC,
>  };
> =20
> --=20
> 1.6.3.3
>=20
>=20

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
