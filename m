From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH] input: add mpr121 capacitive touchkey driver
Date: Tue, 12 Apr 2011 19:41:46 +0800
Message-ID: <BANLkTi=Dm2CXBDE1A9Lt_CjPcfrpMR0iuw@mail.gmail.com>
References: <1302541337-2934-1-git-send-email-kzjeef@gmail.com>
 <20110411232010.GC3579@lovely.krouter> <BANLkTimsN2ff53i9FYCoatRa+rAjamnMaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56227 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab1DLLmG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 07:42:06 -0400
Received: by pvg12 with SMTP id 12so2330439pvg.19
        for <linux-input@vger.kernel.org>; Tue, 12 Apr 2011 04:42:06 -0700 (PDT)
In-Reply-To: <BANLkTimsN2ff53i9FYCoatRa+rAjamnMaQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Zhang Jiejing <jiejing.zhang@freescale.com>

Hi Christoph,

I'm sorry for my poor English grammar.
I'll try to fix these typo, If still have error, please point me out.

2011/4/12 Christoph Fritz <chf.fritz@googlemail.com>
>
> Hi Zhang,
>
> =A0this is just a superficial review of your driver.
>
> thanks,
> =A0Christoph
>
> On Tue, Apr 12, 2011 at 01:02:17AM +0800, Jiejing Zhang wrote:
> > From: Zhang Jiejing <jiejing.zhang@freescale.com>
> >
> > This touchkey driver is based on Freescale mpr121 capacitive
> > touch sensor controller.
> >
> > It can support up to 12 keys, it use i2c interface.
>
> typo

-> It can supports up to 12 electrodes, and using i2c interface.
>
> >
> > The product infomation(data sheet, application notes) can
> > be found under this link:
> > http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMP=
R121
> >
> > Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
> > ---
> > =A0drivers/input/keyboard/Kconfig =A0| =A0 12 ++
> > =A0drivers/input/keyboard/Makefile | =A0 =A01 +
> > =A0drivers/input/keyboard/mpr121.c | =A0301 +++++++++++++++++++++++=
++++++++++++++++
> > =A0include/linux/i2c/mpr.h =A0 =A0 =A0 =A0 | =A0 64 ++++++++
> > =A04 files changed, 378 insertions(+), 0 deletions(-)
> > =A0create mode 100644 drivers/input/keyboard/mpr121.c
> > =A0create mode 100644 include/linux/i2c/mpr.h
> >
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboar=
d/Kconfig
> > index b16bed0..0666e1e 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -520,6 +520,18 @@ config KEYBOARD_XTKBD
> > =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the
> > =A0 =A0 =A0 =A0 module will be called xtkbd.
> >
> > +config KEYBOARD_MPR121
> > + =A0 =A0 tristate "Freescale MPR121 Touchkey Driver"
> > + =A0 =A0 depends on I2C
> > + =A0 =A0 help
> > + =A0 =A0 =A0 Say Y here if you have the =A0touchkey Freescale mpr1=
21 capacitive
>
> typo: two spaces

will fix.
>
> > + =A0 =A0 =A0 touch sensor controller in your system.
> > +
> > + =A0 =A0 =A0 If unsure, say N.
> > +
> > + =A0 =A0 =A0 To compile this driver as a module, choose M here
> > +endif
> > +
> > =A0config KEYBOARD_W90P910
> > =A0 =A0 =A0 tristate "W90P910 Matrix Keypad support"
> > =A0 =A0 =A0 depends on ARCH_W90X900
>
> - add: "To compile this driver as a module, choose M here: the
> =A0module will be called mpr121."
> - "endif" is wrong here, it breaks 'make config'
> - maybe a more alphabetic approach in this list of drivers would
> =A0be nice

yes. I will.
>
> > diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboa=
rd/Makefile
> > index 878e6c2..b110ca8 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -47,4 +47,5 @@ obj-$(CONFIG_KEYBOARD_TEGRA) =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0+=3D tegra-kbc.o
> > =A0obj-$(CONFIG_KEYBOARD_TNETV107X) =A0 =A0 +=3D tnetv107x-keypad.o
> > =A0obj-$(CONFIG_KEYBOARD_TWL4030) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D =
twl4030_keypad.o
> > =A0obj-$(CONFIG_KEYBOARD_XTKBD) =A0 =A0 =A0 =A0 +=3D xtkbd.o
> > +obj-$(CONFIG_KEYBOARD_MPR121) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D =
mpr121.o
> > =A0obj-$(CONFIG_KEYBOARD_W90P910) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D =
w90p910_keypad.o
>
> for better examination, please mind alphabetic order

will do.
>
> > diff --git a/drivers/input/keyboard/mpr121.c b/drivers/input/keyboa=
rd/mpr121.c
> > new file mode 100644
> > index 0000000..ee149a8
> > --- /dev/null
> > +++ b/drivers/input/keyboard/mpr121.c
> > @@ -0,0 +1,301 @@
> > +/*
> > + * Touchkey driver for Freescale MPR121 Controllor
> > + *
> > + * Copyright (C) 2011 Freescale Semiconductor, Inc.
> > + * Author: Zhang Jiejing <jiejing.zhang@freescale.com>
> > + *
> > + * Based on mcs_touchkey.c
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License version 2 =
as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/i2c.h>
> > +#include <linux/i2c/mpr.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/input.h>
> > +#include <linux/irq.h>
>
> do not use irq.h directly

ok.
>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/bitops.h>
> > +
> > +struct mpr121_touchkey_data {
> > + =A0 =A0 struct i2c_client =A0 =A0 =A0 *client;
> > + =A0 =A0 struct input_dev =A0 =A0 =A0 =A0*input_dev;
> > + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0key_val;
> > + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 statusbits;
> > + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keycount;
> > + =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keycodes[MPR1=
21_MAX_KEY_COUNT];
> > +};
> > +
> > +struct mpr121_init_register {
> > + =A0 =A0 int addr;
> > + =A0 =A0 u8 val;
> > +};
> > +
> > +static struct mpr121_init_register init_reg_table[] =3D {
> > + =A0 =A0 {MHD_RISING_ADDR, =A0 =A0 =A0 0x1},
> > + =A0 =A0 {NHD_RISING_ADDR, =A0 =A0 =A0 0x1},
> > + =A0 =A0 {MHD_FALLING_ADDR, =A0 =A0 =A00x1},
> > + =A0 =A0 {NHD_FALLING_ADDR, =A0 =A0 =A00x1},
> > + =A0 =A0 {NCL_FALLING_ADDR, =A0 =A0 =A00xff},
> > + =A0 =A0 {FDL_FALLING_ADDR, =A0 =A0 =A00x02},
> > + =A0 =A0 {FILTER_CONF_ADDR, =A0 =A0 =A00x04},
> > + =A0 =A0 {AFE_CONF_ADDR, =A0 =A0 =A0 =A0 0x0b},
> > + =A0 =A0 {AUTO_CONFIG_CTRL_ADDR, 0x0b},
> > +};
> > +
> > +static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
> > +{
> > + =A0 =A0 struct mpr121_touchkey_data *data =3D dev_id;
> > + =A0 =A0 struct i2c_client *client =3D data->client;
> > + =A0 =A0 struct input_dev *input =3D data->input_dev;
> > + =A0 =A0 unsigned int key_num, pressed;
> > + =A0 =A0 int reg;
> > +
> > + =A0 =A0 reg =3D i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS=
_1_ADDR);
> > + =A0 =A0 if (reg < 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "i2c read error [%d=
]\n", reg);
> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> > + =A0 =A0 }
> > +
> > + =A0 =A0 reg <<=3D 8;
> > + =A0 =A0 reg |=3D i2c_smbus_read_byte_data(client, ELE_TOUCH_STATU=
S_0_ADDR);
> > + =A0 =A0 if (reg < 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "i2c read error [%d=
]\n", reg);
> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> > + =A0 =A0 }
> > +
> > + =A0 =A0 reg &=3D TOUCH_STATUS_MASK;
> > + =A0 =A0 /* use old press bit to figure out which bit changed */
> > + =A0 =A0 key_num =3D ffs(reg ^ data->statusbits) - 1;
> > + =A0 =A0 /* use the bit check the press status */
>
> typo

this comment will remove.
>
> > + =A0 =A0 pressed =3D (reg & (1 << (key_num))) >> key_num;
> > + =A0 =A0 data->statusbits =3D reg;
> > + =A0 =A0 data->key_val =3D data->keycodes[key_num];
> > +
> > + =A0 =A0 input_event(input, EV_MSC, MSC_SCAN, data->key_val);
> > + =A0 =A0 input_report_key(input, data->key_val, pressed);
> > + =A0 =A0 input_sync(input);
> > +
> > + =A0 =A0 dev_dbg(&client->dev, "key %d %d %s\n", key_num, data->ke=
y_val,
> > + =A0 =A0 =A0 =A0 =A0 =A0 pressed ? "pressed" : "released");
> > +
> > +out:
> > + =A0 =A0 return IRQ_HANDLED;
> > +}
> > +
> > +static int mpr121_phys_init(struct mpr121_platform_data *pdata,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpr121_tou=
chkey_data *data,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct i2c_client=
 *client)
> > +{
> > + =A0 =A0 struct mpr121_init_register *reg;
> > + =A0 =A0 unsigned char usl, lsl, tl;
> > + =A0 =A0 int i, t, vdd, ret;
> > +
> > + =A0 =A0 /* setup touch/release threshold for ele0-ele11 */
> > + =A0 =A0 for (i =3D 0; i <=3D MPR121_MAX_KEY_COUNT; i++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 t =3D ELE0_TOUCH_THRESHOLD_ADDR + (i * 2)=
;
> > + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client,=
 t, TOUCH_THRESHOLD);
> > + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
> > + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client,=
 t + 1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 RELEASE_THRESHOLD);
> > + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
> > + =A0 =A0 }
> > + =A0 =A0 /* setup init register */
> > + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(init_reg_table); i++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &init_reg_table[i];
> > + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client,=
 reg->addr, reg->val);
> > + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
> > + =A0 =A0 }
> > + =A0 =A0 /* setup auto-register by vdd,the formula please ref: AN3=
889
> > + =A0 =A0 =A0* These register *must* set acrodding your VDD voltage=
 supply
> > + =A0 =A0 =A0* to the chip*/
>
> typo

is this right?
=A0=A0=A0 /* setup Auto Config Registers by VDD.
=A0=A0=A0 =A0* The formula was written in AN3889.
=A0=A0=A0 =A0* These registers *must* be set by VDD voltage.
=A0=A0=A0 =A0*/
>
> > + =A0 =A0 vdd =3D pdata->vdd_uv / 1000;
> > + =A0 =A0 usl =3D ((vdd - 700) * 256) / vdd;
> > + =A0 =A0 lsl =3D (usl * 65) / 100;
> > + =A0 =A0 tl =3D (usl * 90) / 100;
> > + =A0 =A0 ret =3D i2c_smbus_write_byte_data(client, AUTO_CONFIG_USL=
_ADDR, usl);
> > + =A0 =A0 ret |=3D i2c_smbus_write_byte_data(client, AUTO_CONFIG_LS=
L_ADDR, lsl);
> > + =A0 =A0 ret |=3D i2c_smbus_write_byte_data(client, AUTO_CONFIG_TL=
_ADDR, tl);
> > + =A0 =A0 ret |=3D i2c_smbus_write_byte_data(client, ELECTRODE_CONF=
_ADDR,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 data->keycount);
> > + =A0 =A0 if (ret !=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
> > +
> > + =A0 =A0 dev_info(&client->dev, "mpr121: config as enable %x of el=
ectrode.\n",
>
> typo ?

-> dev_dbg(&client->dev, "mpr121: setup with %x electrodes.\n",

>
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0data->keycount);
> > +
> > + =A0 =A0 return 0;
> > +
> > +err_i2c_write:
> > + =A0 =A0 dev_err(&client->dev, "i2c write error: %d\n", ret);
> > + =A0 =A0 return ret;
> > +}
> > +
> > +static int __devinit mpr_touchkey_probe(struct i2c_client *client,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct i2c_device_id *id)
> > +{
> > + =A0 =A0 struct mpr121_platform_data *pdata;
> > + =A0 =A0 struct mpr121_touchkey_data *data;
> > + =A0 =A0 struct input_dev *input_dev;
> > + =A0 =A0 int error;
> > + =A0 =A0 int i;
> > +
> > + =A0 =A0 pdata =3D client->dev.platform_data;
> > + =A0 =A0 if (!pdata) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "no platform data d=
efined\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > + =A0 =A0 }
> > +
> > + =A0 =A0 if (!client->irq) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "The irq number sho=
uld not be zero\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > + =A0 =A0 }
> > +
> > + =A0 =A0 data =3D kzalloc(sizeof(struct mpr121_touchkey_data), GFP=
_KERNEL);
> > + =A0 =A0 input_dev =3D input_allocate_device();
> > + =A0 =A0 if (!data || !input_dev) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Falied to allocate=
 memory\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
> > + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> > + =A0 =A0 }
> > +
> > + =A0 =A0 data->client =3D client;
> > + =A0 =A0 data->input_dev =3D input_dev;
> > + =A0 =A0 data->keycount =3D pdata->keycount;
> > +
> > + =A0 =A0 if (data->keycount > MPR121_MAX_KEY_COUNT) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Too many key defin=
ed\n");
>
> typo

-> dev_err(&client->dev, "too much keys defined\n");
>
> > + =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> > + =A0 =A0 }
> > +
> > + =A0 =A0 error =3D mpr121_phys_init(pdata, data, client);
> > + =A0 =A0 if (error) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to init reg=
ister\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> > + =A0 =A0 }
> > +
> > + =A0 =A0 i2c_set_clientdata(client, data);
> > +
> > + =A0 =A0 input_dev->name =3D "FSL MPR121 Touchkey";
> > + =A0 =A0 input_dev->id.bustype =3D BUS_I2C;
> > + =A0 =A0 input_dev->dev.parent =3D &client->dev;
> > + =A0 =A0 input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_RE=
P);
> > + =A0 =A0 input_dev->keycode =3D pdata->matrix;
> > + =A0 =A0 input_dev->keycodesize =3D sizeof(pdata->matrix[0]);
> > + =A0 =A0 input_dev->keycodemax =3D data->keycount;
> > +
> > + =A0 =A0 for (i =3D 0; i < input_dev->keycodemax; i++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(pdata->matrix[i], input_dev->ke=
ybit);
> > + =A0 =A0 =A0 =A0 =A0 =A0 data->keycodes[i] =3D pdata->matrix[i];
> > + =A0 =A0 }
> > +
> > + =A0 =A0 input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> > + =A0 =A0 input_set_drvdata(input_dev, data);
> > +
> > + =A0 =A0 error =3D request_threaded_irq(client->irq, NULL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mpr_touchkey_interrupt,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
IRQF_TRIGGER_FALLING,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
client->dev.driver->name, data);
> > + =A0 =A0 if (error) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to register=
 interrupt\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> > + =A0 =A0 }
> > +
> > + =A0 =A0 error =3D input_register_device(input_dev);
> > + =A0 =A0 if (error)
> > + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> > + =A0 =A0 i2c_set_clientdata(client, data);
> > + =A0 =A0 device_init_wakeup(&client->dev, pdata->wakeup);
> > + =A0 =A0 dev_info(&client->dev, "Mpr121 touch keyboard init succes=
s.\n");
> > + =A0 =A0 return 0;
> > +
> > +err_free_irq:
> > + =A0 =A0 free_irq(client->irq, data);
> > +err_free_mem:
> > + =A0 =A0 input_free_device(input_dev);
> > + =A0 =A0 kfree(data);
> > + =A0 =A0 return error;
> > +}
> > +
> > +static int __devexit mpr_touchkey_remove(struct i2c_client *client=
)
> > +{
> > + =A0 =A0 struct mpr121_touchkey_data *data =3D i2c_get_clientdata(=
client);
> > +
> > + =A0 =A0 free_irq(client->irq, data);
> > + =A0 =A0 input_unregister_device(data->input_dev);
> > + =A0 =A0 kfree(data);
> > +
> > + =A0 =A0 return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int mpr_suspend(struct device *dev)
> > +{
> > + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> > +
> > + =A0 =A0 if (device_may_wakeup(&client->dev))
> > + =A0 =A0 =A0 =A0 =A0 =A0 enable_irq_wake(client->irq);
> > +
> > + =A0 =A0 i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, 0x=
00);
> > +
> > + =A0 =A0 return 0;
> > +}
> > +
> > +static int mpr_resume(struct device *dev)
> > +{
> > + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> > + =A0 =A0 struct mpr121_touchkey_data *data =3D i2c_get_clientdata(=
client);
> > +
> > + =A0 =A0 if (device_may_wakeup(&client->dev))
> > + =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_wake(client->irq);
> > +
> > + =A0 =A0 i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, da=
ta->keycount);
> > +
> > + =A0 =A0 return 0;
> > +}
> > +#endif
> > +
> > +static const struct i2c_device_id mpr121_id[] =3D {
> > + =A0 =A0 {"mpr121_touchkey", 0},
> > + =A0 =A0 { }
> > +};
> > +
> > +static SIMPLE_DEV_PM_OPS(mpr121_touchkey_pm_ops, mpr_suspend, mpr_=
resume);
> > +
> > +static struct i2c_driver mpr_touchkey_driver =3D {
> > + =A0 =A0 .driver =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "mpr121",
> > + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> > + =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &mpr121_touchkey_pm_ops,
>
> I would add a ifdef CONFIG_PM_SLEEP
>
> > + =A0 =A0 },
> > + =A0 =A0 .id_table =A0 =A0 =A0 =3D mpr121_id,
> > + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D mpr_touchkey_probe,
> > + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(mpr_touchkey_remo=
ve),
> > +};
> > +
> > +static int __init mpr_touchkey_init(void)
> > +{
> > + =A0 =A0 return i2c_add_driver(&mpr_touchkey_driver);
> > +}
> > +
> > +static void __exit mpr_touchkey_exit(void)
> > +{
> > + =A0 =A0 i2c_del_driver(&mpr_touchkey_driver);
> > +}
> > +
> > +module_init(mpr_touchkey_init);
> > +module_exit(mpr_touchkey_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Zhang Jiejing <jiejing.zhang@freescale.com>");
> > +MODULE_DESCRIPTION("Touch Key driver for FSL MPR121 Chip");
> > diff --git a/include/linux/i2c/mpr.h b/include/linux/i2c/mpr.h
> > new file mode 100644
> > index 0000000..52d6e33
> > --- /dev/null
> > +++ b/include/linux/i2c/mpr.h
> > @@ -0,0 +1,64 @@
> > +/* mpr.h - Header file for Freescale mpr121 capacitive touch senso=
r
>
> no filename please

will do.
>
> > + * controllor */
> > +
> > +#ifndef MPR_H
> > +#define MPR_H
> > +
> > +/* Register definitions */
> > +#define ELE_TOUCH_STATUS_0_ADDR =A0 =A0 =A00x0
> > +#define ELE_TOUCH_STATUS_1_ADDR =A0 =A0 =A00X1
> > +#define MHD_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x2b
> > +#define NHD_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x2c
> > +#define NCL_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x2d
> > +#define FDL_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x2e
> > +#define MHD_FALLING_ADDR =A0 =A0 0x2f
> > +#define NHD_FALLING_ADDR =A0 =A0 0x30
> > +#define NCL_FALLING_ADDR =A0 =A0 0x31
> > +#define FDL_FALLING_ADDR =A0 =A0 0x32
> > +#define ELE0_TOUCH_THRESHOLD_ADDR =A0 =A00x41
> > +#define ELE0_RELEASE_THRESHOLD_ADDR =A00x42
> > +/* ELE0...ELE11's threshold will set in a loop */
>
> typo

-> /* ELE0...ELE11's threshold will be set in a loop */
>
> > +#define AFE_CONF_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x5c
> > +#define FILTER_CONF_ADDR =A0 =A0 =A0 =A0 =A0 =A0 0x5d
> > +
> > +/* ELECTRODE_CONF: this register is most important register, it
> > + * control how many of electrode is enabled. If you set this regis=
ter
> > + * to 0x0, it make the sensor going to suspend mode. Other value(l=
ow
> > + * bit is non-zero) will make the sensor into Run mode. =A0This re=
gister
> > + * should be write at last.
>
> typo

->=A0 * should be written in the end.

>
> > + */
> > +#define ELECTRODE_CONF_ADDR =A0 =A0 =A0 =A0 =A00x5e
> > +#define AUTO_CONFIG_CTRL_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x7b
> > +/* AUTO_CONFIG_USL: Upper Limit for auto baseline search, this
> > + * register is related to VDD supplied on your board, the value of
> > + * this register is calc by EQ: `((VDD-0.7)/VDD) * 256`.
>
> typo

->=A0 * this register is calculated by EQ: `((VDD-0.7)/VDD) * 256`.

>
> > + * AUTO_CONFIG_LSL: Low Limit of auto baseline search. This is 65%=
 of
> > + * USL AUTO_CONFIG_TL: The Traget Level of auto baseline search, T=
his
> > + * is 90% of USL =A0*/
>
> typo

->=A0 * USL AUTO_CONFIG_TL: The traget level of auto baseline search, i=
t is
->=A0 * 90% of USL */

>
> > +#define AUTO_CONFIG_USL_ADDR =A0 =A0 =A0 =A0 0x7d
> > +#define AUTO_CONFIG_LSL_ADDR =A0 =A0 =A0 =A0 0x7e
> > +#define AUTO_CONFIG_TL_ADDR =A0 =A0 =A0 =A0 =A00x7f
> > +
> > +/* Threshold of touch/release trigger */
> > +#define TOUCH_THRESHOLD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x0f
> > +#define RELEASE_THRESHOLD =A0 =A0 =A0 =A0 =A0 =A00x0a
> > +/* Mask Button bits of STATUS_0 & STATUS_1 register */
>
> and or bit-and?

don't need and or bit-and, it just means low 12 bits of status
register is touch key's status.
-> /* low 12 bits of status register is touch key's status */
>
> > +#define TOUCH_STATUS_MASK =A0 =A0 =A0 =A0 =A0 =A00xfff
> > +/* MPR121 have 12 electrodes */
> > +#define MPR121_MAX_KEY_COUNT =A0 =A0 =A0 =A0 12
> > +
> > +
> > +/**
> > + * @keycount: how many key maped
>
> typo: "keys" ?

->=A0 * @keycount: how many keys mapped
>
> > + * @vdd_uv: voltage of vdd supply the chip in uV
>
> - typo
> - uppercase for vdd

->=A0 * @vdd_uv: VDD voltage in uV

>
> > + * @matrix: maxtrix of keys
> > + * @wakeup: can key wake up system.
>
> typo

->=A0 * @wakeup: can wake up system or not
>
> > + */
> > +struct mpr121_platform_data {
> > + =A0 =A0 u16 keycount;
> > + =A0 =A0 u16 *matrix;
> > + =A0 =A0 int wakeup;
> > + =A0 =A0 int vdd_uv;
> > +};
> > +
> > +#endif
> > --
> > 1.7.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-inp=
ut" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
ln Tue, Apr 12, 2011 at 01:02:17AM +0800, Jiejing Zhang wrote:

:-(
sorry again for my horrible grammar.

Jiejing
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
