From: Anirudh Ghayal <anirudhghayal@gmail.com>
Subject: Re: [PATCH] input: joystick: Adding Austria Microsystem AS5011
 joystick driver
Date: Wed, 24 Nov 2010 20:59:26 +0530
Message-ID: <AANLkTi=UNGfPxp+7-cCu8U=g2CyEQJ5npjJjzEbYCO84@mail.gmail.com>
References: <4CEBED7E.7010101@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61501 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab0KXP3s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 10:29:48 -0500
In-Reply-To: <4CEBED7E.7010101@armadeus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: fabien.marteau@armadeus.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Fabien,

A few comments --

On Tue, Nov 23, 2010 at 10:06 PM, Fabien Marteau
<fabien.marteau@armadeus.com> wrote:
> Driver for EasyPoint AS5011 2 axis joystick chip. This chip is plugge=
d
> on an I2C bus. It as been tested on ARM processor (i.MX27).
>
> Signed-off-by: Fabien Marteau <fabien.marteau@armadeus.com>
> ---
> =A0drivers/input/joystick/Kconfig =A0| =A0 =A09 +
> =A0drivers/input/joystick/Makefile | =A0 =A01 +
> =A0drivers/input/joystick/as5011.c | =A0454
> +++++++++++++++++++++++++++++++++++++++
> =A0include/linux/as5011.h =A0 =A0 =A0 =A0 =A0| =A0 72 ++++++
> =A04 files changed, 536 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/input/joystick/as5011.c
> =A0create mode 100644 include/linux/as5011.h
>
> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/=
Kconfig
> index 5b59616..5fad03e 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -255,6 +255,15 @@ config JOYSTICK_AMIGA
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called amijoy.
>
> +config JOYSTICK_AS5011
> + =A0 =A0 =A0 tristate "Austria Microsystem AS5011 joystick"
> + =A0 =A0 =A0 depends on I2C
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here if you have an AS5011 digital joystick.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the
> + =A0 =A0 =A0 =A0 module will be called as5011.
> +
> =A0config JOYSTICK_JOYDUMP
> =A0 =A0 =A0 =A0tristate "Gameport data dumper"
> =A0 =A0 =A0 =A0select GAMEPORT
> diff --git a/drivers/input/joystick/Makefile
> b/drivers/input/joystick/Makefile
> index f3a8cbe..92dc0de 100644
> --- a/drivers/input/joystick/Makefile
> +++ b/drivers/input/joystick/Makefile
> @@ -7,6 +7,7 @@
> =A0obj-$(CONFIG_JOYSTICK_A3D) =A0 =A0 =A0 =A0 =A0 =A0 +=3D a3d.o
> =A0obj-$(CONFIG_JOYSTICK_ADI) =A0 =A0 =A0 =A0 =A0 =A0 +=3D adi.o
> =A0obj-$(CONFIG_JOYSTICK_AMIGA) =A0 =A0 =A0 =A0 =A0 +=3D amijoy.o
> +obj-$(CONFIG_JOYSTICK_AS5011) =A0 =A0 =A0 =A0 =A0+=3D as5011.o
> =A0obj-$(CONFIG_JOYSTICK_ANALOG) =A0 =A0 =A0 =A0 =A0+=3D analog.o
> =A0obj-$(CONFIG_JOYSTICK_COBRA) =A0 =A0 =A0 =A0 =A0 +=3D cobra.o
> =A0obj-$(CONFIG_JOYSTICK_DB9) =A0 =A0 =A0 =A0 =A0 =A0 +=3D db9.o
> diff --git a/drivers/input/joystick/as5011.c
> b/drivers/input/joystick/as5011.c
> new file mode 100644
> index 0000000..db0f129
> --- /dev/null
> +++ b/drivers/input/joystick/as5011.c
> @@ -0,0 +1,454 @@
> +/*
> + * Copyright (c) 2010 Fabien Marteau <fabien.marteau@armadeus.com>
> + *
> + * Sponsored by ARMadeus Systems
> + */
> +
> +/*
> + * Driver for Austria Microsystems joysticks AS5011
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-13=
07 USA
> + *
> + * TODO:
> + * =A0 =A0 - Manage power mode
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/string.h>
> +#include <linux/list.h>
> +#include <linux/sysfs.h>
> +#include <linux/ctype.h>
> +#include <linux/hwmon-sysfs.h>
> +
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +
> +#include <linux/input.h>
> +#include <linux/gpio.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/as5011.h>
> +#define DRIVER_DESC "Driver for Austria Microsystems AS5011 joystick=
"
> +
> +MODULE_AUTHOR("Fabien Marteau <fabien.marteau@armadeus.com>");
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL");
> +
> +#define SIZE_NAME 30
> +#define AS5011_MAX_AXIS =A0 =A0 =A0 =A080
> +#define AS5011_MIN_AXIS =A0 =A0 =A0 =A0(-80)
> +#define AS5011_FUZZ =A0 =A08
> +#define AS5011_FLAT =A0 =A040
> +
> +static int g_num =3D 1; /* device counter */
> +
> +static signed char as5011_i2c_read(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint8_t aRegAddr=
);
> +static int as5011_i2c_write(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint8_t aRegAdd=
r,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint8_t aValue)=
;
> +
> +/*
> + * interrupts operations
> + */
> +
> +static irqreturn_t button_interrupt(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct as5011_platform_data *plat_dat =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct as5011_platform_data *)dev_id;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D gpio_get_value(plat_dat->button_gpio);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(plat_dat->input_dev, B=
TN_JOYSTICK, 0);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(plat_dat->input_dev, B=
TN_JOYSTICK, 1);
> + =A0 =A0 =A0 input_sync(plat_dat->input_dev);
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static void as5011_update_axes(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct as5011_platform_data *plat_dat =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct as501=
1_platform_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0update_axes_=
work);
> + =A0 =A0 =A0 signed char x, y;
> +
> + =A0 =A0 =A0 x =3D as5011_i2c_read(plat_dat->i2c_client, AS5011_X_RE=
S_INT);
> + =A0 =A0 =A0 y =3D as5011_i2c_read(plat_dat->i2c_client, AS5011_Y_RE=
S_INT);

What if the read call returns an error ?

> + =A0 =A0 =A0 input_report_abs(plat_dat->input_dev, ABS_X, x);
> + =A0 =A0 =A0 input_report_abs(plat_dat->input_dev, ABS_Y, y);
> + =A0 =A0 =A0 input_sync(plat_dat->input_dev);
> +}
> +
> +static irqreturn_t as5011_int_interrupt(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct as5011_platform_data *plat_dat =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct as5011_platform_data *)dev_id;
> +
> + =A0 =A0 =A0 queue_work(plat_dat->workqueue, &plat_dat->update_axes_=
work);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +/*
> + * I2C bus operation
> + */
> +
> +static int as5011_i2c_write(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint8_t aRegAdd=
r,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint8_t aValue)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 uint8_t data[2] =3D { aRegAddr, aValue };
> + =A0 =A0 =A0 struct i2c_msg msg =3D { =A0client->addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_M_I=
GNORE_NAK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (uint8_=
t *)data };
> +
> + =A0 =A0 =A0 ret =3D i2c_transfer(client->adapter, &msg, 1);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 return 1;
> +}
> +
> +static signed char as5011_i2c_read(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint8_t aRegAddr=
)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 uint8_t data[2];
> + =A0 =A0 =A0 struct i2c_msg msg_set[2];
> + =A0 =A0 =A0 struct i2c_msg msg1 =3D { client->addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_M_R=
EV_DIR_ADDR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (uint8_=
t *)data};
> + =A0 =A0 =A0 struct i2c_msg msg2 =3D { client->addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_M_R=
D|I2C_M_NOSTART,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (uint8_=
t *)data};
> +
> + =A0 =A0 =A0 data[0] =3D aRegAddr;
> + =A0 =A0 =A0 msg_set[0] =3D msg1;
> + =A0 =A0 =A0 msg_set[1] =3D msg2;
> +
> + =A0 =A0 =A0 ret =3D i2c_transfer(client->adapter, msg_set, 2);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (data[0] & 0x80)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1*(1+(~data[0]));
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data[0];
> +}
> +
> +static int as5011_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device=
_id *id)
> +{

__devinit as5011_probe()

> + =A0 =A0 =A0 struct as5011_platform_data *plat_dat =3D client->dev.p=
latform_data;
> + =A0 =A0 =A0 int retval =3D 0;
> +
> + =A0 =A0 =A0 plat_dat->num =3D g_num;
> + =A0 =A0 =A0 g_num++;
> +
> + =A0 =A0 =A0 retval =3D snprintf(plat_dat->workqueue_name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SIZE_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "as5011_%d_workqueu=
e", plat_dat->num);
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "as5011: Failed t=
o give workqueue name\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto workqueue_name_error;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 plat_dat->workqueue =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 create_singlethread_workqueue(plat_dat-=
>workqueue_name);
> + =A0 =A0 =A0 if (plat_dat->workqueue =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "as5011: Failed t=
o create workqueue\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto workqueue_create_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 INIT_WORK(&plat_dat->update_axes_work, as5011_update_ax=
es);
> +
> + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0I2C_FUNC_PROTOCOL_MANGLING)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "i2c bus does not support protocol mang=
ling, as5011 can't work\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto i2c_protocol_error;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 plat_dat->i2c_client =3D client;
> +
> + =A0 =A0 =A0 plat_dat->input_dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (plat_dat->input_dev < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "not enough memory for input devices st=
ructure\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto input_allocate_device_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 plat_dat->input_dev->name =3D "Austria Microsystem as50=
11 joystick";
> + =A0 =A0 =A0 plat_dat->input_dev->uniq =3D "Austria0";
> + =A0 =A0 =A0 plat_dat->input_dev->id.bustype =3D BUS_I2C;
> + =A0 =A0 =A0 plat_dat->input_dev->phys =3D "/dev/input/event0";
> + =A0 =A0 =A0 plat_dat->input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BI=
T_MASK(EV_ABS);
> + =A0 =A0 =A0 plat_dat->input_dev->keybit[BIT_WORD(BTN_JOYSTICK)] =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 BIT_MASK(BTN_JOYSTICK);
> +
> + =A0 =A0 =A0 input_set_abs_params(plat_dat->input_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ABS_X,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AS5011_MIN_A=
XIS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AS5011_MAX_A=
XIS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AS5011_FUZZ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AS5011_FLAT)=
;
> + =A0 =A0 =A0 input_set_abs_params(plat_dat->input_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ABS_Y,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AS5011_MIN_A=
XIS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AS5011_MAX_A=
XIS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AS5011_FUZZ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AS5011_FLAT)=
;
> +
> + =A0 =A0 =A0 plat_dat->button_irq_name =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(sizeof(unsigned char)*SIZE_NAME=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GFP_KERNEL);
> + =A0 =A0 =A0 if (plat_dat->button_irq_name =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "not enough memory for input devices ir=
q name\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto input_allocate_device_name_error;
> + =A0 =A0 =A0 }
> +
> +
> + =A0 =A0 =A0 retval =3D snprintf(plat_dat->button_irq_name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SIZE_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "as5011_%d_button",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 plat_dat->num);
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "as5011: Failed t=
o give button irq name\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto button_irq_name_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (request_irq(plat_dat->button_irq, button_interrupt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, plat_dat->button_irq=
_name, (void *)plat_dat)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "as5011: Can't al=
locate irq %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 plat_dat->button_irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto request_irq_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 plat_dat->int_irq_name =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(sizeof(unsigned char)*SIZE_NAME=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0GFP_KERNEL);
> + =A0 =A0 =A0 if (plat_dat->int_irq_name =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "not enough memory for input devices in=
t irq name\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto input_allocate_int_device_name_err=
or;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D snprintf(plat_dat->int_irq_name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SIZE_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "as5011_%d_int",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 plat_dat->num);
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "as5011: Failed t=
o give int irq name\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto int_irq_name_error;
> + =A0 =A0 =A0 }
> +
> +
> + =A0 =A0 =A0 if (request_irq(plat_dat->int_irq, as5011_int_interrupt=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, plat_dat->int_irq_na=
me, (void *)plat_dat)) {

How about using request_any_context_irq() ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "as5011: Can't al=
locate int irq %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 plat_dat->int_irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto request_int_irq_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D input_register_device(plat_dat->input_dev);

Its better to register your device at the end, after all the initializa=
tion.

> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "as5011: Failed t=
o register device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto input_register_device_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D plat_dat->init_gpio();

Please check if the function pointer is NULL.

> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "as5011: Failed t=
o init gpios\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_gpio_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* chip soft reset */
> + =A0 =A0 =A0 retval =3D as5011_i2c_write(plat_dat->i2c_client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_CTRL1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_CTRL1_SOFT_RST);
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&plat_dat->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "as5011: soft reset fai=
led\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto soft_reset_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D as5011_i2c_write(plat_dat->i2c_client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_CTRL1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_CTRL1_LP_PULSED |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_CTRL1_LP_ACTIVE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_CTRL1_INT_ACT_EN
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 );
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&plat_dat->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "as5011: power config f=
ailed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto soft_reset_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D as5011_i2c_write(plat_dat->i2c_client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_CTRL2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_CTRL2_INV_SPINNING);
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&plat_dat->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "as5011: can't invert s=
pinning\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto invert_spinning_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* write threshold */
> + =A0 =A0 =A0 retval =3D as5011_i2c_write(plat_dat->i2c_client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_XP,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pla=
t_dat->Xp);
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&plat_dat->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "as5011: can't write th=
reshold\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto threshold_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D as5011_i2c_write(plat_dat->i2c_client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_XN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pla=
t_dat->Xn);
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&plat_dat->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "as5011: can't write th=
reshold\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto threshold_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D as5011_i2c_write(plat_dat->i2c_client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_YP,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pla=
t_dat->Yp);
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&plat_dat->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "as5011: can't write th=
reshold\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto threshold_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D as5011_i2c_write(plat_dat->i2c_client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AS5=
011_YN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pla=
t_dat->Yn);
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&plat_dat->i2c_client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "as5011: can't write th=
reshold\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto threshold_error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* to free irq gpio in chip*/
> + =A0 =A0 =A0 as5011_i2c_read(plat_dat->i2c_client, AS5011_X_RES_INT)=
;
> +
> + =A0 =A0 =A0 queue_work(plat_dat->workqueue, &plat_dat->update_axes_=
work);
> +
> + =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 /* Error management */
> +threshold_error:
> +invert_spinning_error:
> +soft_reset_error:
> + =A0 =A0 =A0 plat_dat->exit_gpio();

Please check if the function pointer is NULL.

> +init_gpio_error:
> + =A0 =A0 =A0 input_unregister_device(plat_dat->input_dev);
> +input_register_device_error:
> + =A0 =A0 =A0 free_irq(plat_dat->int_irq, as5011_int_interrupt);
> +request_int_irq_error:
> +int_irq_name_error:
> + =A0 =A0 =A0 kfree(plat_dat->int_irq_name);
> +input_allocate_int_device_name_error:
> + =A0 =A0 =A0 free_irq(plat_dat->button_irq, button_interrupt);
> +request_irq_error:
> +button_irq_name_error:
> + =A0 =A0 =A0 kfree(plat_dat->button_irq_name);
> +input_allocate_device_name_error:
> + =A0 =A0 =A0 input_free_device(plat_dat->input_dev);
> +input_allocate_device_error:
> +i2c_protocol_error:
> + =A0 =A0 =A0 destroy_workqueue(plat_dat->workqueue);
> +workqueue_create_error:
> +workqueue_name_error:
> + =A0 =A0 =A0 return retval;
> +}
> +static int as5011_remove(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct as5011_platform_data *plat_dat =3D client->dev.p=
latform_data;
> +
> + =A0 =A0 =A0 destroy_workqueue(plat_dat->workqueue);
> + =A0 =A0 =A0 input_unregister_device(plat_dat->input_dev);
> + =A0 =A0 =A0 free_irq(plat_dat->button_irq, plat_dat);
> + =A0 =A0 =A0 free_irq(plat_dat->int_irq, plat_dat);
> + =A0 =A0 =A0 kfree(plat_dat->button_irq_name);
> + =A0 =A0 =A0 input_free_device(plat_dat->input_dev);
> + =A0 =A0 =A0 plat_dat->exit_gpio();

Same here.

> +
> + =A0 =A0 =A0 return 0;
> +}
> +static const struct i2c_device_id as5011_id[] =3D {
> + =A0 =A0 =A0 { "as5011", 0 },
> + =A0 =A0 =A0 { }
> +};
> +
> +static struct i2c_driver as5011_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "as5011",
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D as5011_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D as5011_remove,

__devexit_p (as5011_remove)

> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D as5011_id,
> +};
> +
> +/*
> + * Module initialization
> + */
> +
> +static int __init as5011_init(void)
> +{
> + =A0 =A0 =A0 return i2c_add_driver(&as5011_driver);
> +}
> +
> +static void __exit as5011_exit(void)
> +{
> + =A0 =A0 =A0 i2c_del_driver(&as5011_driver);
> +}
> +
> +module_init(as5011_init);
> +module_exit(as5011_exit);
> diff --git a/include/linux/as5011.h b/include/linux/as5011.h
> new file mode 100644
> index 0000000..7db0a75
> --- /dev/null
> +++ b/include/linux/as5011.h
> @@ -0,0 +1,72 @@
> +#ifndef _AS5011_H
> +#define _AS5011_H
> +
> +/*
> + * Copyright (c) 2010 Fabien Marteau
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as
> published by
> + * the Free Software Foundation.
> + */
> +
> +#define AS5011_MAX_NAME_LENGTH 64
> +#define AS5011_MAX_CNAME_LENGTH =A0 =A0 =A0 =A016
> +#define AS5011_MAX_PHYS_LENGTH 64
> +#define AS5011_MAX_LENGTH =A0 =A0 =A064
> +
> +/* registers */
> +#define AS5011_CTRL1 =A0 =A0 =A0 =A0 =A0 0x76
> +#define AS5011_CTRL2 =A0 =A0 =A0 =A0 =A0 0x75
> +#define AS5011_XP =A0 =A0 =A0 =A0 =A0 =A0 =A00x43
> +#define AS5011_XN =A0 =A0 =A0 =A0 =A0 =A0 =A00x44
> +#define AS5011_YP =A0 =A0 =A0 =A0 =A0 =A0 =A00x53
> +#define AS5011_YN =A0 =A0 =A0 =A0 =A0 =A0 =A00x54
> +#define AS5011_X_REG =A0 =A0 =A0 =A0 =A0 0x41
> +#define AS5011_Y_REG =A0 =A0 =A0 =A0 =A0 0x42
> +#define AS5011_X_RES_INT =A0 =A0 =A0 0x51
> +#define AS5011_Y_RES_INT =A0 =A0 =A0 0x52
> +
> +/* CTRL1 bits */
> +#define AS5011_CTRL1_LP_PULSED =A0 =A0 =A0 =A0 0x80
> +#define AS5011_CTRL1_LP_ACTIVE =A0 =A0 =A0 =A0 0x40
> +#define AS5011_CTRL1_LP_CONTINUE =A0 =A0 =A0 0x20
> +#define AS5011_CTRL1_INT_WUP_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x10
> +#define AS5011_CTRL1_INT_ACT_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x08
> +#define AS5011_CTRL1_EXT_CLK_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x04
> +#define AS5011_CTRL1_SOFT_RST =A0 =A0 =A0 =A0 =A00x02
> +#define AS5011_CTRL1_DATA_VALID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
> +
> +/* CTRL2 bits */
> +#define AS5011_CTRL2_EXT_SAMPLE_EN =A0 =A0 0x08
> +#define AS5011_CTRL2_RC_BIAS_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x04
> +#define AS5011_CTRL2_INV_SPINNING =A0 =A0 =A00x02
> +
> +
> +struct as5011_platform_data {
> + =A0 =A0 =A0 /* public */
> + =A0 =A0 =A0 int button_gpio;
> + =A0 =A0 =A0 int button_irq;
> + =A0 =A0 =A0 int int_gpio;
> + =A0 =A0 =A0 int int_irq;
> + =A0 =A0 =A0 char Xp, Xn; /* threshold for x axis */
> + =A0 =A0 =A0 char Yp, Yn; /* threshold for y axis */
> +
> + =A0 =A0 =A0 int (*init_gpio)(void); /* init interrupts gpios */
> + =A0 =A0 =A0 void (*exit_gpio)(void);/* exit gpios */
> +
> + =A0 =A0 =A0 /* private */
> + =A0 =A0 =A0 int num;
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 struct i2c_client *i2c_client;
> + =A0 =A0 =A0 unsigned char *button_irq_name;
> + =A0 =A0 =A0 unsigned char *int_irq_name;
> + =A0 =A0 =A0 char name[AS5011_MAX_NAME_LENGTH];
> + =A0 =A0 =A0 char cname[AS5011_MAX_CNAME_LENGTH];
> + =A0 =A0 =A0 char phys[AS5011_MAX_PHYS_LENGTH];
> + =A0 =A0 =A0 unsigned char data[AS5011_MAX_LENGTH];
> + =A0 =A0 =A0 char workqueue_name[AS5011_MAX_NAME_LENGTH];
> + =A0 =A0 =A0 struct workqueue_struct *workqueue;
> + =A0 =A0 =A0 struct work_struct update_axes_work;
> +};
> +
> +#endif /* _AS5011_H */
> --
> 1.7.0.4
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
