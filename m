From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Tue, 14 Jul 2009 15:50:18 +0530
Message-ID: <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com>
References: <20090714100634.GA4054@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:62309 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbZGNKUU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 06:20:20 -0400
In-Reply-To: <20090714100634.GA4054@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org

Hi Pavel,

On Tue, Jul 14, 2009 at 3:36 PM, Pavel Machek<pavel@ucw.cz> wrote:
> From: Arve Hj?nnev?g <arve@android.com>
>
> This adds support for synaptic touchscreen, used in HTC dream
> cellphone.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index bb6486a..fa3404f 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -206,6 +213,14 @@ config TOUCHSCREEN_MIGOR
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called migor_ts.
>
> +config TOUCHSCREEN_SYNAPTICS_I2C_RMI
> + =A0 =A0 =A0 tristate "Synaptics i2c touchscreen"
> + =A0 =A0 =A0 depends on I2C
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This enables support for Synaptics RMI over I2C bas=
ed touchscreens.
> + =A0 =A0 =A0 =A0 Such touchscreen is used in HTC Dream.
> +
> +
> =A0config TOUCHSCREEN_TOUCHRIGHT
> =A0 =A0 =A0 =A0tristate "Touchright serial touchscreen"
> =A0 =A0 =A0 =A0select SERIO
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index d3375af..959dcda 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -22,6 +23,7 @@ obj-$(CONFIG_TOUCHSCREEN_HP7XX) =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 +=3D jornada720_ts.o
> =A0obj-$(CONFIG_TOUCHSCREEN_HTCPEN) =A0 =A0 =A0 +=3D htcpen.o
> =A0obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE) =A0 =A0 =A0 =A0+=3D usbtou=
chscreen.o
> =A0obj-$(CONFIG_TOUCHSCREEN_PENMOUNT) =A0 =A0 +=3D penmount.o
> +obj-$(CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI) =A0 =A0+=3D synaptics_i2=
c_rmi.o
> =A0obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213) =A0 +=3D touchit213.o
> =A0obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT) =A0 +=3D touchright.o
> =A0obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN) =A0 =A0 +=3D touchwin.o
> diff --git a/drivers/input/touchscreen/synaptics_i2c_rmi.c b/drivers/=
input/touchscreen/synaptics_i2c_rmi.c
> new file mode 100644
> index 0000000..fe10e85
> --- /dev/null
> +++ b/drivers/input/touchscreen/synaptics_i2c_rmi.c
> @@ -0,0 +1,587 @@
> +/*
> + * Support for synaptics touchscreen.
> + *
> + * Copyright (C) 2007 Google, Inc.
> + * Author: Arve Hj?nnev?g <arve@android.com>
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/hrtimer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/synaptics_i2c_rmi.h>
> +
> +static struct workqueue_struct *synaptics_wq;
> +
> +struct synaptics_ts_data {
> + =A0 =A0 =A0 u16 addr;
> + =A0 =A0 =A0 struct i2c_client *client;
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 int use_irq;
> + =A0 =A0 =A0 struct hrtimer timer;
> + =A0 =A0 =A0 struct work_struct =A0work;
> + =A0 =A0 =A0 u16 max[2];
> + =A0 =A0 =A0 int snap_state[2][2];
> + =A0 =A0 =A0 int snap_down_on[2];
> + =A0 =A0 =A0 int snap_down_off[2];
> + =A0 =A0 =A0 int snap_up_on[2];
> + =A0 =A0 =A0 int snap_up_off[2];
> + =A0 =A0 =A0 int snap_down[2];
> + =A0 =A0 =A0 int snap_up[2];
> + =A0 =A0 =A0 u32 flags;
> + =A0 =A0 =A0 int (*power)(int on);
> +};
> +
> +static int i2c_set(struct synaptics_ts_data *ts, u8 reg, u8 val, cha=
r *msg)
> +{
> + =A0 =A0 =A0 int ret =3D i2c_smbus_write_byte_data(ts->client, reg, =
val);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("i2c_smbus_write_byte_data faile=
d (%s)\n", msg);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int i2c_read(struct synaptics_ts_data *ts, u8 reg, char *msg)
> +{
> + =A0 =A0 =A0 int ret =3D i2c_smbus_read_byte_data(ts->client, 0xf0);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("i2c_smbus_read_byte_data failed=
 (%s)\n", msg);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int synaptics_init_panel(struct synaptics_ts_data *ts)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D i2c_set(ts, 0xff, 0x10, "set page select");
> + =A0 =A0 =A0 if (ret =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_set(ts, 0x41, 0x04, "set No=
 Clip Z");
> +
> + =A0 =A0 =A0 ret =3D i2c_set(ts, 0xff, 0x04, "fallback page select")=
;
> + =A0 =A0 =A0 ret =3D i2c_set(ts, 0xf0, 0x81, "select 80 reports per =
second");
> + =A0 =A0 =A0 return ret;
> +}
> +

> +static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
> +{

some documentation about this logic would be great.

> + =A0 =A0 =A0 int pos[2][2];
> + =A0 =A0 =A0 int f, a;
> + =A0 =A0 =A0 int base =3D 2;
> + =A0 =A0 =A0 int z =3D buf[1];
> + =A0 =A0 =A0 int w =3D buf[0] >> 4;
> + =A0 =A0 =A0 int finger =3D buf[0] & 7;
> + =A0 =A0 =A0 int finger2_pressed;
> +
> + =A0 =A0 =A0 for (f =3D 0; f < 2; f++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 flip_flag =3D SYNAPTICS_FLIP_X;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (a =3D 0; a < 2; a++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D buf[base + 1]=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p |=3D (u16)(buf[base] =
& 0x1f) << 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ts->flags & flip_fl=
ag)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D t=
s->max[a] - p;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ts->flags & SYNAPTI=
CS_SNAP_TO_INACTIVE_EDGE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ts-=
>snap_state[f][a]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (p <=3D ts->snap_down_off[a])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 p =3D ts->snap_down[a];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 else if (p >=3D ts->snap_up_off[a])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 p =3D ts->snap_up[a];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ts->snap_state[f][a] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (p <=3D ts->snap_down_on[a]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 p =3D ts->snap_down[a];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ts->snap_state[f][a] =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 } else if (p >=3D ts->snap_up_on[a]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 p =3D ts->snap_up[a];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ts->snap_state[f][a] =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pos[f][a] =3D p;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base +=3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flip_flag <<=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 base +=3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ts->flags & SYNAPTICS_SWAP_XY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 swap(pos[f][0], pos[f][=
1]);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (z) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(ts->input_dev, ABS_X, =
pos[0][0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(ts->input_dev, ABS_Y, =
pos[0][1]);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 input_report_abs(ts->input_dev, ABS_PRESSURE, z);
> + =A0 =A0 =A0 input_report_abs(ts->input_dev, ABS_TOOL_WIDTH, w);
> + =A0 =A0 =A0 input_report_key(ts->input_dev, BTN_TOUCH, finger);
> + =A0 =A0 =A0 finger2_pressed =3D finger > 1 && finger !=3D 7;
> + =A0 =A0 =A0 input_report_key(ts->input_dev, BTN_2, finger2_pressed)=
;
> + =A0 =A0 =A0 if (finger2_pressed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(ts->input_dev, ABS_HAT=
0X, pos[1][0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(ts->input_dev, ABS_HAT=
0Y, pos[1][1]);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 input_sync(ts->input_dev);
> +}
> +
> +static void synaptics_ts_work_func(struct work_struct *work)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int bad_data =3D 0;
> + =A0 =A0 =A0 struct i2c_msg msg[2];
> + =A0 =A0 =A0 u8 start_reg =3D 0;
> + =A0 =A0 =A0 u8 buf[15];
> + =A0 =A0 =A0 struct synaptics_ts_data *ts =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struct synaptics_ts_=
data, work);
> +
> + =A0 =A0 =A0 msg[0].addr =3D ts->client->addr;
> + =A0 =A0 =A0 msg[0].flags =3D 0;
> + =A0 =A0 =A0 msg[0].len =3D 1;
> + =A0 =A0 =A0 msg[0].buf =3D &start_reg;
> + =A0 =A0 =A0 msg[1].addr =3D ts->client->addr;
> + =A0 =A0 =A0 msg[1].flags =3D I2C_M_RD;
> + =A0 =A0 =A0 msg[1].len =3D sizeof(buf);
> + =A0 =A0 =A0 msg[1].buf =3D buf;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ((ts->use_irq && !bad_data) ? 1 : 10)=
; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_transfer(ts->client->adapte=
r, msg, 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "ts_wor=
k: i2c_transfer failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad_data =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((buf[14] & 0xc0) !=3D 0x40) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "sy=
naptics_ts_work_func:"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" bad re=
ad %x %x %x %x %x %x %x %x %x"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" %x %x =
%x %x %x %x, ret %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf[0], =
buf[1], buf[2], buf[3],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf[4], =
buf[5], buf[6], buf[7],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf[8], =
buf[9], buf[10], buf[11],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf[12],=
 buf[13], buf[14], ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bad_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 synapti=
cs_init_panel(ts);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad_data =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bad_data =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((buf[14] & 1) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 decode_report(ts, buf);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (ts->use_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(ts->client->irq);
> +}
> +
> +static enum hrtimer_restart synaptics_ts_timer_func(struct hrtimer *=
timer)
> +{
> + =A0 =A0 =A0 struct synaptics_ts_data *ts =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(timer, struct synaptics_ts=
_data, timer);
> +
> + =A0 =A0 =A0 queue_work(synaptics_wq, &ts->work);
> +
> + =A0 =A0 =A0 hrtimer_start(&ts->timer, ktime_set(0, 12500000), HRTIM=
ER_MODE_REL);
> + =A0 =A0 =A0 return HRTIMER_NORESTART;
> +}
> +
> +static irqreturn_t synaptics_ts_irq_handler(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct synaptics_ts_data *ts =3D dev_id;
> +
> + =A0 =A0 =A0 disable_irq(ts->client->irq);

disable_irq_nosync or convert this to request_threaded_irq(...).
Please see recent discussion on linux-input for MAX key switch
controller.

> + =A0 =A0 =A0 queue_work(synaptics_wq, &ts->work);
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int detect(struct synaptics_ts_data *ts, u32 *panel_version)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int retry =3D 10;
> +
> + =A0 =A0 =A0 ret =3D i2c_set(ts, 0xf4, 0x01, "reset device");
> +
> + =A0 =A0 =A0 while (retry-- > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_read_byte_data(ts->cl=
ient, 0xe4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(100);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("i2c_smbus_read_byte_data failed=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 *panel_version =3D ret << 8;
> + =A0 =A0 =A0 ret =3D i2c_read(ts, 0xe5, "product minor");
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 *panel_version |=3D ret;
> +
> + =A0 =A0 =A0 ret =3D i2c_read(ts, 0xe3, "property");
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 pr_info("synaptics: version %x, product property %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *panel_version, ret);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void compute_areas(struct synaptics_ts_data *ts,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct synaptics_i2=
c_rmi_platform_data *pdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 max_x, u16 max_=
y)
> +{
> + =A0 =A0 =A0 u32 inactive_area_left;
> + =A0 =A0 =A0 u32 inactive_area_right;
> + =A0 =A0 =A0 u32 inactive_area_top;
> + =A0 =A0 =A0 u32 inactive_area_bottom;
> + =A0 =A0 =A0 u32 snap_left_on;
> + =A0 =A0 =A0 u32 snap_left_off;
> + =A0 =A0 =A0 u32 snap_right_on;
> + =A0 =A0 =A0 u32 snap_right_off;
> + =A0 =A0 =A0 u32 snap_top_on;
> + =A0 =A0 =A0 u32 snap_top_off;
> + =A0 =A0 =A0 u32 snap_bottom_on;
> + =A0 =A0 =A0 u32 snap_bottom_off;
> + =A0 =A0 =A0 u32 fuzz_x;
> + =A0 =A0 =A0 u32 fuzz_y;
> + =A0 =A0 =A0 int fuzz_p;
> + =A0 =A0 =A0 int fuzz_w;
> + =A0 =A0 =A0 int swapped =3D !!(ts->flags & SYNAPTICS_SWAP_XY);
> +
> + =A0 =A0 =A0 inactive_area_left =3D pdata->inactive_left;
> + =A0 =A0 =A0 inactive_area_right =3D pdata->inactive_right;
> + =A0 =A0 =A0 inactive_area_top =3D pdata->inactive_top;
> + =A0 =A0 =A0 inactive_area_bottom =3D pdata->inactive_bottom;
> + =A0 =A0 =A0 snap_left_on =3D pdata->snap_left_on;
> + =A0 =A0 =A0 snap_left_off =3D pdata->snap_left_off;
> + =A0 =A0 =A0 snap_right_on =3D pdata->snap_right_on;
> + =A0 =A0 =A0 snap_right_off =3D pdata->snap_right_off;
> + =A0 =A0 =A0 snap_top_on =3D pdata->snap_top_on;
> + =A0 =A0 =A0 snap_top_off =3D pdata->snap_top_off;
> + =A0 =A0 =A0 snap_bottom_on =3D pdata->snap_bottom_on;
> + =A0 =A0 =A0 snap_bottom_off =3D pdata->snap_bottom_off;
> + =A0 =A0 =A0 fuzz_x =3D pdata->fuzz_x;
> + =A0 =A0 =A0 fuzz_y =3D pdata->fuzz_y;
> + =A0 =A0 =A0 fuzz_p =3D pdata->fuzz_p;
> + =A0 =A0 =A0 fuzz_w =3D pdata->fuzz_w;
> +
> + =A0 =A0 =A0 inactive_area_left =3D inactive_area_left * max_x / 0x1=
0000;
> + =A0 =A0 =A0 inactive_area_right =3D inactive_area_right * max_x / 0=
x10000;
> + =A0 =A0 =A0 inactive_area_top =3D inactive_area_top * max_y / 0x100=
00;
> + =A0 =A0 =A0 inactive_area_bottom =3D inactive_area_bottom * max_y /=
 0x10000;
> + =A0 =A0 =A0 snap_left_on =3D snap_left_on * max_x / 0x10000;
> + =A0 =A0 =A0 snap_left_off =3D snap_left_off * max_x / 0x10000;
> + =A0 =A0 =A0 snap_right_on =3D snap_right_on * max_x / 0x10000;
> + =A0 =A0 =A0 snap_right_off =3D snap_right_off * max_x / 0x10000;
> + =A0 =A0 =A0 snap_top_on =3D snap_top_on * max_y / 0x10000;
> + =A0 =A0 =A0 snap_top_off =3D snap_top_off * max_y / 0x10000;
> + =A0 =A0 =A0 snap_bottom_on =3D snap_bottom_on * max_y / 0x10000;
> + =A0 =A0 =A0 snap_bottom_off =3D snap_bottom_off * max_y / 0x10000;
> + =A0 =A0 =A0 fuzz_x =3D fuzz_x * max_x / 0x10000;
> + =A0 =A0 =A0 fuzz_y =3D fuzz_y * max_y / 0x10000;
> +
> +
> + =A0 =A0 =A0 ts->snap_down[swapped] =3D -inactive_area_left;
> + =A0 =A0 =A0 ts->snap_up[swapped] =3D max_x + inactive_area_right;
> + =A0 =A0 =A0 ts->snap_down[!swapped] =3D -inactive_area_top;
> + =A0 =A0 =A0 ts->snap_up[!swapped] =3D max_y + inactive_area_bottom;
> + =A0 =A0 =A0 ts->snap_down_on[swapped] =3D snap_left_on;
> + =A0 =A0 =A0 ts->snap_down_off[swapped] =3D snap_left_off;
> + =A0 =A0 =A0 ts->snap_up_on[swapped] =3D max_x - snap_right_on;
> + =A0 =A0 =A0 ts->snap_up_off[swapped] =3D max_x - snap_right_off;
> + =A0 =A0 =A0 ts->snap_down_on[!swapped] =3D snap_top_on;
> + =A0 =A0 =A0 ts->snap_down_off[!swapped] =3D snap_top_off;
> + =A0 =A0 =A0 ts->snap_up_on[!swapped] =3D max_y - snap_bottom_on;
> + =A0 =A0 =A0 ts->snap_up_off[!swapped] =3D max_y - snap_bottom_off;
> + =A0 =A0 =A0 pr_info("synaptics_ts_probe: max_x %d, max_y %d\n", max=
_x, max_y);
> + =A0 =A0 =A0 pr_info("synaptics_ts_probe: inactive_x %d %d, inactive=
_y %d %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0inactive_area_left, inactive_area_right,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0inactive_area_top, inactive_area_bottom)=
;
> + =A0 =A0 =A0 pr_info("synaptics_ts_probe: snap_x %d-%d %d-%d, snap_y=
 %d-%d %d-%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0snap_left_on, snap_left_off, snap_right_=
on, snap_right_off,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0snap_top_on, snap_top_off, snap_bottom_o=
n, snap_bottom_off);
> +
> + =A0 =A0 =A0 input_set_abs_params(ts->input_dev, ABS_X,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-inactive_ar=
ea_left, max_x + inactive_area_right,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fuzz_x, 0);
> + =A0 =A0 =A0 input_set_abs_params(ts->input_dev, ABS_Y,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-inactive_ar=
ea_top, max_y + inactive_area_bottom,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fuzz_y, 0);
> + =A0 =A0 =A0 input_set_abs_params(ts->input_dev, ABS_PRESSURE, 0, 25=
5, fuzz_p, 0);
> + =A0 =A0 =A0 input_set_abs_params(ts->input_dev, ABS_TOOL_WIDTH, 0, =
15, fuzz_w, 0);
> + =A0 =A0 =A0 input_set_abs_params(ts->input_dev, ABS_HAT0X, -inactiv=
e_area_left,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_x + inac=
tive_area_right, fuzz_x, 0);
> + =A0 =A0 =A0 input_set_abs_params(ts->input_dev, ABS_HAT0Y, -inactiv=
e_area_top,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_y + inac=
tive_area_bottom, fuzz_y, 0);
> +}
> +
> +static int synaptics_ts_probe(
> + =A0 =A0 =A0 struct i2c_client *client, const struct i2c_device_id *=
id)
> +{

__devinit ?

> + =A0 =A0 =A0 struct synaptics_ts_data *ts;
> + =A0 =A0 =A0 u8 buf0[4];
> + =A0 =A0 =A0 u8 buf1[8];
> + =A0 =A0 =A0 struct i2c_msg msg[2];
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 struct synaptics_i2c_rmi_platform_data *pdata;
> + =A0 =A0 =A0 u32 panel_version =3D 0;
> + =A0 =A0 =A0 u16 max_x, max_y;
> +
> + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FUNC_=
I2C)) {

check for SMBUS? I have added linux-i2c as this driver has i2c bits,
so not removing any code.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "synaptics_ts_probe: ne=
ed I2C_FUNC_I2C\n");

dev_xxx/pr_xxx friends?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_check_functionality_failed;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ts =3D kzalloc(sizeof(*ts), GFP_KERNEL);
> + =A0 =A0 =A0 if (ts =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc_data_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 INIT_WORK(&ts->work, synaptics_ts_work_func);
> + =A0 =A0 =A0 ts->client =3D client;
> + =A0 =A0 =A0 i2c_set_clientdata(client, ts);
> + =A0 =A0 =A0 pdata =3D client->dev.platform_data;
> + =A0 =A0 =A0 if (pdata)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->power =3D pdata->power;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_K=
ERNEL);
> +
> + =A0 =A0 =A0 if (ts->power) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ts->power(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "synapt=
ics_ts_probe power on failed\n");

Ditto.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_power_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D detect(ts, &panel_version);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_detect_failed;
> +
> + =A0 =A0 =A0 while (pdata->version > panel_version)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata++;
> + =A0 =A0 =A0 ts->flags =3D pdata->flags;
> +
> + =A0 =A0 =A0 ret =3D i2c_read(ts, 0xf0, "device control");
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_detect_failed;
> + =A0 =A0 =A0 pr_info("synaptics: device control %x\n", ret);
> +
> + =A0 =A0 =A0 ret =3D i2c_read(ts, 0xf1, "interrupt enable");
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_detect_failed;
> + =A0 =A0 =A0 pr_info("synaptics_ts_probe: interrupt enable %x\n", re=
t);
> +
> + =A0 =A0 =A0 ret =3D i2c_set(ts, 0xf1, 0, "disable interrupt");
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_detect_failed;
> +
> + =A0 =A0 =A0 msg[0].addr =3D ts->client->addr;
> + =A0 =A0 =A0 msg[0].flags =3D 0;
> + =A0 =A0 =A0 msg[0].len =3D 1;
> + =A0 =A0 =A0 msg[0].buf =3D buf0;
> + =A0 =A0 =A0 buf0[0] =3D 0xe0;
> + =A0 =A0 =A0 msg[1].addr =3D ts->client->addr;
> + =A0 =A0 =A0 msg[1].flags =3D I2C_M_RD;
> + =A0 =A0 =A0 msg[1].len =3D 8;
> + =A0 =A0 =A0 msg[1].buf =3D buf1;
> + =A0 =A0 =A0 ret =3D i2c_transfer(ts->client->adapter, msg, 2);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "i2c_transfer failed\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_detect_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 printk(KERN_INFO "synaptics_ts_probe: 0xe0: %x %x %x %x=
 %x %x %x %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0buf1[0], buf1[1], buf1[2], buf1[3],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0buf1[4], buf1[5], buf1[6], buf1[7]);
> +
> + =A0 =A0 =A0 ret =3D i2c_set(ts, 0xff, 0x10, "page select =3D 0x10")=
;
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_detect_failed;
> +
> + =A0 =A0 =A0 ret =3D i2c_smbus_read_word_data(ts->client, 0x04);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "i2c_smbus_read_word_da=
ta failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_detect_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ts->max[0] =3D max_x =3D (ret >> 8 & 0xff) | ((ret & 0x=
1f) << 8);
> + =A0 =A0 =A0 ret =3D i2c_smbus_read_word_data(ts->client, 0x06);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "i2c_smbus_read_word_da=
ta failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_detect_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ts->max[1] =3D max_y =3D (ret >> 8 & 0xff) | ((ret & 0x=
1f) << 8);
> + =A0 =A0 =A0 if (ts->flags & SYNAPTICS_SWAP_XY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 swap(max_x, max_y);
> +
> + =A0 =A0 =A0 /* will also switch back to page 0x04 */
> + =A0 =A0 =A0 ret =3D synaptics_init_panel(ts);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("synaptics_init_panel failed\n")=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_detect_failed;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ts->input_dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (ts->input_dev =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("synaptics: Failed to allocate i=
nput device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_input_dev_alloc_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ts->input_dev->name =3D "synaptics-rmi-touchscreen";

other parameters of input_dev, like vendor, bus etc.,

> + =A0 =A0 =A0 set_bit(EV_SYN, ts->input_dev->evbit);
> + =A0 =A0 =A0 set_bit(EV_KEY, ts->input_dev->evbit);
> + =A0 =A0 =A0 set_bit(BTN_TOUCH, ts->input_dev->keybit);
> + =A0 =A0 =A0 set_bit(BTN_2, ts->input_dev->keybit);
> + =A0 =A0 =A0 set_bit(EV_ABS, ts->input_dev->evbit);
> +

__set_bit or input_set_capability please.

> + =A0 =A0 =A0 compute_areas(ts, pdata, max_x, max_y);
> +
> +
> + =A0 =A0 =A0 ret =3D input_register_device(ts->input_dev);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("synaptics: Unable to register %=
s input device\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ts->input_dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_input_register_device_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (client->irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(client->irq, synapt=
ics_ts_irq_handler,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, =
client->name, ts);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_set(ts, 0xf=
1, 0x01, "enable abs int");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_ir=
q(client->irq, ts);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->use_irq =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "=
request_irq failed\n");
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!ts->use_irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_init(&ts->timer, CLOCK_MONOTONI=
C, HRTIMER_MODE_REL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->timer.function =3D synaptics_ts_tim=
er_func;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(&ts->timer, ktime_set(1, =
0), HRTIMER_MODE_REL);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_info("synaptics: Start touchscreen %s in %s mode\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->input_dev->name, ts->use_irq ? "int=
errupt" : "polling");
> +
> + =A0 =A0 =A0 return 0;
> +
> + err_input_register_device_failed:
> + =A0 =A0 =A0 input_free_device(ts->input_dev);
> +
> + err_input_dev_alloc_failed:
> + err_detect_failed:
> + err_power_failed:
> + =A0 =A0 =A0 kfree(ts);
> + err_alloc_data_failed:
> + err_check_functionality_failed:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int synaptics_ts_remove(struct i2c_client *client)
> +{

__devexit

> + =A0 =A0 =A0 struct synaptics_ts_data *ts =3D i2c_get_clientdata(cli=
ent);
> +
> + =A0 =A0 =A0 if (ts->use_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(client->irq, ts);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_cancel(&ts->timer);
> + =A0 =A0 =A0 input_unregister_device(ts->input_dev);
> + =A0 =A0 =A0 kfree(ts);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int synaptics_ts_suspend(struct i2c_client *client, pm_messag=
e_t mesg)
> +{

#ifdef CONFIG_PM ?

> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct synaptics_ts_data *ts =3D i2c_get_clientdata(cli=
ent);
> +
> + =A0 =A0 =A0 if (ts->use_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq(client->irq);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_cancel(&ts->timer);
> + =A0 =A0 =A0 ret =3D cancel_work_sync(&ts->work);
> + =A0 =A0 =A0 if (ret && ts->use_irq) /* if work was pending disable-=
count is now 2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(client->irq);
> + =A0 =A0 =A0 i2c_set(ts, 0xf1, 0, "disable interrupt");
> + =A0 =A0 =A0 i2c_set(ts, 0xf0, 0x86, "deep sleep");
> +
> + =A0 =A0 =A0 if (ts->power) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ts->power(0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("synaptics_ts_su=
spend power off failed\n");
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int synaptics_ts_resume(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct synaptics_ts_data *ts =3D i2c_get_clientdata(cli=
ent);
> +
> + =A0 =A0 =A0 if (ts->power) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ts->power(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("synaptics_ts_re=
sume power on failed\n");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 synaptics_init_panel(ts);
> +
> + =A0 =A0 =A0 if (ts->use_irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(client->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_set(ts, 0xf1, 0x01, "enable abs int=
");
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(&ts->timer, ktime_set(1, =
0), HRTIMER_MODE_REL);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +
> +static const struct i2c_device_id synaptics_ts_id[] =3D {
> + =A0 =A0 =A0 { SYNAPTICS_I2C_RMI_NAME, 0 },
> + =A0 =A0 =A0 { }
> +};
> +
> +static struct i2c_driver synaptics_ts_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D synaptics_ts_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D synaptics_ts_remove,

__devexit_p

> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D synaptics_ts_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D synaptics_ts_resume,
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D synaptics_ts_id,
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D SYNAPTICS_I2C_RMI_NAME,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __devinit synaptics_ts_init(void)
> +{
> + =A0 =A0 =A0 synaptics_wq =3D create_singlethread_workqueue("synapti=
cs_wq");
> + =A0 =A0 =A0 if (!synaptics_wq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 return i2c_add_driver(&synaptics_ts_driver);
> +}
> +
> +static void __exit synaptics_ts_exit(void)
> +{
> + =A0 =A0 =A0 i2c_del_driver(&synaptics_ts_driver);
> + =A0 =A0 =A0 if (synaptics_wq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 destroy_workqueue(synaptics_wq);
> +}
> +
> +module_init(synaptics_ts_init);
> +module_exit(synaptics_ts_exit);
> +
> +MODULE_DESCRIPTION("Synaptics Touchscreen Driver");
> +MODULE_LICENSE("GPL");

MODULE_ALIAS?

> diff --git a/include/linux/synaptics_i2c_rmi.h b/include/linux/synapt=
ics_i2c_rmi.h
> new file mode 100644
> index 0000000..73e1de7
> --- /dev/null
> +++ b/include/linux/synaptics_i2c_rmi.h
> @@ -0,0 +1,53 @@
> +/*
> + * synaptics_i2c_rmi.h - platform data structure for f75375s sensor
> + *
> + * Copyright (C) 2008 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef _LINUX_SYNAPTICS_I2C_RMI_H
> +#define _LINUX_SYNAPTICS_I2C_RMI_H
> +
> +#define SYNAPTICS_I2C_RMI_NAME "synaptics-rmi-ts"
> +
> +enum {
> + =A0 =A0 =A0 SYNAPTICS_FLIP_X =3D 1UL << 0,
> + =A0 =A0 =A0 SYNAPTICS_FLIP_Y =3D 1UL << 1,
> + =A0 =A0 =A0 SYNAPTICS_SWAP_XY =3D 1UL << 2,
> + =A0 =A0 =A0 SYNAPTICS_SNAP_TO_INACTIVE_EDGE =3D 1UL << 3,
> +};
> +
> +struct synaptics_i2c_rmi_platform_data {
> + =A0 =A0 =A0 u32 version; =A0 =A0/* Use this entry for panels with *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* (maj=
or << 8 | minor) version or above. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If n=
on-zero another array entry follows */
> + =A0 =A0 =A0 int (*power)(int on); =A0 /* Only valid in first array =
entry */
> + =A0 =A0 =A0 u32 flags;
> + =A0 =A0 =A0 u32 inactive_left; /* 0x10000 =3D screen width */
> + =A0 =A0 =A0 u32 inactive_right; /* 0x10000 =3D screen width */
> + =A0 =A0 =A0 u32 inactive_top; /* 0x10000 =3D screen height */
> + =A0 =A0 =A0 u32 inactive_bottom; /* 0x10000 =3D screen height */
> + =A0 =A0 =A0 u32 snap_left_on; /* 0x10000 =3D screen width */
> + =A0 =A0 =A0 u32 snap_left_off; /* 0x10000 =3D screen width */
> + =A0 =A0 =A0 u32 snap_right_on; /* 0x10000 =3D screen width */
> + =A0 =A0 =A0 u32 snap_right_off; /* 0x10000 =3D screen width */
> + =A0 =A0 =A0 u32 snap_top_on; /* 0x10000 =3D screen height */
> + =A0 =A0 =A0 u32 snap_top_off; /* 0x10000 =3D screen height */
> + =A0 =A0 =A0 u32 snap_bottom_on; /* 0x10000 =3D screen height */
> + =A0 =A0 =A0 u32 snap_bottom_off; /* 0x10000 =3D screen height */
> + =A0 =A0 =A0 u32 fuzz_x; /* 0x10000 =3D screen width */
> + =A0 =A0 =A0 u32 fuzz_y; /* 0x10000 =3D screen height */
> + =A0 =A0 =A0 int fuzz_p;
> + =A0 =A0 =A0 int fuzz_w;
> +};
> +
> +#endif /* _LINUX_SYNAPTICS_I2C_RMI_H */
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
