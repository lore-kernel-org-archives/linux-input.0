From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
Date: Mon, 21 Jun 2010 17:05:34 +0800
Message-ID: <AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 21, 2010 at 2:26 PM, Joonyoung Shim <jy0922.shim@samsung.co=
m> wrote:
> This patch adds samsung keypad device definition for samsung cpus.
>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =C2=A0arch/arm/plat-samsung/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A05 ++
> =C2=A0arch/arm/plat-samsung/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0arch/arm/plat-samsung/dev-keypad.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 58 +++++++++++++++++++++

Why need an individual file for a simple device?  In the end, these fil=
es
will flood over the plat-samsung/ directory. And now think this - in yo=
ur
new SoC design ,the keypad IP is replaced with a completely new one, do=
es
that mean a new dev-keypad-new1.c, dev-keypad-new2.c?

I personally prefer a single devices.c for all the devices, if you
orgnize well, shouldn't take up much code size in that single file.

> =C2=A0arch/arm/plat-samsung/include/plat/devs.h =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 =C2=A02 +
> =C2=A0arch/arm/plat-samsung/include/plat/keypad.h =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 59 ++++++++++++++++++++++
> =C2=A0arch/arm/plat-samsung/include/plat/regs-keypad.h | =C2=A0 49 ++=
++++++++++++++++

Will these registers be used elsewhere except within the keypad driver?
If no, they might be better moved to the keypad driver itself, it makes
the driver more self-contained and avoid the registers being accessed
anywhere.

> =C2=A06 files changed, 174 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 arch/arm/plat-samsung/dev-keypad.c
> =C2=A0create mode 100644 arch/arm/plat-samsung/include/plat/keypad.h
> =C2=A0create mode 100644 arch/arm/plat-samsung/include/plat/regs-keyp=
ad.h
>
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kc=
onfig
> index 2753fb3..bd007e3 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -227,6 +227,11 @@ config SAMSUNG_DEV_TS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Common in platform device de=
finitions for touchscreen device
>
> +config SAMSUNG_DEV_KEYPAD
> + =C2=A0 =C2=A0 =C2=A0 bool
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Compile in platform device definitions =
for keypad
> +
> =C2=A0# DMA
>
> =C2=A0config S3C_DMA
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/M=
akefile
> index b1d82cc..8269d80 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_S3C_DEV_RTC) =C2=A0 =C2=A0 +=3D dev-rt=
c.o
>
> =C2=A0obj-$(CONFIG_SAMSUNG_DEV_ADC) =C2=A0+=3D dev-adc.o
> =C2=A0obj-$(CONFIG_SAMSUNG_DEV_TS) =C2=A0 +=3D dev-ts.o
> +obj-$(CONFIG_SAMSUNG_DEV_KEYPAD) =C2=A0 =C2=A0 =C2=A0 +=3D dev-keypa=
d.o
>
> =C2=A0# DMA support
>
> diff --git a/arch/arm/plat-samsung/dev-keypad.c b/arch/arm/plat-samsu=
ng/dev-keypad.c
> new file mode 100644
> index 0000000..679b444
> --- /dev/null
> +++ b/arch/arm/plat-samsung/dev-keypad.c
> @@ -0,0 +1,58 @@
> +/*
> + * linux/arch/arm/plat-samsung/dev-keypad.c
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + *
> + * =C2=A0This program is free software; you can redistribute =C2=A0i=
t and/or modify it
> + * =C2=A0under =C2=A0the terms of =C2=A0the GNU General =C2=A0Public=
 License as published by the
> + * =C2=A0Free Software Foundation; =C2=A0either version 2 of the =C2=
=A0License, or (at your
> + * =C2=A0option) any later version.
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
> +static struct resource samsung_keypad_resources[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 [0] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0=3D S=
AMSUNG_PA_KEYPAD,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0=
=3D SAMSUNG_PA_KEYPAD + 0x20 - 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0=3D I=
ORESOURCE_MEM,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 [1] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0=3D I=
RQ_KEYPAD,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0=
=3D IRQ_KEYPAD,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0=3D I=
ORESOURCE_IRQ,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +struct platform_device samsung_device_keypad =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
samsung-keypad",
> + =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D -1,
> + =C2=A0 =C2=A0 =C2=A0 .num_resources =C2=A0=3D ARRAY_SIZE(samsung_ke=
ypad_resources),
> + =C2=A0 =C2=A0 =C2=A0 .resource =C2=A0 =C2=A0 =C2=A0 =3D samsung_key=
pad_resources,
> +};
> +
> +void __init samsung_keypad_set_platdata(struct samsung_keypad_platda=
ta *pd)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct samsung_keypad_platdata *npd;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!pd) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "%=
s: no platform data\n", __func__);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 npd =3D kmemdup(pd, sizeof(struct samsung_keyp=
ad_platdata), GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!npd)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "%=
s: no memory for platform data\n", __func__);

This part of the code is actually duplicated again and again and again
for each device, PXA and other legacy platforms are bad references for
this. In arch/arm/mach-mmp/, it might be a bit cleaner, there are three
major points:

 1. A minimum 'struct pxa_device_desc' for a simple description of a
    device (more than 90% of the devices can be described that way),
    and avoid using a comparatively heavier weight platform_device,
    which can be generated at run-time

 2. pxa_register_device() to allocate and register the platform_device
    at run-time, along with the platform data

 3. pxa168_add_*() as a consistent/clearly named API, and with type
    checking for the platform_data type (it's a bit difficult to check
    type in pxa_register_device())

Just for your reference.

> +
> + =C2=A0 =C2=A0 =C2=A0 if (!npd->cfg_gpio)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 npd->cfg_gpio =3D =
samsung_keypad_cfg_gpio;

More and more platforms are moving their IO-mux to a static descriptive
array and have some API to configure. E.g. PXA, Orion/Kirkwood, iMX....
The idea basically is:

  1) IO-Mux and the internal peripheral controller are conceptually
     separate entities (the extreme case is the internal peripheral
     controller can function normally even without IO-mux being setup
     correct, only that signals not proplery routed in/out)

  2) IO-mux should be configured before the peripheral drivers are
     ready to go (there are cases that IO-mux will have to be changed
     at run-time, so IO-mux API should be able to handle that, though
     such cases are rare)

  3) Peripheral drivers should not be concerned with IO-mux config

Not sure though how the IO-mux is designed in S5P, so treat the above
as reference only.

> +
> + =C2=A0 =C2=A0 =C2=A0 samsung_device_keypad.dev.platform_data =3D np=
d;
> +}
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/pla=
t-samsung/include/plat/devs.h
> index e6144e4..6d9f01b 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -100,6 +100,8 @@ extern struct platform_device s5pc100_device_iis0=
;
> =C2=A0extern struct platform_device s5pc100_device_iis1;
> =C2=A0extern struct platform_device s5pc100_device_iis2;
>
> +extern struct platform_device samsung_device_keypad;
> +
> =C2=A0/* s3c2440 specific devices */
>
> =C2=A0#ifdef CONFIG_CPU_S3C2440
> diff --git a/arch/arm/plat-samsung/include/plat/keypad.h b/arch/arm/p=
lat-samsung/include/plat/keypad.h
> new file mode 100644
> index 0000000..6d139d6
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/keypad.h
> @@ -0,0 +1,59 @@
> +/*
> + * linux/arch/arm/plat-samsung/include/plat/keypad.h
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + *
> + * Samsung Platform - Keypad platform data definitions
> + *
> + * =C2=A0This program is free software; you can redistribute =C2=A0i=
t and/or modify it
> + * =C2=A0under =C2=A0the terms of =C2=A0the GNU General =C2=A0Public=
 License as published by the
> + * =C2=A0Free Software Foundation; =C2=A0either version 2 of the =C2=
=A0License, or (at your
> + * =C2=A0option) any later version.
> + *
> + */
> +
> +#ifndef __PLAT_SAMSUNG_KEYPAD_H
> +#define __PLAT_SAMSUNG_KEYPAD_H
> +
> +#include <linux/input/matrix_keypad.h>
> +
> +#define SAMSUNG_MAX_ROWS =C2=A0 =C2=A0 =C2=A0 8
> +#define SAMSUNG_MAX_COLS =C2=A0 =C2=A0 =C2=A0 8
> +
> +/**
> + * struct samsung_keypad_platdata - Platform device data for Samsung=
 Keypad.
> + * @keymap_data: pointer to &matrix_keymap_data.
> + * @rows: number of keypad row supported.
> + * @cols: number of keypad col supported.
> + * @no_autorepeat: disable key autorepeat.
> + * @wakeup: controls whether the device should be set up as wakeup s=
ource.
> + * @cfg_gpio: configure the GPIO.
> + *
> + * Initialisation data specific to either the machine or the platfor=
m
> + * for the device driver to use or call-back when configuring gpio.
> + */
> +struct samsung_keypad_platdata {
> + =C2=A0 =C2=A0 =C2=A0 const struct matrix_keymap_data *keymap_data;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0rows;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cols;
> + =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0no_autorepeat;
> + =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0wakeup;
> +
> + =C2=A0 =C2=A0 =C2=A0 void =C2=A0 =C2=A0(*cfg_gpio)(unsigned int row=
s, unsigned int cols);
> +};

Why are you calling everything samsung_this, samsung_that? Now think ab=
out:

  1. Is this keypad applicable to all Samsung silicon?
  2. Samsung has a new IP for the keypad, now what? samsung_new_keypad_=
platdata?

s5p_keypad sounds more reasable to me if it's applicable to all the s5p
series. Now I also doubt that's the case. So normally, we will name it
after the first silicon where this IP appears, e.g.

  s5pc100_keypad

and now in s5pc200 code, you can also register/re-use the s5pc100_keypa=
d
device/driver, and everyone knows - OK, the IP on S5PC100 is now re-use=
d
here.

> +
> +/**
> + * samsung_keypad_set_platdata - Set platform data for Samsung Keypa=
d device.
> + * @pd: Platform data to register to device.
> + *
> + * Register the given platform data for use with Samsung Keypad devi=
ce.
> + * The call will copy the platform data, so the board definitions ca=
n
> + * make the structure itself __initdata.
> + */
> +extern void samsung_keypad_set_platdata(struct samsung_keypad_platda=
ta *pd);
> +
> +/* defined by architecture to configure gpio. */
> +extern void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int =
cols);
> +
> +#endif /* __PLAT_SAMSUNG_KEYPAD_H */
> diff --git a/arch/arm/plat-samsung/include/plat/regs-keypad.h b/arch/=
arm/plat-samsung/include/plat/regs-keypad.h
> new file mode 100644
> index 0000000..e4688f0
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/regs-keypad.h
> @@ -0,0 +1,49 @@
> +/*
> + * linux/arch/arm/plat-samsung/include/plat/regs-keypad.h
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + *
> + * =C2=A0This program is free software; you can redistribute =C2=A0i=
t and/or modify it
> + * =C2=A0under =C2=A0the terms of =C2=A0the GNU General =C2=A0Public=
 License as published by the
> + * =C2=A0Free Software Foundation; =C2=A0either version 2 of the =C2=
=A0License, or (at your
> + * =C2=A0option) any later version.
> + *
> + */
> +
> +#ifndef __SAMSUNG_KEYPAD_H__
> +#define __SAMSUNG_KEYPAD_H__
> +
> +#define SAMSUNG_KEYIFCON =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00
> +#define SAMSUNG_KEYIFSTSCLR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00x04
> +#define SAMSUNG_KEYIFCOL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08
> +#define SAMSUNG_KEYIFROW =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0c
> +#define SAMSUNG_KEYIFFC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10
> +
> +/* SAMSUNG_KEYIFCON */
> +#define SAMSUNG_KEYIFCON_INT_F_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(1 << 0)
> +#define SAMSUNG_KEYIFCON_INT_R_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(1 << 1)
> +#define SAMSUNG_KEYIFCON_DF_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1 << 2)
> +#define SAMSUNG_KEYIFCON_FC_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1 << 3)
> +#define SAMSUNG_KEYIFCON_WAKEUPEN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(1 << 4)
> +
> +/* SAMSUNG_KEYIFSTSCLR */
> +#define SAMSUNG_KEYIFSTSCLR_P_INT_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
0xff << 0)
> +#define SAMSUNG_KEYIFSTSCLR_R_INT_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
0xff << 8)
> +#define SAMSUNG_KEYIFSTSCLR_R_INT_OFFSET =C2=A0 =C2=A0 =C2=A0 8
> +#define S5PV210_KEYIFSTSCLR_P_INT_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
0x3fff << 0)
> +#define S5PV210_KEYIFSTSCLR_R_INT_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
0x3fff << 16)
> +#define S5PV210_KEYIFSTSCLR_R_INT_OFFSET =C2=A0 =C2=A0 =C2=A0 16
> +
> +/* SAMSUNG_KEYIFCOL */
> +#define SAMSUNG_KEYIFCOL_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(0xff << 0)
> +#define S5PV210_KEYIFCOLEN_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0xff << 8)
> +
> +/* SAMSUNG_KEYIFROW */
> +#define SAMSUNG_KEYIFROW_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(0xff << 0)
> +#define S5PV210_KEYIFROW_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(0x3fff << 0)
> +
> +/* SAMSUNG_KEYIFFC */
> +#define SAMSUNG_KEYIFFC_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (0x3ff << 0)
> +
> +#endif /* __SAMSUNG_KEYPAD_H__ */
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
