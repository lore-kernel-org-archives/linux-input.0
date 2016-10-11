From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 3/5] Input: add driver for Ilitek ili2139
 touch IC
Date: Tue, 11 Oct 2016 18:21:31 +0800
Message-ID: <20161011132149.LZ40KToV@smtp1h.mail.yandex.net>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBW726K7QKGQESZSRF7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Siebren Vroegindeweij <siebren.vroegindeweij-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sangwon Jee <jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rask Ingemann Lambertsen <ccc94453-1EA3ORoCGBhoJ7GROcy7lA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Damien
List-Id: linux-input@vger.kernel.org


2016=E5=B9=B410=E6=9C=8811=E6=97=A5 =E4=B8=8B=E5=8D=885:37=E4=BA=8E Hans de=
 Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,=20

I have a request: could you please test this driver on your E708 Q1? (Accor=
ding to the info you published on github, your E708 has also ili)

>
> On 10/11/2016 02:33 AM, Icenowy Zheng wrote:=20
> > This driver adds support for Ilitek ili2139 touch IC, which is used in=
=20
> > several Colorfly tablets (for example, Colorfly E708 Q1, which is an=20
> > Allwinner A31s tablet with mainline kernel support).=20
> >=20
> > Theortically it may support more Ilitek touch ICs, however, only ili213=
9=20
> > is used in any mainlined device.=20
> >=20
> > It supports device tree enumeration, with screen resolution and axis=20
> > quirks configurable.=20
> >=20
> > Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>=20
> > ---=20
> >=C2=A0 drivers/input/touchscreen/Kconfig=C2=A0=C2=A0 |=C2=A0 14 ++=20
> >=C2=A0 drivers/input/touchscreen/Makefile=C2=A0 |=C2=A0=C2=A0 1 +=20
> >=C2=A0 drivers/input/touchscreen/ili2139.c | 320 +++++++++++++++++++++++=
+++++++++++++=20
> >=C2=A0 3 files changed, 335 insertions(+)=20
> >=C2=A0 create mode 100644 drivers/input/touchscreen/ili2139.c=20
> >=20
> > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig=20
> > index 5079813..bb4d9d2 100644=20
> > --- a/drivers/input/touchscreen/Kconfig=20
> > +++ b/drivers/input/touchscreen/Kconfig=20
> > @@ -348,6 +348,20 @@ config TOUCHSCREEN_ILI210X=20
> >=C2=A0 =C2=A0 To compile this driver as a module, choose M here: the=20
> >=C2=A0 =C2=A0 module will be called ili210x.=20
> >=20
> > +config TOUCHSCREEN_ILI2139=20
> > + tristate "Ilitek ILI2139 based touchscreen"=20
> > + depends on I2C=20
> > + depends on OF=20
> > + help=20
> > + =C2=A0 Say Y here if you have a ILI2139 based touchscreen=20
> > + =C2=A0 controller. Such kind of chipsets can be found in several=20
> > + =C2=A0 Colorfly tablets.=20
> > +=20
> > + =C2=A0 If unsure, say N.=20
> > +=20
> > + =C2=A0 To compile this driver as a module, choose M here; the=20
> > + =C2=A0 module will be called ili2139.=20
> > +=20
> >=C2=A0 config TOUCHSCREEN_IPROC=20
> >=C2=A0 tristate "IPROC touch panel driver support"=20
> >=C2=A0 depends on ARCH_BCM_IPROC || COMPILE_TEST=20
> > diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile=20
> > index 81b8645..930b5e2 100644=20
> > --- a/drivers/input/touchscreen/Makefile=20
> > +++ b/drivers/input/touchscreen/Makefile=20
> > @@ -40,6 +40,7 @@ obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL) +=3D egalax_t=
s_serial.o=20
> >=C2=A0 obj-$(CONFIG_TOUCHSCREEN_FUJITSU) +=3D fujitsu_ts.o=20
> >=C2=A0 obj-$(CONFIG_TOUCHSCREEN_GOODIX) +=3D goodix.o=20
> >=C2=A0 obj-$(CONFIG_TOUCHSCREEN_ILI210X) +=3D ili210x.o=20
> > +obj-$(CONFIG_TOUCHSCREEN_ILI2139) +=3D ili2139.o=20
> >=C2=A0 obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC) +=3D imx6ul_tsc.o=20
> >=C2=A0 obj-$(CONFIG_TOUCHSCREEN_INEXIO) +=3D inexio.o=20
> >=C2=A0 obj-$(CONFIG_TOUCHSCREEN_INTEL_MID) +=3D intel-mid-touch.o=20
> > diff --git a/drivers/input/touchscreen/ili2139.c b/drivers/input/touchs=
creen/ili2139.c=20
> > new file mode 100644=20
> > index 0000000..65c2dea=20
> > --- /dev/null=20
> > +++ b/drivers/input/touchscreen/ili2139.c=20
> > @@ -0,0 +1,320 @@=20
> > +/* -------------------------------------------------------------------=
------=20
> > + * Copyright (C) 2016, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>=20
> > + *=20
> > + * Derived from:=20
> > + *=C2=A0 ili210x.c=20
> > + *=C2=A0 Copyright (C) Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>=20
> > + *=20
> > + *=C2=A0 This program is free software; you can redistribute it and/or=
 modify=20
> > + *=C2=A0 it under the terms of the GNU General Public License as publi=
shed by=20
> > + *=C2=A0 the Free Software Foundation; either version 2 of the License=
, or=20
> > + *=C2=A0 (at your option) any later version.=20
> > + *=20
> > + *=C2=A0 This program is distributed in the hope that it will be usefu=
l,=20
> > + *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty o=
f=20
> > + *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 Se=
e the=20
> > + *=C2=A0 GNU General Public License for more details.=20
> > + * -------------------------------------------------------------------=
------=20
> > + */=20
> > +=20
> > +#include <linux/module.h>=20
> > +#include <linux/i2c.h>=20
> > +#include <linux/interrupt.h>=20
> > +#include <linux/slab.h>=20
> > +#include <linux/input.h>=20
> > +#include <linux/input/mt.h>=20
> > +#include <linux/input/touchscreen.h>=20
> > +#include <linux/delay.h>=20
> > +#include <linux/workqueue.h>=20
> > +=20
> > +#define DEFAULT_POLL_PERIOD 20=20
> > +=20
> > +#define MAX_TOUCHES 10=20
> > +#define COMPATIBLE_TOUCHES 2=20
> > +=20
> > +/* Touchscreen commands */=20
> > +#define REG_TOUCHDATA 0x10=20
> > +#define REG_TOUCHSUBDATA 0x11=20
> > +#define REG_PANEL_INFO 0x20=20
> > +#define REG_FIRMWARE_VERSION 0x40=20
> > +#define REG_PROTO_VERSION 0x42=20
> > +=20
> > +#define SUBDATA_STATUS_TOUCH_POINT 0x80=20
> > +#define SUBDATA_STATUS_RELEASE_POINT 0x00=20
> > +=20
> > +struct finger {=20
> > + u8 x_low;=20
> > + u8 x_high;=20
> > + u8 y_low;=20
> > + u8 y_high;=20
> > +} __packed;=20
> > +=20
> > +struct touchdata {=20
> > + u8 length;=20
> > + struct finger finger[COMPATIBLE_TOUCHES];=20
> > +} __packed;=20
> > +=20
> > +struct touch_subdata {=20
> > + u8 status;=20
> > + struct finger finger;=20
> > +} __packed;=20
> > +=20
> > +struct panel_info {=20
> > + struct finger finger_max;=20
> > + u8 xchannel_num;=20
> > + u8 ychannel_num;=20
> > +} __packed;=20
> > +=20
> > +struct firmware_version {=20
> > + u8 id;=20
> > + u8 major;=20
> > + u8 minor;=20
> > +} __packed;=20
> > +=20
> > +struct ili2139 {=20
> > + struct i2c_client *client;=20
> > + struct input_dev *input;=20
> > + unsigned int poll_period;=20
> > + struct delayed_work dwork;=20
> > + struct touchscreen_properties prop;=20
> > + int slots[MAX_TOUCHES];=20
> > + int ids[MAX_TOUCHES];=20
> > + struct input_mt_pos pos[MAX_TOUCHES];=20
> > +};=20
> > +=20
> > +static int ili2139_read_reg(struct i2c_client *client, u8 reg, void *b=
uf,=20
> > + =C2=A0=C2=A0=C2=A0 size_t len)=20
> > +{=20
> > + struct i2c_msg msg[2] =3D {=20
> > + {=20
> > + .addr =3D client->addr,=20
> > + .flags =3D 0,=20
> > + .len =3D 1,=20
> > + .buf =3D &reg,=20
> > + },=20
> > + {=20
> > + .addr =3D client->addr,=20
> > + .flags =3D I2C_M_RD,=20
> > + .len =3D len,=20
> > + .buf =3D buf,=20
> > + }=20
> > + };=20
> > +=20
> > + if (i2c_transfer(client->adapter, msg, 2) !=3D 2) {=20
> > + dev_err(&client->dev, "i2c transfer failed\n");=20
> > + return -EIO;=20
> > + }=20
> > +=20
> > + return 0;=20
> > +}=20
>
> This just i2c_smbus_read_i2c_block_data, please use that instead.=20
>
> > +static void ili2139_work(struct work_struct *work)=20
> > +{=20
> > + int id;=20
> > + struct ili2139 *priv =3D container_of(work, struct ili2139,=20
> > + =C2=A0=C2=A0=C2=A0 dwork.work);=20
> > + struct i2c_client *client =3D priv->client;=20
> > + struct touchdata touchdata;=20
> > + struct touch_subdata subdata;=20
> > + int error;=20
> > +=20
> > + error =3D ili2139_read_reg(client, REG_TOUCHDATA,=20
> > + &touchdata, sizeof(touchdata));=20
> > + if (error) {=20
> > + dev_err(&client->dev,=20
> > + "Unable to get touchdata, err =3D %d\n", error);=20
> > + return;=20
> > + }=20
> > +=20
> > + for (id =3D 0; id < touchdata.length; id++) {=20
> > + error =3D ili2139_read_reg(client, REG_TOUCHSUBDATA, &subdata,=20
> > + sizeof(subdata));=20
> > + if (error) {=20
> > + dev_err(&client->dev,=20
> > + "Unable to get touch subdata, err =3D %d\n",=20
> > + error);=20
> > + return;=20
> > + }=20
> > +=20
> > + priv->ids[id] =3D subdata.status & 0x3F;=20
> > +=20
> > + /* The sequence changed in the v2 subdata protocol. */=20
> > + touchscreen_set_mt_pos(&priv->pos[id], &priv->prop,=20
> > + (subdata.finger.x_high | (subdata.finger.x_low << 8)),=20
> > + (subdata.finger.y_high | (subdata.finger.y_low << 8)));=20
> > + }=20
> > +=20
> > + input_mt_assign_slots(priv->input, priv->slots, priv->pos,=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 touchdata.length, 0);=20
> > +=20
> > + for (id =3D 0; id < touchdata.length; id++) {=20
> > + input_mt_slot(priv->input, priv->slots[id]);=20
> > + input_mt_report_slot_state(priv->input, MT_TOOL_FINGER,=20
> > + =C2=A0=C2=A0 subdata.status &=20
> > + =C2=A0=C2=A0 SUBDATA_STATUS_TOUCH_POINT);=20
> > + input_report_abs(priv->input, ABS_MT_POSITION_X,=20
> > + priv->pos[id].x);=20
> > + input_report_abs(priv->input, ABS_MT_POSITION_Y,=20
> > + priv->pos[id].y);=20
> > + }=20
> > +=20
> > + input_mt_sync_frame(priv->input);=20
> > + input_sync(priv->input);=20
> > +=20
> > + schedule_delayed_work(&priv->dwork,=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msecs_to_jiffies(priv->poll_period));=
=20
>
> If the irq is working properly there should be no need for this,=20
> can you try with this schedule call removed ?=20

Thanks. I'm glad to know this.
The driver that I modelled after is too old and unmaintained, and even near=
ly not usable now (as it requires platform data)

>
> > +}=20
> > +=20
> > +static irqreturn_t ili2139_irq(int irq, void *irq_data)=20
> > +{=20
> > + struct ili2139 *priv =3D irq_data;=20
> > +=20
> > + schedule_delayed_work(&priv->dwork, 0);=20
> > +=20
> > + return IRQ_HANDLED;=20
> > +}=20
> > +=20
> > +static int ili2139_i2c_probe(struct i2c_client *client,=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct i2c_device_id *id)=
=20
> > +{=20
> > + struct device *dev =3D &client->dev;=20
> > + struct ili2139 *priv;=20
> > + struct input_dev *input;=20
> > + struct panel_info panel;=20
> > + struct firmware_version firmware;=20
> > + int xmax, ymax;=20
> > + int error;=20
> > +=20
> > + dev_dbg(dev, "Probing for ILI2139 I2C Touschreen driver");=20
> > +=20
> > + if (client->irq <=3D 0) {=20
> > + dev_err(dev, "No IRQ!\n");=20
> > + return -ENODEV;=20
> > + }=20
> > +=20
> > + /* Get firmware version */=20
> > + error =3D ili2139_read_reg(client, REG_FIRMWARE_VERSION,=20
> > + &firmware, sizeof(firmware));=20
> > + if (error) {=20
> > + dev_err(dev, "Failed to get firmware version, err: %d\n",=20
> > + error);=20
> > + return error;=20
> > + }=20
> > +=20
> > + /* get panel info */=20
> > + error =3D ili2139_read_reg(client, REG_PANEL_INFO, &panel, sizeof(pan=
el));=20
> > + if (error) {=20
> > + dev_err(dev, "Failed to get panel information, err: %d\n",=20
> > + error);=20
> > + return error;=20
> > + }=20
> > +=20
> > + xmax =3D panel.finger_max.x_low | (panel.finger_max.x_high << 8);=20
> > + ymax =3D panel.finger_max.y_low | (panel.finger_max.y_high << 8);=20
> > +=20
> > + priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);=20
> > + input =3D devm_input_allocate_device(dev);=20
> > + if (!priv || !input)=20
> > + return -ENOMEM;=20
> > +=20
> > + priv->client =3D client;=20
> > + priv->input =3D input;=20
> > + priv->poll_period =3D DEFAULT_POLL_PERIOD;=20
> > + INIT_DELAYED_WORK(&priv->dwork, ili2139_work);=20
> > +=20
> > + /* Setup input device */=20
> > + input->name =3D "ILI2139 Touchscreen";=20
> > + input->id.bustype =3D BUS_I2C;=20
> > + input->dev.parent =3D dev;=20
> > +=20
> > + __set_bit(EV_SYN, input->evbit);=20
> > + __set_bit(EV_KEY, input->evbit);=20
> > + __set_bit(EV_ABS, input->evbit);=20
> > +=20
> > + /* Multi touch */=20
> > + input_mt_init_slots(input, MAX_TOUCHES, INPUT_MT_DIRECT |=20
> > + =C2=A0=C2=A0=C2=A0 INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK);=20
> > + input_set_abs_params(input, ABS_MT_POSITION_X, 0, xmax, 0, 0);=20
> > + input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ymax, 0, 0);=20
> > +=20
> > + touchscreen_parse_properties(input, true, &priv->prop);=20
> > +=20
> > + input_set_drvdata(input, priv);=20
> > + i2c_set_clientdata(client, priv);=20
> > +=20
> > + error =3D devm_request_irq(dev, client->irq, ili2139_irq,=20
> > + IRQF_TRIGGER_FALLING, client->name, priv);=20
>
> If things work with the re-scheduleing of the delayed work=20
> from the work removed, then you can use request_threaded_irq here,=20
> pass in ili2139_irq as the threaded handler (and NULL as the non threaded=
=20
> handler) and do all the i2c reading directly in ili2139_irq without needi=
ng=20
> to use any work struct at all.=20

I'll test it, and remember request_threaded_irq function. I've seen the usa=
ge of the function in silead.c.

>
> Regards,=20
>
> Hans=20
>
>
> > + if (error) {=20
> > + dev_err(dev, "Unable to request touchscreen IRQ, err: %d\n",=20
> > + error);=20
> > + return error;=20
> > + }=20
> > +=20
> > + error =3D input_register_device(priv->input);=20
> > + if (error) {=20
> > + dev_err(dev, "Cannot register input device, err: %d\n", error);=20
> > + return error;=20
> > + }=20
> > +=20
> > + device_init_wakeup(&client->dev, 1);=20
> > +=20
> > + dev_dbg(dev,=20
> > + "ILI2139 initialized (IRQ: %d), firmware version %d.%d.%d",=20
> > + client->irq, firmware.id, firmware.major, firmware.minor);=20
> > +=20
> > + return 0;=20
> > +}=20
> > +=20
> > +static int ili2139_i2c_remove(struct i2c_client *client)=20
> > +{=20
> > + struct ili2139 *priv =3D i2c_get_clientdata(client);=20
> > +=20
> > + cancel_delayed_work_sync(&priv->dwork);=20
> > +=20
> > + return 0;=20
> > +}=20
> > +=20
> > +static int __maybe_unused ili2139_i2c_suspend(struct device *dev)=20
> > +{=20
> > + struct i2c_client *client =3D to_i2c_client(dev);=20
> > +=20
> > + if (device_may_wakeup(&client->dev))=20
> > + enable_irq_wake(client->irq);=20
> > +=20
> > + return 0;=20
> > +}=20
> > +=20
> > +static int __maybe_unused ili2139_i2c_resume(struct device *dev)=20
> > +{=20
> > + struct i2c_client *client =3D to_i2c_client(dev);=20
> > +=20
> > + if (device_may_wakeup(&client->dev))=20
> > + disable_irq_wake(client->irq);=20
> > +=20
> > + return 0;=20
> > +}=20
> > +=20
> > +static SIMPLE_DEV_PM_OPS(ili2139_i2c_pm,=20
> > + ili2139_i2c_suspend, ili2139_i2c_resume);=20
> > +=20
> > +static const struct i2c_device_id ili2139_i2c_id[] =3D {=20
> > + { "ili2139", 0 },=20
> > + { }=20
> > +};=20
> > +MODULE_DEVICE_TABLE(i2c, ili2139_i2c_id);=20
> > +=20
> > +static struct i2c_driver ili2139_ts_driver =3D {=20
> > + .driver =3D {=20
> > + .name =3D "ili2139_i2c",=20
> > + .pm =3D &ili2139_i2c_pm,=20
> > + },=20
> > + .id_table =3D ili2139_i2c_id,=20
> > + .probe =3D ili2139_i2c_probe,=20
> > + .remove =3D ili2139_i2c_remove,=20
> > +};=20
> > +=20
> > +module_i2c_driver(ili2139_ts_driver);=20
> > +=20
> > +MODULE_AUTHOR("Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>");=20
> > +MODULE_DESCRIPTION("ILI2139 I2C Touchscreen Driver");=20
> > +MODULE_LICENSE("GPL");=20
> >=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
