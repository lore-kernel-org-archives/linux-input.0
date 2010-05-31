From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/5] ARM: SAMSUNG: Add keypad device support
Date: Mon, 31 May 2010 02:15:09 +0200
Message-ID: <201005310215.09555.marek.vasut@gmail.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com> <004101cb0055$2c9d5640$85d802c0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63226 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab0EaAQz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 20:16:55 -0400
In-Reply-To: <004101cb0055$2c9d5640$85d802c0$%kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Joonyoung Shim' <jy0922.shim@samsung.com>, ben-linux@fluff.org, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Dne Po 31. kv=C4=9Btna 2010 02:06:48 Kukjin Kim napsal(a):
> Joonyoung Shim wrote:
> > This patch adds samsung keypad device definition for samsung cpus.
> >=20
> > Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >=20
> >  arch/arm/plat-samsung/Kconfig                    |    7 ++-
> >  arch/arm/plat-samsung/Makefile                   |    1 +
> >  arch/arm/plat-samsung/dev-keypad.c               |   50
> >=20
> > +++++++++++++++++++
> >=20
> >  arch/arm/plat-samsung/include/plat/devs.h        |    2 +
> >  arch/arm/plat-samsung/include/plat/keypad.h      |   57
> >=20
> > ++++++++++++++++++++++
> >=20
> >  arch/arm/plat-samsung/include/plat/regs-keypad.h |   49
>=20
> +++++++++++++++++++
>=20
> >  6 files changed, 165 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/plat-samsung/dev-keypad.c
> >  create mode 100644 arch/arm/plat-samsung/include/plat/keypad.h
> >  create mode 100644 arch/arm/plat-samsung/include/plat/regs-keypad.=
h
> >=20
> > diff --git a/arch/arm/plat-samsung/Kconfig
> > b/arch/arm/plat-samsung/Kconfig index 2753fb3..3ef2df7 100644
> > --- a/arch/arm/plat-samsung/Kconfig
> > +++ b/arch/arm/plat-samsung/Kconfig
> > @@ -225,7 +225,12 @@ config S3C64XX_DEV_SPI
> >=20
> >  config SAMSUNG_DEV_TS
> > =20
> >  	bool
> >  	help
> >=20
> > -	    Common in platform device definitions for touchscreen device
> > +	  Common in platform device definitions for touchscreen device
> > +
>=20
> Above changing is not for keypad.
>=20
> > +config SAMSUNG_DEV_KEYPAD
> > +	bool
> > +	help
> > +	  Compile in platform device definitions for keypad
> >=20
> >  # DMA
> >=20
> > diff --git a/arch/arm/plat-samsung/Makefile
>=20
> b/arch/arm/plat-samsung/Makefile
>=20
> > index 228c2ad..ef00c47 100644
> > --- a/arch/arm/plat-samsung/Makefile
> > +++ b/arch/arm/plat-samsung/Makefile
> > @@ -50,6 +50,7 @@ obj-$(CONFIG_S3C_DEV_RTC)	+=3D dev-rtc.o
> >=20
> >  obj-$(CONFIG_SAMSUNG_DEV_ADC)	+=3D dev-adc.o
> >  obj-$(CONFIG_SAMSUNG_DEV_TS)	+=3D dev-ts.o
> >=20
> > +obj-$(CONFIG_SAMSUNG_DEV_KEYPAD)	+=3D dev-keypad.o
> >=20
> >  # DMA support
> >=20
> > diff --git a/arch/arm/plat-samsung/dev-keypad.c
>=20
> b/arch/arm/plat-samsung/dev-
>=20
> > keypad.c
> > new file mode 100644
> > index 0000000..70e2e2d
> > --- /dev/null
> > +++ b/arch/arm/plat-samsung/dev-keypad.c
> > @@ -0,0 +1,50 @@
> > +/*
> > + * linux/arch/arm/plat-samsung/dev-keypad.c
> > + *
> > + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> > + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> > + *
> > + *  This program is free software; you can redistribute  it and/or
> > modify
>=20
> it
>=20
> > + *  under  the terms of  the GNU General  Public License as publis=
hed by
>=20
> the
>=20
> > + *  Free Software Foundation;  either version 2 of the  License, o=
r (at
>=20
> your
>=20
> > + *  option) any later version.
> > + *
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +#include <mach/irqs.h>
> > +#include <mach/map.h>
> > +#include <plat/cpu.h>
> > +#include <plat/devs.h>
> > +#include <plat/keypad.h>
> > +
> > +static struct resource samsung_kp_resources[] =3D {
>=20
> How about samsung_keypad_resources easily to reading?

IMO doesn't matter ... kp is fine and it's well known acronym anyway.
>=20
> > +	[0] =3D {
> > +		.start	=3D SAMSUNG_PA_KEYPAD,
> > +		.end	=3D SAMSUNG_PA_KEYPAD + 0x20 - 1,
> > +		.flags	=3D IORESOURCE_MEM,
> > +	},
> > +	[1] =3D {
> > +		.start	=3D IRQ_KEYPAD,
> > +		.end	=3D IRQ_KEYPAD,
> > +		.flags	=3D IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +struct platform_device samsung_device_keypad =3D {
> > +	.name		=3D "samsung-keypad",
> > +	.id		=3D -1,
> > +	.num_resources	=3D ARRAY_SIZE(samsung_kp_resources),
> > +	.resource	=3D samsung_kp_resources,
> > +};
> > +
> > +void __init samsung_kp_set_platdata(struct samsung_kp_platdata *pd=
)
> > +{
> > +	struct samsung_kp_platdata *npd;
> > +
> > +	npd =3D s3c_set_platdata(pd, sizeof(struct samsung_kp_platdata),
> > +			&samsung_device_keypad);
> > +
> > +	if (!npd->cfg_gpio)
> > +		npd->cfg_gpio =3D samsung_keypad_cfg_gpio;
> > +}
> > diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/p=
lat-
> > samsung/include/plat/devs.h
> > index 6760999..c06386b 100644
> > --- a/arch/arm/plat-samsung/include/plat/devs.h
> > +++ b/arch/arm/plat-samsung/include/plat/devs.h
> > @@ -100,6 +100,8 @@ extern struct platform_device s5pc100_device_ii=
s0;
> >=20
> >  extern struct platform_device s5pc100_device_iis1;
> >  extern struct platform_device s5pc100_device_iis2;
> >=20
> > +extern struct platform_device samsung_device_keypad;
> > +
> >=20
> >  /* s3c2440 specific devices */
> > =20
> >  #ifdef CONFIG_CPU_S3C2440
> >=20
> > diff --git a/arch/arm/plat-samsung/include/plat/keypad.h b/arch/arm=
/plat-
> > samsung/include/plat/keypad.h
> > new file mode 100644
> > index 0000000..d144f42
> > --- /dev/null
> > +++ b/arch/arm/plat-samsung/include/plat/keypad.h
> > @@ -0,0 +1,57 @@
> > +/*
> > + * linux/arch/arm/plat-samsung/include/plat/keypad.h
> > + *
> > + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> > + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> > + *
> > + * Samsung Platform - Keypad platform data definitions
> > + *
> > + *  This program is free software; you can redistribute  it and/or
> > modify
>=20
> it
>=20
> > + *  under  the terms of  the GNU General  Public License as publis=
hed by
>=20
> the
>=20
> > + *  Free Software Foundation;  either version 2 of the  License, o=
r (at
>=20
> your
>=20
> > + *  option) any later version.
> > + *
> > + */
> > +
> > +#ifndef __PLAT_SAMSUNG_KEYPAD_H
> > +#define __PLAT_SAMSUNG_KEYPAD_H
> > +
> > +#include <linux/input/matrix_keypad.h>
> > +
> > +#define SAMSUNG_MAX_ROWS	8
> > +#define SAMSUNG_MAX_COLS	8
>=20
> Is the MAX really 8?
>=20
> S5PV210 & S5PC110 has 2 slots supporting 14 rows * 8 columns and 8 ro=
ws * 8
> columns.
>=20
> So just SAMSUNG_KEYPAD_ROWS is 8.

Maybe pass this as pdata ?
>=20
> > +
> > +/**
> > + * struct samsung_kp_platdata() - Platform device data for Samsung
> > Keypad + * @keymap_data: pointer to &matrix_keymap_data
> > + * @rows: number of keypad row supported.
> > + * @cols: number of keypad col supported.
> > + * @rep: flag for repeat setting.
> > + * @cfg_gpio: configure the GPIO.
> > + *
> > + * Initialisation data specific to either the machine or the platf=
orm
> > + * for the device driver to use or call-back when configuring gpio=
=2E
> > + */
> > +struct samsung_kp_platdata {
> > +	const struct matrix_keymap_data	*keymap_data;
> > +	unsigned int		rows;
> > +	unsigned int		cols;
> > +	unsigned int		rep;
> > +
> > +	void	(*cfg_gpio)(unsigned int rows, unsigned int cols);
> > +};
> > +
> > +/**
> > + * samsung_kp_set_platdata - Set platform data for Samsung Keypad
> > device. + * @pd: Platform data to register to device.
> > + *
> > + * Register the given platform data for use with Samsung Keypad de=
vice.
> > + * The call will copy the platform data, so the board definitions =
can
> > + * make the structure itself __initdata.
> > + */
> > +extern void samsung_kp_set_platdata(struct samsung_kp_platdata *pd=
);
> > +
> > +/* defined by architecture to configure gpio */
> > +extern void samsung_keypad_cfg_gpio(unsigned int rows, unsigned in=
t
> > cols); +
> > +#endif /* __PLAT_SAMSUNG_KEYPAD_H */
> > diff --git a/arch/arm/plat-samsung/include/plat/regs-keypad.h
>=20
> b/arch/arm/plat-
>=20
> > samsung/include/plat/regs-keypad.h
> > new file mode 100644
> > index 0000000..1a8c046
> > --- /dev/null
> > +++ b/arch/arm/plat-samsung/include/plat/regs-keypad.h
> > @@ -0,0 +1,49 @@
> > +/*
> > + * linux/arch/arm/plat-samsung/include/plat/regs-keypad.h
> > + *
> > + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> > + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> > + *
> > + *  This program is free software; you can redistribute  it and/or
> > modify
>=20
> it
>=20
> > + *  under  the terms of  the GNU General  Public License as publis=
hed by
>=20
> the
>=20
> > + *  Free Software Foundation;  either version 2 of the  License, o=
r (at
>=20
> your
>=20
> > + *  option) any later version.
> > + *
> > + */
> > +
> > +#ifndef __SAMSUNG_KEYPAD_H__
> > +#define __SAMSUNG_KEYPAD_H__
> > +
> > +#define SAMSUNG_KEYIFCON	0x00
> > +#define SAMSUNG_KEYIFSTSCLR	0x04
> > +#define SAMSUNG_KEYIFCOL	0x08
> > +#define SAMSUNG_KEYIFROW	0x0c
> > +#define SAMSUNG_KEYIFFC		0x10
> > +
> > +/* SAMSUNG_KEYIFCON */
> > +#define SAMSUNG_INT_F_EN	(1 << 0)
> > +#define SAMSUNG_INT_R_EN	(1 << 1)
> > +#define SAMSUNG_DF_EN		(1 << 2)
> > +#define SAMSUNG_FC_EN		(1 << 3)
> > +#define SAMSUNG_WAKEUPEN	(1 << 4)
>=20
> Needs KEYIF in the definition name for avoid confusing.
>=20
> > +
> > +/* SAMSUNG_KEYIFSTSCLR */
> > +#define SAMSUNG_P_INT_MASK	(0xff << 0)
> > +#define SAMSUNG_R_INT_MASK	(0xff << 8)
> > +#define SAMSUNG_R_INT_OFFSET	8
> > +#define S5PV210_P_INT_MASK	(0x3fff << 0)
> > +#define S5PV210_R_INT_MASK	(0x3fff << 16)
> > +#define S5PV210_R_INT_OFFSET	16
> > +
> > +/* SAMSUNG_KEYIFCOL */
> > +#define SAMSUNG_KEYIFCOL_MASK	(0xff << 0)
> > +#define S5PV210_KEYIFCOLEN_MASK (0xff << 8)
> > +
> > +/* SAMSUNG_KEYIFROW */
> > +#define SAMSUNG_KEYIFROW_MASK	(0xff << 0)
> > +#define S5PV210_KEYIFROW_MASK	(0x3fff << 0)
> > +
> > +/* SAMSUNG_KEYIFFC */
> > +#define SAMSUNG_KEYIFFC_MASK	(0x3ff << 0)
> > +
> > +#endif /* __SAMSUNG_KEYPAD_H__ */
> > --
> > 1.7.0.4
>=20
> Thanks.
>=20
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
