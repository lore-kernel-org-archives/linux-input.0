From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config option
Date: Thu, 8 Sep 2011 09:28:50 +0530
Message-ID: <CAJuYYwSMLOZD9b2F=yYQnUQ2BgB69smaeQJmopk3izR7gEjNyg@mail.gmail.com>
References: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
	<1315317317-21873-2-git-send-email-thomas.abraham@linaro.org>
	<20110907182248.GA2874@core.coreip.homeip.net>
	<20110907214954.GA32235@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110907214954.GA32235@core.coreip.homeip.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 8 September 2011 03:19, Dmitry Torokhov <dmitry.torokhov@gmail.com> =
wrote:

[...]

> BTW, should we do something like below?
>
> Thanks.
>
> --
> Dmitry
>
> Input: samsung-keypad - enable compiling on other platforms
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> There is nothing in keypad platform definitions that requires
> the driver be complied on Samsung platform only, so let's move them
> out of the platform subdirectory and relax the dependencies.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0arch/arm/plat-samsung/include/plat/keypad.h | =A0 27 +------------=
----
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
5 ++-
> =A0drivers/input/keyboard/samsung-keypad.c =A0 =A0 | =A0 =A02 +
> =A0include/linux/input/samsung-keypad.h =A0 =A0 =A0 =A0| =A0 43 +++++=
++++++++++++++++++++++
> =A04 files changed, 48 insertions(+), 29 deletions(-)
> =A0create mode 100644 include/linux/input/samsung-keypad.h
>
>
> diff --git a/arch/arm/plat-samsung/include/plat/keypad.h b/arch/arm/p=
lat-samsung/include/plat/keypad.h
> index b59a648..8fddee3 100644
> --- a/arch/arm/plat-samsung/include/plat/keypad.h
> +++ b/arch/arm/plat-samsung/include/plat/keypad.h
> @@ -13,32 +13,7 @@
> =A0#ifndef __PLAT_SAMSUNG_KEYPAD_H
> =A0#define __PLAT_SAMSUNG_KEYPAD_H
>
> -#include <linux/input/matrix_keypad.h>
> -
> -#define SAMSUNG_MAX_ROWS =A0 =A0 =A0 8
> -#define SAMSUNG_MAX_COLS =A0 =A0 =A0 8
> -
> -/**
> - * struct samsung_keypad_platdata - Platform device data for Samsung=
 Keypad.
> - * @keymap_data: pointer to &matrix_keymap_data.
> - * @rows: number of keypad row supported.
> - * @cols: number of keypad col supported.
> - * @no_autorepeat: disable key autorepeat.
> - * @wakeup: controls whether the device should be set up as wakeup s=
ource.
> - * @cfg_gpio: configure the GPIO.
> - *
> - * Initialisation data specific to either the machine or the platfor=
m
> - * for the device driver to use or call-back when configuring gpio.
> - */
> -struct samsung_keypad_platdata {
> - =A0 =A0 =A0 const struct matrix_keymap_data *keymap_data;
> - =A0 =A0 =A0 unsigned int rows;
> - =A0 =A0 =A0 unsigned int cols;
> - =A0 =A0 =A0 bool no_autorepeat;
> - =A0 =A0 =A0 bool wakeup;
> -
> - =A0 =A0 =A0 void (*cfg_gpio)(unsigned int rows, unsigned int cols);
> -};
> +#include <linux/input/samsung_keypad.h>
>
> =A0/**
> =A0* samsung_keypad_set_platdata - Set platform data for Samsung Keyp=
ad device.
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index de846f8..db1b221 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -434,9 +434,10 @@ config KEYBOARD_PMIC8XXX
>
> =A0config KEYBOARD_SAMSUNG
> =A0 =A0 =A0 =A0tristate "Samsung keypad support"
> - =A0 =A0 =A0 depends on SAMSUNG_DEV_KEYPAD
> + =A0 =A0 =A0 depends on HAVE_CLK
> =A0 =A0 =A0 =A0help
> - =A0 =A0 =A0 =A0 Say Y here if you want to use the Samsung keypad.
> + =A0 =A0 =A0 =A0 Say Y here if you want to use the keypad on your Sa=
msung mobile
> + =A0 =A0 =A0 =A0 device.

In this case, Samsung Keyboad option would be listed in the available
keyboard list in menuconfig for non-samsung platforms as well. Knowing
that Samsung keypad controller has been used only in Samsung
Application Processor SoC's only (and would be this way for quite
sometime), should we not retain its selection to Samsung AP SoC's
only?

>
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called samsung-keypad.
> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/=
keyboard/samsung-keypad.c
> index d244fdf..1a2b755 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -22,7 +22,7 @@
> =A0#include <linux/platform_device.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/sched.h>
> -#include <plat/keypad.h>
> +#include <linux/input/samsung-keypad.h>
>
> =A0#define SAMSUNG_KEYIFCON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x00
> =A0#define SAMSUNG_KEYIFSTSCLR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x04
> diff --git a/include/linux/input/samsung-keypad.h b/include/linux/inp=
ut/samsung-keypad.h
> new file mode 100644
> index 0000000..f25619b
> --- /dev/null
> +++ b/include/linux/input/samsung-keypad.h
> @@ -0,0 +1,43 @@
> +/*
> + * Samsung Keypad platform data definitions
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + *
> + * This program is free software; you can redistribute =A0it and/or =
modify it
> + * under =A0the terms of =A0the GNU General =A0Public License as pub=
lished by the
> + * Free Software Foundation; =A0either version 2 of the =A0License, =
or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __SAMSUNG_KEYPAD_H
> +#define __SAMSUNG_KEYPAD_H
> +
> +#include <linux/input/matrix_keypad.h>
> +
> +#define SAMSUNG_MAX_ROWS =A0 =A0 =A0 8
> +#define SAMSUNG_MAX_COLS =A0 =A0 =A0 8
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
> + =A0 =A0 =A0 const struct matrix_keymap_data *keymap_data;
> + =A0 =A0 =A0 unsigned int rows;
> + =A0 =A0 =A0 unsigned int cols;
> + =A0 =A0 =A0 bool no_autorepeat;
> + =A0 =A0 =A0 bool wakeup;
> +
> + =A0 =A0 =A0 void (*cfg_gpio)(unsigned int rows, unsigned int cols);
> +};
> +
> +#endif /* __SAMSUNG_KEYPAD_H */
>

The movement of samsung-keypad.h to include/linux/input would be
helpful if it is decided to make samsung-keypad driver available to
non-samsung platforms as well.

Thanks,
Thomas.
