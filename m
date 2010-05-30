From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 5/5] input: samsung-keypad - Add samsung keypad driver
Date: Sun, 30 May 2010 05:39:50 +0200
Message-ID: <201005300539.50619.marek.vasut@gmail.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com> <1275188784-23395-5-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64351 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab0E3Dlh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 May 2010 23:41:37 -0400
In-Reply-To: <1275188784-23395-5-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com, dmitry.torokhov@gmail.com

Dne Ne 30. kv=C4=9Btna 2010 05:06:24 Joonyoung Shim napsal(a):
> This patch adds support for keypad driver running on Samsung cpus. Th=
is
> driver is tested on GONI and Aquila board using S5PC110 cpu.
>=20
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/input/keyboard/Kconfig          |    9 +
>  drivers/input/keyboard/Makefile         |    1 +
>  drivers/input/keyboard/samsung-keypad.c |  364
> +++++++++++++++++++++++++++++++ 3 files changed, 374 insertions(+), 0
> deletions(-)
>  create mode 100644 drivers/input/keyboard/samsung-keypad.c
>=20
> diff --git a/drivers/input/keyboard/Kconfig
> b/drivers/input/keyboard/Kconfig index d8fa5d7..bf6a50f 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -342,6 +342,15 @@ config KEYBOARD_PXA930_ROTARY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pxa930_rotary.
>=20
> +config KEYBOARD_SAMSUNG
> +	tristate "Samsung keypad support"
> +	depends on SAMSUNG_DEV_KEYPAD
> +	help
> +	  Say Y here if you want to use the Samsung keypad.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called samsung-keypad.
> +
>  config KEYBOARD_STOWAWAY
>  	tristate "Stowaway keyboard"
>  	select SERIO
> diff --git a/drivers/input/keyboard/Makefile
> b/drivers/input/keyboard/Makefile index 4596d0c..8f973ed 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_KEYBOARD_OPENCORES)	+=3D opencores-kbd=
=2Eo
>  obj-$(CONFIG_KEYBOARD_PXA27x)		+=3D pxa27x_keypad.o
>  obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+=3D pxa930_rotary.o
>  obj-$(CONFIG_KEYBOARD_QT2160)		+=3D qt2160.o
> +obj-$(CONFIG_KEYBOARD_SAMSUNG)		+=3D samsung-keypad.o
>  obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+=3D sh_keysc.o
>  obj-$(CONFIG_KEYBOARD_STOWAWAY)		+=3D stowaway.o
>  obj-$(CONFIG_KEYBOARD_SUNKBD)		+=3D sunkbd.o
> diff --git a/drivers/input/keyboard/samsung-keypad.c
> b/drivers/input/keyboard/samsung-keypad.c new file mode 100644
> index 0000000..f4bcf97
> --- /dev/null
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -0,0 +1,364 @@
> +/*
> + * samsung-keypad.c  --  Samsung keypad driver
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + * Author: Donghwa Lee <dh09.lee@samsung.com>
> + *
> + *  This program is free software; you can redistribute  it and/or m=
odify
> it + *  under  the terms of  the GNU General  Public License as publi=
shed
> by the + *  Free Software Foundation;  either version 2 of the  Licen=
se,
> or (at your + *  option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <plat/cpu.h>
> +#include <plat/keypad.h>
> +#include <plat/regs-keypad.h>
> +
> +struct samsung_kp {
> +	struct input_dev *input_dev;
> +	struct timer_list timer;
> +	struct clk *clk;
> +	struct work_struct work;
> +	void __iomem *base;
> +	unsigned short *keycodes;
> +	unsigned int row_shift;
> +	unsigned int rows;
> +	unsigned int cols;
> +	unsigned int row_state[SAMSUNG_MAX_COLS];
> +	int irq;
> +};
> +
> +static void samsung_kp_scan(struct samsung_kp *keypad, unsigned int
> *row_state) +{
> +	unsigned int col;
> +	unsigned int val;
> +
> +	for (col =3D 0; col < keypad->cols; col++) {
> +#if CONFIG_ARCH_S5PV210
> +		val =3D S5PV210_KEYIFCOLEN_MASK;
> +		val &=3D ~(1 << col) << 8;
> +#else
> +		val =3D SAMSUNG_KEYIFCOL_MASK;
> +		val &=3D ~(1 << col);
> +#endif


No, what if you want to run this on both S5PV210 and some other samsung=
 soc?
=46ix the #if CONFIG_ARCH_S5PV210 please. Maybe like this:

if (cpu_is_s5pv210()) {} else {} ?

The rest looks good.

Cheers!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
