From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] mx31moboard: Add MC13783 power button support
Date: Thu, 3 Jun 2010 10:31:55 +0200
Message-ID: <20100603083155.GW26820@pengutronix.de>
References: <1275334140-29339-1-git-send-email-philippe.retornaz@epfl.ch> <1275334140-29339-2-git-send-email-philippe.retornaz@epfl.ch> <1275334140-29339-3-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43581 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab0FCIcE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jun 2010 04:32:04 -0400
Content-Disposition: inline
In-Reply-To: <1275334140-29339-3-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe =?iso-8859-15?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, ext-jari.vanhala@nokia.com, valentin.longchamp@epfl.ch

Hi Philippe,

Please ping me once the LED/Power button support is merged. I'll take
care of the platform patches.

Sascha

On Mon, May 31, 2010 at 09:29:00PM +0200, Philippe R=E9tornaz wrote:
> Add the power-on button on mx31moboard using MC13783 PMIC.
>=20
> Signed-off-by: Philippe R=E9tornaz <philippe.retornaz@epfl.ch>
> ---
>  arch/arm/mach-mx3/mach-mx31moboard.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3=
/mach-mx31moboard.c
> index 62b5e40..7a8f078 100644
> --- a/arch/arm/mach-mx3/mach-mx31moboard.c
> +++ b/arch/arm/mach-mx3/mach-mx31moboard.c
> @@ -31,6 +31,7 @@
>  #include <linux/mfd/mc13783.h>
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
> +#include <linux/input.h>
> =20
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ulpi.h>
> @@ -262,12 +263,19 @@ static struct mc13783_leds_platform_data moboar=
d_leds =3D {
>  	.tc2_period =3D MC13783_LED_PERIOD_10MS,
>  };
> =20
> +static struct mc13783_buttons_platform_data moboard_buttons =3D {
> +	.b1on_flags =3D MC13783_BUTTON_DBNC_750MS | MC13783_BUTTON_ENABLE |
> +			MC13783_BUTTON_POL_INVERT | MC13783_BUTTON_EMUL_CAD,
> +	.b1on_key =3D KEY_POWER,
> +};
> +
>  static struct mc13783_platform_data moboard_pmic =3D {
>  	.regulators =3D moboard_regulators,
>  	.num_regulators =3D ARRAY_SIZE(moboard_regulators),
>  	.leds =3D &moboard_leds,
> +	.buttons =3D &moboard_buttons,
>  	.flags =3D MC13783_USE_REGULATOR | MC13783_USE_RTC |
> -		MC13783_USE_ADC | MC13783_USE_LED,
> +		MC13783_USE_ADC | MC13783_USE_LED | MC13783_USE_BUTTON,
>  };
> =20
>  static struct spi_board_info moboard_spi_board_info[] __initdata =3D=
 {
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
