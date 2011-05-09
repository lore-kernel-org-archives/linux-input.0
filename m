From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH v4] input: keyboard: FSL MPR121 capacitive touch button.
Date: Mon, 9 May 2011 18:29:33 +0800
Message-ID: <BANLkTim8VT5sMbSRQ8dYarD4vj8hrDJrUg@mail.gmail.com>
References: <1302748933-25935-1-git-send-email-jiejing.zhang@freescale.com> <20110503164024.GA27903@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56707 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1EIK3y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 May 2011 06:29:54 -0400
Received: by vxi39 with SMTP id 39so5598394vxi.19
        for <linux-input@vger.kernel.org>; Mon, 09 May 2011 03:29:54 -0700 (PDT)
In-Reply-To: <20110503164024.GA27903@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org, Christoph Fritz <chf.fritz@googlemail.com>

Hi Dmitry,

After test, this patch works fine, please queue this to .40.

Thanks!

Best regards,
Zhang Jiejing


2011/5/4 Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Hi Zhang,
>
> On Thu, Apr 14, 2011 at 10:42:13AM +0800, Zhang Jiejing wrote:
> > This patch adds basic support for Freescale MPR121 capacitive touch
> > sensor.
> > It's an i2c controller with up to 12 capacitance sensing inputs.
> >
> > Product information (data sheet, application notes) can be found he=
re:
> > http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMP=
R121
> >
> > Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
>
> I reviewed the driver and it looks like my original suggestion of usi=
ng
> matrix keypad infrastructure does not really work for this driver as =
it
> doers not use a matrix but simply has 12 discrete sensors. So I remov=
ed
> that code and made couple of other adjustments. Could you please tell=
 me
> if the patch below still works on your hardware and if it does I'll
> queue the dirver for 2.6.40.
>
> Thanks!
>
> --
> Dmitry
>
>
> Input: add driver FSL MPR121 capacitive touch sensor
>
> From: Zhang Jiejing <jiejing.zhang@freescale.com>
>
> This patch adds basic support for Freescale MPR121 capacitive touch
> sensor. =A0It's an i2c controller with up to 12 capacitance sensing i=
nputs.
>
> Product information (data sheet, application notes) can be found here=
:
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMPR1=
21
>
> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 12 +
> =A0drivers/input/keyboard/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01
> =A0drivers/input/keyboard/mpr121_touchkey.c | =A0339 ++++++++++++++++=
++++++++++++++
> =A0include/linux/i2c/mpr121_touchkey.h =A0 =A0 =A0| =A0 20 ++
> =A04 files changed, 372 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/input/keyboard/mpr121_touchkey.c
> =A0create mode 100644 include/linux/i2c/mpr121_touchkey.h
>
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index ed43f38..ea9a821 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -325,6 +325,18 @@ config KEYBOARD_MCS
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called mcs_touchkey.
>
> +config KEYBOARD_MPR121
> + =A0 =A0 =A0 tristate "Freescale MPR121 Touchkey"
> + =A0 =A0 =A0 depends on I2C
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here if you have Freescale MPR121 touchkey co=
ntroller
> + =A0 =A0 =A0 =A0 chip in your system.
> +
> + =A0 =A0 =A0 =A0 If unsure, say N.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the
> + =A0 =A0 =A0 =A0 module will be called mpr121_touchkey.
> +
> =A0config KEYBOARD_IMX
> =A0 =A0 =A0 =A0tristate "IMX keypad support"
> =A0 =A0 =A0 =A0depends on ARCH_MXC
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard=
/Makefile
> index 874bf52..883a0dd 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_MAPLE) =A0 =A0 =A0 =A0 =A0+=3D=
 maple_keyb.o
> =A0obj-$(CONFIG_KEYBOARD_MATRIX) =A0 =A0 =A0 =A0 =A0+=3D matrix_keypa=
d.o
> =A0obj-$(CONFIG_KEYBOARD_MAX7359) =A0 =A0 =A0 =A0 +=3D max7359_keypad=
=2Eo
> =A0obj-$(CONFIG_KEYBOARD_MCS) =A0 =A0 =A0 =A0 =A0 =A0 +=3D mcs_touchk=
ey.o
> +obj-$(CONFIG_KEYBOARD_MPR121) =A0 =A0 =A0 =A0 =A0+=3D mpr121_touchke=
y.o
> =A0obj-$(CONFIG_KEYBOARD_NEWTON) =A0 =A0 =A0 =A0 =A0+=3D newtonkbd.o
> =A0obj-$(CONFIG_KEYBOARD_NOMADIK) =A0 =A0 =A0 =A0 +=3D nomadik-ske-ke=
ypad.o
> =A0obj-$(CONFIG_KEYBOARD_OMAP) =A0 =A0 =A0 =A0 =A0 =A0+=3D omap-keypa=
d.o
> diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input=
/keyboard/mpr121_touchkey.c
> new file mode 100644
> index 0000000..0a9e811
> --- /dev/null
> +++ b/drivers/input/keyboard/mpr121_touchkey.c
> @@ -0,0 +1,339 @@
> +/*
> + * Touchkey driver for Freescale MPR121 Controllor
> + *
> + * Copyright (C) 2011 Freescale Semiconductor, Inc.
> + * Author: Zhang Jiejing <jiejing.zhang@freescale.com>
> + *
> + * Based on mcs_touchkey.c
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c/mpr121_touchkey.h>
> +
> +/* Register definitions */
> +#define ELE_TOUCH_STATUS_0_ADDR =A0 =A0 =A0 =A00x0
> +#define ELE_TOUCH_STATUS_1_ADDR =A0 =A0 =A0 =A00X1
> +#define MHD_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2b
> +#define NHD_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2c
> +#define NCL_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2d
> +#define FDL_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2e
> +#define MHD_FALLING_ADDR =A0 =A0 =A0 0x2f
> +#define NHD_FALLING_ADDR =A0 =A0 =A0 0x30
> +#define NCL_FALLING_ADDR =A0 =A0 =A0 0x31
> +#define FDL_FALLING_ADDR =A0 =A0 =A0 0x32
> +#define ELE0_TOUCH_THRESHOLD_ADDR =A0 =A0 =A00x41
> +#define ELE0_RELEASE_THRESHOLD_ADDR =A0 =A00x42
> +#define AFE_CONF_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x5c
> +#define FILTER_CONF_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x5d
> +
> +/*
> + * ELECTRODE_CONF_ADDR: This register configures the number of
> + * enabled capacitance sensing inputs and its run/suspend mode.
> + */
> +#define ELECTRODE_CONF_ADDR =A0 =A0 =A0 =A0 =A0 =A00x5e
> +#define AUTO_CONFIG_CTRL_ADDR =A0 =A0 =A0 =A0 =A00x7b
> +#define AUTO_CONFIG_USL_ADDR =A0 =A0 =A0 =A0 =A0 0x7d
> +#define AUTO_CONFIG_LSL_ADDR =A0 =A0 =A0 =A0 =A0 0x7e
> +#define AUTO_CONFIG_TL_ADDR =A0 =A0 =A0 =A0 =A0 =A00x7f
> +
> +/* Threshold of touch/release trigger */
> +#define TOUCH_THRESHOLD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x0f
> +#define RELEASE_THRESHOLD =A0 =A0 =A0 =A0 =A0 =A0 =A00x0a
> +/* Masks for touch and release triggers */
> +#define TOUCH_STATUS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A00xfff
> +/* MPR121 has 12 keys */
> +#define MPR121_MAX_KEY_COUNT =A0 =A0 =A0 =A0 =A0 12
> +
> +struct mpr121_touchkey {
> + =A0 =A0 =A0 struct i2c_client =A0 =A0 =A0 *client;
> + =A0 =A0 =A0 struct input_dev =A0 =A0 =A0 =A0*input_dev;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0key_val;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0statusbits;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0keycount;
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keycodes[MP=
R121_MAX_KEY_COUNT];
> +};
> +
> +struct mpr121_init_register {
> + =A0 =A0 =A0 int addr;
> + =A0 =A0 =A0 u8 val;
> +};
> +
> +static const struct mpr121_init_register init_reg_table[] __devinitc=
onst =3D {
> + =A0 =A0 =A0 { MHD_RISING_ADDR, =A0 =A0 =A00x1 },
> + =A0 =A0 =A0 { NHD_RISING_ADDR, =A0 =A0 =A00x1 },
> + =A0 =A0 =A0 { MHD_FALLING_ADDR, =A0 =A0 0x1 },
> + =A0 =A0 =A0 { NHD_FALLING_ADDR, =A0 =A0 0x1 },
> + =A0 =A0 =A0 { NCL_FALLING_ADDR, =A0 =A0 0xff },
> + =A0 =A0 =A0 { FDL_FALLING_ADDR, =A0 =A0 0x02 },
> + =A0 =A0 =A0 { FILTER_CONF_ADDR, =A0 =A0 0x04 },
> + =A0 =A0 =A0 { AFE_CONF_ADDR, =A0 =A0 =A0 =A00x0b },
> + =A0 =A0 =A0 { AUTO_CONFIG_CTRL_ADDR, 0x0b },
> +};
> +
> +static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct mpr121_touchkey *mpr121 =3D dev_id;
> + =A0 =A0 =A0 struct i2c_client *client =3D mpr121->client;
> + =A0 =A0 =A0 struct input_dev *input =3D mpr121->input_dev;
> + =A0 =A0 =A0 unsigned int key_num, key_val, pressed;
> + =A0 =A0 =A0 int reg;
> +
> + =A0 =A0 =A0 reg =3D i2c_smbus_read_byte_data(client, ELE_TOUCH_STAT=
US_1_ADDR);
> + =A0 =A0 =A0 if (reg < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "i2c read error [=
%d]\n", reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 reg <<=3D 8;
> + =A0 =A0 =A0 reg |=3D i2c_smbus_read_byte_data(client, ELE_TOUCH_STA=
TUS_0_ADDR);
> + =A0 =A0 =A0 if (reg < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "i2c read error [=
%d]\n", reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 reg &=3D TOUCH_STATUS_MASK;
> + =A0 =A0 =A0 /* use old press bit to figure out which bit changed */
> + =A0 =A0 =A0 key_num =3D ffs(reg ^ mpr121->statusbits) - 1;
> + =A0 =A0 =A0 pressed =3D reg & (1 << key_num);
> + =A0 =A0 =A0 mpr121->statusbits =3D reg;
> +
> + =A0 =A0 =A0 key_val =3D mpr121->keycodes[key_num];
> +
> + =A0 =A0 =A0 input_event(input, EV_MSC, MSC_SCAN, key_num);
> + =A0 =A0 =A0 input_report_key(input, key_val, pressed);
> + =A0 =A0 =A0 input_sync(input);
> +
> + =A0 =A0 =A0 dev_dbg(&client->dev, "key %d %d %s\n", key_num, key_va=
l,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressed ? "pressed" : "released");
> +
> +out:
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int __devinit mpr121_phys_init(const struct mpr121_platform_d=
ata *pdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct mpr121_touchkey *mpr121,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct i2c_client *client)
> +{
> + =A0 =A0 =A0 const struct mpr121_init_register *reg;
> + =A0 =A0 =A0 unsigned char usl, lsl, tl;
> + =A0 =A0 =A0 int i, t, vdd, ret;
> +
> + =A0 =A0 =A0 /* Set up touch/release threshold for ele0-ele11 */
> + =A0 =A0 =A0 for (i =3D 0; i <=3D MPR121_MAX_KEY_COUNT; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t =3D ELE0_TOUCH_THRESHOLD_ADDR + (i * =
2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(clien=
t, t, TOUCH_THRESHOLD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(clien=
t, t + 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 RELEASE_THRESHOLD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set up init register */
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(init_reg_table); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &init_reg_table[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(clien=
t, reg->addr, reg->val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
> + =A0 =A0 =A0 }
> +
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Capacitance on sensing input varies and needs to b=
e compensated.
> + =A0 =A0 =A0 =A0* The internal MPR121-auto-configuration can do this=
 if it's
> + =A0 =A0 =A0 =A0* registers are set properly (based on pdata->vdd_uv=
).
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 vdd =3D pdata->vdd_uv / 1000;
> + =A0 =A0 =A0 usl =3D ((vdd - 700) * 256) / vdd;
> + =A0 =A0 =A0 lsl =3D (usl * 65) / 100;
> + =A0 =A0 =A0 tl =3D (usl * 90) / 100;
> + =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client, AUTO_CONFIG_U=
SL_ADDR, usl);
> + =A0 =A0 =A0 ret |=3D i2c_smbus_write_byte_data(client, AUTO_CONFIG_=
LSL_ADDR, lsl);
> + =A0 =A0 =A0 ret |=3D i2c_smbus_write_byte_data(client, AUTO_CONFIG_=
TL_ADDR, tl);
> + =A0 =A0 =A0 ret |=3D i2c_smbus_write_byte_data(client, ELECTRODE_CO=
NF_ADDR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0mpr121->keycount);
> + =A0 =A0 =A0 if (ret !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
> +
> + =A0 =A0 =A0 dev_dbg(&client->dev, "set up with %x keys.\n", mpr121-=
>keycount);
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_i2c_write:
> + =A0 =A0 =A0 dev_err(&client->dev, "i2c write error: %d\n", ret);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __devinit mpr_touchkey_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 const struct i2c_device_id *id)
> +{
> + =A0 =A0 =A0 const struct mpr121_platform_data *pdata =3D client->de=
v.platform_data;
> + =A0 =A0 =A0 struct mpr121_touchkey *mpr121;
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 int error;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "no platform data=
 defined\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!pdata->keymap || !pdata->keymap_size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "missing keymap d=
ata\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pdata->keymap_size > MPR121_MAX_KEY_COUNT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "too many keys de=
fined\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!client->irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "irq number shoul=
d not be zero\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mpr121 =3D kzalloc(sizeof(struct mpr121_touchkey), GFP_=
KERNEL);
> + =A0 =A0 =A0 input_dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (!mpr121 || !input_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to alloca=
te memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mpr121->client =3D client;
> + =A0 =A0 =A0 mpr121->input_dev =3D input_dev;
> + =A0 =A0 =A0 mpr121->keycount =3D pdata->keymap_size;
> +
> + =A0 =A0 =A0 input_dev->name =3D "Freescale MPR121 Touchkey";
> + =A0 =A0 =A0 input_dev->id.bustype =3D BUS_I2C;
> + =A0 =A0 =A0 input_dev->dev.parent =3D &client->dev;
> + =A0 =A0 =A0 input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_=
REP);
> +
> + =A0 =A0 =A0 input_dev->keycode =3D mpr121->keycodes;
> + =A0 =A0 =A0 input_dev->keycodesize =3D sizeof(mpr121->keycodes[0]);
> + =A0 =A0 =A0 input_dev->keycodemax =3D mpr121->keycount;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->keymap_size; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(input_dev, EV_KEY,=
 pdata->keymap[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpr121->keycodes[i] =3D pdata->keymap[i=
];
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 error =3D mpr121_phys_init(pdata, mpr121, client);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to init r=
egister\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 error =3D request_threaded_irq(client->irq, NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0mpr_touchkey_interrupt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0IRQF_TRIGGER_FALLING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0client->dev.driver->name, mpr121);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to regist=
er interrupt\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 error =3D input_register_device(input_dev);
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> +
> + =A0 =A0 =A0 i2c_set_clientdata(client, mpr121);
> + =A0 =A0 =A0 device_init_wakeup(&client->dev, pdata->wakeup);
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_free_irq:
> + =A0 =A0 =A0 free_irq(client->irq, mpr121);
> +err_free_mem:
> + =A0 =A0 =A0 input_free_device(input_dev);
> + =A0 =A0 =A0 kfree(mpr121);
> + =A0 =A0 =A0 return error;
> +}
> +
> +static int __devexit mpr_touchkey_remove(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct mpr121_touchkey *mpr121 =3D i2c_get_clientdata(c=
lient);
> +
> + =A0 =A0 =A0 free_irq(client->irq, mpr121);
> + =A0 =A0 =A0 input_unregister_device(mpr121->input_dev);
> + =A0 =A0 =A0 kfree(mpr121);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mpr_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> +
> + =A0 =A0 =A0 if (device_may_wakeup(&client->dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq_wake(client->irq);
> +
> + =A0 =A0 =A0 i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, =
0x00);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int mpr_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> + =A0 =A0 =A0 struct mpr121_touchkey *mpr121 =3D i2c_get_clientdata(c=
lient);
> +
> + =A0 =A0 =A0 if (device_may_wakeup(&client->dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_wake(client->irq);
> +
> + =A0 =A0 =A0 i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpr=
121->keycount);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(mpr121_touchkey_pm_ops, mpr_suspend, mpr_re=
sume);
> +
> +static const struct i2c_device_id mpr121_id[] =3D {
> + =A0 =A0 =A0 { "mpr121_touchkey", 0 },
> + =A0 =A0 =A0 { }
> +};
> +MODULE_DEVICE_TABLE(i2c, mpr121_id);
> +
> +static struct i2c_driver mpr_touchkey_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "mpr121",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &mpr121_touchkey_pm_ops=
,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D mpr121_id,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D mpr_touchkey_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(mpr_touchkey_re=
move),
> +};
> +
> +static int __init mpr_touchkey_init(void)
> +{
> + =A0 =A0 =A0 return i2c_add_driver(&mpr_touchkey_driver);
> +}
> +module_init(mpr_touchkey_init);
> +
> +static void __exit mpr_touchkey_exit(void)
> +{
> + =A0 =A0 =A0 i2c_del_driver(&mpr_touchkey_driver);
> +}
> +module_exit(mpr_touchkey_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhang Jiejing <jiejing.zhang@freescale.com>");
> +MODULE_DESCRIPTION("Touch Key driver for Freescale MPR121 Chip");
> diff --git a/include/linux/i2c/mpr121_touchkey.h b/include/linux/i2c/=
mpr121_touchkey.h
> new file mode 100644
> index 0000000..f0bcc38
> --- /dev/null
> +++ b/include/linux/i2c/mpr121_touchkey.h
> @@ -0,0 +1,20 @@
> +/* Header file for Freescale MPR121 Capacitive Touch Sensor */
> +
> +#ifndef _MPR121_TOUCHKEY_H
> +#define _MPR121_TOUCHKEY_H
> +
> +/**
> + * struct mpr121_platform_data - platform data for mpr121 sensor
> + * @keymap: pointer to array of KEY_* values representing keymap
> + * @keymap_size: size of the keymap
> + * @wakeup: configure the button as a wake-up source
> + * @vdd_uv: VDD voltage in uV
> + */
> +struct mpr121_platform_data {
> + =A0 =A0 =A0 const unsigned short *keymap;
> + =A0 =A0 =A0 unsigned int keymap_size;
> + =A0 =A0 =A0 bool wakeup;
> + =A0 =A0 =A0 int vdd_uv;
> +};
> +
> +#endif /* _MPR121_TOUCHKEY_H */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
