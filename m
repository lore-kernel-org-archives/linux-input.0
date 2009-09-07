From: Jinsung Yang <jsgood.yang@samsung.com>
Subject: RE: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
	series SoCs
Date: Mon, 07 Sep 2009 12:50:13 +0900
Message-ID: <001201ca2f6e$4e12e690$ea38b3b0$%yang@samsung.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
 <9c9fda240909062025h6400686ema7b5c64937168fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18392 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758765AbZIGDre convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Sep 2009 23:47:34 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPL007SV17BK1@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 12:47:35 +0900 (KST)
Received: from JSGOODMAIN ([12.23.109.106])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPL0054L17B4G@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 12:47:35 +0900 (KST)
In-reply-to: <9c9fda240909062025h6400686ema7b5c64937168fbc@mail.gmail.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>
Cc: linux-input@vger.kernel.org, laforge@gnumonks.org, ben-linux@fluff.org, =?utf-8?B?J+q5gOqyveydvC9BUOqwnOuwnO2MgC9FMy/sgrzshLHsoITsnpAn?= <ki0351.kim@samsung.com>, =?utf-8?B?J+q5gOq1reynhC9BUOqwnOuwnO2MgC9FNS/sgrzshLHsoITsnpAn?= <kgene.kim@samsung.com>

> -----Original Message-----
> From: kyungmin78@gmail.com [mailto:kyungmin78@gmail.com] On Behalf Of
> Kyungmin Park
> Sent: Monday, September 07, 2009 12:25 PM
> To: =EC=96=91=EC=A7=84=EC=84=B1
> Cc: linux-input@vger.kernel.org; laforge@gnumonks.org; ben-linux@fluf=
f.org;
> =EA=B9=80=EA=B2=BD=EC=9D=BC/AP=EA=B0=9C=EB=B0=9C=ED=8C=80/E3/=EC=82=BC=
=EC=84=B1=EC=A0=84=EC=9E=90; =EA=B9=80=EA=B5=AD=EC=A7=84/AP=EA=B0=9C=EB=
=B0=9C=ED=8C=80/E5/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90
> Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver fo=
r s3c
> series SoCs
>=20
> Hi,
>=20
> 2009/9/5 =EC=96=91=EC=A7=84=EC=84=B1 <jsgood.yang@samsung.com>:
> > This keypad driver supports Samsung s3c based SoCs such as s3c6410.
> > This driver is written with input device compatibles.
> >
> > Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
> > Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
> > ---
> >  drivers/input/keyboard/s3c-keypad.c |  468
> +++++++++++++++++++++++++++++++++++
> >  1 files changed, 468 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/input/keyboard/s3c-keypad.c
> >
> > diff --git a/drivers/input/keyboard/s3c-keypad.c
> b/drivers/input/keyboard/s3c-keypad.c
> > new file mode 100644
> > index 0000000..73b9a90
> > --- /dev/null
> > +++ b/drivers/input/keyboard/s3c-keypad.c
> > @@ -0,0 +1,468 @@
> > +/*
> > + * linux/drivers/input/keyboard/s3c_keypad.c
> > + *
> > + * Driver for Samsung SoC matrix keypad controller.
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License version 2 =
as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/input.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +
> > +#include <mach/hardware.h>
> > +#include <asm/irq.h>
> > +
> > +#include <plat/keypad.h>
> > +#include <plat/regs-keypad.h>
> > +
> > +#undef DEBUG
> > +
> > +static const unsigned char s3c_keycode[] =3D {
> > +       1, 2, KEY_1, KEY_Q, KEY_A, 6, 7, KEY_LEFT,
> > +       9, 10, KEY_2, KEY_W, KEY_S, KEY_Z, KEY_RIGHT, 16,
> > +       17, 18, KEY_3, KEY_E, KEY_D, KEY_X, 23, KEY_UP,
> > +       25, 26, KEY_4, KEY_R, KEY_F, KEY_C, 31, 32,
> > +       33, KEY_O, KEY_5, KEY_T, KEY_G, KEY_V, KEY_DOWN, KEY_BACKSP=
ACE,
> > +       KEY_P, KEY_0, KEY_6, KEY_Y, KEY_H, KEY_SPACE, 47, 48,
> > +       KEY_M, KEY_L, KEY_7, KEY_U, KEY_J, KEY_N, 55, KEY_ENTER,
> > +       KEY_LEFTSHIFT, KEY_9, KEY_8, KEY_I, KEY_K, KEY_B, 63, KEY_C=
OMMA,
> > +};
>=20
> Why do you use fixed keycode? Dose it provided from board specific
> platform? and If we want to use only 3 * 3 keypad then how do you
> handle this one?
>=20

That keycode array is just default value.
The input device layer supports EVIOCGKEYCODE and EVIOCSKEYCODE ioctls =
to change keymap by user application.

> > +
> > +struct s3c_keypad {
> > +       struct s3c_platform_keypad *pdata;
> > +       unsigned char keycodes[ARRAY_SIZE(s3c_keycode)];
>=20
> We don't need full keycode array here. It should be allocated with
> required size.
>=20
> > +       struct input_dev *dev;
> > +       struct timer_list timer;
> > +       void __iomem *regs;
> > +       struct clk *clk;
> > +       int irq;
> > +       int timer_enabled;
> > +       unsigned int prevmask_low;
> > +       unsigned int prevmask_high;
> > +       unsigned int keyifcon;
> > +       unsigned int keyiffc;
> > +};
> > +
> > +static int s3c_keypad_scan(struct s3c_keypad *keypad, u32 *keymask=
_low,
> > +                               u32 *keymask_high)
> > +{
> > +       struct s3c_platform_keypad *pdata =3D keypad->pdata;
> > +       int i, j =3D 0;
> > +       u32 cval, rval, cfg;
> > +
> > +       for (i =3D 0; i < pdata->nr_cols; i++) {
> > +               cval =3D readl(keypad->regs + S3C_KEYIFCOL);
> > +               cval |=3D S3C_KEYIF_COL_DMASK;
> > +               cval &=3D ~(1 << i);
> > +               writel(cval, keypad->regs + S3C_KEYIFCOL);
> > +               udelay(pdata->delay);
> > +
> > +               rval =3D ~(readl(keypad->regs + S3C_KEYIFROW)) &
> > +                       S3C_KEYIF_ROW_DMASK;
> > +
> > +               if ((i * pdata->nr_rows) < pdata->max_masks)
> > +                       *keymask_low |=3D (rval << (i * pdata->nr_r=
ows));
> > +               else {
> > +                       *keymask_high |=3D (rval << (j * pdata->nr_=
rows));
> > +                       j++;
> > +               }
> > +       }
> > +
> > +       cfg =3D readl(keypad->regs + S3C_KEYIFCOL);
> > +       cfg &=3D ~S3C_KEYIF_COL_MASK_ALL;
> > +       writel(cfg, keypad->regs + S3C_KEYIFCOL);
> > +
> > +       return 0;
> > +}
> > +
> > +static void s3c_keypad_timer_handler(unsigned long data)
> > +{
> > +       struct s3c_keypad *keypad =3D (struct s3c_keypad *)data;
> > +       struct s3c_platform_keypad *pdata =3D keypad->pdata;
> > +       struct input_dev *input =3D keypad->dev;
> > +       u32 keymask_low =3D 0, keymask_high =3D 0;
> > +       u32 press_mask_low, press_mask_high;
> > +       u32 release_mask_low, release_mask_high, code, cfg;
> > +       int i;
> > +
> > +       s3c_keypad_scan(keypad, &keymask_low, &keymask_high);
> > +
> > +       if (keymask_low !=3D keypad->prevmask_low) {
> > +               press_mask_low =3D ((keymask_low ^ keypad->prevmask=
_low) &
> > +                                       keymask_low);
> > +               release_mask_low =3D ((keymask_low ^ keypad->prevma=
sk_low) &
> > +                                       keypad->prevmask_low);
> > +
> > +               i =3D 0;
> > +               while (press_mask_low) {
> > +                       if (press_mask_low & 1) {
> > +                               code =3D keypad->keycodes[i];
> > +                               input_report_key(input, code, 1);
> > +                               dev_dbg(&input->dev, "low pressed: =
%d\n", i);
> > +                       }
> > +                       press_mask_low >>=3D 1;
> > +                       i++;
> > +               }
> > +
> > +               i =3D 0;
> > +               while (release_mask_low) {
> > +                       if (release_mask_low & 1) {
> > +                               code =3D keypad->keycodes[i];
> > +                               input_report_key(input, code, 0);
> > +                               dev_dbg(&input->dev, "low released =
: %d\n",
> i);
> > +                       }
> > +                       release_mask_low >>=3D 1;
> > +                       i++;
> > +               }
> > +               keypad->prevmask_low =3D keymask_low;
> > +       }
> > +
> > +       if (keymask_high !=3D keypad->prevmask_high) {
> > +               press_mask_high =3D ((keymask_high ^ keypad->prevma=
sk_high)
> &
> > +                                       keymask_high);
> > +               release_mask_high =3D ((keymask_high ^ keypad->prev=
mask_high)
> &
> > +                                       keypad->prevmask_high);
> > +
> > +               i =3D 0;
> > +               while (press_mask_high) {
> > +                       if (press_mask_high & 1) {
> > +                               code =3D keypad->keycodes[i + pdata=
-
> >max_masks];
> > +                               input_report_key(input, code, 1);
> > +                               dev_dbg(&input->dev, "high pressed:=
 %d %d\n",
> > +                                       keypad->keycodes[i + pdata-
> >max_masks],
> > +                                       i);
> > +                       }
> > +                       press_mask_high >>=3D 1;
> > +                       i++;
> > +               }
> > +
> > +               i =3D 0;
> > +               while (release_mask_high) {
> > +                       if (release_mask_high & 1) {
> > +                               code =3D keypad->keycodes[i + pdata=
-
> >max_masks];
> > +                               input_report_key(input, code, 0);
> > +                               dev_dbg(&input->dev, "high released=
: %d\n",
> > +                                       keypad->keycodes[i + pdata-
> >max_masks]);
> > +                       }
> > +                       release_mask_high >>=3D 1;
> > +                       i++;
> > +               }
> > +               keypad->prevmask_high =3D keymask_high;
> > +       }
> > +
> > +       if (keymask_low | keymask_high) {
> > +               mod_timer(&keypad->timer, jiffies + HZ / 10);
> > +       } else {
> > +               cfg =3D readl(keypad->regs + S3C_KEYIFCON);
> > +               cfg &=3D ~S3C_KEYIF_CON_MASK_ALL;
> > +               cfg |=3D (S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN |
> > +                               S3C_KEYIF_DF_EN | S3C_KEYIF_FC_EN);
> > +               writel(cfg, keypad->regs + S3C_KEYIFCON);
> > +
> > +               keypad->timer_enabled =3D 0;
> > +       }
> > +}
> > +
> > +static irqreturn_t s3c_keypad_irq(int irq, void *dev_id)
> > +{
> > +       struct s3c_keypad *keypad =3D dev_id;
> > +       u32 cfg;
> > +
> > +       /* disable keypad interrupt and schedule for keypad timer h=
andler
> */
> > +       cfg =3D readl(keypad->regs + S3C_KEYIFCON);
> > +       cfg &=3D ~(S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN);
> > +       writel(cfg, keypad->regs + S3C_KEYIFCON);
> > +
> > +       keypad->timer.expires =3D jiffies + (HZ / 100);
> > +       if (keypad->timer_enabled) {
> > +               mod_timer(&keypad->timer, keypad->timer.expires);
> > +       } else {
> > +               add_timer(&keypad->timer);
> > +               keypad->timer_enabled =3D 1;
> > +       }
> > +
> > +       /* clear the keypad interrupt status */
> > +       writel(S3C_KEYIF_STSCLR_CLEAR, keypad->regs + S3C_KEYIFSTSC=
LR);
> > +
> > +       return IRQ_HANDLED;
> > +}
>=20
> Why do you use timer. As other input drivers how about to use workque=
ue?
>=20
> > +
> > +static int s3c_keypad_open(struct input_dev *dev)
> > +{
> > +       struct s3c_keypad *keypad =3D input_get_drvdata(dev);
> > +       u32 cfg;
> > +
> > +       clk_enable(keypad->clk);
> > +
> > +       /* init keypad h/w block */
> > +       cfg =3D readl(keypad->regs + S3C_KEYIFCON);
> > +       cfg &=3D ~S3C_KEYIF_CON_MASK_ALL;
> > +       cfg |=3D (S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN |
> > +                       S3C_KEYIF_DF_EN | S3C_KEYIF_FC_EN);
> > +       writel(cfg, keypad->regs + S3C_KEYIFCON);
> > +
> > +       cfg =3D readl(keypad->regs + S3C_KEYIFFC);
> > +       cfg |=3D 0x1;
>=20
> What's the meaning of '0x1'?
>=20
> > +       writel(cfg, keypad->regs + S3C_KEYIFFC);
> > +
> > +       cfg =3D readl(keypad->regs + S3C_KEYIFCOL);
> > +       cfg &=3D ~S3C_KEYIF_COL_MASK_ALL;
> > +       writel(cfg, keypad->regs + S3C_KEYIFCOL);
> > +
> > +       /* Scan timer init */
> > +       init_timer(&keypad->timer);
> > +       keypad->timer.function =3D s3c_keypad_timer_handler;
> > +       keypad->timer.data =3D (unsigned long)keypad;
> > +       keypad->timer.expires =3D jiffies + (HZ / 10);
> > +
> > +       if (keypad->timer_enabled) {
> > +               mod_timer(&keypad->timer, keypad->timer.expires);
> > +       } else {
>=20
> useless curly braces
>=20
> > +               add_timer(&keypad->timer);
> > +               keypad->timer_enabled =3D 1;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void s3c_keypad_close(struct input_dev *dev)
> > +{
> > +       struct s3c_keypad *keypad =3D input_get_drvdata(dev);
> > +
> > +       clk_disable(keypad->clk);
> > +}
> > +
> > +#define res_size(res)  ((res)->end - (res)->start + 1)
> > +
> > +static int __devinit s3c_keypad_probe(struct platform_device *pdev=
)
> > +{
> > +       struct s3c_platform_keypad *pdata;
> > +       struct s3c_keypad *keypad;
> > +       struct input_dev *input;
> > +       struct resource *res;
> > +       int irq, error, i;
> > +
> > +       pdata =3D pdev->dev.platform_data;
> > +       if (pdata =3D=3D NULL) {
> > +               dev_err(&pdev->dev, "no platform data\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       keypad =3D kzalloc(sizeof(struct s3c_keypad), GFP_KERNEL);
> > +       if (keypad =3D=3D NULL) {
> > +               dev_err(&pdev->dev, "failed to allocate driver data=
\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       keypad->pdata =3D pdata;
> > +       memcpy(keypad->keycodes, s3c_keycode, sizeof(keypad->keycod=
es));
>=20
> memcpy??? if you don't modify s3c_keycode. just assign it.
>=20
> > +
> > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (res =3D=3D NULL) {
> > +               dev_err(&pdev->dev, "failed to get I/O memory\n");
> > +               error =3D -ENXIO;
> > +               goto err_get_io;
> > +       }
> > +
> > +       res =3D request_mem_region(res->start, res_size(res), pdev-=
>name);
> > +       if (res =3D=3D NULL) {
> > +               dev_err(&pdev->dev, "failed to request I/O memory\n=
");
> > +               error =3D -EBUSY;
> > +               goto err_get_io;
> > +       }
> > +
> > +       keypad->regs =3D ioremap(res->start, res_size(res));
> > +       if (keypad->regs =3D=3D NULL) {
> > +               dev_err(&pdev->dev, "failed to remap I/O memory\n")=
;
> > +               error =3D -ENXIO;
> > +               goto err_map_io;
> > +       }
> > +
> > +       keypad->clk =3D clk_get(&pdev->dev, "keypad");
> > +       if (IS_ERR(keypad->clk)) {
> > +               dev_err(&pdev->dev, "failed to get keypad clock\n")=
;
> > +               error =3D PTR_ERR(keypad->clk);
> > +               goto err_clk;
> > +       }
> > +
> > +       /* Create and register the input driver. */
> > +       input =3D input_allocate_device();
> > +       if (!input) {
> > +               dev_err(&pdev->dev, "failed to allocate input devic=
e\n");
> > +               error =3D -ENOMEM;
> > +               goto err_alloc_input;
> > +       }
> > +
> > +       input->name =3D pdev->name;
> > +       input->id.bustype =3D BUS_HOST;
> > +       input->open =3D s3c_keypad_open;
> > +       input->close =3D s3c_keypad_close;
> > +       input->dev.parent =3D &pdev->dev;
> > +       input->keycode =3D (void *)keypad->keycodes;
> > +       input->keycodesize =3D sizeof(keypad->keycodes[0]);
> > +       input->keycodemax =3D ARRAY_SIZE(keypad->keycodes);
> > +
> > +       keypad->dev =3D input;
> > +
> > +       input_set_drvdata(input, keypad);
> > +
> > +       __set_bit(EV_KEY, input->evbit);
> > +       __set_bit(EV_REP, input->evbit);
> > +
> > +       for (i =3D 0; i < pdata->max_keys; i++) {
> > +               keypad->keycodes[i] =3D s3c_keycode[i];
> > +               if (keypad->keycodes[i] <=3D 0)
> > +                       continue;
> > +
> > +               __set_bit(keypad->keycodes[i] & KEY_MAX, input->key=
bit);
> > +       }
> > +
> > +       irq =3D platform_get_irq(pdev, 0);
> > +       if (irq < 0) {
> > +               dev_err(&pdev->dev, "failed to get keypad irq\n");
> > +               error =3D -ENXIO;
> > +               goto err_get_irq;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, keypad);
> > +
> > +       error =3D request_irq(irq, s3c_keypad_irq, IRQF_DISABLED,
> > +                           pdev->name, keypad);
> > +       if (error) {
> > +               dev_err(&pdev->dev, "failed to request IRQ\n");
> > +               goto err_req_irq;
> > +       }
> > +
> > +       keypad->irq =3D irq;
> > +
> > +       /* Register the input device */
> > +       error =3D input_register_device(input);
> > +       if (error) {
> > +               dev_err(&pdev->dev, "failed to register input devic=
e\n");
> > +               goto err_reg_input;
> > +       }
> > +
> > +       device_init_wakeup(&pdev->dev, 1);
> > +       dev_info(&pdev->dev, "Samsung Keypad Interface driver\n");
> > +
> > +       return 0;
> > +
> > +err_reg_input:
> > +       free_irq(irq, pdev);
> > +
> > +err_req_irq:
> > +       platform_set_drvdata(pdev, NULL);
> > +
> > +err_get_irq:
> > +       input_free_device(input);
> > +
> > +err_alloc_input:
> > +       clk_put(keypad->clk);
> > +
> > +err_clk:
> > +       iounmap(keypad->regs);
> > +
> > +err_map_io:
> > +       release_mem_region(res->start, res_size(res));
> > +
> > +err_get_io:
> > +       kfree(keypad);
> > +
> > +       return error;
> > +}
> > +
> > +static int __devexit s3c_keypad_remove(struct platform_device *pde=
v)
> > +{
> > +       struct s3c_keypad *keypad =3D platform_get_drvdata(pdev);
> > +       struct resource *res;
> > +
> > +       free_irq(keypad->irq, pdev);
> > +
> > +       clk_disable(keypad->clk);
> > +       clk_put(keypad->clk);
> > +
> > +       input_unregister_device(keypad->dev);
> > +       input_free_device(keypad->dev);
> > +
> > +       iounmap(keypad->regs);
> > +
> > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       release_mem_region(res->start, res_size(res));
> > +
> > +       platform_set_drvdata(pdev, NULL);
> > +       kfree(keypad);
> > +
> > +       return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int s3c_keypad_suspend(struct platform_device *dev, pm_mess=
age_t
> state)
> > +{
> > +       struct s3c_keypad *keypad =3D platform_get_drvdata(pdev);
> > +
> > +       keypad->keyifcon =3D readl(keypad->regs + S3C_KEYIFCON);
> > +       keypad->keyiffc =3D readl(keypad->regs + S3C_KEYIFFC);
> > +
> > +       disable_irq(IRQ_KEYPAD);
> > +       clk_disable(keypad->clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static int s3c_keypad_resume(struct platform_device *dev)
> > +{
> > +       struct s3c_keypad *keypad =3D platform_get_drvdata(pdev);
> > +
> > +       clk_enable(keypad->clock);
> > +
> > +       writel(keypad->keyifcon, keypad->regs + S3C_KEYIFCON);
> > +       writel(keypad->keyiffc, keypad->regs + S3C_KEYIFFC);
> > +
> > +       enable_irq(IRQ_KEYPAD);
> > +
> > +       return 0;
> > +}
> > +#else
> > +#define s3c_keypad_suspend NULL
> > +#define s3c_keypad_resume  NULL
> > +#endif /* CONFIG_PM */
> > +
> > +static struct platform_driver s3c_keypad_driver =3D {
> > +       .probe          =3D s3c_keypad_probe,
> > +       .remove         =3D s3c_keypad_remove,
> > +       .suspend        =3D s3c_keypad_suspend,
> > +       .resume         =3D s3c_keypad_resume,
> > +       .driver         =3D {
> > +               .owner  =3D THIS_MODULE,
> > +               .name   =3D "s3c-keypad",
> > +       },
> > +};
> > +
> > +static int __init s3c_keypad_init(void)
> > +{
> > +       return platform_driver_register(&s3c_keypad_driver);
> > +}
> > +
> > +static void __exit s3c_keypad_exit(void)
> > +{
> > +       platform_driver_unregister(&s3c_keypad_driver);
> > +}
> > +
> > +module_init(s3c_keypad_init);
> > +module_exit(s3c_keypad_exit);
> > +
> > +MODULE_AUTHOR("Kyeongil, Kim <ki0351.kim@samsung.com>");
> > +MODULE_AUTHOR("Jinsung, Yang <jsgood.yang@samsung.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Keypad interface for Samsung SoC");
> > +
>=20
> Finally,
> We did duplicated works. We already implement the keypad driver for
> s5pc100 & s5pc110. but we use workqueue structure instead of timer.
>=20
> I will post the our works.
>=20
> Thank you,
> Kyungmin Park

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
