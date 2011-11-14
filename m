From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: FW: [PATCH] Input:Add Wacom Stylus support for I2C
Date: Mon, 14 Nov 2011 09:14:06 -0800
Message-ID: <20111114171406.GC12659@core.coreip.homeip.net>
References: <4ec0d42f.e32c440a.043b.20d7SMTPIN_ADDED@mx.google.com>
 <CA+MtpR1VGAwYjmKaVmMvAidapMq9mgyYtqBxCwQy8+VHFMJ7zw@mail.gmail.com>
 <CA+MtpR1BixrC+SF3wurjtiD3j0hYZH_rJoZkKODQXjjW7b8BTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:37678 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab1KNROR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 12:14:17 -0500
Received: by pzk36 with SMTP id 36so12867330pzk.1
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 09:14:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+MtpR1BixrC+SF3wurjtiD3j0hYZH_rJoZkKODQXjjW7b8BTw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?6aOb55Sw6b6N5LmL5LuL?= <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Tobita,

On Mon, Nov 14, 2011 at 05:51:18PM +0900, =E9=A3=9B=E7=94=B0=E9=BE=8D=E4=
=B9=8B=E4=BB=8B wrote:
> Hi all
>=20
> I hope this mail will work.
> Please help to review wacom_i2c driver for wacom stylus with I2C inte=
rface.

It is in my queue to review, sorry for the delay...

> Thanks!
> Tats
>=20
> 2011/11/14 Tobita Tatsunosuke <tobita.tatsunosuke@wacom.co.jp>
> >
> >
> > -----Original Message-----
> > From: Tobita Tatsunosuke [mailto:tobita.tatsunosuke@wacom.co.jp]
> > Sent: Friday, November 04, 2011 9:44 PM
> > To: 'linux-input@vger.kernel.org'
> > Cc: 'Dmitry Torokhov'; 'Ping Cheng'; 'Jason Gerecke'
> > Subject: RE: [PATCH] Input:Add Wacom Stylus support for I2C
> >
> > Hello all
> >
> > It seems like my E-mail server didn't work well.
> > I sent this again in case it doesn't really send the message.
> >
> > I posted two patches a week ago; one is for modification Kconfig an=
d
> > Makefile(attached txt) and the other is below the driver and the he=
ader
> > files.
> > However, I haven't gotten any comment and am even not sure if those=
 files
> > are going to be included in next release.
> > Would you please help to review them?
> > Thanks!
> >
> > Regards,
> >
> > Tats
> >
> > -----Original Message-----
> > From: linux-input-owner@vger.kernel.org
> > [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Tatsunosuke=
 Tobita
> > Sent: Wednesday, October 19, 2011 3:36 PM
> > To: linux-input@vger.kernel.org
> > Cc: Tatsunosuke Tobita
> > Subject: [PATCH] Input:Add Wacom Stylus support for I2C
> >
> > From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> >
> > Adding support for Wacom Stylus with I2C interface.
> >
> > Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> > ---
> > =C2=A0drivers/input/touchscreen/wacom_i2c.c | =C2=A0261
> > +++++++++++++++++++++++++++++++++
> > =C2=A0drivers/input/touchscreen/wacom_i2c.h | =C2=A0 72 +++++++++
> > =C2=A02 files changed, 333 insertions(+), 0 deletions(-) =C2=A0crea=
te mode 100644
> > drivers/input/touchscreen/wacom_i2c.c
> > =C2=A0create mode 100644 drivers/input/touchscreen/wacom_i2c.h
> >
> > diff --git a/drivers/input/touchscreen/wacom_i2c.c
> > b/drivers/input/touchscreen/wacom_i2c.c
> > new file mode 100644
> > index 0000000..3f16f93
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/wacom_i2c.c
> > @@ -0,0 +1,260 @@
> > +/*
> > + * Wacom Penabled Driver for I2C
> > + *
> > + * Copyright (c) 2011 Tatsunosuke Tobita, Wacom.
> > + * <tobita.tatsunosuke@wacom.co.jp>
> > + *
> > + * This program is free software; you can redistribute it
> > + * and/or modify it under the terms of the GNU General
> > + * Public License as published by the Free Software
> > + * Foundation; either version of 2 of the License,
> > + * or (at your option) any later version.
> > + */
> > +
> > +#include "wacom_i2c.h"
> > +
> > +static int wacom_send_query(struct wacom_i2c *wac_i2c) {
> > + =C2=A0 =C2=A0 =C2=A0 int ret;
> > + =C2=A0 =C2=A0 =C2=A0 u8 cmd[4] =3D {CMD_QUERY0, CMD_QUERY1, CMD_Q=
UERY2, CMD_QUERY3};
> > + =C2=A0 =C2=A0 =C2=A0 u8 data[COM_COORD_NUM];
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_master_send(wac_i2c->client, cmd=
, sizeof(cmd));
> > + =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_printk(KERN_=
ERR, &wac_i2c->client->dev,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0"Sending 1st Query failed \n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 cmd[0] =3D CMD_THROW0; cmd[1] =3D CMD_THROW1=
;
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_master_send(wac_i2c->client, cmd=
, 2);
> > + =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_printk(KERN_=
ERR, &wac_i2c->client->dev,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0"Sending 2nd Query failed \n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_master_recv(wac_i2c->client, dat=
a, QUERY_SIZE);
> > + =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_printk(KERN_=
ERR, &wac_i2c->client->dev,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0"Receiving data failed 1\n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->wac_feature.x_max =3D get_unaligned=
_le16(&data[3]);
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->wac_feature.y_max =3D get_unaligned=
_le16(&data[5]);
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->wac_feature.pressure_max =3D get_un=
aligned_le16(&data[11]);
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->wac_feature.fw_version =3D get_unal=
igned_le16(&data[13]);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 dev_printk(KERN_INFO, &wac_i2c->client->dev,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"x_=
max:%d, y_max:%d, pressure:%d, fw:%d\n",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wac=
_i2c->wac_feature.x_max, wac_i2c->wac_feature.y_max,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wac=
_i2c->wac_feature.pressure_max,
> > +wac_i2c->wac_feature.fw_version);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +static void wacom_set_coordination(struct wacom_i2c *wac_i2c) {
> > + =C2=A0 =C2=A0 =C2=A0 int ret;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int x, y, pressure;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned char tsw, f1, f2, ers;
> > + =C2=A0 =C2=A0 =C2=A0 u8 data[COM_COORD_NUM];
> > +
> > + =C2=A0 =C2=A0 =C2=A0 do {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_mast=
er_recv(wac_i2c->client, data, QUERY_SIZE);
> > + =C2=A0 =C2=A0 =C2=A0 } while (gpio_get_value(GPIO) <=3D 0);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (ret >=3D 0) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tsw =3D data[3]&=
0x01;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ers =3D data[3]&=
0x04;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f1 =3D data[3]&0=
x02;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f2 =3D data[3]&0=
x10;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x =3D le16_to_cp=
up((__le16 *)&data[4]);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y =3D le16_to_cp=
up((__le16 *)&data[6]);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pressure =3D le1=
6_to_cpup((__le16 *)&data[8]);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_abs=
(wac_i2c->input, ABS_X, x);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_abs=
(wac_i2c->input, ABS_Y, y);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key=
(wac_i2c->input, BTN_TOOL_PEN, tsw);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key=
(wac_i2c->input, BTN_TOOL_RUBBER, ers);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_abs=
(wac_i2c->input, ABS_PRESSURE, pressure);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key=
(wac_i2c->input, BTN_TOUCH, (tsw || ers));
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key=
(wac_i2c->input, BTN_STYLUS, f1);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key=
(wac_i2c->input, BTN_STYLUS2, f2);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_sync(wac_i=
2c->input);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +}
> > +
> > +static irqreturn_t wacom_i2c_irq(int irqno, void *param) {
> > + =C2=A0 =C2=A0 =C2=A0 struct wacom_i2c *wac_i2c =3D param;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 wacom_set_coordination(wac_i2c);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
> > +}
> > +
> > +
> > +static int wacom_i2c_input_open(struct input_dev *dev) {
> > + =C2=A0 =C2=A0 =C2=A0 struct wacom_i2c *wac_i2c =3D input_get_drvd=
ata(dev);
> > + =C2=A0 =C2=A0 =C2=A0 int ret;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 __set_bit(ABS_X, wac_i2c->input->absbit);
> > + =C2=A0 =C2=A0 =C2=A0 __set_bit(ABS_Y, wac_i2c->input->absbit);
> > + =C2=A0 =C2=A0 =C2=A0 __set_bit(ABS_PRESSURE, wac_i2c->input->absb=
it);
> > + =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_TOOL_PEN, wac_i2c->input->keyb=
it);
> > + =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_TOOL_RUBBER, wac_i2c->input->k=
eybit);
> > + =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_STYLUS, wac_i2c->input->keybit=
);
> > + =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_STYLUS2, wac_i2c->input->keybi=
t);
> > + =C2=A0 =C2=A0 =C2=A0 __set_bit(BTN_TOUCH, wac_i2c->input->keybit)=
;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ret =3D wacom_send_query(wac_i2c);
> > + =C2=A0 =C2=A0 =C2=A0 if (ret < 0)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->input->id.version =3D wac_i2c->wac_=
feature.fw_version;
> > + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(wac_i2c->input, ABS_X, =
0,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wac_i2c->wac_feature.x_max, 0, 0);
> > + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(wac_i2c->input, ABS_Y, =
0,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wac_i2c->wac_feature.y_max, 0, 0);
> > + =C2=A0 =C2=A0 =C2=A0 input_set_abs_params(wac_i2c->input, ABS_PRE=
SSURE, 0,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wac_i2c->wac_feature.pressure_max, 0, 0)=
;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (request_threaded_irq(EMR_IRQ, NULL,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wacom_i2c_irq, IRQF_TRIGGE=
R_FALLING,
> > "WACOM_I2C_IRQ", wac_i2c)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_printk(KERN_=
ERR, &wac_i2c->client->dev, "Failed to
> > enable IRQ for EMR \n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 /*Clear the buffer in the firmware*/
> > + =C2=A0 =C2=A0 =C2=A0 wacom_set_coordination(wac_i2c);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +static void wacom_i2c_input_close(struct input_dev *dev) {
> > + =C2=A0 =C2=A0 =C2=A0 disable_irq(EMR_IRQ);
> > +}
> > +
> > +static int wacom_i2c_probe(struct i2c_client *client,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0const struct i2c_device_id *id)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct wacom_i2c *wac_i2c;
> > + =C2=A0 =C2=A0 =C2=A0 int err;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (!i2c_check_functionality(client->adapter=
, I2C_FUNC_I2C)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EIO;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail1;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c =3D kzalloc(sizeof(struct wacom_i2c)=
, GFP_KERNEL);
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->input =3D input_allocate_device();
> > + =C2=A0 =C2=A0 =C2=A0 if (wac_i2c =3D=3D NULL || wac_i2c->input =3D=
=3D NULL) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOMEM;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail2;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->client =3D client;
> > + =C2=A0 =C2=A0 =C2=A0 i2c_set_clientdata(client, wac_i2c);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 mutex_init(&wac_i2c->lock);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->input->name =3D "WACOM_I2C_DIGITIZE=
R";
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->input->id.bustype =3D BUS_I2C;
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->input->id.vendor =3D 0x56a;
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->input->dev.parent =3D &client->dev;
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->input->open =3D wacom_i2c_input_ope=
n;
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->input->close =3D wacom_i2c_input_cl=
ose;
> > + =C2=A0 =C2=A0 =C2=A0 wac_i2c->input->evbit[0] |=3D BIT_MASK(EV_KE=
Y) | BIT_MASK(EV_ABS);
> > + =C2=A0 =C2=A0 =C2=A0 input_set_drvdata(wac_i2c->input, wac_i2c);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (input_register_device(wac_i2c->input)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_printk(KERN_=
ERR, &wac_i2c->client->dev, "Failed to
> > register input device \n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENODEV;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail3;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +
> > + fail3:
> > + =C2=A0 =C2=A0 =C2=A0 input_free_device(wac_i2c->input);
> > + fail2:
> > + =C2=A0 =C2=A0 =C2=A0 kfree(wac_i2c);
> > + =C2=A0 =C2=A0 =C2=A0 dev_printk(KERN_ERR, &wac_i2c->client->dev, =
"Freeing device \n");
> > + fail1:
> > + =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "wacom_i2c: No I2C functiona=
lity found \n");
> > + =C2=A0 =C2=A0 =C2=A0 return err;
> > +}
> > +
> > +static int wacom_i2c_remove(struct i2c_client *client) {
> > + =C2=A0 =C2=A0 =C2=A0 struct wacom_i2c *wac_i2c =3D i2c_get_client=
data(client);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 free_irq(EMR_IRQ, wac_i2c);
> > + =C2=A0 =C2=A0 =C2=A0 input_unregister_device(wac_i2c->input);
> > + =C2=A0 =C2=A0 =C2=A0 kfree(wac_i2c);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int wacom_i2c_suspend(struct device *dev) {
> > + =C2=A0 =C2=A0 =C2=A0 disable_irq(EMR_IRQ);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +static int wacom_i2c_resume(struct device *dev) {
> > + =C2=A0 =C2=A0 =C2=A0 enable_irq(EMR_IRQ);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +static const struct dev_pm_ops wacom_i2c_pm =3D {
> > + =C2=A0 =C2=A0 =C2=A0 .suspend =3D wacom_i2c_suspend,
> > + =C2=A0 =C2=A0 =C2=A0 .resume =3D wacom_i2c_resume,
> > +};
> > +#endif
> > +
> > +static const struct i2c_device_id wacom_i2c_id[] =3D {
> > + =C2=A0 =C2=A0 =C2=A0 {WACNAME, 0},
> > + =C2=A0 =C2=A0 =C2=A0 {},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, wacom_i2c_id);
> > +
> > +static struct i2c_driver wacom_i2c_driver =3D {
> > + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "wacom=
_i2c",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_=
MODULE,
> > +#ifdef CONFIG_PM
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pm =3D &wacom_i=
2c_pm,
> > +#endif
> > + =C2=A0 =C2=A0 =C2=A0 },
> > +
> > + =C2=A0 =C2=A0 =C2=A0 .probe =3D wacom_i2c_probe,
> > + =C2=A0 =C2=A0 =C2=A0 .remove =3D wacom_i2c_remove,
> > + =C2=A0 =C2=A0 =C2=A0 .id_table =3D wacom_i2c_id,
> > +};
> > +
> > +static int __init wacom_i2c_init(void)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 return i2c_add_driver(&wacom_i2c_driver);
> > +}
> > +
> > +static void __exit wacom_i2c_exit(void) {
> > + =C2=A0 =C2=A0 =C2=A0 i2c_del_driver(&wacom_i2c_driver);
> > +}
> > +
> > +module_init(wacom_i2c_init);
> > +module_exit(wacom_i2c_exit);
> > +
> > +MODULE_AUTHOR("Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>=
");
> > +MODULE_DESCRIPTION("WACOM EMR I2C Driver"); MODULE_LICENSE("GPL");
> > diff --git a/drivers/input/touchscreen/wacom_i2c.h
> > b/drivers/input/touchscreen/wacom_i2c.h
> > new file mode 100644
> > index 0000000..13d86f9
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/wacom_i2c.h
> > @@ -0,0 +1,72 @@
> > +/*
> > + * Wacom Penabled Driver for I2C
> > + *
> > + * Copyright (c) 2011 Tatsunosuke Tobita, Wacom.
> > + * <tobita.tatsunosuke@wacom.co.jp>
> > + *
> > + * This program is free software; you can redistribute it
> > + * and/or modify it under the terms of the GNU General
> > + * Public License as published by the Free Software
> > + * Foundation; either version of 2 of the License,
> > + * or (at your option) any later version.
> > + */
> > +
> > +#ifndef WACOM_I2C_H
> > +#define WACOM_I2C_H
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/input.h>
> > +#include <linux/i2c.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/device.h>
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/gpio.h>
> > +#include <asm/unaligned.h>
> > +#include <asm/system.h>
> > +
> > +#define NAMEBUF 12
> > +#define WACNAME "WAC_I2C_EMR"
> > +
> > +/*Wacom Command*/
> > +#define COM_COORD_NUM =C2=A0 =C2=A0 =C2=A0256
> > +#define COM_SAMPLERATE_40 =C2=A00x33
> > +#define COM_SAMPLERATE_80 =C2=A00x32
> > +#define COM_SAMPLERATE_133 0x31
> > +#define CMD_QUERY0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04
> > +#define CMD_QUERY1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00
> > +#define CMD_QUERY2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x33
> > +#define CMD_QUERY3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02
> > +#define CMD_THROW0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x05
> > +#define CMD_THROW1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00
> > +#define QUERY_SIZE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 19
> > +
> > +/*I2C address for digitizer*/
> > +#define WACOM_I2C_ADDR =C2=A0 0x09
> > +
> > +/*Set a specific pin number on GPI for IRQ*/ #define GPIO 1 #defin=
e
> > +EMR_IRQ gpio_to_irq(GPIO)
> > +
> > +/*Parameters for wacom own features*/
> > +struct wacom_features {
> > + =C2=A0 =C2=A0 =C2=A0 int x_max;
> > + =C2=A0 =C2=A0 =C2=A0 int y_max;
> > + =C2=A0 =C2=A0 =C2=A0 int pressure_max;
> > + =C2=A0 =C2=A0 =C2=A0 char fw_version;
> > +};
> > +
> > +/*Parameters for i2c driver*/
> > +struct wacom_i2c {
> > + =C2=A0 =C2=A0 =C2=A0 struct i2c_client *client;
> > + =C2=A0 =C2=A0 =C2=A0 struct input_dev *input;
> > + =C2=A0 =C2=A0 =C2=A0 struct mutex lock;
> > + =C2=A0 =C2=A0 =C2=A0 struct wacom_features wac_feature;
> > + =C2=A0 =C2=A0 =C2=A0 int type;
> > + =C2=A0 =C2=A0 =C2=A0 const char name[NAMEBUF];
> > +};
> > +#endif
> > 1.7.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-inp=
ut" in
> > the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at
> > http://vger.kernel.org/majordomo-info.html

> =E5=B7=AE=E5=87=BA=E4=BA=BA:	linux-input-owner@vger.kernel.org =E3=81=
=AF Tatsunosuke Tobita [junkpainting@gmail.com] =E3=81=AE
> =E4=BB=A3=E7=90=86
> =E9=80=81=E4=BF=A1=E6=97=A5=E6=99=82:	2011=E5=B9=B410=E6=9C=8819=E6=97=
=A5=E6=B0=B4=E6=9B=9C=E6=97=A5 15:36
> =E5=AE=9B=E5=85=88:	linux-input@vger.kernel.org
> =EF=BC=A3=EF=BC=A3:	Tatsunosuke Tobita
> =E4=BB=B6=E5=90=8D:	[PATCH] Input: Modified on Kconfig and Makefile f=
or adding  Wacom Stylus for I2C
>=20
> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
>=20
>=20
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> ---
>  drivers/input/touchscreen/Kconfig  |   11 +++++++++++
>  drivers/input/touchscreen/Makefile |    1 +
>  2 files changed, 12 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index 3488ffe..cae448e 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -738,4 +738,15 @@ config TOUCHSCREEN_TPS6507X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tps6507x_ts.
> =20
> +config TOUCHSCREEN_WACOM_I2C
> +	tristate "Wacom Tablet support(I2C)"
> +	depends on I2C
> +	help
> +	 Say Y here if you want to use the I2C version of the Wacom Pen.
> +	 Make sure to say Y to "Mouse support" (CONFIG_INPUT_MOUSEDEV)
> +	 and/or "Event interface support" (CONFIG_INPUT_EVDEV) as well.
> +
> +	 To compile this driver as a module, choose M here: the module
> +	 will be called wacom_i2c.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index f957676..61bbfc8 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+=3D=20
> mainstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+=3D zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+=3D w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+=3D tps6507x-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_WACOM_I2C)	+=3D wacom_i2c.o
> --
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in the body of=20
> a message to majordomo@vger.kernel.org More majordomo info at =20
> http://vger.kernel.org/majordomo-info.html


--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
