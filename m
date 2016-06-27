From: Tony Felice <tony.felice@timesys.com>
Subject: Re: [PATCH 2/4] input: touchscreen: crtouch_ts: Add driver
Date: Mon, 27 Jun 2016 14:50:14 -0400
Message-ID: <CANcVtchY+gUE-RjLc1fskOhO+e9YMesFL-JLdHesa=btNR3XUQ@mail.gmail.com>
References: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
 <1466797486-31558-3-git-send-email-tony.felice@timesys.com>
 <20160624220427.GA11719@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0080597060=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160624220427.GA11719@dtor-ws>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, maitysanchayan@gmail.com, damien.riegel@savoirfairelinux.com, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, sre@kernel.org, mwelling@ieee.org, robh+dt@kernel.org, geert@linux-m68k.org, dri-devel@lists.freedesktop.org, kernel@pengutronix.de, linux-input@vger.kernel.org, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

--===============0080597060==
Content-Type: multipart/alternative; boundary=94eb2c03507800124a05364700e1

--94eb2c03507800124a05364700e1
Content-Type: text/plain; charset=UTF-8

Hi Dmitry, Stefan,

Thanks for your valuable feedback, I really appreciate it. I will review
and submit V2 patchset based on this. Please see a few comments in-line.

-Tony


On Fri, Jun 24, 2016 at 6:04 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com>
wrote:

> Hi Anthony,
>
> On Fri, Jun 24, 2016 at 03:44:44PM -0400, Anthony Felice wrote:
> > Add driver for the Vybrid Tower CRTouch-based touchscreen. This is
> > required for the touchscreen on the TWR-LCD-RGB to work on the Vybrid
> > Tower platform.
> >
> > There is a known issue with this driver: rarely, SW1 on the TWR-LCD-RGB
> > module needs to be pressed in order for the touchscreen to begin
> > functioning.
>
> Hmm. Could it be that you want level interrupt and not edge? Or maybe
> you want to read state after requesting interrupt?
>

I dug up an old email thread about this - According to this, the reason for
the failure is the crtouch chip is configured with the CRTSLEEP bit
initially set.  This means the chip goes into sleep mode between touchscreen
scans, and if the host tries to access it during this time it will start to
wake up, but will NAK until it is initialized.   The hardware solution is
to tie the WAKEUP pin low on the crtouch chip; otherwise, the driver needs
to run a loop to clear the CRTSLEEP bit in the crtouch configuration
register to prevent the device from sleeping. I will investigate further,
if this is the solution I will include as part of V2 patchset.

>
> > Signed-off-by: Anthony Felice <tony.felice@timesys.com>
> > ---
> >  .../bindings/input/touchscreen/crtouch_ts.txt      |  14 ++
> >  drivers/input/touchscreen/Kconfig                  |  10 +
> >  drivers/input/touchscreen/Makefile                 |   1 +
> >  drivers/input/touchscreen/crtouch_ts.c             | 279
> +++++++++++++++++++++
> >  4 files changed, 304 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> >  create mode 100644 drivers/input/touchscreen/crtouch_ts.c
> >
> > diff --git
> a/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> b/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> > new file mode 100644
> > index 0000000..cfb966c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> > @@ -0,0 +1,14 @@
> > +* Freescale CRTOUCH based touchscreen
> > +
> > +Required Properties:
> > +- compatible must be fsl,crtouch_ts
> > +- reg: I2C address of the touchscreen
> > +- irq-gpio: GPIO to use as event IRQ
> > +
> > +Example:
> > +
> > +     touch: crtouch@49 {
> > +             compatible = "fsl,crtouch_ts";
> > +             reg = <0x49>;
> > +             irq-gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
>
> You are not using it as gpio but only as interrupt source, so please
> set it up as regular interrupt and let I2C core set it up for you so
> that you will only need to call request_irq(client->irq, ...)
>
>                 interrupts = <&gpio0 21 IRQ_TYPE_EDGE_FALLING>;
>
> > +     };
> > diff --git a/drivers/input/touchscreen/Kconfig
> b/drivers/input/touchscreen/Kconfig
> > index 8ecdc38..799e342 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -1155,4 +1155,14 @@ config TOUCHSCREEN_ROHM_BU21023
> >         To compile this driver as a module, choose M here: the
> >         module will be called bu21023_ts.
> >
> > +config TOUCHSCREEN_CRTOUCH
> > +     tristate "Freescale CRTOUCH based touchscreen"
> > +     depends on I2C
> > +     help
> > +       Say Y here if you have a CRTOUCH based touchscreen
> > +       controller.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called crtouch_ts.
> > +
> >  endif
> > diff --git a/drivers/input/touchscreen/Makefile
> b/drivers/input/touchscreen/Makefile
> > index f42975e..8cb0a7a 100644
> > --- a/drivers/input/touchscreen/Makefile
> > +++ b/drivers/input/touchscreen/Makefile
> > @@ -95,3 +95,4 @@ obj-$(CONFIG_TOUCHSCREEN_TPS6507X)  += tps6507x-ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)     += zforce_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)       += colibri-vf50-ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)       += rohm_bu21023.o
> > +obj-$(CONFIG_TOUCHSCREEN_CRTOUCH)    += crtouch_ts.o
> > diff --git a/drivers/input/touchscreen/crtouch_ts.c
> b/drivers/input/touchscreen/crtouch_ts.c
> > new file mode 100644
> > index 0000000..bb87a8e
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/crtouch_ts.c
> > @@ -0,0 +1,279 @@
> > +/*
> > + * Driver for Freescale Semiconductor CRTOUCH - A Resistive and
> Capacitive
> > + * touch device with i2c interface
> > + *
> > + * Copyright 2012 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/input.h>
> > +#include <linux/input/mt.h>
> > +#include <linux/slab.h>
> > +#include <linux/bitops.h>
> > +#include <linux/gpio.h>
> > +#include <linux/of.h>
> > +#include <linux/of_gpio.h>
> > +
> > +/* Resistive touch sense status registers */
> > +#define RES_STA_ERROR                        0x00
> > +#define RES_STA_STATUS1                      0x01
> > +#define      RES_STA_STATUS2                 0x02
> > +#define RES_STA_X_MSB                        0x03
> > +#define RES_STA_X_LSB                        0x04
> > +#define RES_STA_Y_MSB                        0x05
> > +#define RES_STA_Y_LSB                        0x06
> > +#define RES_STA_PRES_MSB             0x07
> > +#define RES_STA_RRES_LSB             0x08
> > +#define RES_STA_FIFO_STATUS          0x09
> > +#define RES_STA_FIFO_X_MSB           0x0a
> > +#define RES_STA_FIFO_X_LSB           0x0b
> > +#define RES_STA_FIFO_Y_MSB           0x0c
> > +#define RES_STA_FIFO_Y_LSB           0x0d
> > +#define RES_STA_FIFO_PRES_MSB                0x0e
> > +#define RES_STA_FIFO_PRES_LSB                0x0f
> > +#define RES_STA_UART_BRATE_MSB               0x10
> > +#define RES_STA_UART_BRATE_MID               0x11
> > +#define RES_STA_UART_BRATE_LSB               0x12
> > +#define RES_STA_DEV_IDEN             0x13
> > +#define RES_STA_SLIDE_DISPLACE               0x14
> > +#define RES_STA_ROTATE_ANGLE         0x15
> > +
> > +/* Resistive touch configuration registers */
> > +#define CR_CON_SYSTEM                        0x40
> > +#define CR_CON_TRIG_EVENT            0x41
> > +#define CR_CON_FIFO_SETUP            0x42
> > +#define CR_CON_SAMPLING_RATE         0x43
> > +#define CR_CON_X_DELAY_MSB           0x44
> > +#define CR_CON_X_DELAY_LSB           0x45
> > +#define CR_CON_Y_DELAY_MSB           0x46
> > +#define CR_CON_Y_DELAY_LSB           0x47
> > +#define CR_CON_Z_DELAY_MSB           0x48
> > +#define CR_CON_Z_DELAY_LSB           0x49
> > +#define CR_CON_DIS_HOR_MSB           0x4a
> > +#define CR_CON_DIS_HOR_LSB           0x4b
> > +#define CR_CON_DIS_VER_MSB           0x4c
> > +#define CR_CON_DIS_VER_LSB           0x4d
> > +#define CR_CON_SLIDE_STEPS           0x4e
> > +
> > +#define RTST_EVENT                   BIT(7)
> > +#define RTS2T_EVENT                  BIT(6)
> > +#define RTSZ_EVENT                   BIT(5)
> > +#define RTSR_EVENT                   BIT(4)
> > +#define RTSS_EVENT                   BIT(3)
> > +#define RTSF_EVENT                   BIT(2)
> > +#define RTSRDY_EVENT                 BIT(0)
> > +
> > +#define RTSSD_MASK                   BIT(2)
> > +#define RTSSD_H_NEG                  BIT(2)
> > +#define RTSSD_V_POS                  BIT(3)
> > +#define RTSSD_V_NEG                  BIT(4)
> > +
> > +#define RTSRD_MASK                   BIT(4)
> > +#define RTSRD_COUNTER_CLK_WISE               BIT(4)
> > +
> > +#define RTSZD_MASK                   BIT(5)
> > +#define RTSZD_ZOOM_OUT                       BIT(5)
> > +
> > +#define CRTOUCH_MAX_FINGER           2
> > +#define CRTOUCH_MAX_AREA             0xfff
> > +#define CRTOUCH_MAX_X                        0x01df
> > +#define CRTOUCH_MAX_Y                        0x010f
> > +
> > +struct crtouch_ts_data {
> > +     struct i2c_client       *client;
> > +     struct input_dev        *input_dev;
> > +};
> > +
> > +static u8 crtouch_read_reg(struct i2c_client *client, int addr)
> > +{
> > +     return i2c_smbus_read_byte_data(client, addr);
> > +}
> > +
> > +static int crtouch_write_reg(struct i2c_client *client, int addr, int
> data)
> > +{
> > +     return i2c_smbus_write_byte_data(client, addr, data);
> > +}
> > +
> > +static void calibration_pointer(u16 *x_orig, u16 *y_orig)
> > +{
> > +     u16 x, y;
> > +
> > +     x = CRTOUCH_MAX_X - *x_orig;
> > +     *x_orig = x;
> > +
> > +     y = CRTOUCH_MAX_Y - *y_orig;
> > +     *y_orig = y;
> > +}
> > +
> > +static irqreturn_t crtouch_ts_interrupt(int irq, void *dev_id)
> > +{
> > +     struct crtouch_ts_data *data = dev_id;
> > +     struct i2c_client *client = data->client;
> > +     u8 status1;
> > +     u16 valuep, valuex, valuey;
> > +
> > +     status1 = crtouch_read_reg(client, RES_STA_STATUS1);
> > +
> > +     /* For single touch */
> > +     if (status1 & RTST_EVENT) {
> > +             valuep = crtouch_read_reg(client, RES_STA_PRES_MSB);
> > +             valuep = ((valuep << 8) |
> > +                     crtouch_read_reg(client, RES_STA_RRES_LSB));
>
> Is it possible to read 2 bytes at once?
>
> > +             valuex = crtouch_read_reg(client, RES_STA_X_MSB);
> > +             valuex = ((valuex << 8) |
> > +                     crtouch_read_reg(client, RES_STA_X_LSB));
> > +             valuey = crtouch_read_reg(client, RES_STA_Y_MSB);
> > +             valuey = ((valuey << 8) |
> > +                     crtouch_read_reg(client, RES_STA_Y_LSB));
> > +             calibration_pointer(&valuex, &valuey);
>
> I'd do conversion inline - it is clearer what is going on.
>
> > +             input_report_key(data->input_dev, BTN_TOUCH, 1);
> > +             input_report_abs(data->input_dev, ABS_X, valuex);
> > +             input_report_abs(data->input_dev, ABS_Y, valuey);
> > +             input_report_abs(data->input_dev, ABS_PRESSURE, valuep);
> > +             input_sync(data->input_dev);
> > +     } else {
> > +             input_report_abs(data->input_dev, ABS_PRESSURE, 0);
> > +             input_event(data->input_dev, EV_KEY, BTN_TOUCH, 0);
> > +             input_sync(data->input_dev);
> > +     }
>
> input_sync() can go here.
>
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void crtouch_ts_reg_init(struct crtouch_ts_data *data)
> > +{
> > +     struct i2c_client *client = data->client;
> > +
> > +     crtouch_write_reg(client, CR_CON_SYSTEM, 0x9c);
> > +     crtouch_write_reg(client, CR_CON_TRIG_EVENT, 0xf9);
> > +     crtouch_write_reg(client, CR_CON_FIFO_SETUP, 0x1f);
> > +     crtouch_write_reg(client, CR_CON_SAMPLING_RATE, 0x08);
> > +     crtouch_write_reg(client, CR_CON_DIS_HOR_MSB, 0x01);
> > +     crtouch_write_reg(client, CR_CON_DIS_HOR_LSB, 0xdf);
> > +     crtouch_write_reg(client, CR_CON_DIS_VER_MSB, 0x01);
> > +     crtouch_write_reg(client, CR_CON_DIS_VER_LSB, 0x0f);
>
> Should we fetch any of this data from DTS? I assume CR_CON_DIS_HOR/VER
> is resolution? Or not?
>

Yes, the HOR/VER info can at least be fetched from DTS. I will fix as part
of V2 patchset.


>
> Also, why no error handling?
>
> > +}
> > +
> > +static int crtouch_ts_probe(struct i2c_client *client,
> > +                         const struct i2c_device_id *id)
> > +{
> > +     struct crtouch_ts_data *data;
> > +     struct input_dev *input_dev;
> > +     int error = -1, irq_gpio;
> > +
> > +     dev_info(&client->dev, "Freescale CRTOUCH driver\n");
>
> Please drop this.
>
> > +
> > +     data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +     input_dev = input_allocate_device();
>
> Please use devm* and you will be able to get rid of crtouch_ts_remove().
>
> > +     if (!data || !input_dev) {
> > +             dev_err(&client->dev, "Failed to allocate memory\n");
> > +             error = -ENOMEM;
> > +             goto err_free_mem;
> > +     }
> > +
> > +     data->client = client;
> > +     data->input_dev = input_dev;
> > +
> > +     input_dev->name = "crtouch_ts";
> > +     input_dev->id.bustype = BUS_I2C;
> > +     input_dev->dev.parent = &client->dev;
> > +
> > +     /* For single touch */
> > +     __set_bit(EV_KEY, input_dev->evbit);
> > +     __set_bit(BTN_TOUCH, input_dev->keybit);
> > +     __set_bit(EV_ABS, input_dev->evbit);
> > +     __set_bit(ABS_X, input_dev->absbit);
> > +     __set_bit(ABS_Y, input_dev->absbit);
> > +     __set_bit(ABS_PRESSURE, input_dev->absbit);
> > +
> > +     input_set_abs_params(input_dev, ABS_X, 0, CRTOUCH_MAX_X, 0, 0);
> > +     input_set_abs_params(input_dev, ABS_Y, 0, CRTOUCH_MAX_Y, 0, 0);
> > +     input_set_abs_params(input_dev, ABS_PRESSURE, 0,
> > +                          CRTOUCH_MAX_AREA, 0, 0);
> > +
> > +     input_set_drvdata(input_dev, data);
> > +
> > +     crtouch_ts_reg_init(data);
> > +
> > +     irq_gpio = of_get_named_gpio(client->dev.of_node, "irq-gpio", 0);
> > +     if (!gpio_is_valid(irq_gpio))
> > +             goto err_free_mem;
> > +
> > +     error = gpio_request_one(irq_gpio, GPIOF_IN, "TS_IRQ");
> > +     if (error) {
> > +             dev_err(&client->dev, "Failed to request gpio\n");
> > +             goto err_free_mem;
> > +     }
> > +
> > +     error = request_threaded_irq(gpio_to_irq(irq_gpio), NULL,
> > +                                  crtouch_ts_interrupt,
> > +                                  IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
> > +                                  "crtouch_ts", data);
>
> As i mentioned above replace everything starting with of_get_named_gpio
> with:
>
>         error = devm_request_threaded_irq(&cleint->dev, client->irq,
>                                           NULL, crtouch_ts_interrupt,
>                                           IRQF_ONESHOT,
>                                           "crtouch_ts", data);
>
> > +
> > +     if (error) {
> > +             dev_err(&client->dev, "Failed to register interrupt\n");
> > +             goto err_free_mem;
> > +     }
> > +
> > +     error = input_register_device(data->input_dev);
> > +     if (error)
> > +             goto err_free_irq;
> > +
> > +     i2c_set_clientdata(client, data);
> > +     return 0;
> > +
> > +err_free_irq:
> > +     free_irq(client->irq, data);
> > +err_free_mem:
> > +     input_free_device(input_dev);
> > +     kfree(data);
> > +     return error;
> > +}
> > +
> > +static int crtouch_ts_remove(struct i2c_client *client)
> > +{
> > +     struct crtouch_ts_data *data = i2c_get_clientdata(client);
> > +
> > +     free_irq(client->irq, data);
> > +     input_unregister_device(data->input_dev);
> > +     kfree(data);
>
> With devm it can all be dropped.
>
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct i2c_device_id crtouch_ts_id[] = {
> > +     {"crtouch_ts", 0},
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, crtouch_ts_id);
> > +
> > +static const struct of_device_id crtouch_ts_dt_ids[] = {
> > +     { .compatible = "fsl,crtouch_ts", },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, crtouch_ts_dt_ids);
> > +
> > +static struct i2c_driver crtouch_ts_i2c_driver = {
> > +     .driver = {
> > +                .name = "crtouch_ts",
> > +                .owner = THIS_MODULE,
>
> No need to set owner.
>
> > +                .of_match_table = crtouch_ts_dt_ids,
>
>                         .of_match_table = of_match_ptr(crtouch_ts_dt_ids),
>
> Also, no PM methods?
>
>
Well, the main reason for no PM methods is the original driver did not have
PM methods. I can implement sleep/resume methods, and if all is working
well will submit as part of V2.


> > +                },
> > +     .probe = crtouch_ts_probe,
> > +     .remove = crtouch_ts_remove,
> > +     .id_table = crtouch_ts_id,
> > +};
> > +
> > +module_i2c_driver(crtouch_ts_i2c_driver);
> > +
> > +MODULE_AUTHOR("Alison Wang <b18965@freescale.com>");
> > +MODULE_DESCRIPTION("Touchscreen driver for Freescale CRTOUCH");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.7.4
> >
>
> Thanks.
>
> --
> Dmitry
>



-- 
Tony Felice
Support Engineering Manager
Timesys Corporation

--94eb2c03507800124a05364700e1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi Dmitry, Stefan,<br><br></div>Thanks for your =
valuable feedback, I really appreciate it. I will review and submit V2 patc=
hset based on this. Please see a few comments in-line.<br><br></div>-Tony<b=
r><div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri=
, Jun 24, 2016 at 6:04 PM, Dmitry Torokhov <span dir=3D"ltr">&lt;<a href=3D=
"mailto:dmitry.torokhov@gmail.com" target=3D"_blank">dmitry.torokhov@gmail.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi Anthony,<br>
<span><br>
On Fri, Jun 24, 2016 at 03:44:44PM -0400, Anthony Felice wrote:<br>
&gt; Add driver for the Vybrid Tower CRTouch-based touchscreen. This is<br>
&gt; required for the touchscreen on the TWR-LCD-RGB to work on the Vybrid<=
br>
&gt; Tower platform.<br>
&gt;<br>
&gt; There is a known issue with this driver: rarely, SW1 on the TWR-LCD-RG=
B<br>
&gt; module needs to be pressed in order for the touchscreen to begin<br>
&gt; functioning.<br>
<br>
</span>Hmm. Could it be that you want level interrupt and not edge? Or mayb=
e<br>
you want to read state after requesting interrupt?<br><div><div></div></div=
></blockquote><div><br></div><div>I dug up an old email thread about this -=
 According to this, the reason for the failure is the crtouch chip is confi=
gured with=20
the CRTSLEEP bit initially set.=C2=A0 This
 means the chip goes into sleep mode between <span class=3D"">touchscreen</=
span>
 scans, and if the host tries to access it during this time it will=20
start to wake up, but will NAK until it is initialized.=C2=A0=C2=A0 The har=
dware solution is to tie the WAKEUP pin low on the crtouch chip; otherwise,=
 the driver needs to run a loop to clear the CRTSLEEP bit in the crtouch co=
nfiguration register to prevent the device from sleeping. I will investigat=
e further, if this is the solution I will include as part of V2 patchset.<b=
r><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div>
&gt;<br>
&gt; Signed-off-by: Anthony Felice &lt;<a href=3D"mailto:tony.felice@timesy=
s.com" target=3D"_blank">tony.felice@timesys.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../bindings/input/touchscreen/crtouch_ts.txt=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 14 ++<br>
&gt;=C2=A0 drivers/input/touchscreen/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 drivers/input/touchscreen/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/input/touchscreen/crtouch_ts.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 279 +++++++++++++++++++++<br>
&gt;=C2=A0 4 files changed, 304 insertions(+)<br>
&gt;=C2=A0 create mode 100644 Documentation/devicetree/bindings/input/touch=
screen/crtouch_ts.txt<br>
&gt;=C2=A0 create mode 100644 drivers/input/touchscreen/crtouch_ts.c<br>
&gt;<br>
&gt; diff --git a/Documentation/devicetree/bindings/input/touchscreen/crtou=
ch_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.=
txt<br>
&gt; new file mode 100644<br>
&gt; index 0000000..cfb966c<br>
&gt; --- /dev/null<br>
&gt; +++ b/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.t=
xt<br>
&gt; @@ -0,0 +1,14 @@<br>
&gt; +* Freescale CRTOUCH based touchscreen<br>
&gt; +<br>
&gt; +Required Properties:<br>
&gt; +- compatible must be fsl,crtouch_ts<br>
&gt; +- reg: I2C address of the touchscreen<br>
&gt; +- irq-gpio: GPIO to use as event IRQ<br>
&gt; +<br>
&gt; +Example:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0touch: crtouch@49 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
fsl,crtouch_ts&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x49&gt;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq-gpio =3D &lt;&amp=
;gpio0 21 GPIO_ACTIVE_HIGH&gt;;<br>
<br>
</div></div>You are not using it as gpio but only as interrupt source, so p=
lease<br>
set it up as regular interrupt and let I2C core set it up for you so<br>
that you will only need to call request_irq(client-&gt;irq, ...)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D &lt;=
&amp;gpio0 21 IRQ_TYPE_EDGE_FALLING&gt;;<br>
<div><div><br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchsc=
reen/Kconfig<br>
&gt; index 8ecdc38..799e342 100644<br>
&gt; --- a/drivers/input/touchscreen/Kconfig<br>
&gt; +++ b/drivers/input/touchscreen/Kconfig<br>
&gt; @@ -1155,4 +1155,14 @@ config TOUCHSCREEN_ROHM_BU21023<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, c=
hoose M here: the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called bu21023_ts.<br>
&gt;<br>
&gt; +config TOUCHSCREEN_CRTOUCH<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;Freescale CRTOUCH based touchscree=
n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on I2C<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here if you have a CRTOUCH based tou=
chscreen<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0controller.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, choose=
 M here: the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called crtouch_ts.<br>
&gt; +<br>
&gt;=C2=A0 endif<br>
&gt; diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchs=
creen/Makefile<br>
&gt; index f42975e..8cb0a7a 100644<br>
&gt; --- a/drivers/input/touchscreen/Makefile<br>
&gt; +++ b/drivers/input/touchscreen/Makefile<br>
&gt; @@ -95,3 +95,4 @@ obj-$(CONFIG_TOUCHSCREEN_TPS6507X)=C2=A0 +=3D tps650=
7x-ts.o<br>
&gt;=C2=A0 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)=C2=A0 =C2=A0 =C2=A0+=3D zforce_=
ts.o<br>
&gt;=C2=A0 obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0+=3D colibri-vf50-ts.o<br>
&gt;=C2=A0 obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0+=3D rohm_bu21023.o<br>
&gt; +obj-$(CONFIG_TOUCHSCREEN_CRTOUCH)=C2=A0 =C2=A0 +=3D crtouch_ts.o<br>
&gt; diff --git a/drivers/input/touchscreen/crtouch_ts.c b/drivers/input/to=
uchscreen/crtouch_ts.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..bb87a8e<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/input/touchscreen/crtouch_ts.c<br>
&gt; @@ -0,0 +1,279 @@<br>
&gt; +/*<br>
&gt; + * Driver for Freescale Semiconductor CRTOUCH - A Resistive and Capac=
itive<br>
&gt; + * touch device with i2c interface<br>
&gt; + *<br>
&gt; + * Copyright 2012 Freescale Semiconductor, Inc.<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation; either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/init.h&gt;<br>
&gt; +#include &lt;linux/i2c.h&gt;<br>
&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt; +#include &lt;linux/input.h&gt;<br>
&gt; +#include &lt;linux/input/mt.h&gt;<br>
&gt; +#include &lt;linux/slab.h&gt;<br>
&gt; +#include &lt;linux/bitops.h&gt;<br>
&gt; +#include &lt;linux/gpio.h&gt;<br>
&gt; +#include &lt;linux/of.h&gt;<br>
&gt; +#include &lt;linux/of_gpio.h&gt;<br>
&gt; +<br>
&gt; +/* Resistive touch sense status registers */<br>
&gt; +#define RES_STA_ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00<br>
&gt; +#define RES_STA_STATUS1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 RES_STA_STATUS2=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x02<br>
&gt; +#define RES_STA_X_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x03<br>
&gt; +#define RES_STA_X_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>
&gt; +#define RES_STA_Y_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x05<br>
&gt; +#define RES_STA_Y_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x06<br>
&gt; +#define RES_STA_PRES_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x07<br>
&gt; +#define RES_STA_RRES_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x08<br>
&gt; +#define RES_STA_FIFO_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x09<br=
>
&gt; +#define RES_STA_FIFO_X_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
0a<br>
&gt; +#define RES_STA_FIFO_X_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
0b<br>
&gt; +#define RES_STA_FIFO_Y_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
0c<br>
&gt; +#define RES_STA_FIFO_Y_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
0d<br>
&gt; +#define RES_STA_FIFO_PRES_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x0e<br>
&gt; +#define RES_STA_FIFO_PRES_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x0f<br>
&gt; +#define RES_STA_UART_BRATE_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x10<br>
&gt; +#define RES_STA_UART_BRATE_MID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x11<br>
&gt; +#define RES_STA_UART_BRATE_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x12<br>
&gt; +#define RES_STA_DEV_IDEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x13<br>
&gt; +#define RES_STA_SLIDE_DISPLACE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x14<br>
&gt; +#define RES_STA_ROTATE_ANGLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x15<br=
>
&gt; +<br>
&gt; +/* Resistive touch configuration registers */<br>
&gt; +#define CR_CON_SYSTEM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x40<br>
&gt; +#define CR_CON_TRIG_EVENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x=
41<br>
&gt; +#define CR_CON_FIFO_SETUP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x=
42<br>
&gt; +#define CR_CON_SAMPLING_RATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x43<br=
>
&gt; +#define CR_CON_X_DELAY_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
44<br>
&gt; +#define CR_CON_X_DELAY_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
45<br>
&gt; +#define CR_CON_Y_DELAY_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
46<br>
&gt; +#define CR_CON_Y_DELAY_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
47<br>
&gt; +#define CR_CON_Z_DELAY_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
48<br>
&gt; +#define CR_CON_Z_DELAY_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
49<br>
&gt; +#define CR_CON_DIS_HOR_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
4a<br>
&gt; +#define CR_CON_DIS_HOR_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
4b<br>
&gt; +#define CR_CON_DIS_VER_MSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
4c<br>
&gt; +#define CR_CON_DIS_VER_LSB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
4d<br>
&gt; +#define CR_CON_SLIDE_STEPS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
4e<br>
&gt; +<br>
&gt; +#define RTST_EVENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0BIT(7)<br>
&gt; +#define RTS2T_EVENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 BIT(6)<br>
&gt; +#define RTSZ_EVENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0BIT(5)<br>
&gt; +#define RTSR_EVENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0BIT(4)<br>
&gt; +#define RTSS_EVENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0BIT(3)<br>
&gt; +#define RTSF_EVENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0BIT(2)<br>
&gt; +#define RTSRDY_EVENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0BIT(0)<br>
&gt; +<br>
&gt; +#define RTSSD_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0BIT(2)<br>
&gt; +#define RTSSD_H_NEG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 BIT(2)<br>
&gt; +#define RTSSD_V_POS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 BIT(3)<br>
&gt; +#define RTSSD_V_NEG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 BIT(4)<br>
&gt; +<br>
&gt; +#define RTSRD_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0BIT(4)<br>
&gt; +#define RTSRD_COUNTER_CLK_WISE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BIT(4)<br>
&gt; +<br>
&gt; +#define RTSZD_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0BIT(5)<br>
&gt; +#define RTSZD_ZOOM_OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(5)<br>
&gt; +<br>
&gt; +#define CRTOUCH_MAX_FINGER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<=
br>
&gt; +#define CRTOUCH_MAX_AREA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00xfff<br>
&gt; +#define CRTOUCH_MAX_X=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01df<br>
&gt; +#define CRTOUCH_MAX_Y=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x010f<br>
&gt; +<br>
&gt; +struct crtouch_ts_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_client=C2=A0 =C2=A0 =C2=A0 =C2=A0*clie=
nt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct input_dev=C2=A0 =C2=A0 =C2=A0 =C2=A0 *inpu=
t_dev;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static u8 crtouch_read_reg(struct i2c_client *client, int addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return i2c_smbus_read_byte_data(client, addr);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +static int crtouch_write_reg(struct i2c_client *client, int addr, int=
 data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return i2c_smbus_write_byte_data(client, addr, da=
ta);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void calibration_pointer(u16 *x_orig, u16 *y_orig)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 x, y;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0x =3D CRTOUCH_MAX_X - *x_orig;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*x_orig =3D x;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0y =3D CRTOUCH_MAX_Y - *y_orig;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*y_orig =3D y;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static irqreturn_t crtouch_ts_interrupt(int irq, void *dev_id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct crtouch_ts_data *data =3D dev_id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_client *client =3D data-&gt;client;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 status1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 valuep, valuex, valuey;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status1 =3D crtouch_read_reg(client, RES_STA_STAT=
US1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* For single touch */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (status1 &amp; RTST_EVENT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0valuep =3D crtouch_re=
ad_reg(client, RES_STA_PRES_MSB);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0valuep =3D ((valuep &=
lt;&lt; 8) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0crtouch_read_reg(client, RES_STA_RRES_LSB));<br>
<br>
</div></div>Is it possible to read 2 bytes at once?<br>
<span><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0valuex =3D crtouch_re=
ad_reg(client, RES_STA_X_MSB);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0valuex =3D ((valuex &=
lt;&lt; 8) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0crtouch_read_reg(client, RES_STA_X_LSB));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0valuey =3D crtouch_re=
ad_reg(client, RES_STA_Y_MSB);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0valuey =3D ((valuey &=
lt;&lt; 8) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0crtouch_read_reg(client, RES_STA_Y_LSB));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0calibration_pointer(&=
amp;valuex, &amp;valuey);<br>
<br>
</span>I&#39;d do conversion inline - it is clearer what is going on.<br>
<span><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_key(data=
-&gt;input_dev, BTN_TOUCH, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_abs(data=
-&gt;input_dev, ABS_X, valuex);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_abs(data=
-&gt;input_dev, ABS_Y, valuey);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_abs(data=
-&gt;input_dev, ABS_PRESSURE, valuep);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_sync(data-&gt;i=
nput_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_abs(data=
-&gt;input_dev, ABS_PRESSURE, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_event(data-&gt;=
input_dev, EV_KEY, BTN_TOUCH, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_sync(data-&gt;i=
nput_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
</span>input_sync() can go here.<br>
<span><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void crtouch_ts_reg_init(struct crtouch_ts_data *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct i2c_client *client =3D data-&gt;client;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0crtouch_write_reg(client, CR_CON_SYSTEM, 0x9c);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0crtouch_write_reg(client, CR_CON_TRIG_EVENT, 0xf9=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0crtouch_write_reg(client, CR_CON_FIFO_SETUP, 0x1f=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0crtouch_write_reg(client, CR_CON_SAMPLING_RATE, 0=
x08);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0crtouch_write_reg(client, CR_CON_DIS_HOR_MSB, 0x0=
1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0crtouch_write_reg(client, CR_CON_DIS_HOR_LSB, 0xd=
f);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0crtouch_write_reg(client, CR_CON_DIS_VER_MSB, 0x0=
1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0crtouch_write_reg(client, CR_CON_DIS_VER_LSB, 0x0=
f);<br>
<br>
</span>Should we fetch any of this data from DTS? I assume CR_CON_DIS_HOR/V=
ER<br>
is resolution? Or not?<br></blockquote><div><br></div><div>Yes, the HOR/VER=
 info can at least be fetched from DTS. I will fix as part of V2 patchset.<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
Also, why no error handling?<br>
<span><br>
&gt; +}<br>
&gt; +<br>
&gt; +static int crtouch_ts_probe(struct i2c_client *client,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0const struct i2c_device_id *id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct crtouch_ts_data *data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct input_dev *input_dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int error =3D -1, irq_gpio;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(&amp;client-&gt;dev, &quot;Freescale CRT=
OUCH driver\n&quot;);<br>
<br>
</span>Please drop this.<br>
<span><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D kzalloc(sizeof(*data), GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_dev =3D input_allocate_device();<br>
<br>
</span>Please use devm* and you will be able to get rid of crtouch_ts_remov=
e().<br>
<div><div><br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!data || !input_dev) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;client-&=
gt;dev, &quot;Failed to allocate memory\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D -ENOMEM;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_mem;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;client =3D client;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;input_dev =3D input_dev;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_dev-&gt;name =3D &quot;crtouch_ts&quot;;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0input_dev-&gt;id.bustype =3D BUS_I2C;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_dev-&gt;dev.parent =3D &amp;client-&gt;dev;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* For single touch */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__set_bit(EV_KEY, input_dev-&gt;evbit);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__set_bit(BTN_TOUCH, input_dev-&gt;keybit);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__set_bit(EV_ABS, input_dev-&gt;evbit);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__set_bit(ABS_X, input_dev-&gt;absbit);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__set_bit(ABS_Y, input_dev-&gt;absbit);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__set_bit(ABS_PRESSURE, input_dev-&gt;absbit);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_set_abs_params(input_dev, ABS_X, 0, CRTOUCH=
_MAX_X, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_set_abs_params(input_dev, ABS_Y, 0, CRTOUCH=
_MAX_Y, 0, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_set_abs_params(input_dev, ABS_PRESSURE, 0,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 CRTOUCH_MAX_AREA, 0, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_set_drvdata(input_dev, data);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0crtouch_ts_reg_init(data);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0irq_gpio =3D of_get_named_gpio(client-&gt;dev.of_=
node, &quot;irq-gpio&quot;, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!gpio_is_valid(irq_gpio))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_mem;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0error =3D gpio_request_one(irq_gpio, GPIOF_IN, &q=
uot;TS_IRQ&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (error) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;client-&=
gt;dev, &quot;Failed to request gpio\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_mem;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0error =3D request_threaded_irq(gpio_to_irq(irq_gp=
io), NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crtouch_ts_interrupt,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_ONESHOT | IRQF_TRIGG=
ER_FALLING,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;crtouch_ts&quot;, d=
ata);<br>
<br>
</div></div>As i mentioned above replace everything starting with of_get_na=
med_gpio<br>
with:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D devm_request_threaded_irq(&amp;cleint=
-&gt;dev, client-&gt;irq,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 N=
ULL, crtouch_ts_interrupt,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I=
RQF_ONESHOT,<br>
<div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;crtouch_ts&quot;, data);<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (error) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;client-&=
gt;dev, &quot;Failed to register interrupt\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_mem;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0error =3D input_register_device(data-&gt;input_de=
v);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (error)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_free_irq;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c_set_clientdata(client, data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +err_free_irq:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0free_irq(client-&gt;irq, data);<br>
&gt; +err_free_mem:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_free_device(input_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kfree(data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return error;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int crtouch_ts_remove(struct i2c_client *client)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct crtouch_ts_data *data =3D i2c_get_clientda=
ta(client);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0free_irq(client-&gt;irq, data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0input_unregister_device(data-&gt;input_dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kfree(data);<br>
<br>
</div></div>With devm it can all be dropped.<br>
<span><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct i2c_device_id crtouch_ts_id[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{&quot;crtouch_ts&quot;, 0},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ }<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(i2c, crtouch_ts_id);<br>
&gt; +<br>
&gt; +static const struct of_device_id crtouch_ts_dt_ids[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;fsl,crtouch_ts&quot;, },<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ /* sentinel */ }<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(of, crtouch_ts_dt_ids);<br>
&gt; +<br>
&gt; +static struct i2c_driver crtouch_ts_i2c_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &qu=
ot;crtouch_ts&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D TH=
IS_MODULE,<br>
<br>
</span>No need to set owner.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_tab=
le =3D crtouch_ts_dt_ids,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 .of_match_table =3D of_match_ptr(crtouch_ts_dt_ids),<br>
<br>
Also, no PM methods?<br>
<span><br></span></blockquote><div><br></div><div>Well, the main reason for=
 no PM methods is the original driver did not have PM methods. I can implem=
ent sleep/resume methods, and if all is working well will submit as part of=
 V2.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><span>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe =3D crtouch_ts_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.remove =3D crtouch_ts_remove,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.id_table =3D crtouch_ts_id,<br>
&gt; +};<br>
&gt; +<br>
&gt; +module_i2c_driver(crtouch_ts_i2c_driver);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;Alison Wang &lt;<a href=3D"mailto:b18965@freescal=
e.com" target=3D"_blank">b18965@freescale.com</a>&gt;&quot;);<br>
&gt; +MODULE_DESCRIPTION(&quot;Touchscreen driver for Freescale CRTOUCH&quo=
t;);<br>
&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
<br>
</span>Thanks.<br>
<span><font color=3D"#888888"><br>
--<br>
Dmitry<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div data=
-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div>=
Tony Felice<br>Support Engineering Manager<br></div>Timesys Corporation<br>=
</div></div></div></div>
</div></div></div>

--94eb2c03507800124a05364700e1--

--===============0080597060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0080597060==--
