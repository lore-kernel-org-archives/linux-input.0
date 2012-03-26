From: Tatsunosuke Tobita <junkpainting@gmail.com>
Subject: Re: [PATCH] Input: Wacom Stylus driver for I2C interface
Date: Mon, 26 Mar 2012 12:05:09 +0900
Message-ID: <CA+MtpR2TLL9rUd16KoDe7jvZ3kosYBVOuk88FipHoAbVh_e8yQ@mail.gmail.com>
References: <1332481207-6224-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
	<20120325235034.GA1054@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62833 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932142Ab2CZDFL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Mar 2012 23:05:11 -0400
Received: by bkcik5 with SMTP id ik5so3622595bkc.19
        for <linux-input@vger.kernel.org>; Sun, 25 Mar 2012 20:05:09 -0700 (PDT)
In-Reply-To: <20120325235034.GA1054@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Shubhrajyoti <shubhrajyoti@ti.com>

Hi Dmitry

On Mon, Mar 26, 2012 at 8:50 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Tatsunosuke,
>
> On Fri, Mar 23, 2012 at 02:40:07PM +0900, Tatsunosuke Tobita wrote:
>> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>>
>> This adds support for Wacom Stylus device with I2C interface.
>> The modification from the previous update is replacing module_init a=
nd
>> module_exit with module_i2c_driver.
>>
>> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>> ---
>> =A0drivers/input/touchscreen/wacom_i2c.c | =A0238 ++++++++++++++++++=
+++++++++++++++
>> =A0drivers/input/touchscreen/wacom_i2c.h | =A0 55 ++++++++
>> =A02 files changed, 293 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.c
>> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.h
>>
>> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/t=
ouchscreen/wacom_i2c.c
>> new file mode 100644
>> index 0000000..f5a3845
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/wacom_i2c.c
>> @@ -0,0 +1,238 @@
>> +/*
>> + * Wacom Penabled Driver for I2C
>> + *
>> + * Copyright (c) 2011 Tatsunosuke Tobita, Wacom.
>> + * <tobita.tatsunosuke@wacom.co.jp>
>> + *
>> + * This program is free software; you can redistribute it
>> + * and/or modify it under the terms of the GNU General
>> + * Public License as published by the Free Software
>> + * Foundation; either version of 2 of the License,
>> + * or (at your option) any later version.
>> + */
>> +
>> +#include "wacom_i2c.h"
>> +
>> +static int wacom_send_query(struct wacom_i2c *wac_i2c)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 u8 cmd[4] =3D {CMD_QUERY0, CMD_QUERY1, CMD_QUERY2, CMD_QUE=
RY3};
>> + =A0 =A0 u8 data[COM_COORD_NUM];
>> +
>> + =A0 =A0 ret =3D i2c_master_send(wac_i2c->client, cmd, sizeof(cmd))=
;
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Sending 1st Query =
failed \n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>
> As Shubhrajyoti already mentioned you should not clobber errors retur=
ned
> by i2c_master_send with a generic -1 (-EPERM).
Right, I will check on this.

>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 cmd[0] =3D CMD_THROW0; cmd[1] =3D CMD_THROW1;
>> + =A0 =A0 ret =3D i2c_master_send(wac_i2c->client, cmd, 2);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Sending 2nd Query =
failed \n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D i2c_master_recv(wac_i2c->client, data, QUERY_SIZE)=
;
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Receiving data fai=
led 1\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 }
>
> I wonder if all this could be converted into a single i2c_transfer().
The difficulty combining those into one is because our device allow to
receive the command as
the proper order. Therefore, I split it; sending the first command and
the second command, and receiving the information of the device as the
result.

>
>> +
>> + =A0 =A0 wac_i2c->wac_feature.x_max =3D get_unaligned_le16(&data[3]=
);
>> + =A0 =A0 wac_i2c->wac_feature.y_max =3D get_unaligned_le16(&data[5]=
);
>> + =A0 =A0 wac_i2c->wac_feature.pressure_max =3D get_unaligned_le16(&=
data[11]);
>> + =A0 =A0 wac_i2c->wac_feature.fw_version =3D get_unaligned_le16(&da=
ta[13]);
>> +
>> + =A0 =A0 dev_dbg(&wac_i2c->client->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"x_max:%d, y_max:%d, pressure:%d, f=
w:%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_feature.x_max, wac_i2c=
->wac_feature.y_max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_feature.pressure_max, =
wac_i2c->wac_feature.fw_version);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static irqreturn_t wacom_i2c_irq(int irqno, void *param)
>> +{
>> + =A0 =A0 struct wacom_i2c *wac_i2c =3D param;
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 unsigned int x, y, pressure;
>> + =A0 =A0 unsigned char tsw, f1, f2, ers;
>> + =A0 =A0 u8 data[COM_COORD_NUM];
>> +
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_master_recv(wac_i2c->client, d=
ata, QUERY_SIZE);
>> + =A0 =A0 } while (gpio_get_value(irq_to_gpio(wac_i2c->client->irq))=
 =3D=3D 0);
>
> irq_to_gpio() may fail. Also it does not make sense to do the convers=
ion
> in interrupt handler if it can be done once, at probe() time.
Our device stores data as many as possible in buffer when the stylus
is in proximity and it
keeps an irq line low. So, we should check if all data is transfered;
otherwise, the device
keeps the irq line as low and no interrupt could not be detected after =
words.
So, in fact, this is implemented just in case. Should I use work-queue
here to do the same functionality?

>
>> +
>> + =A0 =A0 if (ret > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 tsw =3D data[3]&0x01;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ers =3D data[3]&0x04;
>> + =A0 =A0 =A0 =A0 =A0 =A0 f1 =3D data[3]&0x02;
>> + =A0 =A0 =A0 =A0 =A0 =A0 f2 =3D data[3]&0x10;
>> + =A0 =A0 =A0 =A0 =A0 =A0 x =3D le16_to_cpup((__le16 *)&data[4]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 y =3D le16_to_cpup((__le16 *)&data[6]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D le16_to_cpup((__le16 *)&data[=
8]);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(wac_i2c->input, ABS_X, x)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(wac_i2c->input, ABS_Y, y)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->input, BTN_TOOL_=
PEN, tsw);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->input, BTN_TOOL_=
RUBBER, ers);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(wac_i2c->input, ABS_PRESS=
URE, pressure);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->input, BTN_TOUCH=
, (tsw || ers));
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->input, BTN_STYLU=
S, f1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->input, BTN_STYLU=
S2, f2);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_sync(wac_i2c->input);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static int wacom_i2c_input_open(struct input_dev *dev)
>> +{
>> + =A0 =A0 struct wacom_i2c *wac_i2c =3D input_get_drvdata(dev);
>> + =A0 =A0 int ret;
>> + =A0 =A0 ret =3D wacom_send_query(wac_i2c);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> +
>> + =A0 =A0 wac_i2c->input->id.version =3D wac_i2c->wac_feature.fw_ver=
sion;
>> + =A0 =A0 input_set_abs_params(wac_i2c->input, ABS_X, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_fe=
ature.x_max, 0, 0);
>> + =A0 =A0 input_set_abs_params(wac_i2c->input, ABS_Y, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_fe=
ature.y_max, 0, 0);
>> + =A0 =A0 input_set_abs_params(wac_i2c->input, ABS_PRESSURE, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_fe=
ature.pressure_max, 0, 0);
>
> This should be done when registering input device.
>
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void wacom_i2c_input_close(struct input_dev *dev)
>> +{
>> +}
>
> Empty methods are not needed.
>
>> +
>> +static int __devinit wacom_i2c_probe(struct i2c_client *client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct i2c_de=
vice_id *id)
>> +{
>> + =A0 =A0 struct wacom_i2c *wac_i2c;
>> + =A0 =A0 int err;
>> + =A0 =A0 u8 data[COM_COORD_NUM];
>> +
>> + =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 wac_i2c =3D kzalloc(sizeof(*wac_i2c), GFP_KERNEL);
>> + =A0 =A0 if (wac_i2c =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 wac_i2c->input =3D input_allocate_device();
>> + =A0 =A0 if (wac_i2c->input =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 wac_i2c->client =3D client;
>> + =A0 =A0 i2c_set_clientdata(client, wac_i2c);
>> + =A0 =A0 mutex_init(&wac_i2c->lock);
>
> What is this lock used for?
This should be  considered for the future when we need it at first, but
I understand that should be included when it is exactly needed.
I will get rid of this.
>
>> +
>> + =A0 =A0 __set_bit(BTN_TOOL_PEN, wac_i2c->input->keybit);
>> + =A0 =A0 __set_bit(BTN_TOOL_RUBBER, wac_i2c->input->keybit);
>> + =A0 =A0 __set_bit(BTN_STYLUS, wac_i2c->input->keybit);
>> + =A0 =A0 __set_bit(BTN_STYLUS2, wac_i2c->input->keybit);
>> + =A0 =A0 __set_bit(BTN_TOUCH, wac_i2c->input->keybit);
>> +
>> + =A0 =A0 wac_i2c->input->name =3D "Wacom I2C Digitizer";
>> + =A0 =A0 wac_i2c->input->id.bustype =3D BUS_I2C;
>> + =A0 =A0 wac_i2c->input->id.vendor =3D 0x56a;
>> + =A0 =A0 wac_i2c->input->dev.parent =3D &client->dev;
>> + =A0 =A0 wac_i2c->input->open =3D wacom_i2c_input_open;
>> + =A0 =A0 wac_i2c->input->close =3D wacom_i2c_input_close;
>> + =A0 =A0 wac_i2c->input->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(=
EV_ABS);
>> + =A0 =A0 input_set_drvdata(wac_i2c->input, wac_i2c);
>> +
>> + =A0 =A0 if (input_register_device(wac_i2c->input)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev=
, "Failed to register input device \n");
>
> dev_err() and dev_info() throughout.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENODEV;
>
> The proper error is ENOMEM.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
>> + =A0 =A0 }
>> +
>> +
>> + =A0 =A0 err =3D request_threaded_irq(wac_i2c->client->irq, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac=
om_i2c_irq, IRQF_TRIGGER_FALLING, "WACOM_I2C_IRQ", wac_i2c);
>> + =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev=
, "Failed to enable IRQ for EMR \n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*Clear the buffer in the firmware*/
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 i2c_master_recv(wac_i2c->client, data, QUE=
RY_SIZE);
>> + =A0 =A0 } while (gpio_get_value(irq_to_gpio(wac_i2c->client->irq))=
 =3D=3D 0);
>
> This should be done at open() time.
>
>> +
>> + =A0 =A0 return 0;
>> +
>> + fail3:
>> + =A0 =A0 input_free_device(wac_i2c->input);
>> + fail2:
>> + =A0 =A0 dev_err(&wac_i2c->client->dev, "Freeing device \n");
>> + fail1:
>> + =A0 =A0 return err;
>> +}
>> +
>> +static int __devexit wacom_i2c_remove(struct i2c_client *client)
>> +{
>> + =A0 =A0 struct wacom_i2c *wac_i2c =3D i2c_get_clientdata(client);
>> +
>> + =A0 =A0 free_irq(wac_i2c->client->irq, wac_i2c);
>> + =A0 =A0 input_unregister_device(wac_i2c->input);
>> + =A0 =A0 kfree(wac_i2c);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int wacom_i2c_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> + =A0 =A0 disable_irq(client->irq);
>
> I guess disabling IRQ is OK for now, but don't you want to use it as =
a
> wakeup source?
Can you tell more in detail? I don't understand exactly mean "wakeup so=
urce".
Thanks.

>
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int wacom_i2c_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> + =A0 =A0 enable_irq(client->irq);
>> +
>> + =A0 =A0 return 0;
>> +}
>
> Suspend and resume should be guarded by #ifdef CONFIG_PM_SLEEP
>
>> +
>> +static SIMPLE_DEV_PM_OPS(wacom_i2c_pm, wacom_i2c_suspend, wacom_i2c=
_resume);
>> +
>> +static const struct i2c_device_id wacom_i2c_id[] =3D {
>> + =A0 =A0 {WACNAME, 0},
>> + =A0 =A0 {},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, wacom_i2c_id);
>> +
>> +static struct i2c_driver wacom_i2c_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "wacom_i2c",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &wacom_i2c_pm,
>> + =A0 =A0 },
>> +
>> + =A0 =A0 .probe =3D wacom_i2c_probe,
>> + =A0 =A0 .remove =3D __devexit_p(wacom_i2c_remove),
>> + =A0 =A0 .id_table =3D wacom_i2c_id,
>> +};
>> +module_i2c_driver(wacom_i2c_driver);
>> +
>> +MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>"=
);
>> +MODULE_DESCRIPTION("WACOM EMR I2C Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/input/touchscreen/wacom_i2c.h b/drivers/input/t=
ouchscreen/wacom_i2c.h
>> new file mode 100644
>> index 0000000..b5c2d07
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/wacom_i2c.h
>> @@ -0,0 +1,55 @@
>> +/*
>> + * Wacom Penabled Driver for I2C
>> + *
>> + * Copyright (c) 2011 Tatsunosuke Tobita, Wacom.
>> + * <tobita.tatsunosuke@wacom.co.jp>
>> + *
>> + * This program is free software; you can redistribute it
>> + * and/or modify it under the terms of the GNU General
>> + * Public License as published by the Free Software
>> + * Foundation; either version of 2 of the License,
>> + * or (at your option) any later version.
>> + */
>> +
>> +#ifndef WACOM_I2C_H
>> +#define WACOM_I2C_H
>> +
>> +#include <linux/module.h>
>> +#include <linux/input.h>
>> +#include <linux/i2c.h>
>> +#include <linux/slab.h>
>> +#include <linux/irq.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/gpio.h>
>> +#include <asm/unaligned.h>
>> +
>> +#define NAMEBUF 12
>
> Not used.
>
>> +#define WACNAME "WAC_I2C_EMR"
>> +
>> +/*Wacom Command*/
>> +#define COM_COORD_NUM =A0 =A0 =A0128
>> +#define CMD_QUERY0 =A0 =A0 =A0 =A0 0x04
>> +#define CMD_QUERY1 =A0 =A0 =A0 =A0 0x00
>> +#define CMD_QUERY2 =A0 =A0 =A0 =A0 0x33
>> +#define CMD_QUERY3 =A0 =A0 =A0 =A0 0x02
>> +#define CMD_THROW0 =A0 =A0 =A0 =A0 0x05
>> +#define CMD_THROW1 =A0 =A0 =A0 =A0 0x00
>> +#define QUERY_SIZE =A0 =A0 =A0 =A0 =A0 19
>> +
>> +/*Parameters for wacom own features*/
>> +struct wacom_features {
>> + =A0 =A0 int x_max;
>> + =A0 =A0 int y_max;
>> + =A0 =A0 int pressure_max;
>> + =A0 =A0 char fw_version;
>> +};
>> +
>> +/*Parameters for i2c driver*/
>> +struct wacom_i2c {
>> + =A0 =A0 struct i2c_client *client;
>> + =A0 =A0 struct input_dev *input;
>> + =A0 =A0 struct mutex lock;
>
> Not used.
>
>> + =A0 =A0 struct wacom_features wac_feature;
>
> No need to carry this around, you only use it once.
>
>> + =A0 =A0 int type;
>
> Not needed.
>
>> +};
>> +#endif
>
> I also do not see why you need a separate header file and why you spl=
it
> this into 2 patches - one with driver and another with Kconfig/Makefi=
le
> adjustments.
Separating the codes may be clear to see, I thought.
The reason I made 2 patches is because when combining drivers and one
with Kconfig/Makefile,
it fails to patch in high percentage. On the other hand, when I make
two patched separately, it always
succeeds. That is the reason.

>
> Could you please try the version below and let me know if it works fo=
r
> you. Thanks!
Thank you for your support and help; this is much appreciated.
I will look through the code you created and learn more about your
idea; then compile
it and tell you the result!
Hope, it won't take long ;)

Tats

>
> --
> Dmitry
>
>
> Input: add support for Wacom Stylus device with I2C interface
>
> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>
> This adds support for Wacom Stylus device with I2C interface.
>
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/touchscreen/Kconfig =A0 =A0 | =A0 12 +
> =A0drivers/input/touchscreen/Makefile =A0 =A0| =A0 =A01
> =A0drivers/input/touchscreen/wacom_i2c.c | =A0338 +++++++++++++++++++=
++++++++++++++
> =A03 files changed, 351 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.c
>
>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index 3594591..1773001 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -323,6 +323,18 @@ config TOUCHSCREEN_WACOM_W8001
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called wacom_w8001.
>
> +config TOUCHSCREEN_WACOM_I2C
> + =A0 =A0 =A0 tristate "Wacom Tablet support (I2C)"
> + =A0 =A0 =A0 depends on I2C
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here if you want to use the I2C version of th=
e Wacom
> + =A0 =A0 =A0 =A0 Pen Tablet.
> +
> + =A0 =A0 =A0 =A0 If unsure, say N.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the module
> + =A0 =A0 =A0 =A0 will be called wacom_i2c.
> +
> =A0config TOUCHSCREEN_LPC32XX
> =A0 =A0 =A0 =A0tristate "LPC32XX touchscreen controller"
> =A0 =A0 =A0 =A0depends on ARCH_LPC32XX
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index b6c746e0..eb8bfe1 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_TOUCHSCREEN_TSC2005) =A0 =A0 +=3D tsc2=
005.o
> =A0obj-$(CONFIG_TOUCHSCREEN_TSC2007) =A0 =A0 =A0+=3D tsc2007.o
> =A0obj-$(CONFIG_TOUCHSCREEN_UCB1400) =A0 =A0 =A0+=3D ucb1400_ts.o
> =A0obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001) =A0+=3D wacom_w8001.o
> +obj-$(CONFIG_TOUCHSCREEN_WACOM_I2C) =A0 =A0+=3D wacom_i2c.o
> =A0obj-$(CONFIG_TOUCHSCREEN_WM831X) =A0 =A0 =A0 +=3D wm831x-ts.o
> =A0obj-$(CONFIG_TOUCHSCREEN_WM97XX) =A0 =A0 =A0 +=3D wm97xx-ts.o
> =A0wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9705) +=3D wm9705.o
> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/to=
uchscreen/wacom_i2c.c
> new file mode 100644
> index 0000000..88e0800
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c.c
> @@ -0,0 +1,338 @@
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
> + */
> +
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <asm/unaligned.h>
> +
> +#define WACOM_CMD_QUERY0 =A0 =A0 =A0 0x04
> +#define WACOM_CMD_QUERY1 =A0 =A0 =A0 0x00
> +#define WACOM_CMD_QUERY2 =A0 =A0 =A0 0x33
> +#define WACOM_CMD_QUERY3 =A0 =A0 =A0 0x02
> +#define WACOM_CMD_THROW0 =A0 =A0 =A0 0x05
> +#define WACOM_CMD_THROW1 =A0 =A0 =A0 0x00
> +#define WACOM_QUERY_SIZE =A0 =A0 =A0 19
> +#define WACOM_RETRY_CNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0100
> +
> +struct wacom_features {
> + =A0 =A0 =A0 int x_max;
> + =A0 =A0 =A0 int y_max;
> + =A0 =A0 =A0 int pressure_max;
> + =A0 =A0 =A0 char fw_version;
> +};
> +
> +struct wacom_i2c {
> + =A0 =A0 =A0 struct i2c_client *client;
> + =A0 =A0 =A0 struct input_dev *input;
> + =A0 =A0 =A0 unsigned int gpio;
> + =A0 =A0 =A0 u8 data[WACOM_QUERY_SIZE];
> +};
> +
> +static int wacom_query_device(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct waco=
m_features *features)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 u8 cmd1[] =3D { WACOM_CMD_QUERY0, WACOM_CMD_QUERY1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WACOM_CMD_QUERY2, WACOM=
_CMD_QUERY3 };
> + =A0 =A0 =A0 u8 cmd2[] =3D { WACOM_CMD_THROW0, WACOM_CMD_THROW1 };
> + =A0 =A0 =A0 u8 data[WACOM_QUERY_SIZE];
> +#if 1
> + =A0 =A0 =A0 struct i2c_msg msgs[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =3D client->addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D sizeof(cmd1),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .buf =3D cmd1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =3D client->addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D sizeof(cmd2),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .buf =3D cmd2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =3D client->addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D I2C_M_RD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D sizeof(data),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .buf =3D data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(=
msgs));
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 if (ret !=3D ARRAY_SIZE(msgs))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +#else
> + =A0 =A0 =A0 ret =3D i2c_master_send(client, cmd1, sizeof(cmd1));
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Sending 1st Query fail=
ed, error: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D i2c_master_send(client, cmd2, sizeof(cmd2));
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Sending 2nd Query fail=
ed, error: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D i2c_master_recv(client, data, sizeof(data));
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Receiving data failed,=
 error: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +#endif
> +
> + =A0 =A0 =A0 features->x_max =3D get_unaligned_le16(&data[3]);
> + =A0 =A0 =A0 features->y_max =3D get_unaligned_le16(&data[5]);
> + =A0 =A0 =A0 features->pressure_max =3D get_unaligned_le16(&data[11]=
);
> + =A0 =A0 =A0 features->fw_version =3D get_unaligned_le16(&data[13]);
> +
> + =A0 =A0 =A0 dev_dbg(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "x_max:%d, y_max:%d, pressure:%d, fw:%d=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_max, features->y_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pressure_max, features->fw_ve=
rsion);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int wacom_i2c_fetch_data(struct wacom_i2c *wac_i2c)
> +{
> + =A0 =A0 =A0 int retries =3D 0;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_master_recv(wac_i2c->client=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 wac_i2c->data, sizeof(wac_i2c->data));
> + =A0 =A0 =A0 } while (gpio_get_value(wac_i2c->gpio) =3D=3D 0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retries++ < WACOM_RETRY_CNT);
> +
> + =A0 =A0 =A0 if (retries >=3D WACOM_RETRY_CNT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> +
> + =A0 =A0 =A0 return ret < 0 ? ret : 0;
> +}
> +
> +static irqreturn_t wacom_i2c_irq(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D dev_id;
> + =A0 =A0 =A0 struct input_dev *input =3D wac_i2c->input;
> + =A0 =A0 =A0 u8 *data =3D wac_i2c->data;
> + =A0 =A0 =A0 unsigned int x, y, pressure;
> + =A0 =A0 =A0 unsigned char tsw, f1, f2, ers;
> + =A0 =A0 =A0 int error;
> +
> + =A0 =A0 =A0 error =3D wacom_i2c_fetch_data(wac_i2c);
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 tsw =3D data[3] & 0x01;
> + =A0 =A0 =A0 ers =3D data[3] & 0x04;
> + =A0 =A0 =A0 f1 =3D data[3] & 0x02;
> + =A0 =A0 =A0 f2 =3D data[3] & 0x10;
> + =A0 =A0 =A0 x =3D le16_to_cpup((__le16 *)&data[4]);
> + =A0 =A0 =A0 y =3D le16_to_cpup((__le16 *)&data[6]);
> + =A0 =A0 =A0 pressure =3D le16_to_cpup((__le16 *)&data[8]);
> +
> + =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, tsw || ers);
> + =A0 =A0 =A0 input_report_key(input, BTN_TOOL_PEN, tsw);
> + =A0 =A0 =A0 input_report_key(input, BTN_TOOL_RUBBER, ers);
> + =A0 =A0 =A0 input_report_key(input, BTN_STYLUS, f1);
> + =A0 =A0 =A0 input_report_key(input, BTN_STYLUS2, f2);
> + =A0 =A0 =A0 input_report_abs(input, ABS_X, x);
> + =A0 =A0 =A0 input_report_abs(input, ABS_Y, y);
> + =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, pressure);
> +
> + =A0 =A0 =A0 input_sync(wac_i2c->input);
> +out:
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int wacom_i2c_open(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D input_get_drvdata(dev);
> + =A0 =A0 =A0 struct i2c_client *client =3D wac_i2c->client;
> + =A0 =A0 =A0 int error;
> +
> + =A0 =A0 =A0 /* Clear the device buffer */
> + =A0 =A0 =A0 error =3D wacom_i2c_fetch_data(wac_i2c);
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> +
> + =A0 =A0 =A0 enable_irq(client->irq);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void wacom_i2c_close(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D input_get_drvdata(dev);
> + =A0 =A0 =A0 struct i2c_client *client =3D wac_i2c->client;
> +
> + =A0 =A0 =A0 disable_irq(client->irq);
> +}
> +
> +static int __devinit wacom_i2c_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const struct i2c_device_id *id)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c;
> + =A0 =A0 =A0 struct input_dev *input;
> + =A0 =A0 =A0 struct wacom_features features;
> + =A0 =A0 =A0 int gpio;
> + =A0 =A0 =A0 int error;
> +
> + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FUNC_=
I2C)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "i2c_check_functi=
onality error\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 gpio =3D irq_to_gpio(client->irq);
> + =A0 =A0 =A0 if (gpio < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D gpio;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "irq_to_gpio() failed, =
error: %d\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 error =3D wacom_query_device(client, &features);
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> +
> + =A0 =A0 =A0 wac_i2c =3D kzalloc(sizeof(*wac_i2c), GFP_KERNEL);
> + =A0 =A0 =A0 input =3D input_allocate_device();
> + =A0 =A0 =A0 if (!wac_i2c || !input) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 wac_i2c->client =3D client;
> + =A0 =A0 =A0 wac_i2c->input =3D input;
> + =A0 =A0 =A0 wac_i2c->gpio =3D gpio;
> +
> + =A0 =A0 =A0 input->name =3D "Wacom I2C Digitizer";
> + =A0 =A0 =A0 input->id.bustype =3D BUS_I2C;
> + =A0 =A0 =A0 input->id.vendor =3D 0x56a;
> + =A0 =A0 =A0 input->id.version =3D features.fw_version;
> + =A0 =A0 =A0 input->dev.parent =3D &client->dev;
> + =A0 =A0 =A0 input->open =3D wacom_i2c_open;
> + =A0 =A0 =A0 input->close =3D wacom_i2c_close;
> +
> + =A0 =A0 =A0 input->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS=
);
> +
> + =A0 =A0 =A0 __set_bit(BTN_TOOL_PEN, input->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_TOOL_RUBBER, input->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_STYLUS, input->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_STYLUS2, input->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_TOUCH, input->keybit);
> +
> + =A0 =A0 =A0 input_set_abs_params(input, ABS_X, 0, features.x_max, 0=
, 0);
> + =A0 =A0 =A0 input_set_abs_params(input, ABS_Y, 0, features.y_max, 0=
, 0);
> + =A0 =A0 =A0 input_set_abs_params(input, ABS_PRESSURE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00, features.=
pressure_max, 0, 0);
> +
> + =A0 =A0 =A0 input_set_drvdata(input, wac_i2c);
> +
> + =A0 =A0 =A0 error =3D request_threaded_irq(client->irq, NULL, wacom=
_i2c_irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0IRQF_TRIGGER_FALLING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"wacom_i2c", wac_i2c);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed to enable IRQ, =
error: %d\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Disable the IRQ, we'll enable it in wac_i2c_open() *=
/
> + =A0 =A0 =A0 disable_irq(client->irq);
> +
> + =A0 =A0 =A0 error =3D input_register_device(wac_i2c->input);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed to register inp=
ut device, error: %d\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 i2c_set_clientdata(client, wac_i2c);
> + =A0 =A0 =A0 return 0;
> +
> +err_free_irq:
> + =A0 =A0 =A0 free_irq(client->irq, wac_i2c);
> +err_free_mem:
> + =A0 =A0 =A0 input_free_device(wac_i2c->input);
> + =A0 =A0 =A0 kfree(wac_i2c);
> +
> + =A0 =A0 =A0 return error;
> +}
> +
> +static int __devexit wacom_i2c_remove(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D i2c_get_clientdata(client=
);
> +
> + =A0 =A0 =A0 free_irq(client->irq, wac_i2c);
> + =A0 =A0 =A0 input_unregister_device(wac_i2c->input);
> + =A0 =A0 =A0 kfree(wac_i2c);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int wacom_i2c_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> +
> + =A0 =A0 =A0 disable_irq(client->irq);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int wacom_i2c_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> +
> + =A0 =A0 =A0 enable_irq(client->irq);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(wacom_i2c_pm, wacom_i2c_suspend, wacom_i2c_=
resume);
> +
> +static const struct i2c_device_id wacom_i2c_id[] =3D {
> + =A0 =A0 =A0 { "WAC_I2C_EMR", 0 },
> + =A0 =A0 =A0 { },
> +};
> +MODULE_DEVICE_TABLE(i2c, wacom_i2c_id);
> +
> +static struct i2c_driver wacom_i2c_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "wacom_i2c",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &wacom_i2c_pm,
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D wacom_i2c_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(wacom_i2c_remov=
e),
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D wacom_i2c_id,
> +};
> +module_i2c_driver(wacom_i2c_driver);
> +
> +MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>")=
;
> +MODULE_DESCRIPTION("WACOM EMR I2C Driver");
> +MODULE_LICENSE("GPL");
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
