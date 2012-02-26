From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH v6 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
Date: Sun, 26 Feb 2012 12:03:27 +0100
Message-ID: <CA+gwMcd03tgoSYUTiLNCKHWNS5ZY+UceSHBAKHyKGJMwVQupig@mail.gmail.com>
References: <1325817448.50788.YahooMailClassic@web29004.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43097 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab2BZLD1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Feb 2012 06:03:27 -0500
Received: by iazz13 with SMTP id z13so2047273iaz.19
        for <linux-input@vger.kernel.org>; Sun, 26 Feb 2012 03:03:27 -0800 (PST)
In-Reply-To: <1325817448.50788.YahooMailClassic@web29004.mail.ird.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, eric.y.miao@gmail.com, mad_soft@inbox.ru, koen@dominion.thruhere.net, dmitry.torokhov@gmail.com

On Fri, Jan 6, 2012 at 3:37 AM, Paul Parsons <lost.distance@yahoo.com> =
wrote:
> Add support for the Synaptics NavPoint touchpad connected to a PXA27x=
 SSP port
> in SPI slave mode. The driver implements a simple navigation pad. The=
 four
> raised dots are mapped to UP/DOWN/LEFT/RIGHT buttons and the centre o=
f the
> touchpad is mapped to the ENTER button.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
>
> V6:
> Rebased to linux-3.2.
>
> diff -uprN clean-3.2/arch/arm/mach-pxa/hx4700.c linux-3.2/arch/arm/ma=
ch-pxa/hx4700.c
> --- clean-3.2/arch/arm/mach-pxa/hx4700.c =A0 =A0 =A0 =A02012-01-04 23=
:55:44.000000000 +0000
> +++ linux-3.2/arch/arm/mach-pxa/hx4700.c =A0 =A0 =A0 =A02012-01-06 02=
:25:35.580520397 +0000
> @@ -22,6 +22,7 @@
> =A0#include <linux/gpio.h>
> =A0#include <linux/gpio_keys.h>
> =A0#include <linux/input.h>
> +#include <linux/input/navpoint.h>
> =A0#include <linux/lcd.h>
> =A0#include <linux/mfd/htc-egpio.h>
> =A0#include <linux/mfd/asic3.h>
> @@ -111,7 +112,7 @@ static unsigned long hx4700_pin_config[]
> =A0 =A0 =A0 =A0GPIO113_I2S_SYSCLK,
>
> =A0 =A0 =A0 =A0/* SSP 1 (NavPoint) */
> - =A0 =A0 =A0 GPIO23_SSP1_SCLK,
> + =A0 =A0 =A0 GPIO23_SSP1_SCLK_IN,
> =A0 =A0 =A0 =A0GPIO24_SSP1_SFRM,
> =A0 =A0 =A0 =A0GPIO25_SSP1_TXD,
> =A0 =A0 =A0 =A0GPIO26_SSP1_RXD,
> @@ -181,6 +182,23 @@ static struct platform_device gpio_keys
> =A0};
>
> =A0/*
> + * Synaptics NavPoint connected to SSP1
> + */
> +
> +static struct navpoint_platform_data navpoint_platform_data =3D {
> + =A0 =A0 =A0 .port =A0 =3D 1,
> + =A0 =A0 =A0 .gpio =A0 =3D GPIO102_HX4700_SYNAPTICS_ON,
> +};
> +
> +static struct platform_device navpoint =3D {
> + =A0 =A0 =A0 .name =A0 =3D "navpoint",
> + =A0 =A0 =A0 .id =A0 =A0 =3D -1,
> + =A0 =A0 =A0 .dev =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &navpoint_platform_d=
ata,
> + =A0 =A0 =A0 },
> +};
> +
> +/*
> =A0* ASIC3
> =A0*/
>
> @@ -782,6 +800,7 @@ static struct platform_device pcmcia =3D {
> =A0static struct platform_device *devices[] __initdata =3D {
> =A0 =A0 =A0 =A0&asic3,
> =A0 =A0 =A0 =A0&gpio_keys,
> + =A0 =A0 =A0 &navpoint,
> =A0 =A0 =A0 =A0&backlight,
> =A0 =A0 =A0 =A0&w3220,
> =A0 =A0 =A0 =A0&hx4700_lcd,
> @@ -806,6 +825,7 @@ static struct gpio global_gpios[] =3D {
> =A0 =A0 =A0 =A0{ GPIO32_HX4700_RS232_ON, =A0 =A0 =A0 =A0 GPIOF_OUT_IN=
IT_HIGH, "RS232_ON" },
> =A0 =A0 =A0 =A0{ GPIO71_HX4700_ASIC3_nRESET, =A0 =A0 GPIOF_OUT_INIT_H=
IGH, "ASIC3_nRESET" },
> =A0 =A0 =A0 =A0{ GPIO82_HX4700_EUART_RESET, =A0 =A0 =A0GPIOF_OUT_INIT=
_HIGH, "EUART_RESET" },
> + =A0 =A0 =A0 { GPIO102_HX4700_SYNAPTICS_ON, =A0 =A0GPIOF_OUT_INIT_LO=
W, =A0"SYNAPTICS_ON" },
> =A0 =A0 =A0 =A0{ GPIO105_HX4700_nIR_ON, =A0 =A0 =A0 =A0 =A0GPIOF_OUT_=
INIT_HIGH, "nIR_EN" },
> =A0};
>
> diff -uprN clean-3.2/arch/arm/mach-pxa/include/mach/hx4700.h linux-3.=
2/arch/arm/mach-pxa/include/mach/hx4700.h
> --- clean-3.2/arch/arm/mach-pxa/include/mach/hx4700.h =A0 2012-01-04 =
23:55:44.000000000 +0000
> +++ linux-3.2/arch/arm/mach-pxa/include/mach/hx4700.h =A0 2012-01-06 =
02:25:35.580520397 +0000
> @@ -62,7 +62,7 @@
> =A0#define GPIO97_HX4700_nBL_DETECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 97
> =A0#define GPIO99_HX4700_KEY_CONTACTS =A0 =A0 =A0 =A0 =A0 =A0 99
> =A0#define GPIO100_HX4700_AUTO_SENSE =A0 =A0 =A0 =A0 =A0 =A0 =A0100 /=
* BL auto brightness */
> -#define GPIO102_HX4700_SYNAPTICS_POWER_ON =A0 =A0 =A0102
> +#define GPIO102_HX4700_SYNAPTICS_ON =A0 =A0 =A0 =A0 =A0 =A0102
> =A0#define GPIO103_HX4700_SYNAPTICS_INT =A0 =A0 =A0 =A0 =A0 103
> =A0#define GPIO105_HX4700_nIR_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01=
05
> =A0#define GPIO106_HX4700_CPU_BT_nRESET =A0 =A0 =A0 =A0 =A0 106

Acked-by: Philipp Zabel <philipp.zabel@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
