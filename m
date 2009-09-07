From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
	series SoCs
Date: Mon, 7 Sep 2009 12:25:14 +0900
Message-ID: <9c9fda240909062025h6400686ema7b5c64937168fbc@mail.gmail.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:64897 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758734AbZIGDZN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Sep 2009 23:25:13 -0400
Received: by vws33 with SMTP id 33so1595990vws.33
        for <linux-input@vger.kernel.org>; Sun, 06 Sep 2009 20:25:15 -0700 (PDT)
In-Reply-To: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>
Cc: linux-input@vger.kernel.org, laforge@gnumonks.org, ben-linux@fluff.org, =?EUC-KR?B?seiw5sDPL0FQsLO538bAL0UzL7vvvLrA/MDa?= <ki0351.kim@samsung.com>, =?EUC-KR?B?seixucH4L0FQsLO538bAL0U1L7vvvLrA/MDa?= <kgene.kim@samsung.com>

Hi,

2009/9/5 =EC=96=91=EC=A7=84=EC=84=B1 <jsgood.yang@samsung.com>:
> This keypad driver supports Samsung s3c based SoCs such as s3c6410.
> This driver is written with input device compatibles.
>
> Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
> Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
> ---
> =C2=A0drivers/input/keyboard/s3c-keypad.c | =C2=A0468 +++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 468 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 drivers/input/keyboard/s3c-keypad.c
>
> diff --git a/drivers/input/keyboard/s3c-keypad.c b/drivers/input/keyb=
oard/s3c-keypad.c
> new file mode 100644
> index 0000000..73b9a90
> --- /dev/null
> +++ b/drivers/input/keyboard/s3c-keypad.c
> @@ -0,0 +1,468 @@
> +/*
> + * linux/drivers/input/keyboard/s3c_keypad.c
> + *
> + * Driver for Samsung SoC matrix keypad controller.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/irq.h>
> +
> +#include <plat/keypad.h>
> +#include <plat/regs-keypad.h>
> +
> +#undef DEBUG
> +
> +static const unsigned char s3c_keycode[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 1, 2, KEY_1, KEY_Q, KEY_A, 6, 7, KEY_LEFT,
> + =C2=A0 =C2=A0 =C2=A0 9, 10, KEY_2, KEY_W, KEY_S, KEY_Z, KEY_RIGHT, =
16,
> + =C2=A0 =C2=A0 =C2=A0 17, 18, KEY_3, KEY_E, KEY_D, KEY_X, 23, KEY_UP=
,
> + =C2=A0 =C2=A0 =C2=A0 25, 26, KEY_4, KEY_R, KEY_F, KEY_C, 31, 32,
> + =C2=A0 =C2=A0 =C2=A0 33, KEY_O, KEY_5, KEY_T, KEY_G, KEY_V, KEY_DOW=
N, KEY_BACKSPACE,
> + =C2=A0 =C2=A0 =C2=A0 KEY_P, KEY_0, KEY_6, KEY_Y, KEY_H, KEY_SPACE, =
47, 48,
> + =C2=A0 =C2=A0 =C2=A0 KEY_M, KEY_L, KEY_7, KEY_U, KEY_J, KEY_N, 55, =
KEY_ENTER,
> + =C2=A0 =C2=A0 =C2=A0 KEY_LEFTSHIFT, KEY_9, KEY_8, KEY_I, KEY_K, KEY=
_B, 63, KEY_COMMA,
> +};

Why do you use fixed keycode? Dose it provided from board specific
platform? and If we want to use only 3 * 3 keypad then how do you
handle this one?

> +
> +struct s3c_keypad {
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_platform_keypad *pdata;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char keycodes[ARRAY_SIZE(s3c_keycode)=
];

We don't need full keycode array here. It should be allocated with
required size.

> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *dev;
> + =C2=A0 =C2=A0 =C2=A0 struct timer_list timer;
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *regs;
> + =C2=A0 =C2=A0 =C2=A0 struct clk *clk;
> + =C2=A0 =C2=A0 =C2=A0 int irq;
> + =C2=A0 =C2=A0 =C2=A0 int timer_enabled;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int prevmask_low;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int prevmask_high;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int keyifcon;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int keyiffc;
> +};
> +
> +static int s3c_keypad_scan(struct s3c_keypad *keypad, u32 *keymask_l=
ow,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *keymask_high)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_platform_keypad *pdata =3D keypad->=
pdata;
> + =C2=A0 =C2=A0 =C2=A0 int i, j =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 u32 cval, rval, cfg;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < pdata->nr_cols; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cval =3D readl(key=
pad->regs + S3C_KEYIFCOL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cval |=3D S3C_KEYI=
=46_COL_DMASK;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cval &=3D ~(1 << i=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(cval, keypa=
d->regs + S3C_KEYIFCOL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(pdata->dela=
y);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rval =3D ~(readl(k=
eypad->regs + S3C_KEYIFROW)) &
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 S3C_KEYIF_ROW_DMASK;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i * pdata->nr=
_rows) < pdata->max_masks)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 *keymask_low |=3D (rval << (i * pdata->nr_rows));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 *keymask_high |=3D (rval << (j * pdata->nr_rows));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 j++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 cfg =3D readl(keypad->regs + S3C_KEYIFCOL);
> + =C2=A0 =C2=A0 =C2=A0 cfg &=3D ~S3C_KEYIF_COL_MASK_ALL;
> + =C2=A0 =C2=A0 =C2=A0 writel(cfg, keypad->regs + S3C_KEYIFCOL);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static void s3c_keypad_timer_handler(unsigned long data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_keypad *keypad =3D (struct s3c_keyp=
ad *)data;
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_platform_keypad *pdata =3D keypad->=
pdata;
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *input =3D keypad->dev;
> + =C2=A0 =C2=A0 =C2=A0 u32 keymask_low =3D 0, keymask_high =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 u32 press_mask_low, press_mask_high;
> + =C2=A0 =C2=A0 =C2=A0 u32 release_mask_low, release_mask_high, code,=
 cfg;
> + =C2=A0 =C2=A0 =C2=A0 int i;
> +
> + =C2=A0 =C2=A0 =C2=A0 s3c_keypad_scan(keypad, &keymask_low, &keymask=
_high);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (keymask_low !=3D keypad->prevmask_low) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 press_mask_low =3D=
 ((keymask_low ^ keypad->prevmask_low) &
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keymask=
_low);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 release_mask_low =3D=
 ((keymask_low ^ keypad->prevmask_low) &
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad-=
>prevmask_low);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (press_mask_=
low) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (press_mask_low & 1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code =3D keypad->keycodes[i];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(input, code, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&input->dev, "low pressed: =
%d\n", i);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 press_mask_low >>=3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 i++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (release_mas=
k_low) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (release_mask_low & 1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code =3D keypad->keycodes[i];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(input, code, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&input->dev, "low released =
: %d\n", i);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 release_mask_low >>=3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 i++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad->prevmask_l=
ow =3D keymask_low;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (keymask_high !=3D keypad->prevmask_high) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 press_mask_high =3D=
 ((keymask_high ^ keypad->prevmask_high) &
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keymask=
_high);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 release_mask_high =
=3D ((keymask_high ^ keypad->prevmask_high) &
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad-=
>prevmask_high);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (press_mask_=
high) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (press_mask_high & 1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code =3D keypad->keycodes[i + pdata=
->max_masks];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(input, code, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&input->dev, "high pressed:=
 %d %d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad-=
>keycodes[i + pdata->max_masks],
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 press_mask_high >>=3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 i++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (release_mas=
k_high) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (release_mask_high & 1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code =3D keypad->keycodes[i + pdata=
->max_masks];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(input, code, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&input->dev, "high released=
: %d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad-=
>keycodes[i + pdata->max_masks]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 release_mask_high >>=3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 i++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad->prevmask_h=
igh =3D keymask_high;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (keymask_low | keymask_high) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod_timer(&keypad-=
>timer, jiffies + HZ / 10);
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg =3D readl(keyp=
ad->regs + S3C_KEYIFCON);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg &=3D ~S3C_KEYI=
=46_CON_MASK_ALL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg |=3D (S3C_KEYI=
=46_INT_F_EN | S3C_KEYIF_INT_R_EN |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 S3C_KEYIF_DF_EN | S3C_KEYIF_FC_EN);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(cfg, keypad=
->regs + S3C_KEYIFCON);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad->timer_enab=
led =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static irqreturn_t s3c_keypad_irq(int irq, void *dev_id)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_keypad *keypad =3D dev_id;
> + =C2=A0 =C2=A0 =C2=A0 u32 cfg;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* disable keypad interrupt and schedule for k=
eypad timer handler */
> + =C2=A0 =C2=A0 =C2=A0 cfg =3D readl(keypad->regs + S3C_KEYIFCON);
> + =C2=A0 =C2=A0 =C2=A0 cfg &=3D ~(S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_=
R_EN);
> + =C2=A0 =C2=A0 =C2=A0 writel(cfg, keypad->regs + S3C_KEYIFCON);
> +
> + =C2=A0 =C2=A0 =C2=A0 keypad->timer.expires =3D jiffies + (HZ / 100)=
;
> + =C2=A0 =C2=A0 =C2=A0 if (keypad->timer_enabled) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod_timer(&keypad-=
>timer, keypad->timer.expires);
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_timer(&keypad-=
>timer);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad->timer_enab=
led =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* clear the keypad interrupt status */
> + =C2=A0 =C2=A0 =C2=A0 writel(S3C_KEYIF_STSCLR_CLEAR, keypad->regs + =
S3C_KEYIFSTSCLR);
> +
> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> +}

Why do you use timer. As other input drivers how about to use workqueue=
?

> +
> +static int s3c_keypad_open(struct input_dev *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_keypad *keypad =3D input_get_drvdat=
a(dev);
> + =C2=A0 =C2=A0 =C2=A0 u32 cfg;
> +
> + =C2=A0 =C2=A0 =C2=A0 clk_enable(keypad->clk);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* init keypad h/w block */
> + =C2=A0 =C2=A0 =C2=A0 cfg =3D readl(keypad->regs + S3C_KEYIFCON);
> + =C2=A0 =C2=A0 =C2=A0 cfg &=3D ~S3C_KEYIF_CON_MASK_ALL;
> + =C2=A0 =C2=A0 =C2=A0 cfg |=3D (S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R=
_EN |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 S3C_KEYIF_DF_EN | S3C_KEYIF_FC_EN);
> + =C2=A0 =C2=A0 =C2=A0 writel(cfg, keypad->regs + S3C_KEYIFCON);
> +
> + =C2=A0 =C2=A0 =C2=A0 cfg =3D readl(keypad->regs + S3C_KEYIFFC);
> + =C2=A0 =C2=A0 =C2=A0 cfg |=3D 0x1;

What's the meaning of '0x1'?

> + =C2=A0 =C2=A0 =C2=A0 writel(cfg, keypad->regs + S3C_KEYIFFC);
> +
> + =C2=A0 =C2=A0 =C2=A0 cfg =3D readl(keypad->regs + S3C_KEYIFCOL);
> + =C2=A0 =C2=A0 =C2=A0 cfg &=3D ~S3C_KEYIF_COL_MASK_ALL;
> + =C2=A0 =C2=A0 =C2=A0 writel(cfg, keypad->regs + S3C_KEYIFCOL);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Scan timer init */
> + =C2=A0 =C2=A0 =C2=A0 init_timer(&keypad->timer);
> + =C2=A0 =C2=A0 =C2=A0 keypad->timer.function =3D s3c_keypad_timer_ha=
ndler;
> + =C2=A0 =C2=A0 =C2=A0 keypad->timer.data =3D (unsigned long)keypad;
> + =C2=A0 =C2=A0 =C2=A0 keypad->timer.expires =3D jiffies + (HZ / 10);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (keypad->timer_enabled) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod_timer(&keypad-=
>timer, keypad->timer.expires);
> + =C2=A0 =C2=A0 =C2=A0 } else {

useless curly braces

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_timer(&keypad-=
>timer);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad->timer_enab=
led =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static void s3c_keypad_close(struct input_dev *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_keypad *keypad =3D input_get_drvdat=
a(dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 clk_disable(keypad->clk);
> +}
> +
> +#define res_size(res) =C2=A0((res)->end - (res)->start + 1)
> +
> +static int __devinit s3c_keypad_probe(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_platform_keypad *pdata;
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_keypad *keypad;
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *input;
> + =C2=A0 =C2=A0 =C2=A0 struct resource *res;
> + =C2=A0 =C2=A0 =C2=A0 int irq, error, i;
> +
> + =C2=A0 =C2=A0 =C2=A0 pdata =3D pdev->dev.platform_data;
> + =C2=A0 =C2=A0 =C2=A0 if (pdata =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "no platform data\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 keypad =3D kzalloc(sizeof(struct s3c_keypad), =
GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (keypad =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to allocate driver data\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 keypad->pdata =3D pdata;
> + =C2=A0 =C2=A0 =C2=A0 memcpy(keypad->keycodes, s3c_keycode, sizeof(k=
eypad->keycodes));

memcpy??? if you don't modify s3c_keycode. just assign it.

> +
> + =C2=A0 =C2=A0 =C2=A0 res =3D platform_get_resource(pdev, IORESOURCE=
_MEM, 0);
> + =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to get I/O memory\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -ENXIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_get_io;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 res =3D request_mem_region(res->start, res_siz=
e(res), pdev->name);
> + =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to request I/O memory\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -EBUSY;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_get_io;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 keypad->regs =3D ioremap(res->start, res_size(=
res));
> + =C2=A0 =C2=A0 =C2=A0 if (keypad->regs =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to remap I/O memory\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -ENXIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_map_io;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 keypad->clk =3D clk_get(&pdev->dev, "keypad");
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(keypad->clk)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to get keypad clock\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D PTR_ERR(=
keypad->clk);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_clk;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Create and register the input driver. */
> + =C2=A0 =C2=A0 =C2=A0 input =3D input_allocate_device();
> + =C2=A0 =C2=A0 =C2=A0 if (!input) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to allocate input device\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_alloc_inp=
ut;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 input->name =3D pdev->name;
> + =C2=A0 =C2=A0 =C2=A0 input->id.bustype =3D BUS_HOST;
> + =C2=A0 =C2=A0 =C2=A0 input->open =3D s3c_keypad_open;
> + =C2=A0 =C2=A0 =C2=A0 input->close =3D s3c_keypad_close;
> + =C2=A0 =C2=A0 =C2=A0 input->dev.parent =3D &pdev->dev;
> + =C2=A0 =C2=A0 =C2=A0 input->keycode =3D (void *)keypad->keycodes;
> + =C2=A0 =C2=A0 =C2=A0 input->keycodesize =3D sizeof(keypad->keycodes=
[0]);
> + =C2=A0 =C2=A0 =C2=A0 input->keycodemax =3D ARRAY_SIZE(keypad->keyco=
des);
> +
> + =C2=A0 =C2=A0 =C2=A0 keypad->dev =3D input;
> +
> + =C2=A0 =C2=A0 =C2=A0 input_set_drvdata(input, keypad);
> +
> + =C2=A0 =C2=A0 =C2=A0 __set_bit(EV_KEY, input->evbit);
> + =C2=A0 =C2=A0 =C2=A0 __set_bit(EV_REP, input->evbit);
> +
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < pdata->max_keys; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keypad->keycodes[i=
] =3D s3c_keycode[i];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (keypad->keycod=
es[i] <=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __set_bit(keypad->=
keycodes[i] & KEY_MAX, input->keybit);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 irq =3D platform_get_irq(pdev, 0);
> + =C2=A0 =C2=A0 =C2=A0 if (irq < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to get keypad irq\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D -ENXIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_get_irq;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, keypad);
> +
> + =C2=A0 =C2=A0 =C2=A0 error =3D request_irq(irq, s3c_keypad_irq, IRQ=
=46_DISABLED,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 pdev->name, keypad);
> + =C2=A0 =C2=A0 =C2=A0 if (error) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to request IRQ\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_req_irq;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 keypad->irq =3D irq;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Register the input device */
> + =C2=A0 =C2=A0 =C2=A0 error =3D input_register_device(input);
> + =C2=A0 =C2=A0 =C2=A0 if (error) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->dev=
, "failed to register input device\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_reg_input=
;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 device_init_wakeup(&pdev->dev, 1);
> + =C2=A0 =C2=A0 =C2=A0 dev_info(&pdev->dev, "Samsung Keypad Interface=
 driver\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +err_reg_input:
> + =C2=A0 =C2=A0 =C2=A0 free_irq(irq, pdev);
> +
> +err_req_irq:
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
> +
> +err_get_irq:
> + =C2=A0 =C2=A0 =C2=A0 input_free_device(input);
> +
> +err_alloc_input:
> + =C2=A0 =C2=A0 =C2=A0 clk_put(keypad->clk);
> +
> +err_clk:
> + =C2=A0 =C2=A0 =C2=A0 iounmap(keypad->regs);
> +
> +err_map_io:
> + =C2=A0 =C2=A0 =C2=A0 release_mem_region(res->start, res_size(res));
> +
> +err_get_io:
> + =C2=A0 =C2=A0 =C2=A0 kfree(keypad);
> +
> + =C2=A0 =C2=A0 =C2=A0 return error;
> +}
> +
> +static int __devexit s3c_keypad_remove(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_keypad *keypad =3D platform_get_drv=
data(pdev);
> + =C2=A0 =C2=A0 =C2=A0 struct resource *res;
> +
> + =C2=A0 =C2=A0 =C2=A0 free_irq(keypad->irq, pdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 clk_disable(keypad->clk);
> + =C2=A0 =C2=A0 =C2=A0 clk_put(keypad->clk);
> +
> + =C2=A0 =C2=A0 =C2=A0 input_unregister_device(keypad->dev);
> + =C2=A0 =C2=A0 =C2=A0 input_free_device(keypad->dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 iounmap(keypad->regs);
> +
> + =C2=A0 =C2=A0 =C2=A0 res =3D platform_get_resource(pdev, IORESOURCE=
_MEM, 0);
> + =C2=A0 =C2=A0 =C2=A0 release_mem_region(res->start, res_size(res));
> +
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, NULL);
> + =C2=A0 =C2=A0 =C2=A0 kfree(keypad);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int s3c_keypad_suspend(struct platform_device *dev, pm_messag=
e_t state)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_keypad *keypad =3D platform_get_drv=
data(pdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 keypad->keyifcon =3D readl(keypad->regs + S3C_=
KEYIFCON);
> + =C2=A0 =C2=A0 =C2=A0 keypad->keyiffc =3D readl(keypad->regs + S3C_K=
EYIFFC);
> +
> + =C2=A0 =C2=A0 =C2=A0 disable_irq(IRQ_KEYPAD);
> + =C2=A0 =C2=A0 =C2=A0 clk_disable(keypad->clk);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int s3c_keypad_resume(struct platform_device *dev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct s3c_keypad *keypad =3D platform_get_drv=
data(pdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 clk_enable(keypad->clock);
> +
> + =C2=A0 =C2=A0 =C2=A0 writel(keypad->keyifcon, keypad->regs + S3C_KE=
YIFCON);
> + =C2=A0 =C2=A0 =C2=A0 writel(keypad->keyiffc, keypad->regs + S3C_KEY=
IFFC);
> +
> + =C2=A0 =C2=A0 =C2=A0 enable_irq(IRQ_KEYPAD);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +#else
> +#define s3c_keypad_suspend NULL
> +#define s3c_keypad_resume =C2=A0NULL
> +#endif /* CONFIG_PM */
> +
> +static struct platform_driver s3c_keypad_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D s=
3c_keypad_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D s3c_ke=
ypad_remove,
> + =C2=A0 =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D s3c_ke=
ypad_suspend,
> + =C2=A0 =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D s3c_ke=
ypad_resume,
> + =C2=A0 =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =C2=A0=3D T=
HIS_MODULE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "=
s3c-keypad",
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +static int __init s3c_keypad_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&s3c_keypad_dr=
iver);
> +}
> +
> +static void __exit s3c_keypad_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&s3c_keypad_driver)=
;
> +}
> +
> +module_init(s3c_keypad_init);
> +module_exit(s3c_keypad_exit);
> +
> +MODULE_AUTHOR("Kyeongil, Kim <ki0351.kim@samsung.com>");
> +MODULE_AUTHOR("Jinsung, Yang <jsgood.yang@samsung.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Keypad interface for Samsung SoC");
> +

=46inally,
We did duplicated works. We already implement the keypad driver for
s5pc100 & s5pc110. but we use workqueue structure instead of timer.

I will post the our works.

Thank you,
Kyungmin Park
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
