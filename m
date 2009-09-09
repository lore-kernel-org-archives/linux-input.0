From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 1/4] [INPUT][KEYBOARD] Samsung keypad driver support
Date: Wed, 9 Sep 2009 20:21:49 +0900
Message-ID: <9c9fda240909090421s76ad640ci83f16ead97e32999@mail.gmail.com>
References: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:47637 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbZIILVq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 07:21:46 -0400
Received: by ywh5 with SMTP id 5so5721607ywh.4
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2009 04:21:49 -0700 (PDT)
In-Reply-To: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jsgood.yang@samsung.com
Cc: dmitry.torokhov@gmail.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyeongil Kim <ki0351.kim@samsung.com>

Hi,

Simple typo at CONFIG_PM parameters. see below

Thank you,
Kyungmin Park

On Wed, Sep 9, 2009 at 8:11 PM,  <jsgood.yang@samsung.com> wrote:
> From: Jinsung Yang <jsgood.yang@samsung.com>
>
> Add support for Samsung matrix keypad driver
>
> Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
> Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
> ---
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0| =A0 =A06 +
> =A0drivers/input/keyboard/Makefile =A0 =A0 | =A0 =A01 +
> =A0drivers/input/keyboard/s3c-keypad.c | =A0446 +++++++++++++++++++++=
++++++++++++++
> =A03 files changed, 453 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/input/keyboard/s3c-keypad.c
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index a6b989a..4a04553 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -361,4 +361,10 @@ config KEYBOARD_XTKBD
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called xtkbd.
>
> +config KEYBOARD_S3C
> + =A0 =A0 =A0 tristate "Samsung S3C keypad support"
> + =A0 =A0 =A0 depends on PLAT_S3C
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Enable support for Samsung S3C keypad interface.
> +
> =A0endif
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard=
/Makefile
> index b5b5eae..21331b8 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -31,3 +31,4 @@ obj-$(CONFIG_KEYBOARD_STOWAWAY) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 +=3D stowaway.o
> =A0obj-$(CONFIG_KEYBOARD_SUNKBD) =A0 =A0 =A0 =A0 =A0+=3D sunkbd.o
> =A0obj-$(CONFIG_KEYBOARD_TOSA) =A0 =A0 =A0 =A0 =A0 =A0+=3D tosakbd.o
> =A0obj-$(CONFIG_KEYBOARD_XTKBD) =A0 =A0 =A0 =A0 =A0 +=3D xtkbd.o
> +obj-$(CONFIG_KEYBOARD_S3C) =A0 =A0 =A0 =A0 =A0 =A0 +=3D s3c-keypad.o
> diff --git a/drivers/input/keyboard/s3c-keypad.c b/drivers/input/keyb=
oard/s3c-keypad.c
> new file mode 100644
> index 0000000..9436a4c
> --- /dev/null
> +++ b/drivers/input/keyboard/s3c-keypad.c
> @@ -0,0 +1,446 @@
> +/*
> + * linux/drivers/input/keyboard/s3c-keypad.c
> + *
> + * Copyright (C) 2009 Samsung Electronics
> + *
> + * Author: Jinsung Yang <jsgood.yang@samsung.com>
> + * Author: Kyeongil Kim <ki0351.kim@samsung.com>
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
> +#define S3C_KEYPAD_MAX_ROWS 16
> +#define S3C_KEYPAD_MAX_COLS 8
> +
> +struct s3c_keypad {
> + =A0 =A0 =A0 struct s3c_platform_keypad *pdata;
> + =A0 =A0 =A0 unsigned short keycodes[S3C_KEYPAD_MAX_ROWS * S3C_KEYPA=
D_MAX_COLS];
> + =A0 =A0 =A0 struct input_dev *dev;
> + =A0 =A0 =A0 struct timer_list timer;
> + =A0 =A0 =A0 void __iomem *regs;
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 unsigned int prevmask_low;
> + =A0 =A0 =A0 unsigned int prevmask_high;
> + =A0 =A0 =A0 unsigned int keyifcon;
> + =A0 =A0 =A0 unsigned int keyiffc;
> +};
> +
> +static int s3c_keypad_scan(struct s3c_keypad *keypad, u32 *keymask_l=
ow,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 *ke=
ymask_high)
> +{
> + =A0 =A0 =A0 struct s3c_platform_keypad *pdata =3D keypad->pdata;
> + =A0 =A0 =A0 int i, j =3D 0;
> + =A0 =A0 =A0 u32 cval, rval, cfg;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->nr_cols; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval =3D readl(keypad->regs + S3C_KEYIF=
COL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval |=3D S3C_KEYIF_COL_DMASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval &=3D ~(1 << i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(cval, keypad->regs + S3C_KEYIFCO=
L);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(pdata->delay);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rval =3D ~(readl(keypad->regs + S3C_KEY=
IFROW)) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S3C_KEYIF_ROW_DMASK;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i * pdata->nr_rows) < pdata->max_m=
asks)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *keymask_low |=3D (rval=
 << (i * pdata->nr_rows));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *keymask_high |=3D (rva=
l << (j * pdata->nr_rows));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 j++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 cfg =3D readl(keypad->regs + S3C_KEYIFCOL);
> + =A0 =A0 =A0 cfg &=3D ~S3C_KEYIF_COL_MASK_ALL;
> + =A0 =A0 =A0 writel(cfg, keypad->regs + S3C_KEYIFCOL);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void s3c_keypad_timer_handler(unsigned long data)
> +{
> + =A0 =A0 =A0 struct s3c_keypad *keypad =3D (struct s3c_keypad *)data=
;
> + =A0 =A0 =A0 struct s3c_platform_keypad *pdata =3D keypad->pdata;
> + =A0 =A0 =A0 struct input_dev *input =3D keypad->dev;
> + =A0 =A0 =A0 u32 keymask_low =3D 0, keymask_high =3D 0;
> + =A0 =A0 =A0 u32 press_mask_low, press_mask_high;
> + =A0 =A0 =A0 u32 release_mask_low, release_mask_high, code, cfg;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 s3c_keypad_scan(keypad, &keymask_low, &keymask_high);
> +
> + =A0 =A0 =A0 if (keymask_low !=3D keypad->prevmask_low) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 press_mask_low =3D ((keymask_low ^ keyp=
ad->prevmask_low) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 keymask_low);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mask_low =3D ((keymask_low ^ ke=
ypad->prevmask_low) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 keypad->prevmask_low);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (press_mask_low) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (press_mask_low & 1)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D=
 keypad->keycodes[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_key(input, code, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&input->dev, "low pressed: %d\n", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 press_mask_low >>=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (release_mask_low) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (release_mask_low & =
1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D=
 keypad->keycodes[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_key(input, code, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&input->dev, "low released: %d\n", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mask_low >>=3D =
1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad->prevmask_low =3D keymask_low;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (keymask_high !=3D keypad->prevmask_high) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 press_mask_high =3D ((keymask_high ^ ke=
ypad->prevmask_high) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 keymask_high);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mask_high =3D ((keymask_high ^ =
keypad->prevmask_high) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 keypad->prevmask_high);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (press_mask_high) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (press_mask_high & 1=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D=
 keypad->keycodes[i + pdata->max_masks];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_key(input, code, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&input->dev, "high pressed: %d %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 keypad->keycodes[i + pdata->max_masks],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 press_mask_high >>=3D 1=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (release_mask_high) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (release_mask_high &=
 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D=
 keypad->keycodes[i + pdata->max_masks];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_key(input, code, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&input->dev, "high released: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 keypad->keycodes[i + pdata->max_masks]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mask_high >>=3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad->prevmask_high =3D keymask_high;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (keymask_low | keymask_high) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&keypad->timer, jiffies + HZ =
/ 10);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg =3D readl(keypad->regs + S3C_KEYIFC=
ON);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg &=3D ~S3C_KEYIF_CON_MASK_ALL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg |=3D (S3C_KEYIF_INT_F_EN | S3C_KEYI=
=46_INT_R_EN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S3C_KEY=
IF_DF_EN | S3C_KEYIF_FC_EN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(cfg, keypad->regs + S3C_KEYIFCON=
);
> + =A0 =A0 =A0 }
> +}
> +
> +static irqreturn_t s3c_keypad_irq(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct s3c_keypad *keypad =3D dev_id;
> + =A0 =A0 =A0 u32 cfg;
> +
> + =A0 =A0 =A0 /* disable keypad interrupt and schedule for keypad tim=
er handler */
> + =A0 =A0 =A0 cfg =3D readl(keypad->regs + S3C_KEYIFCON);
> + =A0 =A0 =A0 cfg &=3D ~(S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN);
> + =A0 =A0 =A0 writel(cfg, keypad->regs + S3C_KEYIFCON);
> +
> + =A0 =A0 =A0 keypad->timer.expires =3D jiffies + (HZ / 100);
> + =A0 =A0 =A0 mod_timer(&keypad->timer, keypad->timer.expires);
> +
> + =A0 =A0 =A0 /* clear the keypad interrupt status */
> + =A0 =A0 =A0 writel(S3C_KEYIF_STSCLR_CLEAR, keypad->regs + S3C_KEYIF=
STSCLR);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int s3c_keypad_open(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct s3c_keypad *keypad =3D input_get_drvdata(dev);
> + =A0 =A0 =A0 u32 cfg;
> +
> + =A0 =A0 =A0 clk_enable(keypad->clk);
> +
> + =A0 =A0 =A0 /* init keypad h/w block */
> + =A0 =A0 =A0 cfg =3D readl(keypad->regs + S3C_KEYIFCON);
> + =A0 =A0 =A0 cfg &=3D ~S3C_KEYIF_CON_MASK_ALL;
> + =A0 =A0 =A0 cfg |=3D (S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S3C_KEYIF_DF_EN | S3C_K=
EYIF_FC_EN);
> + =A0 =A0 =A0 writel(cfg, keypad->regs + S3C_KEYIFCON);
> +
> + =A0 =A0 =A0 cfg =3D readl(keypad->regs + S3C_KEYIFFC);
> + =A0 =A0 =A0 cfg |=3D S3C_KEYIF_FILTER_VAL;
> + =A0 =A0 =A0 writel(cfg, keypad->regs + S3C_KEYIFFC);
> +
> + =A0 =A0 =A0 cfg =3D readl(keypad->regs + S3C_KEYIFCOL);
> + =A0 =A0 =A0 cfg &=3D ~S3C_KEYIF_COL_MASK_ALL;
> + =A0 =A0 =A0 writel(cfg, keypad->regs + S3C_KEYIFCOL);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void s3c_keypad_close(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct s3c_keypad *keypad =3D input_get_drvdata(dev);
> +
> + =A0 =A0 =A0 clk_disable(keypad->clk);
> +}
> +
> +static int __devinit s3c_keypad_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct s3c_platform_keypad *pdata;
> + =A0 =A0 =A0 struct s3c_keypad *keypad;
> + =A0 =A0 =A0 struct input_dev *input;
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 int error =3D 0, irq, i;
> +
> + =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 if (pdata =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no platform data\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad =3D kzalloc(sizeof(struct s3c_keypad), GFP_KERNE=
L);
> + =A0 =A0 =A0 if (keypad =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to allocate=
 driver data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad->pdata =3D pdata;
> + =A0 =A0 =A0 if (!pdata->keymap) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get keym=
ap array\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_keymap;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 memcpy(keypad->keycodes, pdata->keymap,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(pdata->keymap[0]=
) * pdata->max_keys);
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (res =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get I/O =
memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_keymap;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D request_mem_region(res->start, resource_size(re=
s), pdev->name);
> + =A0 =A0 =A0 if (res =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request =
I/O memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_keymap;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad->regs =3D ioremap(res->start, resource_size(res)=
);
> + =A0 =A0 =A0 if (keypad->regs =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to remap I/=
O memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_map_io;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad->clk =3D clk_get(&pdev->dev, "keypad");
> + =A0 =A0 =A0 if (IS_ERR(keypad->clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get keyp=
ad clock\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D PTR_ERR(keypad->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Create and register the input driver. */
> + =A0 =A0 =A0 input =3D input_allocate_device();
> + =A0 =A0 =A0 if (!input) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to allocate=
 input device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc_input;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 input->name =3D pdev->name;
> + =A0 =A0 =A0 input->id.bustype =3D BUS_HOST;
> + =A0 =A0 =A0 input->open =3D s3c_keypad_open;
> + =A0 =A0 =A0 input->close =3D s3c_keypad_close;
> + =A0 =A0 =A0 input->dev.parent =3D &pdev->dev;
> + =A0 =A0 =A0 input->keycode =3D keypad->keycodes;
> + =A0 =A0 =A0 input->keycodesize =3D sizeof(keypad->keycodes[0]);
> + =A0 =A0 =A0 input->keycodemax =3D ARRAY_SIZE(keypad->keycodes);
> +
> + =A0 =A0 =A0 keypad->dev =3D input;
> + =A0 =A0 =A0 input_set_drvdata(input, keypad);
> +
> + =A0 =A0 =A0 __set_bit(EV_KEY, input->evbit);
> + =A0 =A0 =A0 __set_bit(EV_REP, input->evbit);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->max_keys; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(keypad->keycodes[i] & KEY_MAX=
, input->keybit);
> +
> + =A0 =A0 =A0 __clear_bit(KEY_RESERVED, input->keybit);
> +
> + =A0 =A0 =A0 irq =3D platform_get_irq(pdev, 0);
> + =A0 =A0 =A0 if (irq < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get keyp=
ad irq\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_get_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, keypad);
> +
> + =A0 =A0 =A0 error =3D request_irq(irq, s3c_keypad_irq, IRQF_DISABLE=
D,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->name, key=
pad);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request =
IRQ\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_req_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad->irq =3D irq;
> + =A0 =A0 =A0 setup_timer(&keypad->timer, s3c_keypad_timer_handler,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)keypad);
> +
> + =A0 =A0 =A0 /* Register the input device */
> + =A0 =A0 =A0 error =3D input_register_device(input);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to register=
 input device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_reg_input;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 device_init_wakeup(&pdev->dev, 1);
> + =A0 =A0 =A0 dev_info(&pdev->dev, "Samsung Keypad Interface driver l=
oaded\n");
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_reg_input:
> + =A0 =A0 =A0 free_irq(irq, pdev);
> +
> +err_req_irq:
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> +
> +err_get_irq:
> + =A0 =A0 =A0 input_free_device(input);
> +
> +err_alloc_input:
> + =A0 =A0 =A0 clk_put(keypad->clk);
> +
> +err_clk:
> + =A0 =A0 =A0 iounmap(keypad->regs);
> +
> +err_map_io:
> + =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
> +
> +err_keymap:
> + =A0 =A0 =A0 kfree(keypad);
> +
> + =A0 =A0 =A0 return error;
> +}
> +
> +static int __devexit s3c_keypad_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct s3c_keypad *keypad =3D platform_get_drvdata(pdev=
);
> + =A0 =A0 =A0 struct resource *res;
> +
> + =A0 =A0 =A0 free_irq(keypad->irq, pdev);
> + =A0 =A0 =A0 clk_put(keypad->clk);
> +
> + =A0 =A0 =A0 input_unregister_device(keypad->dev);
> + =A0 =A0 =A0 iounmap(keypad->regs);
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 kfree(keypad);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int s3c_keypad_suspend(struct platform_device *dev, pm_messag=
e_t state)
> +{
> + =A0 =A0 =A0 struct s3c_keypad *keypad =3D platform_get_drvdata(pdev=
);
> +
> + =A0 =A0 =A0 keypad->keyifcon =3D readl(keypad->regs + S3C_KEYIFCON)=
;
> + =A0 =A0 =A0 keypad->keyiffc =3D readl(keypad->regs + S3C_KEYIFFC);
> +
> + =A0 =A0 =A0 disable_irq(IRQ_KEYPAD);
> + =A0 =A0 =A0 clk_disable(keypad->clk);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int s3c_keypad_resume(struct platform_device *dev)
> +{
> + =A0 =A0 =A0 struct s3c_keypad *keypad =3D platform_get_drvdata(pdev=
);

Where's pdev? maybe you should use 'pdev' instead of 'dev' at parameter=
=2E

> +
> + =A0 =A0 =A0 clk_enable(keypad->clock);
> +
> + =A0 =A0 =A0 writel(keypad->keyifcon, keypad->regs + S3C_KEYIFCON);
> + =A0 =A0 =A0 writel(keypad->keyiffc, keypad->regs + S3C_KEYIFFC);
> +
> + =A0 =A0 =A0 enable_irq(IRQ_KEYPAD);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +#else
> +#define s3c_keypad_suspend NULL
> +#define s3c_keypad_resume =A0NULL
> +#endif /* CONFIG_PM */
> +
> +static struct dev_pm_ops s3c_keypad_dev_pm_ops =3D {
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D s3c_keypad_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D s3c_keypad_resume,
> +};
> +
> +static struct platform_driver s3c_keypad_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D s3c_keypad_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D s3c_keypad_remove,
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "s3c-keypad",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &s3c_keypad_dev_pm_ops,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init s3c_keypad_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&s3c_keypad_driver);
> +}
> +
> +static void __exit s3c_keypad_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&s3c_keypad_driver);
> +}
> +
> +module_init(s3c_keypad_init);
> +module_exit(s3c_keypad_exit);
> +
> +MODULE_AUTHOR("Kyeongil, Kim <ki0351.kim@samsung.com>");
> +MODULE_AUTHOR("Jinsung, Yang <jsgood.yang@samsung.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Keypad Interface Driver for Samsung SoC");
> +
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
