From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: Add keypad support for w90p910 evb
Date: Wed, 8 Jul 2009 16:02:25 +0530
Message-ID: <5d5443650907080332t4156cabdu267d28c6c486f372@mail.gmail.com>
References: <4A546443.9030907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f193.google.com ([209.85.221.193]:33994 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbZGHKca convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2009 06:32:30 -0400
Received: by qyk31 with SMTP id 31so5244122qyk.33
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2009 03:32:29 -0700 (PDT)
In-Reply-To: <4A546443.9030907@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Hi Wan ZongShun,

>
>
> Add keypad driver for w90p910 evb.

This commit text not sufficient to describe this driver. Please add mor=
e detail.

> +config KEYBOARD_W90P910
> + =A0 =A0 =A0 tristate "W90P910 Matrix Keypad support"
> + =A0 =A0 =A0 depends on ARCH_W90X900
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here to enable the matrix keypad on the W90P9=
10 evb.

EVB? Evaluation Board? If yes, please write evaluation board instead,
and I hope it should even work with other boards designed with this
core.

> diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/=
keyboard/w90p910_keypad.c
> new file mode 100644
> index 0000000..e8dfcc8
> --- /dev/null
> +++ b/drivers/input/keyboard/w90p910_keypad.c
> @@ -0,0 +1,315 @@
> +/*
> + * Copyright (c) 2008 Nuvoton technology corporation.
> + *

Want to update this to 2008-2009 ?

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
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>

Why map.h?

> +
> +#include <mach/hardware.h>
> +#include <mach/w90p910_keypad.h>
> +#include <mach/regs-clock.h>

Do you need this regs-clock.h and hardware.h?

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
> +#define RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00
> +#define PRESCALE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xfa
> +#define DEBOUNCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x50 << 8)
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
> +#define res_size(res) =A0 =A0 =A0 =A0 =A0((res)->end - (res)->start =
+ 1)
> +

Use resource_size please.

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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(code, input_dev->keybit);

__set_bit please.

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

So, we don't get interrupt on key release?

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
> + =A0 =A0 =A0 unsigned int val;
> +
> + =A0 =A0 =A0 /* Enable unit clock */
> + =A0 =A0 =A0 clk_enable(keypad->clk);
> +
> + =A0 =A0 =A0 keypad_writel(KPI_CONF, RESET);
> + =A0 =A0 =A0 keypad_writel(KPI_3KCONF, RESET);
> + =A0 =A0 =A0 keypad_writel(KPI_LPCONF, RESET);
> + =A0 =A0 =A0 keypad_writel(KPI_STATUS, RESET);
> +
> + =A0 =A0 =A0 val =3D keypad_readl(KPI_CONF);
> + =A0 =A0 =A0 val |=3D (PRESCALE | DEBOUNCE | KPSEL | ENKP);

Care to make someof  this configurable through platform data? May be
debounce and prescale can be configured.

> + =A0 =A0 =A0 val &=3D ~(KSIZE0 | KSIZE1);
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

So this controller doesn't support putting controller FSM into IDLE
state by writing some bits into it or is it doing auto-sleep?

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
> + =A0 =A0 =A0 res =3D request_mem_region(res->start, res_size(res), p=
dev->name);
> + =A0 =A0 =A0 if (res =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request =
I/O memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad->mmio_base =3D ioremap(res->start, res_size(res)=
);
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

Could you please point me to implementation of this API? I believe
this is pin-multiplexing code.

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

EV_REP can be done as per platform data, but not a problem to enable
by default if keypad controller itself is not supporting it.

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
> + =A0 =A0 =A0 release_mem_region(res->start, res_size(res));
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
> + =A0 =A0 =A0 clk_disable(keypad->clk);
> + =A0 =A0 =A0 clk_put(keypad->clk);
> +
> + =A0 =A0 =A0 input_unregister_device(keypad->input_dev);
> + =A0 =A0 =A0 input_free_device(keypad->input_dev);

input_free_device not needed after input_unregister_device.

> +
> + =A0 =A0 =A0 iounmap(keypad->mmio_base);
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 release_mem_region(res->start, res_size(res));
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

Care to add suspend/resume support?

> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "w90p910-keypad",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
