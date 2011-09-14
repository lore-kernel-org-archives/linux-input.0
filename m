From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Wed, 14 Sep 2011 12:50:30 +0800
Message-ID: <CACrgxGAxntDkvgnz7Py=-e3i0C8qx0TMdLEiek6-3FJ3+8FWnA@mail.gmail.com>
References: <20110812203003.GA8995@polaris.bitmath.org> <1315482029-13761-1-git-send-email-jiejing.zhang@freescale.com>
 <20110913091515.GA5658@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f42.google.com ([209.85.212.42]:38890 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab1INE5F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 00:57:05 -0400
Received: by vwl1 with SMTP id 1so1981858vwl.1
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 21:57:03 -0700 (PDT)
In-Reply-To: <20110913091515.GA5658@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi Henrik,

Thanks for your review.

2011/9/13 Henrik Rydberg <rydberg@euromail.se>:
> Hi Zhang,
>
> thanks for the changes, please some some comments inline.
>
>> this patch adds EETI eGalax serial multi touch controller driver.
>
> s/this/This/
> s/adds/adds the/
Will do.
>
>> EETI eGalax serial touch screen controller is a I2C based multiple
>> capacitive touch screen controller, it can supports 5 touch events m=
aximum.
>
> s/supports/support/
>
Will do.
>> diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/t=
ouchscreen/egalax_ts.c
>> new file mode 100644
>> index 0000000..9f0a527
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/egalax_ts.c
>> @@ -0,0 +1,299 @@
>> +/*
>> + * Driver for EETI eGalax Multiple Touch Controller
>> + *
>> + * Copyright (C) 2011 Freescale Semiconductor, Inc.
>> + *
>> + * based on max11801_ts.c
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/* EETI eGalax serial touch screen controller is a I2C based multip=
le
>> + * touch screen controller, it can supports 5 pointer multiple touc=
h. */
>> +
>> +/* TODO:
>> + =A0- auto idle mode support
>> +*/
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/input.h>
>> +#include <linux/irq.h>
>> +#include <linux/gpio.h>
>> +#include <linux/delay.h>
>> +#include <linux/slab.h>
>> +#include <linux/bitops.h>
>> +#include <linux/input/mt.h>
>> +
>> +/* Mouse Mode: some panel may configure the controller to mouse mod=
e,
>> + * which can only one point at a given time. */
>
> s/only/only report/
Will do.
>
>> +#define REPORT_MODE_MOUSE =A0 =A0 =A0 =A0 =A0 =A00x1
>> +/* Vendor Mode: this mode is used to transfer some vendor specify
>> + * messages, it was ignore in this driver. */
>> +#define REPORT_MODE_VENDOR =A0 =A0 =A0 =A0 =A0 0x3
>
> Since this is ignored, it could be dropped entirely, or possibly be
> mentioned in the comment.
>
>> +/* Multiple Touch Mode */
>> +#define REPORT_MODE_MTTOUCH =A0 =A0 =A0 =A0 =A00x4
>> +
>> +#define MAX_SUPPORT_POINTS =A0 =A0 =A0 =A0 =A0 5
>> +
>> +#define EVENT_VALID_OFFSET =A0 7
>> +#define EVENT_VAILD_MASK =A0 =A0 (0x1 << EVENT_VALID_OFFSET)
>
> s/VAILD/VALID/
>
>> +#define EVENT_ID_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A02
>> +#define EVENT_ID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xf << EVENT_=
ID_OFFSET)
>> +#define EVENT_IN_RANGE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << 1)
>> +#define EVENT_DOWN_UP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0X1 << 0)
>> +
>> +#define MAX_I2C_DATA_LEN =A0 =A0 10
>> +
>> +#define EGALAX_MAX_X 32760
>> +#define EGALAX_MAX_Y 32760
>> +
>> +struct egalax_ts {
>> + =A0 =A0 struct i2c_client =A0 =A0 =A0 =A0 =A0 =A0 =A0 *client;
>> + =A0 =A0 struct input_dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*input_dev=
;
>> +};
>> +
>> +static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct egalax_ts *data =3D dev_id;
>> + =A0 =A0 struct input_dev *input_dev =3D data->input_dev;
>> + =A0 =A0 struct i2c_client *client =3D data->client;
>> + =A0 =A0 u8 buf[MAX_I2C_DATA_LEN];
>> + =A0 =A0 int id, ret, x, y, z;
>> + =A0 =A0 bool down, valid;
>> + =A0 =A0 u8 state;
>> +
>> +retry:
>> + =A0 =A0 ret =3D i2c_master_recv(client, buf, MAX_I2C_DATA_LEN);
>> + =A0 =A0 if (ret =3D=3D -EAGAIN)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto retry;
>> +
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>> +
>> + =A0 =A0 if (buf[0] !=3D REPORT_MODE_VENDOR
>> + =A0 =A0 =A0 =A0 && buf[0] !=3D REPORT_MODE_MOUSE
>> + =A0 =A0 =A0 =A0 && buf[0] !=3D REPORT_MODE_MTTOUCH) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* invalid point */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (buf[0] =3D=3D REPORT_MODE_VENDOR) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&client->dev, "vendor message, ign=
ore...\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>> + =A0 =A0 }
>
> Why not merge the vendor mode with the rest of the stuff you ignore? =
Something like
>
> if (buf[0] !=3D REPORT_MODE_MOUSE && buf[0] !=3D REPORT_MODE_MTTOUCH)
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
>
Yes, this is better.
>> +
>> + =A0 =A0 state =3D buf[1];
>> + =A0 =A0 x =3D (buf[3] << 8) | buf[2];
>> + =A0 =A0 y =3D (buf[5] << 8) | buf[4];
>> + =A0 =A0 z =3D (buf[7] << 8) | buf[6]; /* only valid in multitouch =
mode. */
>> +
>> + =A0 =A0 if (buf[0] =3D=3D REPORT_MODE_MOUSE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_X, x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_Y, y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input_dev, BTN_TOUCH, !!s=
tate);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_sync(input_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* deal with multiple touch =A0*/
>> + =A0 =A0 valid =3D state & EVENT_VAILD_MASK;
>> + =A0 =A0 id =3D (state & EVENT_ID_MASK) >> EVENT_ID_OFFSET;
>> + =A0 =A0 down =3D state & EVENT_DOWN_UP;
>> +
>> + =A0 =A0 if (!valid || id > MAX_SUPPORT_POINTS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&client->dev, "point invalid\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 input_mt_slot(input_dev, id);
>> + =A0 =A0 input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, down=
);
>> +
>> + =A0 =A0 dev_dbg(&client->dev, "%s id:%d x:%d y:%d z:%d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 (down ? "down" : "up"), id, x, y, z);
>> +
>> + =A0 =A0 if (down) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_MT_POSITIO=
N_X, x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_MT_POSITIO=
N_Y, y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_MT_PRESSUR=
E, z);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 input_mt_report_pointer_emulation(input_dev, true);
>> + =A0 =A0 input_sync(input_dev);
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +/* wake up controller by an falling edge of interrupt gpio. =A0*/
>> +static int egalax_wake_up_device(struct i2c_client *client)
>> +{
>> + =A0 =A0 int gpio =3D irq_to_gpio(client->irq);
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D gpio_request(gpio, "egalax_irq");
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "request gpio failed=
,"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cannot wake up controller=
:%d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> + =A0 =A0 /* wake up controller via an falling edge on IRQ gpio. */
>> + =A0 =A0 gpio_direction_output(gpio, 0);
>> + =A0 =A0 gpio_set_value(gpio, 1);
>> + =A0 =A0 /* controller should be waken up, return irq. =A0*/
>> + =A0 =A0 gpio_direction_input(gpio);
>> + =A0 =A0 gpio_free(gpio);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int egalax_firmware_version(struct i2c_client *client)
>> +{
>> + =A0 =A0 static const u8 cmd[MAX_I2C_DATA_LEN] =3D { 0x03, 0x03, 0x=
a, 0x01, 0x41 };
>> + =A0 =A0 int ret;
>> + =A0 =A0 ret =3D i2c_master_send(client, cmd, MAX_I2C_DATA_LEN);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int __devinit egalax_ts_probe(struct i2c_client *client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const struct i2c_device_id *id)
>> +{
>> + =A0 =A0 struct egalax_ts *data;
>> + =A0 =A0 struct input_dev *input_dev;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 data =3D kzalloc(sizeof(struct egalax_ts), GFP_KERNEL);
>> + =A0 =A0 if (!data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to allocate =
memory\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 input_dev =3D input_allocate_device();
>> + =A0 =A0 if (!input_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to allocate =
memory\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_data;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 data->client =3D client;
>> + =A0 =A0 data->input_dev =3D input_dev;
>> + =A0 =A0 /* controller may be in sleep, wake it up. */
>> + =A0 =A0 egalax_wake_up_device(client);
>> + =A0 =A0 ret =3D egalax_firmware_version(client);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "egalax_ts: failed to read=
 firmware version\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_dev;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 input_dev->name =3D "EETI eGalax Touch Screen";
>> + =A0 =A0 input_dev->phys =3D "I2C",
>> + =A0 =A0 input_dev->id.bustype =3D BUS_I2C;
>> + =A0 =A0 input_dev->dev.parent =3D &client->dev;
>> +
>> + =A0 =A0 __set_bit(EV_ABS, input_dev->evbit);
>> + =A0 =A0 __set_bit(EV_KEY, input_dev->evbit);
>> + =A0 =A0 __set_bit(BTN_TOUCH, input_dev->keybit);
>> + =A0 =A0 __set_bit(ABS_X, input_dev->absbit);
>> + =A0 =A0 __set_bit(ABS_Y, input_dev->absbit);
>> + =A0 =A0 input_set_abs_params(input_dev, ABS_X, 0, EGALAX_MAX_X, 0,=
 0);
>> + =A0 =A0 input_set_abs_params(input_dev, ABS_Y, 0, EGALAX_MAX_Y, 0,=
 0);
>> + =A0 =A0 input_set_abs_params(input_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ABS_MT_POSITION=
_X, 0, EGALAX_MAX_X, 0, 0);
>> + =A0 =A0 input_set_abs_params(input_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ABS_MT_POSITION=
_X, 0, EGALAX_MAX_Y, 0, 0);
>> + =A0 =A0 input_mt_init_slots(input_dev, MAX_SUPPORT_POINTS);
>
> How do you know when the device is in MOUSE mode here? The MT
> parameters should only be set up for multitouch.
>

I double check the document, I can't know the Chip 's mode before the
the chip start report points.

So, I think change the abs_params in runtime is not a good idea.

What about this driver only deal with MT point, and ignore the
MOUSE_MODE related code?

>> +
>> + =A0 =A0 input_set_drvdata(input_dev, data);
>> +
>> + =A0 =A0 ret =3D request_threaded_irq(client->irq, NULL, egalax_ts_=
interrupt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQ=
=46_TRIGGER_LOW | IRQF_ONESHOT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"eg=
alax_ts", data);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to register =
interrupt\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_dev;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D input_register_device(data->input_dev);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
>> + =A0 =A0 i2c_set_clientdata(client, data);
>> + =A0 =A0 return 0;
>> +
>> +err_free_irq:
>> + =A0 =A0 free_irq(client->irq, data);
>> +err_free_dev:
>> + =A0 =A0 input_free_device(input_dev);
>> +err_free_data:
>> + =A0 =A0 kfree(data);
>> +
>> + =A0 =A0 return ret;
>> +}
>
> Thanks,
> Henrik
>

Thanks,
Jiejing
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
