From: Tatsunosuke Tobita <junkpainting@gmail.com>
Subject: Re: [PATCH] Input:Add Wacom Stylus support for I2C
Date: Wed, 16 Nov 2011 16:48:08 +0900
Message-ID: <CA+MtpR19+9910b=t9M=OqLMMf-VFyfF5VXtFMY5E-TS+E+wsqw@mail.gmail.com>
References: <1319006175-8630-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
	<20111115010612.GA12910@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64846 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab1KPHsJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 02:48:09 -0500
Received: by bke11 with SMTP id 11so215860bke.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 23:48:08 -0800 (PST)
In-Reply-To: <20111115010612.GA12910@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry

Thank you for replying and reviewing.
I answered the question you had asked.

>> +
>> + =A0 =A0 ret =3D i2c_master_send(wac_i2c->client, cmd, sizeof(cmd))=
;
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Sending 1st Query =
failed \n");
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&wac_i2c->client->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Sending query 1 faile=
d, error: %d",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret);
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
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
>
> Does it have to be 2 separate transactions? Can we combine everything
> into a single i2c_transfer()?
Yes, the commands have to be sent separately.
This is the way how our firmware correctly responds.

> wacom_report_coordinates; but I would fold it into wacom_i2c_irq.
>
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 unsigned int x, y, pressure;
>> + =A0 =A0 unsigned char tsw, f1, f2, ers;
>> + =A0 =A0 u8 data[COM_COORD_NUM];
>> +
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_master_recv(wac_i2c->client, d=
ata, QUERY_SIZE);
>> + =A0 =A0 } while (gpio_get_value(GPIO) <=3D 0);
>
> Why do we need to spin and check GPIO here?
As long as data remains in our firmware buffer, irq line doesn't go
"High" level, which
means our stylus never responds. So, in order to avoid this, this
statement takes all data which may be in the firmware buffer.

>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*Clear the buffer in the firmware*/
>> + =A0 =A0 wacom_set_coordination(wac_i2c);
>
> Why is this needed?
The same reason stated above.
Our firmware takes data and stores it in firmware buffer even before ir=
q starts.
If the data remains in the firmware buffer before irq starts, pen
seems to never respond
because irq line never goes to "High".
That's why it clears the buffer here.

>> +
>> +/*I2C address for digitizer*/
>> +#define WACOM_I2C_ADDR =A0 0x09
>> +
>> +/*Set a specific pin number on GPI for IRQ*/
>> +#define GPIO 1
>
> No, please don't.
Does your comment mean I should remove  defining or my comment?

Thanks,

Tats

-----------------------------------------------------------------------=
-------------------------------
On Tue, Nov 15, 2011 at 10:06 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Oct 19, 2011 at 03:36:15PM +0900, Tatsunosuke Tobita wrote:
>> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>>
>> Adding support for Wacom Stylus with I2C interface.
>>
>> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>> ---
>> =A0drivers/input/touchscreen/wacom_i2c.c | =A0261 ++++++++++++++++++=
+++++++++++++++
>> =A0drivers/input/touchscreen/wacom_i2c.h | =A0 72 +++++++++
>> =A02 files changed, 333 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.c
>> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.h
>>
>> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/t=
ouchscreen/wacom_i2c.c
>> new file mode 100644
>> index 0000000..3f16f93
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/wacom_i2c.c
>> @@ -0,0 +1,260 @@
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
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&wac_i2c->client->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Sending query 1 faile=
d, error: %d",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret);
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
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
>
> Does it have to be 2 separate transactions? Can we combine everything
> into a single i2c_transfer()?
>
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
>> + =A0 =A0 dev_printk(KERN_INFO, &wac_i2c->client->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"x_max:%d, y_max:%d, pressure:%d, f=
w:%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_feature.x_max, wac_i2c=
->wac_feature.y_max,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_feature.pressure_max, =
wac_i2c->wac_feature.fw_version);
>
> Looks like a good dev_dbg() candidate.
>
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void wacom_set_coordination(struct wacom_i2c *wac_i2c)
>
> wacom_report_coordinates; but I would fold it into wacom_i2c_irq.
>
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 unsigned int x, y, pressure;
>> + =A0 =A0 unsigned char tsw, f1, f2, ers;
>> + =A0 =A0 u8 data[COM_COORD_NUM];
>> +
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_master_recv(wac_i2c->client, d=
ata, QUERY_SIZE);
>> + =A0 =A0 } while (gpio_get_value(GPIO) <=3D 0);
>
> Why do we need to spin and check GPIO here?
>
>> +
>> + =A0 =A0 if (ret >=3D 0) {
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
>> +}
>> +
>> +static irqreturn_t wacom_i2c_irq(int irqno, void *param)
>> +{
>> + =A0 =A0 struct wacom_i2c *wac_i2c =3D param;
>> +
>> + =A0 =A0 wacom_set_coordination(wac_i2c);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +
>> +static int wacom_i2c_input_open(struct input_dev *dev)
>> +{
>> + =A0 =A0 struct wacom_i2c *wac_i2c =3D input_get_drvdata(dev);
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 __set_bit(ABS_X, wac_i2c->input->absbit);
>> + =A0 =A0 __set_bit(ABS_Y, wac_i2c->input->absbit);
>> + =A0 =A0 __set_bit(ABS_PRESSURE, wac_i2c->input->absbit);
>
> These 3 are not needed, input_set_abs_params will take care of settin=
g
> them.
>
>> + =A0 =A0 __set_bit(BTN_TOOL_PEN, wac_i2c->input->keybit);
>> + =A0 =A0 __set_bit(BTN_TOOL_RUBBER, wac_i2c->input->keybit);
>> + =A0 =A0 __set_bit(BTN_STYLUS, wac_i2c->input->keybit);
>> + =A0 =A0 __set_bit(BTN_STYLUS2, wac_i2c->input->keybit);
>> + =A0 =A0 __set_bit(BTN_TOUCH, wac_i2c->input->keybit);
>
> This is too late; input device capabilities should be set before the
> device is registered. Please move it all up and including request_irq
> into your probe function.
>
>> +
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
>> + =A0 =A0 if (request_threaded_irq(EMR_IRQ, NULL,
>
> Use client->irq instead.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_i=
2c_irq, IRQF_TRIGGER_FALLING, "WACOM_I2C_IRQ", wac_i2c)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev=
, "Failed to enable IRQ for EMR \n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>
> Please report error code that request_threaded_irq returned, no need =
to
> mangle it with your own. Besides -EIO does not fit here at all, -EBUS=
Y
> would fit better.
>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*Clear the buffer in the firmware*/
>> + =A0 =A0 wacom_set_coordination(wac_i2c);
>
> Why is this needed?
>
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void wacom_i2c_input_close(struct input_dev *dev)
>> +{
>> + =A0 =A0 disable_irq(EMR_IRQ);
>
> This is not balanced; if you open/close device several times you'll e=
nd
> up with IRQ disabled.
>
>> +}
>> +
>> +static int wacom_i2c_probe(struct i2c_client *client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct i2c_de=
vice_id *id)
>
> __devinit.
>
>> +{
>> + =A0 =A0 struct wacom_i2c *wac_i2c;
>> + =A0 =A0 int err;
>> +
>> + =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 wac_i2c =3D kzalloc(sizeof(struct wacom_i2c), GFP_KERNEL);
>> + =A0 =A0 wac_i2c->input =3D input_allocate_device();
>> + =A0 =A0 if (wac_i2c =3D=3D NULL || wac_i2c->input =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 wac_i2c->client =3D client;
>> + =A0 =A0 i2c_set_clientdata(client, wac_i2c);
>> +
>> + =A0 =A0 mutex_init(&wac_i2c->lock);
>
> What is it used for?
>
>> +
>> + =A0 =A0 wac_i2c->input->name =3D "WACOM_I2C_DIGITIZER";
>
> Maybe "Wacom I2C Digitizer"?
>
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
>> + =A0 =A0 return 0;
>> +
>> + fail3:
>> + =A0 =A0 input_free_device(wac_i2c->input);
>> + fail2:
>> + =A0 =A0 kfree(wac_i2c);
>> + =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev, "Freeing devic=
e \n");
>> + fail1:
>> + =A0 =A0 printk(KERN_ERR "wacom_i2c: No I2C functionality found \n"=
);
>
> dev_err(). And this reporting is misleading as it will trigger even w=
hen
> let's say device registration failed.
>
>> + =A0 =A0 return err;
>> +}
>> +
>> +static int wacom_i2c_remove(struct i2c_client *client)
>
> __devexit.
>
>> +{
>> + =A0 =A0 struct wacom_i2c *wac_i2c =3D i2c_get_clientdata(client);
>> +
>> + =A0 =A0 free_irq(EMR_IRQ, wac_i2c);
>> + =A0 =A0 input_unregister_device(wac_i2c->input);
>> + =A0 =A0 kfree(wac_i2c);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int wacom_i2c_suspend(struct device *dev)
>> +{
>> + =A0 =A0 disable_irq(EMR_IRQ);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int wacom_i2c_resume(struct device *dev)
>> +{
>> + =A0 =A0 enable_irq(EMR_IRQ);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static const struct dev_pm_ops wacom_i2c_pm =3D {
>> + =A0 =A0 .suspend =3D wacom_i2c_suspend,
>> + =A0 =A0 .resume =3D wacom_i2c_resume,
>> +};
>
> Lose this definition in favor of below.
>
>> +#endif
>
> static SIMPLE_DEV_OP_OPS(wacom_i2c_pm, wacom_i2c_suspend, wacom_i2c_r=
esume);
>
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
>> +#ifdef CONFIG_PM
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &wacom_i2c_pm,
>> +#endif
>
> Lose this ifdef.
>
>> + =A0 =A0 },
>> +
>> + =A0 =A0 .probe =3D wacom_i2c_probe,
>> + =A0 =A0 .remove =3D wacom_i2c_remove,
>
> __devexit_p()
>
>> + =A0 =A0 .id_table =3D wacom_i2c_id,
>> +};
>> +
>> +static int __init wacom_i2c_init(void)
>> +{
>> + =A0 =A0 return i2c_add_driver(&wacom_i2c_driver);
>> +}
>> +
>> +static void __exit wacom_i2c_exit(void)
>> +{
>> + =A0 =A0 i2c_del_driver(&wacom_i2c_driver);
>> +}
>> +
>> +module_init(wacom_i2c_init);
>> +module_exit(wacom_i2c_exit);
>> +
>> +MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>"=
);
>> +MODULE_DESCRIPTION("WACOM EMR I2C Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/input/touchscreen/wacom_i2c.h b/drivers/input/t=
ouchscreen/wacom_i2c.h
>> new file mode 100644
>> index 0000000..13d86f9
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/wacom_i2c.h
>> @@ -0,0 +1,72 @@
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
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/input.h>
>> +#include <linux/i2c.h>
>> +#include <linux/slab.h>
>> +#include <linux/delay.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/device.h>
>> +#include <linux/irq.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/gpio.h>
>> +#include <asm/unaligned.h>
>> +#include <asm/system.h>
>
> You need _all_ these headers?
>
>> +
>> +#define NAMEBUF 12
>> +#define WACNAME "WAC_I2C_EMR"
>> +
>> +/*Wacom Command*/
>> +#define COM_COORD_NUM =A0 =A0 =A0256
>> +#define COM_SAMPLERATE_40 =A00x33
>> +#define COM_SAMPLERATE_80 =A00x32
>> +#define COM_SAMPLERATE_133 0x31
>> +#define CMD_QUERY0 =A0 =A0 =A0 =A0 0x04
>> +#define CMD_QUERY1 =A0 =A0 =A0 =A0 0x00
>> +#define CMD_QUERY2 =A0 =A0 =A0 =A0 0x33
>> +#define CMD_QUERY3 =A0 =A0 =A0 =A0 0x02
>> +#define CMD_THROW0 =A0 =A0 =A0 =A0 0x05
>> +#define CMD_THROW1 =A0 =A0 =A0 =A0 0x00
>> +#define QUERY_SIZE =A0 =A0 =A0 =A0 =A0 19
>> +
>> +/*I2C address for digitizer*/
>> +#define WACOM_I2C_ADDR =A0 0x09
>> +
>> +/*Set a specific pin number on GPI for IRQ*/
>> +#define GPIO 1
>
> No, please don't.
>
>> +#define EMR_IRQ gpio_to_irq(GPIO)
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
>> + =A0 =A0 struct wacom_features wac_feature;
>> + =A0 =A0 int type;
>> + =A0 =A0 const char name[NAMEBUF];
>
> If this is const how do you set it?
>
>> +};
>> +#endif
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
