From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/5] Input: add driver for Ilitek ili2139
 touch IC
Date: Wed, 12 Oct 2016 16:57:09 +0200
Message-ID: <f141b3cf-0bc7-59a2-c00e-dd650344e0ef@redhat.com>
References: <20161011132149.LZ40KToV@smtp1h.mail.yandex.net>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORBW467G7QKGQELJPUEBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161011132149.LZ40KToV-7L+JOpG+lXQ0PDqKvflMoHmW9unr2Ajn@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Siebren Vroegindeweij <siebren.vroegindeweij-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sangwon Jee <jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rask Ingemann Lambertsen <ccc94453-1EA3ORoCGBhoJ7GROcy7lA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Thierry Reding <tred>
List-Id: linux-input@vger.kernel.org

Hi,

On 10/11/2016 12:21 PM, Icenowy Zheng wrote:
>
> 2016=E5=B9=B410=E6=9C=8811=E6=97=A5 =E4=B8=8B=E5=8D=885:37=E4=BA=8E Hans =
de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hi,
>
> I have a request: could you please test this driver on your E708 Q1? (Acc=
ording to the info you published on github, your E708 has also ili)

I'm afraid the touchscreen on my E708 Q1 is broken (does not even work in a=
ndroid),
so I cannot test this.

>
>>
>> On 10/11/2016 02:33 AM, Icenowy Zheng wrote:
>>> This driver adds support for Ilitek ili2139 touch IC, which is used in
>>> several Colorfly tablets (for example, Colorfly E708 Q1, which is an
>>> Allwinner A31s tablet with mainline kernel support).
>>>
>>> Theortically it may support more Ilitek touch ICs, however, only ili213=
9
>>> is used in any mainlined device.
>>>
>>> It supports device tree enumeration, with screen resolution and axis
>>> quirks configurable.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
>>> ---
>>>   drivers/input/touchscreen/Kconfig   |  14 ++
>>>   drivers/input/touchscreen/Makefile  |   1 +
>>>   drivers/input/touchscreen/ili2139.c | 320 +++++++++++++++++++++++++++=
+++++++++
>>>   3 files changed, 335 insertions(+)
>>>   create mode 100644 drivers/input/touchscreen/ili2139.c
>>>
>>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
>>> index 5079813..bb4d9d2 100644
>>> --- a/drivers/input/touchscreen/Kconfig
>>> +++ b/drivers/input/touchscreen/Kconfig
>>> @@ -348,6 +348,20 @@ config TOUCHSCREEN_ILI210X
>>>     To compile this driver as a module, choose M here: the
>>>     module will be called ili210x.
>>>
>>> +config TOUCHSCREEN_ILI2139
>>> + tristate "Ilitek ILI2139 based touchscreen"
>>> + depends on I2C
>>> + depends on OF
>>> + help
>>> +   Say Y here if you have a ILI2139 based touchscreen
>>> +   controller. Such kind of chipsets can be found in several
>>> +   Colorfly tablets.
>>> +
>>> +   If unsure, say N.
>>> +
>>> +   To compile this driver as a module, choose M here; the
>>> +   module will be called ili2139.
>>> +
>>>   config TOUCHSCREEN_IPROC
>>>   tristate "IPROC touch panel driver support"
>>>   depends on ARCH_BCM_IPROC || COMPILE_TEST
>>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
>>> index 81b8645..930b5e2 100644
>>> --- a/drivers/input/touchscreen/Makefile
>>> +++ b/drivers/input/touchscreen/Makefile
>>> @@ -40,6 +40,7 @@ obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL) +=3D egalax_t=
s_serial.o
>>>   obj-$(CONFIG_TOUCHSCREEN_FUJITSU) +=3D fujitsu_ts.o
>>>   obj-$(CONFIG_TOUCHSCREEN_GOODIX) +=3D goodix.o
>>>   obj-$(CONFIG_TOUCHSCREEN_ILI210X) +=3D ili210x.o
>>> +obj-$(CONFIG_TOUCHSCREEN_ILI2139) +=3D ili2139.o
>>>   obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC) +=3D imx6ul_tsc.o
>>>   obj-$(CONFIG_TOUCHSCREEN_INEXIO) +=3D inexio.o
>>>   obj-$(CONFIG_TOUCHSCREEN_INTEL_MID) +=3D intel-mid-touch.o
>>> diff --git a/drivers/input/touchscreen/ili2139.c b/drivers/input/touchs=
creen/ili2139.c
>>> new file mode 100644
>>> index 0000000..65c2dea
>>> --- /dev/null
>>> +++ b/drivers/input/touchscreen/ili2139.c
>>> @@ -0,0 +1,320 @@
>>> +/* -------------------------------------------------------------------=
------
>>> + * Copyright (C) 2016, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
>>> + *
>>> + * Derived from:
>>> + *  ili210x.c
>>> + *  Copyright (C) Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
>>> + *
>>> + *  This program is free software; you can redistribute it and/or modi=
fy
>>> + *  it under the terms of the GNU General Public License as published =
by
>>> + *  the Free Software Foundation; either version 2 of the License, or
>>> + *  (at your option) any later version.
>>> + *
>>> + *  This program is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *  GNU General Public License for more details.
>>> + * -------------------------------------------------------------------=
------
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/input.h>
>>> +#include <linux/input/mt.h>
>>> +#include <linux/input/touchscreen.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/workqueue.h>
>>> +
>>> +#define DEFAULT_POLL_PERIOD 20
>>> +
>>> +#define MAX_TOUCHES 10
>>> +#define COMPATIBLE_TOUCHES 2
>>> +
>>> +/* Touchscreen commands */
>>> +#define REG_TOUCHDATA 0x10
>>> +#define REG_TOUCHSUBDATA 0x11
>>> +#define REG_PANEL_INFO 0x20
>>> +#define REG_FIRMWARE_VERSION 0x40
>>> +#define REG_PROTO_VERSION 0x42
>>> +
>>> +#define SUBDATA_STATUS_TOUCH_POINT 0x80
>>> +#define SUBDATA_STATUS_RELEASE_POINT 0x00
>>> +
>>> +struct finger {
>>> + u8 x_low;
>>> + u8 x_high;
>>> + u8 y_low;
>>> + u8 y_high;
>>> +} __packed;
>>> +
>>> +struct touchdata {
>>> + u8 length;
>>> + struct finger finger[COMPATIBLE_TOUCHES];
>>> +} __packed;
>>> +
>>> +struct touch_subdata {
>>> + u8 status;
>>> + struct finger finger;
>>> +} __packed;
>>> +
>>> +struct panel_info {
>>> + struct finger finger_max;
>>> + u8 xchannel_num;
>>> + u8 ychannel_num;
>>> +} __packed;
>>> +
>>> +struct firmware_version {
>>> + u8 id;
>>> + u8 major;
>>> + u8 minor;
>>> +} __packed;
>>> +
>>> +struct ili2139 {
>>> + struct i2c_client *client;
>>> + struct input_dev *input;
>>> + unsigned int poll_period;
>>> + struct delayed_work dwork;
>>> + struct touchscreen_properties prop;
>>> + int slots[MAX_TOUCHES];
>>> + int ids[MAX_TOUCHES];
>>> + struct input_mt_pos pos[MAX_TOUCHES];
>>> +};
>>> +
>>> +static int ili2139_read_reg(struct i2c_client *client, u8 reg, void *b=
uf,
>>> +     size_t len)
>>> +{
>>> + struct i2c_msg msg[2] =3D {
>>> + {
>>> + .addr =3D client->addr,
>>> + .flags =3D 0,
>>> + .len =3D 1,
>>> + .buf =3D &reg,
>>> + },
>>> + {
>>> + .addr =3D client->addr,
>>> + .flags =3D I2C_M_RD,
>>> + .len =3D len,
>>> + .buf =3D buf,
>>> + }
>>> + };
>>> +
>>> + if (i2c_transfer(client->adapter, msg, 2) !=3D 2) {
>>> + dev_err(&client->dev, "i2c transfer failed\n");
>>> + return -EIO;
>>> + }
>>> +
>>> + return 0;
>>> +}
>>
>> This just i2c_smbus_read_i2c_block_data, please use that instead.
>>
>>> +static void ili2139_work(struct work_struct *work)
>>> +{
>>> + int id;
>>> + struct ili2139 *priv =3D container_of(work, struct ili2139,
>>> +     dwork.work);
>>> + struct i2c_client *client =3D priv->client;
>>> + struct touchdata touchdata;
>>> + struct touch_subdata subdata;
>>> + int error;
>>> +
>>> + error =3D ili2139_read_reg(client, REG_TOUCHDATA,
>>> + &touchdata, sizeof(touchdata));
>>> + if (error) {
>>> + dev_err(&client->dev,
>>> + "Unable to get touchdata, err =3D %d\n", error);
>>> + return;
>>> + }
>>> +
>>> + for (id =3D 0; id < touchdata.length; id++) {
>>> + error =3D ili2139_read_reg(client, REG_TOUCHSUBDATA, &subdata,
>>> + sizeof(subdata));
>>> + if (error) {
>>> + dev_err(&client->dev,
>>> + "Unable to get touch subdata, err =3D %d\n",
>>> + error);
>>> + return;
>>> + }
>>> +
>>> + priv->ids[id] =3D subdata.status & 0x3F;
>>> +
>>> + /* The sequence changed in the v2 subdata protocol. */
>>> + touchscreen_set_mt_pos(&priv->pos[id], &priv->prop,
>>> + (subdata.finger.x_high | (subdata.finger.x_low << 8)),
>>> + (subdata.finger.y_high | (subdata.finger.y_low << 8)));
>>> + }
>>> +
>>> + input_mt_assign_slots(priv->input, priv->slots, priv->pos,
>>> +       touchdata.length, 0);
>>> +
>>> + for (id =3D 0; id < touchdata.length; id++) {
>>> + input_mt_slot(priv->input, priv->slots[id]);
>>> + input_mt_report_slot_state(priv->input, MT_TOOL_FINGER,
>>> +    subdata.status &
>>> +    SUBDATA_STATUS_TOUCH_POINT);
>>> + input_report_abs(priv->input, ABS_MT_POSITION_X,
>>> + priv->pos[id].x);
>>> + input_report_abs(priv->input, ABS_MT_POSITION_Y,
>>> + priv->pos[id].y);
>>> + }
>>> +
>>> + input_mt_sync_frame(priv->input);
>>> + input_sync(priv->input);
>>> +
>>> + schedule_delayed_work(&priv->dwork,
>>> +       msecs_to_jiffies(priv->poll_period));
>>
>> If the irq is working properly there should be no need for this,
>> can you try with this schedule call removed ?
>
> Thanks. I'm glad to know this.
> The driver that I modelled after is too old and unmaintained, and even ne=
arly not usable now (as it requires platform data)
>
>>
>>> +}
>>> +
>>> +static irqreturn_t ili2139_irq(int irq, void *irq_data)
>>> +{
>>> + struct ili2139 *priv =3D irq_data;
>>> +
>>> + schedule_delayed_work(&priv->dwork, 0);
>>> +
>>> + return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int ili2139_i2c_probe(struct i2c_client *client,
>>> +        const struct i2c_device_id *id)
>>> +{
>>> + struct device *dev =3D &client->dev;
>>> + struct ili2139 *priv;
>>> + struct input_dev *input;
>>> + struct panel_info panel;
>>> + struct firmware_version firmware;
>>> + int xmax, ymax;
>>> + int error;
>>> +
>>> + dev_dbg(dev, "Probing for ILI2139 I2C Touschreen driver");
>>> +
>>> + if (client->irq <=3D 0) {
>>> + dev_err(dev, "No IRQ!\n");
>>> + return -ENODEV;
>>> + }
>>> +
>>> + /* Get firmware version */
>>> + error =3D ili2139_read_reg(client, REG_FIRMWARE_VERSION,
>>> + &firmware, sizeof(firmware));
>>> + if (error) {
>>> + dev_err(dev, "Failed to get firmware version, err: %d\n",
>>> + error);
>>> + return error;
>>> + }
>>> +
>>> + /* get panel info */
>>> + error =3D ili2139_read_reg(client, REG_PANEL_INFO, &panel, sizeof(pan=
el));
>>> + if (error) {
>>> + dev_err(dev, "Failed to get panel information, err: %d\n",
>>> + error);
>>> + return error;
>>> + }
>>> +
>>> + xmax =3D panel.finger_max.x_low | (panel.finger_max.x_high << 8);
>>> + ymax =3D panel.finger_max.y_low | (panel.finger_max.y_high << 8);
>>> +
>>> + priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> + input =3D devm_input_allocate_device(dev);
>>> + if (!priv || !input)
>>> + return -ENOMEM;
>>> +
>>> + priv->client =3D client;
>>> + priv->input =3D input;
>>> + priv->poll_period =3D DEFAULT_POLL_PERIOD;
>>> + INIT_DELAYED_WORK(&priv->dwork, ili2139_work);
>>> +
>>> + /* Setup input device */
>>> + input->name =3D "ILI2139 Touchscreen";
>>> + input->id.bustype =3D BUS_I2C;
>>> + input->dev.parent =3D dev;
>>> +
>>> + __set_bit(EV_SYN, input->evbit);
>>> + __set_bit(EV_KEY, input->evbit);
>>> + __set_bit(EV_ABS, input->evbit);
>>> +
>>> + /* Multi touch */
>>> + input_mt_init_slots(input, MAX_TOUCHES, INPUT_MT_DIRECT |
>>> +     INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK);
>>> + input_set_abs_params(input, ABS_MT_POSITION_X, 0, xmax, 0, 0);
>>> + input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ymax, 0, 0);
>>> +
>>> + touchscreen_parse_properties(input, true, &priv->prop);
>>> +
>>> + input_set_drvdata(input, priv);
>>> + i2c_set_clientdata(client, priv);
>>> +
>>> + error =3D devm_request_irq(dev, client->irq, ili2139_irq,
>>> + IRQF_TRIGGER_FALLING, client->name, priv);
>>
>> If things work with the re-scheduleing of the delayed work
>> from the work removed, then you can use request_threaded_irq here,
>> pass in ili2139_irq as the threaded handler (and NULL as the non threade=
d
>> handler) and do all the i2c reading directly in ili2139_irq without need=
ing
>> to use any work struct at all.
>
> I'll test it, and remember request_threaded_irq function. I've seen the u=
sage of the function in silead.c.

Good :)


Regards,

Hans



>
>>
>> Regards,
>>
>> Hans
>>
>>
>>> + if (error) {
>>> + dev_err(dev, "Unable to request touchscreen IRQ, err: %d\n",
>>> + error);
>>> + return error;
>>> + }
>>> +
>>> + error =3D input_register_device(priv->input);
>>> + if (error) {
>>> + dev_err(dev, "Cannot register input device, err: %d\n", error);
>>> + return error;
>>> + }
>>> +
>>> + device_init_wakeup(&client->dev, 1);
>>> +
>>> + dev_dbg(dev,
>>> + "ILI2139 initialized (IRQ: %d), firmware version %d.%d.%d",
>>> + client->irq, firmware.id, firmware.major, firmware.minor);
>>> +
>>> + return 0;
>>> +}
>>> +
>>> +static int ili2139_i2c_remove(struct i2c_client *client)
>>> +{
>>> + struct ili2139 *priv =3D i2c_get_clientdata(client);
>>> +
>>> + cancel_delayed_work_sync(&priv->dwork);
>>> +
>>> + return 0;
>>> +}
>>> +
>>> +static int __maybe_unused ili2139_i2c_suspend(struct device *dev)
>>> +{
>>> + struct i2c_client *client =3D to_i2c_client(dev);
>>> +
>>> + if (device_may_wakeup(&client->dev))
>>> + enable_irq_wake(client->irq);
>>> +
>>> + return 0;
>>> +}
>>> +
>>> +static int __maybe_unused ili2139_i2c_resume(struct device *dev)
>>> +{
>>> + struct i2c_client *client =3D to_i2c_client(dev);
>>> +
>>> + if (device_may_wakeup(&client->dev))
>>> + disable_irq_wake(client->irq);
>>> +
>>> + return 0;
>>> +}
>>> +
>>> +static SIMPLE_DEV_PM_OPS(ili2139_i2c_pm,
>>> + ili2139_i2c_suspend, ili2139_i2c_resume);
>>> +
>>> +static const struct i2c_device_id ili2139_i2c_id[] =3D {
>>> + { "ili2139", 0 },
>>> + { }
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, ili2139_i2c_id);
>>> +
>>> +static struct i2c_driver ili2139_ts_driver =3D {
>>> + .driver =3D {
>>> + .name =3D "ili2139_i2c",
>>> + .pm =3D &ili2139_i2c_pm,
>>> + },
>>> + .id_table =3D ili2139_i2c_id,
>>> + .probe =3D ili2139_i2c_probe,
>>> + .remove =3D ili2139_i2c_remove,
>>> +};
>>> +
>>> +module_i2c_driver(ili2139_ts_driver);
>>> +
>>> +MODULE_AUTHOR("Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>");
>>> +MODULE_DESCRIPTION("ILI2139 I2C Touchscreen Driver");
>>> +MODULE_LICENSE("GPL");
>>>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
