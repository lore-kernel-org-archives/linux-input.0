From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] input: mc13783: Make mc13xxx_buttons_platform_data
 more flexible
Date: Mon, 10 Feb 2014 11:29:17 +0000
Message-ID: <20140210112917.GD21522@lee--X1>
References: <1392006129-10227-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:47583 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbaBJL3X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Feb 2014 06:29:23 -0500
Received: by mail-we0-f180.google.com with SMTP id u57so4046984wes.25
        for <linux-input@vger.kernel.org>; Mon, 10 Feb 2014 03:29:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392006129-10227-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>

> Instead of define each button in separate variable, make an array
> for storing all buttons. This change will help to add support for
> other types of PMIC and add support for probing with devicetree
> in the future.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/mach-mx31moboard.c   |  9 ++++--
>  drivers/input/misc/mc13783-pwrbutton.c | 56 +++++++++++++++++-------=
----------
>  include/linux/mfd/mc13xxx.h            | 28 +++++++++--------

Are all the changes in these files entangled? If there is any way to
make them orthogonal, then all the better.

<snip>

> --- a/include/linux/mfd/mc13xxx.h
> +++ b/include/linux/mfd/mc13xxx.h
> @@ -172,20 +172,22 @@ struct mc13xxx_leds_platform_data {
>  	u32 led_control[MAX_LED_CONTROL_REGS];
>  };
> =20
> +#define MAX13XXX_NUM_BUTTONS	3
> +
> +struct mc13xxx_button {
> +	u16		keycode;
> +	unsigned int	flags;
> +#define MC13XXX_BUTTON_DBNC_0MS		0
> +#define MC13XXX_BUTTON_DBNC_30MS	1
> +#define MC13XXX_BUTTON_DBNC_150MS	2
> +#define MC13XXX_BUTTON_DBNC_750MS	3
> +#define MC13XXX_BUTTON_ENABLE		(1 << 2)
> +#define MC13XXX_BUTTON_POL_INVERT	(1 << 3)
> +#define MC13XXX_BUTTON_RESET_EN		(1 << 4)
> +};
> +

Please take the opportunity to remove this slab list of #defines from
the centre of the struct definition. Just above will be fine.

>  struct mc13xxx_buttons_platform_data {
> -#define MC13783_BUTTON_DBNC_0MS		0
> -#define MC13783_BUTTON_DBNC_30MS	1
> -#define MC13783_BUTTON_DBNC_150MS	2
> -#define MC13783_BUTTON_DBNC_750MS	3
> -#define MC13783_BUTTON_ENABLE		(1 << 2)
> -#define MC13783_BUTTON_POL_INVERT	(1 << 3)
> -#define MC13783_BUTTON_RESET_EN		(1 << 4)
> -	int b1on_flags;
> -	unsigned short b1on_key;
> -	int b2on_flags;
> -	unsigned short b2on_key;
> -	int b3on_flags;
> -	unsigned short b3on_key;
> +	struct mc13xxx_button	buttons[MAX13XXX_NUM_BUTTONS];
>  };
> =20
>  struct mc13xxx_ts_platform_data {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
