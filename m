From: =?ISO-2022-JP?B?GyRCSHRFRE42RzcycBsoQg==?= <junkpainting@gmail.com>
Subject: FW: [PATCH] Input:Add Wacom Stylus support for I2C
Date: Mon, 14 Nov 2011 17:51:18 +0900
Message-ID: <CA+MtpR1BixrC+SF3wurjtiD3j0hYZH_rJoZkKODQXjjW7b8BTw@mail.gmail.com>
References: <4ec0d42f.e32c440a.043b.20d7SMTPIN_ADDED@mx.google.com>
	<CA+MtpR1VGAwYjmKaVmMvAidapMq9mgyYtqBxCwQy8+VHFMJ7zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cba6e6987e504b1adf98c
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39675 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab1KNIvU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:51:20 -0500
Received: by bke11 with SMTP id 11so5664170bke.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:51:18 -0800 (PST)
In-Reply-To: <CA+MtpR1VGAwYjmKaVmMvAidapMq9mgyYtqBxCwQy8+VHFMJ7zw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

--0015175cba6e6987e504b1adf98c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all

I hope this mail will work.
Please help to review wacom_i2c driver for wacom stylus with I2C interface.
Thanks!
Tats

2011/11/14 Tobita Tatsunosuke <tobita.tatsunosuke@wacom.co.jp>
>
>
> -----Original Message-----
> From: Tobita Tatsunosuke [mailto:tobita.tatsunosuke@wacom.co.jp]
> Sent: Friday, November 04, 2011 9:44 PM
> To: 'linux-input@vger.kernel.org'
> Cc: 'Dmitry Torokhov'; 'Ping Cheng'; 'Jason Gerecke'
> Subject: RE: [PATCH] Input:Add Wacom Stylus support for I2C
>
> Hello all
>
> It seems like my E-mail server didn't work well.
> I sent this again in case it doesn't really send the message.
>
> I posted two patches a week ago; one is for modification Kconfig and
> Makefile(attached txt) and the other is below the driver and the header
> files.
> However, I haven't gotten any comment and am even not sure if those files
> are going to be included in next release.
> Would you please help to review them?
> Thanks!
>
> Regards,
>
> Tats
>
> -----Original Message-----
> From: linux-input-owner@vger.kernel.org
> [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Tatsunosuke Tobit=
a
> Sent: Wednesday, October 19, 2011 3:36 PM
> To: linux-input@vger.kernel.org
> Cc: Tatsunosuke Tobita
> Subject: [PATCH] Input:Add Wacom Stylus support for I2C
>
> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>
> Adding support for Wacom Stylus with I2C interface.
>
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> ---
> =A0drivers/input/touchscreen/wacom_i2c.c | =A0261
> +++++++++++++++++++++++++++++++++
> =A0drivers/input/touchscreen/wacom_i2c.h | =A0 72 +++++++++
> =A02 files changed, 333 insertions(+), 0 deletions(-) =A0create mode 1006=
44
> drivers/input/touchscreen/wacom_i2c.c
> =A0create mode 100644 drivers/input/touchscreen/wacom_i2c.h
>
> diff --git a/drivers/input/touchscreen/wacom_i2c.c
> b/drivers/input/touchscreen/wacom_i2c.c
> new file mode 100644
> index 0000000..3f16f93
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c.c
> @@ -0,0 +1,260 @@
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
> +#include "wacom_i2c.h"
> +
> +static int wacom_send_query(struct wacom_i2c *wac_i2c) {
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 u8 cmd[4] =3D {CMD_QUERY0, CMD_QUERY1, CMD_QUERY2, CMD_QUER=
Y3};
> + =A0 =A0 =A0 u8 data[COM_COORD_NUM];
> +
> + =A0 =A0 =A0 ret =3D i2c_master_send(wac_i2c->client, cmd, sizeof(cmd));
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Sending 1st Query f=
ailed \n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 cmd[0] =3D CMD_THROW0; cmd[1] =3D CMD_THROW1;
> + =A0 =A0 =A0 ret =3D i2c_master_send(wac_i2c->client, cmd, 2);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Sending 2nd Query f=
ailed \n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D i2c_master_recv(wac_i2c->client, data, QUERY_SIZE);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Receiving data fail=
ed 1\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 wac_i2c->wac_feature.x_max =3D get_unaligned_le16(&data[3])=
;
> + =A0 =A0 =A0 wac_i2c->wac_feature.y_max =3D get_unaligned_le16(&data[5])=
;
> + =A0 =A0 =A0 wac_i2c->wac_feature.pressure_max =3D get_unaligned_le16(&d=
ata[11]);
> + =A0 =A0 =A0 wac_i2c->wac_feature.fw_version =3D get_unaligned_le16(&dat=
a[13]);
> +
> + =A0 =A0 =A0 dev_printk(KERN_INFO, &wac_i2c->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"x_max:%d, y_max:%d, pressure:%d, fw=
:%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_feature.x_max, wac_i2c-=
>wac_feature.y_max,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_feature.pressure_max,
> +wac_i2c->wac_feature.fw_version);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void wacom_set_coordination(struct wacom_i2c *wac_i2c) {
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 unsigned int x, y, pressure;
> + =A0 =A0 =A0 unsigned char tsw, f1, f2, ers;
> + =A0 =A0 =A0 u8 data[COM_COORD_NUM];
> +
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_master_recv(wac_i2c->client, da=
ta, QUERY_SIZE);
> + =A0 =A0 =A0 } while (gpio_get_value(GPIO) <=3D 0);
> +
> + =A0 =A0 =A0 if (ret >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tsw =3D data[3]&0x01;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ers =3D data[3]&0x04;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f1 =3D data[3]&0x02;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f2 =3D data[3]&0x10;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D le16_to_cpup((__le16 *)&data[4]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 y =3D le16_to_cpup((__le16 *)&data[6]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D le16_to_cpup((__le16 *)&data[8=
]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(wac_i2c->input, ABS_X, x);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(wac_i2c->input, ABS_Y, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->input, BTN_TOOL_P=
EN, tsw);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->input, BTN_TOOL_R=
UBBER, ers);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(wac_i2c->input, ABS_PRESSU=
RE, pressure);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->input, BTN_TOUCH,=
 (tsw || ers));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->input, BTN_STYLUS=
, f1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(wac_i2c->input, BTN_STYLUS=
2, f2);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(wac_i2c->input);
> + =A0 =A0 =A0 }
> +}
> +
> +static irqreturn_t wacom_i2c_irq(int irqno, void *param) {
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D param;
> +
> + =A0 =A0 =A0 wacom_set_coordination(wac_i2c);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +
> +static int wacom_i2c_input_open(struct input_dev *dev) {
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D input_get_drvdata(dev);
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 __set_bit(ABS_X, wac_i2c->input->absbit);
> + =A0 =A0 =A0 __set_bit(ABS_Y, wac_i2c->input->absbit);
> + =A0 =A0 =A0 __set_bit(ABS_PRESSURE, wac_i2c->input->absbit);
> + =A0 =A0 =A0 __set_bit(BTN_TOOL_PEN, wac_i2c->input->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_TOOL_RUBBER, wac_i2c->input->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_STYLUS, wac_i2c->input->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_STYLUS2, wac_i2c->input->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_TOUCH, wac_i2c->input->keybit);
> +
> + =A0 =A0 =A0 ret =3D wacom_send_query(wac_i2c);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +
> + =A0 =A0 =A0 wac_i2c->input->id.version =3D wac_i2c->wac_feature.fw_vers=
ion;
> + =A0 =A0 =A0 input_set_abs_params(wac_i2c->input, ABS_X, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_fea=
ture.x_max, 0, 0);
> + =A0 =A0 =A0 input_set_abs_params(wac_i2c->input, ABS_Y, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_fea=
ture.y_max, 0, 0);
> + =A0 =A0 =A0 input_set_abs_params(wac_i2c->input, ABS_PRESSURE, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wac_i2c->wac_fea=
ture.pressure_max, 0, 0);
> +
> + =A0 =A0 =A0 if (request_threaded_irq(EMR_IRQ, NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_i2=
c_irq, IRQF_TRIGGER_FALLING,
> "WACOM_I2C_IRQ", wac_i2c)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev,=
 "Failed to
> enable IRQ for EMR \n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*Clear the buffer in the firmware*/
> + =A0 =A0 =A0 wacom_set_coordination(wac_i2c);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void wacom_i2c_input_close(struct input_dev *dev) {
> + =A0 =A0 =A0 disable_irq(EMR_IRQ);
> +}
> +
> +static int wacom_i2c_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct i2c_dev=
ice_id *id)
> +{
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 wac_i2c =3D kzalloc(sizeof(struct wacom_i2c), GFP_KERNEL);
> + =A0 =A0 =A0 wac_i2c->input =3D input_allocate_device();
> + =A0 =A0 =A0 if (wac_i2c =3D=3D NULL || wac_i2c->input =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 wac_i2c->client =3D client;
> + =A0 =A0 =A0 i2c_set_clientdata(client, wac_i2c);
> +
> + =A0 =A0 =A0 mutex_init(&wac_i2c->lock);
> +
> + =A0 =A0 =A0 wac_i2c->input->name =3D "WACOM_I2C_DIGITIZER";
> + =A0 =A0 =A0 wac_i2c->input->id.bustype =3D BUS_I2C;
> + =A0 =A0 =A0 wac_i2c->input->id.vendor =3D 0x56a;
> + =A0 =A0 =A0 wac_i2c->input->dev.parent =3D &client->dev;
> + =A0 =A0 =A0 wac_i2c->input->open =3D wacom_i2c_input_open;
> + =A0 =A0 =A0 wac_i2c->input->close =3D wacom_i2c_input_close;
> + =A0 =A0 =A0 wac_i2c->input->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(E=
V_ABS);
> + =A0 =A0 =A0 input_set_drvdata(wac_i2c->input, wac_i2c);
> +
> + =A0 =A0 =A0 if (input_register_device(wac_i2c->input)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev,=
 "Failed to
> register input device \n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> + fail3:
> + =A0 =A0 =A0 input_free_device(wac_i2c->input);
> + fail2:
> + =A0 =A0 =A0 kfree(wac_i2c);
> + =A0 =A0 =A0 dev_printk(KERN_ERR, &wac_i2c->client->dev, "Freeing device=
 \n");
> + fail1:
> + =A0 =A0 =A0 printk(KERN_ERR "wacom_i2c: No I2C functionality found \n")=
;
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int wacom_i2c_remove(struct i2c_client *client) {
> + =A0 =A0 =A0 struct wacom_i2c *wac_i2c =3D i2c_get_clientdata(client);
> +
> + =A0 =A0 =A0 free_irq(EMR_IRQ, wac_i2c);
> + =A0 =A0 =A0 input_unregister_device(wac_i2c->input);
> + =A0 =A0 =A0 kfree(wac_i2c);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int wacom_i2c_suspend(struct device *dev) {
> + =A0 =A0 =A0 disable_irq(EMR_IRQ);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int wacom_i2c_resume(struct device *dev) {
> + =A0 =A0 =A0 enable_irq(EMR_IRQ);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct dev_pm_ops wacom_i2c_pm =3D {
> + =A0 =A0 =A0 .suspend =3D wacom_i2c_suspend,
> + =A0 =A0 =A0 .resume =3D wacom_i2c_resume,
> +};
> +#endif
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> +#ifdef CONFIG_PM
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &wacom_i2c_pm,
> +#endif
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 .probe =3D wacom_i2c_probe,
> + =A0 =A0 =A0 .remove =3D wacom_i2c_remove,
> + =A0 =A0 =A0 .id_table =3D wacom_i2c_id,
> +};
> +
> +static int __init wacom_i2c_init(void)
> +{
> + =A0 =A0 =A0 return i2c_add_driver(&wacom_i2c_driver);
> +}
> +
> +static void __exit wacom_i2c_exit(void) {
> + =A0 =A0 =A0 i2c_del_driver(&wacom_i2c_driver);
> +}
> +
> +module_init(wacom_i2c_init);
> +module_exit(wacom_i2c_exit);
> +
> +MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>");
> +MODULE_DESCRIPTION("WACOM EMR I2C Driver"); MODULE_LICENSE("GPL");
> diff --git a/drivers/input/touchscreen/wacom_i2c.h
> b/drivers/input/touchscreen/wacom_i2c.h
> new file mode 100644
> index 0000000..13d86f9
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c.h
> @@ -0,0 +1,72 @@
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
> +#ifndef WACOM_I2C_H
> +#define WACOM_I2C_H
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/uaccess.h>
> +#include <linux/device.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <asm/unaligned.h>
> +#include <asm/system.h>
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
> +/*Set a specific pin number on GPI for IRQ*/ #define GPIO 1 #define
> +EMR_IRQ gpio_to_irq(GPIO)
> +
> +/*Parameters for wacom own features*/
> +struct wacom_features {
> + =A0 =A0 =A0 int x_max;
> + =A0 =A0 =A0 int y_max;
> + =A0 =A0 =A0 int pressure_max;
> + =A0 =A0 =A0 char fw_version;
> +};
> +
> +/*Parameters for i2c driver*/
> +struct wacom_i2c {
> + =A0 =A0 =A0 struct i2c_client *client;
> + =A0 =A0 =A0 struct input_dev *input;
> + =A0 =A0 =A0 struct mutex lock;
> + =A0 =A0 =A0 struct wacom_features wac_feature;
> + =A0 =A0 =A0 int type;
> + =A0 =A0 =A0 const char name[NAMEBUF];
> +};
> +#endif
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

--0015175cba6e6987e504b1adf98c
Content-Type: text/plain; charset=Shift_JIS;
	name="PATCH Input Modified on Kconfig and Makefile for adding  Wacom Stylus for I2C.TXT"
Content-Disposition: attachment;
	filename="PATCH Input Modified on Kconfig and Makefile for adding  Wacom Stylus for I2C.TXT"
Content-Transfer-Encoding: base64
X-Attachment-Id: db48643cdb973c31_0.1

jbePb5BsOglsaW51eC1pbnB1dC1vd25lckB2Z2VyLmtlcm5lbC5vcmcggs0gVGF0c3Vub3N1a2Ug
VG9iaXRhIFtqdW5rcGFpbnRpbmdAZ21haWwuY29tXSCCzAqR45edCpGXkE2T+o6eOgkyMDExlE4x
MIyOMTmT+pCFl2qT+iAxNTozNgqItpDmOglsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmcKgmKC
YjoJVGF0c3Vub3N1a2UgVG9iaXRhCoyPlrw6CVtQQVRDSF0gSW5wdXQ6IE1vZGlmaWVkIG9uIEtj
b25maWcgYW5kIE1ha2VmaWxlIGZvciBhZGRpbmcgIFdhY29tIFN0eWx1cyBmb3IgSTJDCgpGcm9t
OiBUYXRzdW5vc3VrZSBUb2JpdGEgPHRvYml0YS50YXRzdW5vc3VrZUB3YWNvbS5jby5qcD4KCgpT
aWduZWQtb2ZmLWJ5OiBUYXRzdW5vc3VrZSBUb2JpdGEgPHRvYml0YS50YXRzdW5vc3VrZUB3YWNv
bS5jby5qcD4KLS0tCiBkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL0tjb25maWcgIHwgICAxMSAr
KysrKysrKysrKwogZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9NYWtlZmlsZSB8ICAgIDEgKwog
MiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vS2NvbmZpZyBiL2RyaXZlcnMvaW5wdXQv
dG91Y2hzY3JlZW4vS2NvbmZpZwppbmRleCAzNDg4ZmZlLi5jYWU0NDhlIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL0tjb25maWcKKysrIGIvZHJpdmVycy9pbnB1dC90b3Vj
aHNjcmVlbi9LY29uZmlnCkBAIC03MzgsNCArNzM4LDE1IEBAIGNvbmZpZyBUT1VDSFNDUkVFTl9U
UFM2NTA3WAogCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0g
aGVyZTogdGhlCiAJICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgdHBzNjUwN3hfdHMuCiAKK2NvbmZp
ZyBUT1VDSFNDUkVFTl9XQUNPTV9JMkMKKwl0cmlzdGF0ZSAiV2Fjb20gVGFibGV0IHN1cHBvcnQo
STJDKSIKKwlkZXBlbmRzIG9uIEkyQworCWhlbHAKKwkgU2F5IFkgaGVyZSBpZiB5b3Ugd2FudCB0
byB1c2UgdGhlIEkyQyB2ZXJzaW9uIG9mIHRoZSBXYWNvbSBQZW4uCisJIE1ha2Ugc3VyZSB0byBz
YXkgWSB0byAiTW91c2Ugc3VwcG9ydCIgKENPTkZJR19JTlBVVF9NT1VTRURFVikKKwkgYW5kL29y
ICJFdmVudCBpbnRlcmZhY2Ugc3VwcG9ydCIgKENPTkZJR19JTlBVVF9FVkRFVikgYXMgd2VsbC4K
KworCSBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0
aGUgbW9kdWxlCisJIHdpbGwgYmUgY2FsbGVkIHdhY29tX2kyYy4KKwogZW5kaWYKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vTWFrZWZpbGUgYi9kcml2ZXJzL2lucHV0L3Rv
dWNoc2NyZWVuL01ha2VmaWxlCmluZGV4IGY5NTc2NzYuLjYxYmJmYzggMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vTWFrZWZpbGUKKysrIGIvZHJpdmVycy9pbnB1dC90b3Vj
aHNjcmVlbi9NYWtlZmlsZQpAQCAtNjEsMyArNjEsNCBAQCBvYmotJChDT05GSUdfVE9VQ0hTQ1JF
RU5fV005N1hYX01BSU5TVE9ORSkJKz0gCm1haW5zdG9uZS13bTk3eHgubwogb2JqLSQoQ09ORklH
X1RPVUNIU0NSRUVOX1dNOTdYWF9aWUxPTklURSkJKz0genlsb25pdGUtd205N3h4Lm8KIG9iai0k
KENPTkZJR19UT1VDSFNDUkVFTl9XOTBYOTAwKQkrPSB3OTBwOTEwX3RzLm8KIG9iai0kKENPTkZJ
R19UT1VDSFNDUkVFTl9UUFM2NTA3WCkJKz0gdHBzNjUwN3gtdHMubworb2JqLSQoQ09ORklHX1RP
VUNIU0NSRUVOX1dBQ09NX0kyQykJKz0gd2Fjb21faTJjLm8KLS0KMS43LjEKCi0tClRvIHVuc3Vi
c2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBsaW51eC1p
bnB1dCIgaW4gdGhlIGJvZHkgb2YgCmEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwu
b3JnIE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIApodHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9y
ZG9tby1pbmZvLmh0bWwK
--0015175cba6e6987e504b1adf98c--
