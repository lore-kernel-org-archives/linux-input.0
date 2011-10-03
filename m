From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Input:Adding support for Wacom Stylus with I2C interface
Date: Mon, 3 Oct 2011 15:16:22 -0500
Message-ID: <CAGzDe_ZbC_Agd_jnNAjZx-ck+A9B02kKdjEc01=1u=9XqhUNwg@mail.gmail.com>
References: <1317630471-2479-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51107 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab1JCUQX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2011 16:16:23 -0400
Received: by iakk32 with SMTP id k32so146012iak.19
        for <linux-input@vger.kernel.org>; Mon, 03 Oct 2011 13:16:22 -0700 (PDT)
In-Reply-To: <1317630471-2479-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org, Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

Hi Tatsunosuke,

I am not qualified to comment on driver framework but I have a comment
on the pen packet processing below.

On Mon, Oct 3, 2011 at 3:27 AM, Tatsunosuke Tobita
<junkpainting@gmail.com> wrote:
> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>
>
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> ---
> =A0drivers/input/touchscreen/wacom_i2c.c =A0 =A0 =A0| =A0216 ++++++++=
++++++++++++++++++++
> =A0drivers/input/touchscreen/wacom_i2c.h =A0 =A0 =A0| =A0 66 ++++++++=
+
> =A0drivers/input/touchscreen/wacom_i2c_func.c | =A0 81 +++++++++++
> =A0drivers/input/touchscreen/wacom_i2c_func.h | =A0 =A08 +
> =A04 files changed, 371 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.c
> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.h
> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c_func.c
> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c_func.h
>
> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/to=
uchscreen/wacom_i2c.c
> new file mode 100644
> index 0000000..4f5910a
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c.c
> @@ -0,0 +1,216 @@
> +/*
> + * Wacom Penabled Driver for I2C
> + *
> + * Copyright (c) 2011 Tatsunosuke Tobita, Wacom.
> + * <tobita.tatsunosuke@wacom.co.jp>
> + *
> + * This program is free software; you can redistribute it
> + * and/or modify it under the terms of the GNU General
> + * Public License as published by the Free Software
> + * Foundation; either version of 2 of the License,
> + * or (at your option) any later version.
> + *
> + * Note: Wacom Penabled Driver for I2C obtains data by polling.
> + * If you use irq, you must use the edge based rising
> + * interruption with low level pin.
> + */
> +
> +#include <linux/device.h>
> +#include "wacom_i2c_func.h"
> +
> +const unsigned short addr[2];
> +
> +static void wacom_i2c_workqueue(struct work_struct *workq)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D container_of(workq, struc=
t wacom_i2c, workq);
> + =A0 =A0 =A0 wacom_set_coordination(wac_i2c);
> +}
> +
> +static enum hrtimer_restart wacom_i2c_timer(struct hrtimer *timer)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D container_of(timer, struc=
t wacom_i2c, timer);
> +
> + =A0 =A0 =A0 queue_work(wacom_i2c_wq, &wac_i2c->workq);
> + =A0 =A0 =A0 hrtimer_start(&wac_i2c->timer, ktime_set(0, POLL_RATE),=
 HRTIMER_MODE_REL);
> +
> + =A0 =A0 =A0 return HRTIMER_NORESTART;
> +}
> +
> +static int wacom_i2c_input_open(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D input_get_drvdata(dev);
> +
> + =A0 =A0 =A0 mutex_lock(&wac_i2c->lock);
> + =A0 =A0 =A0 wac_i2c->dev->open =3D true;
> + =A0 =A0 =A0 mutex_unlock(&wac_i2c->lock);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void wacom_i2c_input_close(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D input_get_drvdata(dev);
> +
> + =A0 =A0 =A0 mutex_lock(&wac_i2c->lock);
> + =A0 =A0 =A0 wac_i2c->dev->open =3D false;
> + =A0 =A0 =A0 mutex_unlock(&wac_i2c->lock);
> +}
> +
> +static void wacom_i2c_set_input_values(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct wacom_i2c *wac_i2c, struct input_dev *dev)
> +{
> + =A0 =A0 =A0 dev->name =3D "WACOM_I2C_DIGITIZER";
> + =A0 =A0 =A0 dev->id.bustype =3D BUS_I2C;
> + =A0 =A0 =A0 dev->id.vendor =3D 0x56a;
> + =A0 =A0 =A0 dev->dev.parent =3D &client->dev;
> + =A0 =A0 =A0 dev->open =3D wacom_i2c_input_open;
> + =A0 =A0 =A0 dev->close =3D wacom_i2c_input_close;
> + =A0 =A0 =A0 dev->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +
> + =A0 =A0 =A0 __set_bit(ABS_X, dev->absbit);
> + =A0 =A0 =A0 __set_bit(ABS_Y, dev->absbit);
> + =A0 =A0 =A0 __set_bit(ABS_PRESSURE, dev->absbit);
> + =A0 =A0 =A0 __set_bit(BTN_TOOL_PEN, dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_TOOL_RUBBER, dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_STYLUS, dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_STYLUS2, dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_TOUCH, dev->keybit);
> +}
> +
> +static int wacom_i2c_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct i2c=
_device_id *id)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c;
> + =A0 =A0 =A0 int i, ret;
> + =A0 =A0 =A0 i =3D ret =3D 0;
> +
> + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FUNC_=
I2C))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> +
> + =A0 =A0 =A0 wac_i2c =3D kzalloc(sizeof(struct wacom_i2c), GFP_KERNE=
L);
> + =A0 =A0 =A0 wac_i2c->wac_feature =3D &wacom_feature_EMR;
> +
> + =A0 =A0 =A0 mutex_init(&wac_i2c->lock);
> +
> + =A0 =A0 =A0 wac_i2c->dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (wac_i2c =3D=3D NULL || wac_i2c->dev =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
> + =A0 =A0 =A0 wacom_i2c_set_input_values(client, wac_i2c, wac_i2c->de=
v);
> +
> + =A0 =A0 =A0 wac_i2c->client =3D client;
> +
> + =A0 =A0 =A0 INIT_WORK(&wac_i2c->workq, wacom_i2c_workqueue);
> +
> + =A0 =A0 =A0 ret =3D wacom_send_query(wac_i2c);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> +
> + =A0 =A0 =A0 wac_i2c->dev->id.version =3D wac_i2c->wac_feature->fw_v=
ersion;
> + =A0 =A0 =A0 input_set_abs_params(wac_i2c->dev, ABS_X, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac=
_feature->x_max, 0, 0);
> + =A0 =A0 =A0 input_set_abs_params(wac_i2c->dev, ABS_Y, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac=
_feature->y_max, 0, 0);
> + =A0 =A0 =A0 input_set_abs_params(wac_i2c->dev, ABS_PRESSURE, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac=
_feature->pressure_max, 0, 0);
> + =A0 =A0 =A0 input_set_drvdata(wac_i2c->dev, wac_i2c);
> +
> + =A0 =A0 =A0 i2c_set_clientdata(client, wac_i2c);
> + =A0 =A0 =A0 if (input_register_device(wac_i2c->dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> +
> + =A0 =A0 =A0 hrtimer_init(&wac_i2c->timer, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
> + =A0 =A0 =A0 wac_i2c->timer.function =3D wacom_i2c_timer;
> + =A0 =A0 =A0 hrtimer_start(&wac_i2c->timer, ktime_set(1, 0), HRTIMER=
_MODE_REL);
> + =A0 =A0 =A0 printk(KERN_INFO "WACOM_I2C_DIGITIZER: initialized and =
started \n");
> +
> + =A0 =A0 =A0 return 0;
> +
> + err2:
> + =A0 =A0 =A0 printk(KERN_ERR "wacom_i2c:No I2C functionality found\n=
");
> + =A0 =A0 =A0 return -ENODEV;
> +
> + err1:
> + =A0 =A0 =A0 printk(KERN_ERR "wacom_i2c:err1 occured(num:%d)\n", ret=
);
> + =A0 =A0 =A0 input_free_device(wac_i2c->dev);
> + =A0 =A0 =A0 wac_i2c->dev =3D NULL;
> + =A0 =A0 =A0 return -EIO;
> +
> + fail:
> + =A0 =A0 =A0 printk(KERN_ERR "wacom_i2c:fail occured\n");
> + =A0 =A0 =A0 return -ENOMEM;
> +}
> +
> +static int wacom_i2c_remove(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D i2c_get_clientdata(client=
);
> +
> + =A0 =A0 =A0 input_unregister_device(wac_i2c->dev);
> + =A0 =A0 =A0 hrtimer_cancel(&wac_i2c->timer);
> + =A0 =A0 =A0 kfree(wac_i2c);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int wacom_i2c_suspend(struct i2c_client *client, pm_message_t=
 mesg)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D i2c_get_clientdata(client=
);
> +
> + =A0 =A0 =A0 hrtimer_cancel(&wac_i2c->timer);
> + =A0 =A0 =A0 cancel_work_sync(&wac_i2c->workq);
> + =A0 =A0 =A0 ret =3D wac_i2c->power(0);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int wacom_i2c_resume(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D i2c_get_clientdata(client=
);
> +
> + =A0 =A0 =A0 hrtimer_start(&wac_i2c->timer, ktime_set(1, 0), HRTIMER=
_MODE_REL);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct i2c_device_id wacom_i2c_id[] =3D {
> + =A0 =A0 =A0 {WACNAME, 0},
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(i2c, wacom_i2c_id);
> +
> +static struct i2c_driver wacom_i2c_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "wacom_i2c",
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 .probe =3D wacom_i2c_probe,
> + =A0 =A0 =A0 .remove =3D wacom_i2c_remove,
> + =A0 =A0 =A0 .suspend =3D wacom_i2c_suspend,
> + =A0 =A0 =A0 .resume =3D wacom_i2c_resume,
> + =A0 =A0 =A0 .id_table =3D wacom_i2c_id,
> +};
> +
> +static int __init wacom_i2c_init()
> +{
> +
> + =A0 =A0 =A0 wacom_i2c_wq =3D create_singlethread_workqueue("wacom_i=
2c_wq");
> + =A0 =A0 =A0 if (!wacom_i2c_wq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 return i2c_add_driver(&wacom_i2c_driver);
> +}
> +
> +static void __exit wacom_i2c_exit()
> +{
> + =A0 =A0 =A0 if (wacom_i2c_wq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 destroy_workqueue(wacom_i2c_wq);
> +
> + =A0 =A0 =A0 i2c_del_driver(&wacom_i2c_driver);
> +}
> +
> +module_init(wacom_i2c_init);
> +module_exit(wacom_i2c_exit);
> +
> +MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>")=
;
> +MODULE_DESCRIPTION("WACOM EMR I2C Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/input/touchscreen/wacom_i2c.h b/drivers/input/to=
uchscreen/wacom_i2c.h
> new file mode 100644
> index 0000000..4c5f79f
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c.h
> @@ -0,0 +1,66 @@
> +#ifndef WACOM_I2C_H
> +#define WAOCM_I2C_H
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/hrtimer.h>
> +#include <linux/delay.h>
> +#include <linux/uaccess.h>
> +#include <asm/unaligned.h>
> +
> +#define NAMEBUF 12
> +#define WACNAME "WAC_I2C_EMR"
> +
> +/*Wacom Command*/
> +#define COM_COORD_NUM =A0 =A0 =A0256
> +#define COM_SAMPLERATE_40 =A00x33
> +#define COM_SAMPLERATE_80 =A00x32
> +#define COM_SAMPLERATE_133 0x31
> +#define CMD_QUERY0 =A0 =A0 =A0 =A0 0x04
> +#define CMD_QUERY1 =A0 =A0 =A0 =A0 0x00
> +#define CMD_QUERY2 =A0 =A0 =A0 =A0 0x33
> +#define CMD_QUERY3 =A0 =A0 =A0 =A0 0x02
> +#define CMD_THROW0 =A0 =A0 =A0 =A0 0x05
> +#define CMD_THROW1 =A0 =A0 =A0 =A0 0x00
> +#define QUERY_SIZE =A0 =A0 =A0 =A0 =A0 19
> +
> +/*I2C address for digitizer*/
> +#define WACOM_I2C_ADDR =A0 0x09
> +
> +/*Polling Rate*/
> +#define POLL_RATE 7500000
> +
> +static struct workqueue_struct *wacom_i2c_wq;
> +
> +/*Parameters for wacom own features*/
> +struct wacom_features {
> + =A0 =A0 =A0 int x_max;
> + =A0 =A0 =A0 int y_max;
> + =A0 =A0 =A0 int pressure_max;
> + =A0 =A0 =A0 char fw_version;
> + =A0 =A0 =A0 u8 data[COM_COORD_NUM];
> +};
> +
> +static struct wacom_features wacom_feature_EMR =3D {
> + =A0 =A0 =A0 16128,
> + =A0 =A0 =A0 8448,
> + =A0 =A0 =A0 256,
> + =A0 =A0 =A0 0x10
> +};
> +
> +/*Parameters for i2c driver*/
> +struct wacom_i2c {
> + =A0 =A0 =A0 struct i2c_client *client;
> + =A0 =A0 =A0 struct input_dev *dev;
> + =A0 =A0 =A0 struct mutex lock;
> + =A0 =A0 =A0 struct work_struct workq;
> + =A0 =A0 =A0 struct hrtimer timer;
> + =A0 =A0 =A0 struct wacom_features *wac_feature;
> + =A0 =A0 =A0 int (*power)(int on);
> + =A0 =A0 =A0 const char name[NAMEBUF];
> +};
> +#endif
> diff --git a/drivers/input/touchscreen/wacom_i2c_func.c b/drivers/inp=
ut/touchscreen/wacom_i2c_func.c
> new file mode 100644
> index 0000000..51e6f4f
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c_func.c
> @@ -0,0 +1,81 @@
> +#include "wacom_i2c_func.h"
> +
> +int wacom_send_query(struct wacom_i2c *wac_i2c)
> +{
> + =A0 =A0 =A0 struct wacom_features *wac_feature =3D wac_i2c->wac_fea=
ture;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 u8 cmd[4] =3D {CMD_QUERY0, CMD_QUERY1, CMD_QUERY2, CMD_=
QUERY3};
> + =A0 =A0 =A0 u8 data[COM_COORD_NUM];
> +
> + =A0 =A0 =A0 ret =3D i2c_master_send(wac_i2c->client, cmd, sizeof(cm=
d));
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "wacom_i2c: Sending Que=
ry failed \n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 cmd[0] =3D CMD_THROW0; cmd[1] =3D CMD_THROW1;
> + =A0 =A0 =A0 ret =3D i2c_master_send(wac_i2c->client, cmd, 2);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "wacom_i2c: Sending Que=
ry failed \n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D i2c_master_recv(wac_i2c->client, data, QUERY_SI=
ZE);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "wacom_i2c: Receiving Q=
uery failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 wac_feature->x_max =3D get_unaligned_le16(&data[3]);
> + =A0 =A0 =A0 wac_feature->y_max =3D get_unaligned_le16(&data[5]);
> + =A0 =A0 =A0 wac_feature->pressure_max =3D get_unaligned_le16(&data[=
11]);
> + =A0 =A0 =A0 wac_feature->fw_version =3D get_unaligned_le16(&data[13=
]);
> +
> + =A0 =A0 =A0 printk(KERN_INFO "wacom_i2c: x_max:%d, y_max:%d, pressu=
re:%d, fw:%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_feature->x_max, wac_feature->y_max, =
wac_feature->pressure_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_feature->fw_version);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int wacom_set_coordination(struct wacom_i2c *wac_i2c)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 unsigned int x_max, y_max;
> + =A0 =A0 =A0 unsigned int x, y, pressure;
> + =A0 =A0 =A0 unsigned char rdy, tsw, f1, f2, ers;
> + =A0 =A0 =A0 u8 *data;
> +
> + =A0 =A0 =A0 data =3D wac_i2c->wac_feature->data;
> + =A0 =A0 =A0 x_max =3D wac_i2c->wac_feature->x_max;
> + =A0 =A0 =A0 y_max =3D wac_i2c->wac_feature->y_max;

Unreferenced variables?

> +
> + =A0 =A0 =A0 ret =3D i2c_master_recv(wac_i2c->client, data, QUERY_SI=
ZE);
> + =A0 =A0 =A0 if (ret >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsw =3D data[3]&0x01;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ers =3D data[3]&0x04;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f1 =3D data[3]&0x02;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f2 =3D data[3]&0x10;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rdy =3D data[3]&0x20;

rdy appears not to be referenced below so I would think that pen only
works while touching screen in this driver.

The packet format looks the same as that used over serial link by
wacom_w8001.c driver.  That driver addresses the complexity in
detecting pen versus eraser and works while hovering.  Looks like you
can copy that logic.

Chris

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D le16_to_cpup((__le16 *)&data[4]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 y =3D le16_to_cpup((__le16 *)&data[6]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D le16_to_cpup((__le16 *)&da=
ta[8]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(wac_i2c->dev, ABS_X, x=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(wac_i2c->dev, ABS_Y, y=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(wac_i2c->dev, ABS_PRES=
SURE, pressure);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->dev, BTN_TOOL=
_PEN, tsw);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->dev, BTN_STYL=
US, f1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->dev, BTN_STYL=
US2, f2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->dev, BTN_TOOL=
_RUBBER, ers);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->dev, BTN_TOUC=
H, (tsw || ers));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(wac_i2c->dev);
> +
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> diff --git a/drivers/input/touchscreen/wacom_i2c_func.h b/drivers/inp=
ut/touchscreen/wacom_i2c_func.h
> new file mode 100644
> index 0000000..cce35c4
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c_func.h
> @@ -0,0 +1,8 @@
> +#ifndef WACOM_I2C_FUNC_H
> +#define WACOM_I2C_FUNC_H
> +
> +#include "wacom_i2c.h"
> +
> +int wacom_set_coordination(struct wacom_i2c *wac_i2c);
> +int wacom_send_query(struct wacom_i2c *wac_i2c);
> +#endif
> --
> 1.7.1
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
