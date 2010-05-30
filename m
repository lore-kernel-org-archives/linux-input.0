From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/5] ARM: SAMSUNG: Add keypad device support
Date: Sun, 30 May 2010 05:42:37 +0200
Message-ID: <201005300542.37715.marek.vasut@gmail.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58382 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab0E3DoW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 May 2010 23:44:22 -0400
In-Reply-To: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com, dmitry.torokhov@gmail.com

Dne Ne 30. kv=C4=9Btna 2010 05:06:20 Joonyoung Shim napsal(a):
> This patch adds samsung keypad device definition for samsung cpus.
>=20
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/Kconfig                    |    7 ++-
>  arch/arm/plat-samsung/Makefile                   |    1 +
>  arch/arm/plat-samsung/dev-keypad.c               |   50
> +++++++++++++++++++ arch/arm/plat-samsung/include/plat/devs.h        =
|  =20
> 2 +
>  arch/arm/plat-samsung/include/plat/keypad.h      |   57
> ++++++++++++++++++++++ arch/arm/plat-samsung/include/plat/regs-keypad=
=2Eh |=20
>  49 +++++++++++++++++++ 6 files changed, 165 insertions(+), 1 deletio=
ns(-)
>  create mode 100644 arch/arm/plat-samsung/dev-keypad.c
>  create mode 100644 arch/arm/plat-samsung/include/plat/keypad.h
>  create mode 100644 arch/arm/plat-samsung/include/plat/regs-keypad.h
>=20
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kc=
onfig
> index 2753fb3..3ef2df7 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -225,7 +225,12 @@ config S3C64XX_DEV_SPI
>  config SAMSUNG_DEV_TS
>  	bool
>  	help
> -	    Common in platform device definitions for touchscreen device
> +	  Common in platform device definitions for touchscreen device
> +
> +config SAMSUNG_DEV_KEYPAD
> +	bool
> +	help
> +	  Compile in platform device definitions for keypad
>=20
>  # DMA
>=20
> diff --git a/arch/arm/plat-samsung/Makefile
> b/arch/arm/plat-samsung/Makefile index 228c2ad..ef00c47 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_S3C_DEV_RTC)	+=3D dev-rtc.o
>=20
>  obj-$(CONFIG_SAMSUNG_DEV_ADC)	+=3D dev-adc.o
>  obj-$(CONFIG_SAMSUNG_DEV_TS)	+=3D dev-ts.o
> +obj-$(CONFIG_SAMSUNG_DEV_KEYPAD)	+=3D dev-keypad.o
>=20
>  # DMA support
>=20
> diff --git a/arch/arm/plat-samsung/dev-keypad.c
> b/arch/arm/plat-samsung/dev-keypad.c new file mode 100644
> index 0000000..70e2e2d
> --- /dev/null
> +++ b/arch/arm/plat-samsung/dev-keypad.c
> @@ -0,0 +1,50 @@
> +/*
> + * linux/arch/arm/plat-samsung/dev-keypad.c
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + *
> + *  This program is free software; you can redistribute  it and/or m=
odify
> it + *  under  the terms of  the GNU General  Public License as publi=
shed
> by the + *  Free Software Foundation;  either version 2 of the  Licen=
se,
> or (at your + *  option) any later version.
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +#include <mach/irqs.h>
> +#include <mach/map.h>
> +#include <plat/cpu.h>
> +#include <plat/devs.h>
> +#include <plat/keypad.h>
> +
> +static struct resource samsung_kp_resources[] =3D {
> +	[0] =3D {
> +		.start	=3D SAMSUNG_PA_KEYPAD,
> +		.end	=3D SAMSUNG_PA_KEYPAD + 0x20 - 1,
> +		.flags	=3D IORESOURCE_MEM,
> +	},
> +	[1] =3D {
> +		.start	=3D IRQ_KEYPAD,
> +		.end	=3D IRQ_KEYPAD,
> +		.flags	=3D IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct platform_device samsung_device_keypad =3D {
> +	.name		=3D "samsung-keypad",
> +	.id		=3D -1,
> +	.num_resources	=3D ARRAY_SIZE(samsung_kp_resources),
> +	.resource	=3D samsung_kp_resources,
> +};
> +
> +void __init samsung_kp_set_platdata(struct samsung_kp_platdata *pd)
> +{
> +	struct samsung_kp_platdata *npd;
> +
> +	npd =3D s3c_set_platdata(pd, sizeof(struct samsung_kp_platdata),
> +			&samsung_device_keypad);
> +
> +	if (!npd->cfg_gpio)
> +		npd->cfg_gpio =3D samsung_keypad_cfg_gpio;
> +}
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h
> b/arch/arm/plat-samsung/include/plat/devs.h index 6760999..c06386b 10=
0644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -100,6 +100,8 @@ extern struct platform_device s5pc100_device_iis0=
;
>  extern struct platform_device s5pc100_device_iis1;
>  extern struct platform_device s5pc100_device_iis2;
>=20
> +extern struct platform_device samsung_device_keypad;
> +
>  /* s3c2440 specific devices */
>=20
>  #ifdef CONFIG_CPU_S3C2440
> diff --git a/arch/arm/plat-samsung/include/plat/keypad.h
> b/arch/arm/plat-samsung/include/plat/keypad.h new file mode 100644
> index 0000000..d144f42
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/keypad.h
> @@ -0,0 +1,57 @@
> +/*
> + * linux/arch/arm/plat-samsung/include/plat/keypad.h
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + *
> + * Samsung Platform - Keypad platform data definitions
> + *
> + *  This program is free software; you can redistribute  it and/or m=
odify
> it + *  under  the terms of  the GNU General  Public License as publi=
shed
> by the + *  Free Software Foundation;  either version 2 of the  Licen=
se,
> or (at your + *  option) any later version.
> + *
> + */
> +
> +#ifndef __PLAT_SAMSUNG_KEYPAD_H
> +#define __PLAT_SAMSUNG_KEYPAD_H
> +
> +#include <linux/input/matrix_keypad.h>
> +
> +#define SAMSUNG_MAX_ROWS	8
> +#define SAMSUNG_MAX_COLS	8
> +
> +/**
> + * struct samsung_kp_platdata() - Platform device data for Samsung K=
eypad
> + * @keymap_data: pointer to &matrix_keymap_data
> + * @rows: number of keypad row supported.
> + * @cols: number of keypad col supported.
> + * @rep: flag for repeat setting.
> + * @cfg_gpio: configure the GPIO.
> + *
> + * Initialisation data specific to either the machine or the platfor=
m
> + * for the device driver to use or call-back when configuring gpio.
> + */
> +struct samsung_kp_platdata {
> +	const struct matrix_keymap_data	*keymap_data;
> +	unsigned int		rows;
> +	unsigned int		cols;
> +	unsigned int		rep;

I don't know, maybe using uint32_t here? On ARM, it doesn't matter so f=
ar as int=20
will be always 32bit, but maybe we should just type the variables well =
?

Guys, what do you think ?

Otherwise this change looks ok to me.

> +
> +	void	(*cfg_gpio)(unsigned int rows, unsigned int cols);
> +};
> +
> +/**
> + * samsung_kp_set_platdata - Set platform data for Samsung Keypad de=
vice.
> + * @pd: Platform data to register to device.
> + *
> + * Register the given platform data for use with Samsung Keypad devi=
ce.
> + * The call will copy the platform data, so the board definitions ca=
n
> + * make the structure itself __initdata.
> + */
> +extern void samsung_kp_set_platdata(struct samsung_kp_platdata *pd);
> +
> +/* defined by architecture to configure gpio */
> +extern void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int =
cols);
> +
> +#endif /* __PLAT_SAMSUNG_KEYPAD_H */
> diff --git a/arch/arm/plat-samsung/include/plat/regs-keypad.h
> b/arch/arm/plat-samsung/include/plat/regs-keypad.h new file mode 1006=
44
> index 0000000..1a8c046
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/regs-keypad.h
> @@ -0,0 +1,49 @@
> +/*
> + * linux/arch/arm/plat-samsung/include/plat/regs-keypad.h
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + *
> + *  This program is free software; you can redistribute  it and/or m=
odify
> it + *  under  the terms of  the GNU General  Public License as publi=
shed
> by the + *  Free Software Foundation;  either version 2 of the  Licen=
se,
> or (at your + *  option) any later version.
> + *
> + */
> +
> +#ifndef __SAMSUNG_KEYPAD_H__
> +#define __SAMSUNG_KEYPAD_H__
> +
> +#define SAMSUNG_KEYIFCON	0x00
> +#define SAMSUNG_KEYIFSTSCLR	0x04
> +#define SAMSUNG_KEYIFCOL	0x08
> +#define SAMSUNG_KEYIFROW	0x0c
> +#define SAMSUNG_KEYIFFC		0x10
> +
> +/* SAMSUNG_KEYIFCON */
> +#define SAMSUNG_INT_F_EN	(1 << 0)
> +#define SAMSUNG_INT_R_EN	(1 << 1)
> +#define SAMSUNG_DF_EN		(1 << 2)
> +#define SAMSUNG_FC_EN		(1 << 3)
> +#define SAMSUNG_WAKEUPEN	(1 << 4)
> +
> +/* SAMSUNG_KEYIFSTSCLR */
> +#define SAMSUNG_P_INT_MASK	(0xff << 0)
> +#define SAMSUNG_R_INT_MASK	(0xff << 8)
> +#define SAMSUNG_R_INT_OFFSET	8
> +#define S5PV210_P_INT_MASK	(0x3fff << 0)
> +#define S5PV210_R_INT_MASK	(0x3fff << 16)
> +#define S5PV210_R_INT_OFFSET	16
> +
> +/* SAMSUNG_KEYIFCOL */
> +#define SAMSUNG_KEYIFCOL_MASK	(0xff << 0)
> +#define S5PV210_KEYIFCOLEN_MASK (0xff << 8)
> +
> +/* SAMSUNG_KEYIFROW */
> +#define SAMSUNG_KEYIFROW_MASK	(0xff << 0)
> +#define S5PV210_KEYIFROW_MASK	(0x3fff << 0)
> +
> +/* SAMSUNG_KEYIFFC */
> +#define SAMSUNG_KEYIFFC_MASK	(0x3ff << 0)
> +
> +#endif /* __SAMSUNG_KEYPAD_H__ */
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
