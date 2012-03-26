From: Tatsunosuke Tobita <junkpainting@gmail.com>
Subject: Re: [PATCH] Input: Wacom Stylus driver for I2C interface
Date: Mon, 26 Mar 2012 11:26:56 +0900
Message-ID: <CA+MtpR3gMBFSBv-oiYG5kz0LrrT-yfXFB9TtS8dm0v4b7yP31A@mail.gmail.com>
References: <1332481207-6224-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
	<4F6CBAA6.9010308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57808 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105Ab2CZC06 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Mar 2012 22:26:58 -0400
Received: by bkcik5 with SMTP id ik5so3610905bkc.19
        for <linux-input@vger.kernel.org>; Sun, 25 Mar 2012 19:26:56 -0700 (PDT)
In-Reply-To: <4F6CBAA6.9010308@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-input@vger.kernel.org

Hi Shubhrajyoti

Thank you for your comment on this patch.

On Sat, Mar 24, 2012 at 3:02 AM, Shubhrajyoti <shubhrajyoti@ti.com> wro=
te:
> Hi ,
> Some comments / doubts.
>
> On Friday 23 March 2012 11:10 AM, Tatsunosuke Tobita wrote:
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
> May be use dev_err . Feel free to ignore if you feel so. Just a sugge=
stion
I guess I need to look up dev_err and decide which I should use; thanks=
=2E

>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>
> Why mask the error?
Masking here is because whenever wacom_send_query returns the negative
number, that means
the connection and communication between the hardware and our device
is somehow missed.
The cause was always setting of I2C of our device our our developing
environment while we were testing.
So, I thought returning the -EIO
(Error for Input/Output) is understandable for us. But, I come to
realize that this should be not based on
our thought, but should be considered for someone else, so I will
modify it as more appropriate.

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
> same
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
> same
>> + =A0 =A0 }
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
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void wacom_i2c_input_close(struct input_dev *dev)
>> +{
>> +}
> May be this could be cleaned up?
I see, so I shouldn't leave a function without any operation, right?
Leaving here is because the input_open and input_close are considered t=
o
be registered as set. I will delete this function. Thanks!

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
> We are leaking wac_i2c here ?
Sorry, can you tell more detail?
I guess you are talking about the registration of wac_i2c->input when
it errors, but not completely sure if
you mean either input registration or wac_i2c itself, or both.

>> + =A0 =A0 }
>> +
>> + =A0 =A0 wac_i2c->client =3D client;
>> + =A0 =A0 i2c_set_clientdata(client, wac_i2c);
>> + =A0 =A0 mutex_init(&wac_i2c->lock);
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENODEV;
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
> Why is this disable needed?
Our device especially for the tablet PCs, sometimes we were asked to im=
plement
 for entering the mode that reduces the cost of the electric current,
which is similar to sleep mode
when systems are in suspend. The waking up from this mode are easy;
just get our stylus close to the screen
even when the systems in suspend mode. However, the waking up
shouldn't happen when the systems in the suspend mode,
so disabling irq allows our device not to detect that our pen is
getting close to it since the irq is the line detecting our stylus's
signal.
We haven't used this mode a lot these days, but not sure what will be
in the future.
As a result, I leave the operation for disabling irq here.

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
>> +
> nit : 2012?
I almost forget I sign it last year.

Thanks!

Tats
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
