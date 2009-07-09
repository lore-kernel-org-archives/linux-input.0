From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: Add keypad support for w90p910 evb
Date: Thu, 9 Jul 2009 18:39:04 +0530
Message-ID: <5d5443650907090609t9f09c1ue802eb33ff68fa38@mail.gmail.com>
References: <4A546443.9030907@gmail.com>
	 <5d5443650907080332t4156cabdu267d28c6c486f372@mail.gmail.com>
	 <4A55901B.6070805@gmail.com>
	 <5d5443650907082347i40f5f39bn63e2683046155eb@mail.gmail.com>
	 <4A55B8E0.6020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f193.google.com ([209.85.221.193]:33715 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756397AbZGINJG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 09:09:06 -0400
Received: by qyk31 with SMTP id 31so72425qyk.33
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2009 06:09:04 -0700 (PDT)
In-Reply-To: <4A55B8E0.6020909@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Hi Wan ZongShun,

On Thu, Jul 9, 2009 at 3:01 PM, Wan ZongShun<mcuos.com@gmail.com> wrote=
:
> Dear sirs,
>
> According to Trilok's suggestion, I fixed up my driver and
> resubmitted it.
>
> patch text:
>
> Add w90p910 keypad driver for w90p910 evalution board

s/evalution/evaluation ?

> based on w90p910,there is a 4X4 keypad on my board.
>
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
>
> ---
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 10 +
> =A0drivers/input/keyboard/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/input/keyboard/w90p910_keypad.c | =A0306 +++++++++++++++++=
++++++++++++++
> =A03 files changed, 317 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/input/keyboard/w90p910_keypad.c

Looks good to me. Thanks.

Reviewed-by: Trilok Soni <soni.trilok@gmail.com>


>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index 9d8f796..aad2b05 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -353,4 +353,14 @@ config KEYBOARD_EP93XX
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called ep93xx_keypad.
>
> +config KEYBOARD_W90P910
> + =A0 =A0 =A0 tristate "W90P910 Matrix Keypad support"
> + =A0 =A0 =A0 depends on ARCH_W90X900
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here to enable the matrix keypad on evaluatio=
n board
> + =A0 =A0 =A0 =A0 based on W90P910.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the
> + =A0 =A0 =A0 =A0 module will be called w90p910_keypad.
> +
> =A0endif
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard=
/Makefile
> index 156b647..d65086a 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_KEYBOARD_MAPLE) =A0 =A0 =A0 =A0 =A0+=3D=
 maple_keyb.o
> =A0obj-$(CONFIG_KEYBOARD_BFIN) =A0 =A0 =A0 =A0 =A0 =A0+=3D bf54x-keys=
=2Eo
> =A0obj-$(CONFIG_KEYBOARD_SH_KEYSC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 sh_keysc.o
> =A0obj-$(CONFIG_KEYBOARD_EP93XX) =A0 =A0 =A0 =A0 =A0+=3D ep93xx_keypa=
d.o
> +obj-$(CONFIG_KEYBOARD_W90P910) =A0 =A0 =A0 =A0 +=3D w90p910_keypad.o
> diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/=
keyboard/w90p910_keypad.c
> new file mode 100644
> index 0000000..cfa6ab4
> --- /dev/null
> +++ b/drivers/input/keyboard/w90p910_keypad.c
> @@ -0,0 +1,306 @@
> +/*
> + * Copyright (c) 2008-2009 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +
> +#include <mach/w90p910_keypad.h>
> +
> +/* Keypad Interface Control Registers */
> +#define KPI_CONF =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00
> +#define KPI_3KCONF =A0 =A0 =A0 =A0 =A0 =A0 0x04
> +#define KPI_LPCONF =A0 =A0 =A0 =A0 =A0 =A0 0x08
> +#define KPI_STATUS =A0 =A0 =A0 =A0 =A0 =A0 0x0C
> +
> +#define IS1KEY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x01 << 16)
> +#define INTTR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x01 << 21)
> +#define KEY0R =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x0f << 3)
> +#define KEY0C =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x07
> +#define DEBOUNCE_BIT =A0 =A0 =A0 =A0 =A0 0x08
> +#define KSIZE0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x01 << 16)
> +#define KSIZE1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x01 << 17)
> +#define KPSEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x01 << 19)
> +#define ENKP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x01 << 18)
> +
> +#define KGET_RAW(n) =A0 =A0 =A0 =A0 =A0 =A0(((n) & KEY0R) >> 3)
> +#define KGET_COLUMN(n) =A0 =A0 =A0 =A0 ((n) & KEY0C)
> +
> +#define keypad_readl(off) =A0 =A0 =A0__raw_readl(keypad->mmio_base +=
 (off))
> +#define keypad_writel(off, v) =A0__raw_writel((v), keypad->mmio_base=
 + (off))
> +
> +#define MAX_MATRIX_KEY_NUM =A0 =A0 (8 * 8)
> +
> +struct w90p910_keypad {
> + =A0 =A0 =A0 struct w90p910_keypad_platform_data *pdata;
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 void __iomem *mmio_base;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
> +};
> +
> +static void w90p910_keypad_build_keycode(struct w90p910_keypad *keyp=
ad)
> +{
> + =A0 =A0 =A0 struct w90p910_keypad_platform_data *pdata =3D keypad->=
pdata;
> + =A0 =A0 =A0 struct input_dev *input_dev =3D keypad->input_dev;
> + =A0 =A0 =A0 unsigned int *key;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 key =3D &pdata->matrix_key_map[0];
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->matrix_key_map_size; i++, key+=
+) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int row =3D ((*key) >> 28) & 0xf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int col =3D ((*key) >> 24) & 0xf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int code =3D (*key) & 0xffffff;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad->matrix_keycodes[(row << 3) + co=
l] =3D code;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(code, input_dev->keybit);
> + =A0 =A0 =A0 }
> +
> +}
> +
> +static inline unsigned int lookup_matrix_keycode(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct w90p910_keypad *keypad, int row,=
 int col)
> +{
> + =A0 =A0 =A0 return keypad->matrix_keycodes[(row << 3) + col];
> +}
> +
> +static void w90p910_keypad_scan_matrix(struct w90p910_keypad *keypad=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int status)
> +{
> + =A0 =A0 =A0 unsigned int row, col, val;
> +
> + =A0 =A0 =A0 row =3D KGET_RAW(status);
> + =A0 =A0 =A0 col =3D KGET_COLUMN(status);
> +
> + =A0 =A0 =A0 val =3D lookup_matrix_keycode(keypad, row, col);
> +
> + =A0 =A0 =A0 input_report_key(keypad->input_dev, val, 1);
> +
> + =A0 =A0 =A0 input_sync(keypad->input_dev);
> +
> + =A0 =A0 =A0 input_report_key(keypad->input_dev, val, 0);
> +
> + =A0 =A0 =A0 input_sync(keypad->input_dev);
> +}
> +
> +static irqreturn_t w90p910_keypad_irq_handler(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct w90p910_keypad *keypad =3D dev_id;
> + =A0 =A0 =A0 unsigned int =A0kstatus, val;
> +
> + =A0 =A0 =A0 =A0kstatus =3D keypad_readl(KPI_STATUS);
> +
> + =A0 =A0 =A0 val =3D INTTR | IS1KEY;
> +
> + =A0 =A0 =A0 if (kstatus & val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 w90p910_keypad_scan_matrix(keypad, ksta=
tus);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int w90p910_keypad_open(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct w90p910_keypad *keypad =3D input_get_drvdata(dev=
);
> + =A0 =A0 =A0 struct w90p910_keypad_platform_data *pdata =3D keypad->=
pdata;
> + =A0 =A0 =A0 unsigned int val, config;
> +
> + =A0 =A0 =A0 /* Enable unit clock */
> + =A0 =A0 =A0 clk_enable(keypad->clk);
> +
> + =A0 =A0 =A0 val =3D keypad_readl(KPI_CONF);
> + =A0 =A0 =A0 val |=3D (KPSEL | ENKP);
> + =A0 =A0 =A0 val &=3D ~(KSIZE0 | KSIZE1);
> +
> + =A0 =A0 =A0 config =3D pdata->prescale | (pdata->debounce << DEBOUN=
CE_BIT);
> +
> + =A0 =A0 =A0 val |=3D config;
> +
> + =A0 =A0 =A0 keypad_writel(KPI_CONF, val);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void w90p910_keypad_close(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct w90p910_keypad *keypad =3D input_get_drvdata(dev=
);
> +
> + =A0 =A0 =A0 /* Disable clock unit */
> + =A0 =A0 =A0 clk_disable(keypad->clk);
> +}
> +
> +static int __devinit w90p910_keypad_probe(struct platform_device *pd=
ev)
> +{
> + =A0 =A0 =A0 struct w90p910_keypad *keypad;
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 int irq, error;
> +
> + =A0 =A0 =A0 keypad =3D kzalloc(sizeof(struct w90p910_keypad), GFP_K=
ERNEL);
> + =A0 =A0 =A0 if (keypad =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to allocate=
 driver data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad->pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 if (keypad->pdata =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no platform data d=
efined\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 irq =3D platform_get_irq(pdev, 0);
> + =A0 =A0 =A0 if (irq < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get keyp=
ad irq\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (res =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get I/O =
memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D request_mem_region(res->start, resource_size(re=
s), pdev->name);
> + =A0 =A0 =A0 if (res =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request =
I/O memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad->mmio_base =3D ioremap(res->start, resource_size=
(res));
> + =A0 =A0 =A0 if (keypad->mmio_base =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to remap I/=
O memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad->clk =3D clk_get(&pdev->dev, NULL);
> + =A0 =A0 =A0 if (IS_ERR(keypad->clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get keyp=
ad clock\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D PTR_ERR(keypad->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free_io;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Create and register the input driver. */
> + =A0 =A0 =A0 input_dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (!input_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to allocate=
 input device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_put_clk;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* set multi-function pin for w90p910 kpi. */
> + =A0 =A0 =A0 mfp_set_groupi(&pdev->dev);
> +
> + =A0 =A0 =A0 input_dev->name =3D pdev->name;
> + =A0 =A0 =A0 input_dev->id.bustype =3D BUS_HOST;
> + =A0 =A0 =A0 input_dev->open =3D w90p910_keypad_open;
> + =A0 =A0 =A0 input_dev->close =3D w90p910_keypad_close;
> + =A0 =A0 =A0 input_dev->dev.parent =3D &pdev->dev;
> +
> + =A0 =A0 =A0 keypad->input_dev =3D input_dev;
> + =A0 =A0 =A0 input_set_drvdata(input_dev, keypad);
> +
> + =A0 =A0 =A0 input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_=
REP);
> + =A0 =A0 =A0 w90p910_keypad_build_keycode(keypad);
> + =A0 =A0 =A0 platform_set_drvdata(pdev, keypad);
> +
> + =A0 =A0 =A0 error =3D request_irq(irq, w90p910_keypad_irq_handler, =
IRQF_DISABLED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->name, key=
pad);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request =
IRQ\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free_dev;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad->irq =3D irq;
> +
> + =A0 =A0 =A0 /* Register the input device */
> + =A0 =A0 =A0 error =3D input_register_device(input_dev);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to register=
 input device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +failed_free_irq:
> + =A0 =A0 =A0 free_irq(irq, pdev);
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> +failed_free_dev:
> + =A0 =A0 =A0 input_free_device(input_dev);
> +failed_put_clk:
> + =A0 =A0 =A0 clk_put(keypad->clk);
> +failed_free_io:
> + =A0 =A0 =A0 iounmap(keypad->mmio_base);
> +failed_free_mem:
> + =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
> +failed_free:
> + =A0 =A0 =A0 kfree(keypad);
> + =A0 =A0 =A0 return error;
> +}
> +
> +static int __devexit w90p910_keypad_remove(struct platform_device *p=
dev)
> +{
> + =A0 =A0 =A0 struct w90p910_keypad *keypad =3D platform_get_drvdata(=
pdev);
> + =A0 =A0 =A0 struct resource *res;
> +
> + =A0 =A0 =A0 free_irq(keypad->irq, pdev);
> +
> + =A0 =A0 =A0 clk_put(keypad->clk);
> +
> + =A0 =A0 =A0 input_unregister_device(keypad->input_dev);
> +
> + =A0 =A0 =A0 iounmap(keypad->mmio_base);
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 kfree(keypad);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver w90p910_keypad_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D w90p910_keypad_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(w90p910_keypad_=
remove),
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "w90p910-keypad",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init w90p910_keypad_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&w90p910_keypad_driver)=
;
> +}
> +
> +static void __exit w90p910_keypad_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&w90p910_keypad_driver);
> +}
> +
> +module_init(w90p910_keypad_init);
> +module_exit(w90p910_keypad_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("w90p910 keypad driver!");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:w90p910-keypad");
> --
> 1.5.6.3
>
>



--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
