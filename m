From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCHv6][ 1/4] Input: tsc2007: Add device tree support.
Date: Thu, 24 Oct 2013 05:31:07 -0500
Message-ID: <CAL_JsqJ7R_-wO3RcjZLY6+WysdnF8e7eC0iPvVXyYSe=JZVPTw@mail.gmail.com>
References: <1382603933-8539-1-git-send-email-denis@eukrea.com>
	<20131024101624.9008BC4039D@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:58992 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab3JXKbI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Oct 2013 06:31:08 -0400
In-Reply-To: <20131024101624.9008BC4039D@trevor.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Denis Carikli <denis@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Thierry Reding <thierry.reding@gmail.com>, =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@karo-electronics.de>

On Thu, Oct 24, 2013 at 5:16 AM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Thu, 24 Oct 2013 10:38:50 +0200, Denis Carikli <denis@eukrea.com> =
wrote:
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Cc: devicetree@vger.kernel.org
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: linux-input@vger.kernel.org
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: Lothar Wa=DFmann <LW@KARO-electronics.de>
>> Cc: Eric B=E9nard <eric@eukrea.com>
>> Signed-off-by: Denis Carikli <denis@eukrea.com>
>> ---
>> ChangeLog v5->v6:
>> - Fixed a code style issue.
>> - Improved the documentation to set some gpio related properties as =
optional.
>> - The properties related to the gpios are also explained better.
>> ---
>>  .../bindings/input/touchscreen/tsc2007.txt         |   44 +++++
>>  drivers/input/touchscreen/tsc2007.c                |  194 +++++++++=
++++++-----
>>  2 files changed, 197 insertions(+), 41 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/input/touchscr=
een/tsc2007.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc=
2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.=
txt
>> new file mode 100644
>> index 0000000..46fc677
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.tx=
t
>> @@ -0,0 +1,44 @@
>> +* Texas Instruments tsc2007 touchscreen controller
>> +
>> +Required properties:
>> +- compatible: must be "ti,tsc2007".
>> +- reg: I2C address of the chip.
>> +- ti,x-plate-ohms: X-plate resistance in ohms.
>> +
>> +Optional properties:
>> +- gpios: the interrupt gpio the chip is connected to (trough the pe=
nirq pin)
>> +  (see GPIO binding[2] for more details).
>> +- interrupt-parent: the phandle for the gpio controller
>> +  (see interrupt binding[1]).
>> +- interrupts: (gpio) interrupt to which the chip is connected
>> +  (see interrupt binding[1]).
>> +- pinctrl-0: Should specify pin control groups used for the gpio
>> +  (see pinctrl bindings[0]).
>> +- pinctrl-names: Should contain only one value - "default"
>> +  (see pinctrl bindings[0]).
>> +- max-rt: maximum pressure.
>> +- fuzzy: specifies the fuzz value that is used to filter noise from=
 the event
>> +  stream.
>
> I don't actually understand what this means, can you clarify in the
> document?
>
>> +- poll-period: how much time to wait(in millisecond) before reading=
 again the
>> +  values from the tsc2007.
>
> max-rt, fuzzy, and poll-period should probably be prefixed with "ti,"=
=2E

These could be common touchscreen properties. There is also tps6507
touchscreen binding being reviewed. I haven't checked, but there's
probably already some touchscreen bindings. So this is a good
opportunity for common bindings/properties.

Rob

>
> Otherwise the binding looks good to me.
>
> g.
>
>
>> +
>> +[0]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>> +[1]: Documentation/devicetree/bindings/interrupt-controller/interru=
pts.txt
>> +[2]: Documentation/devicetree/bindings/gpio/gpio.txt
>> +
>> +Example:
>> +     &i2c1 {
>> +             /* ... */
>> +             tsc2007@49 {
>> +                     compatible =3D "ti,tsc2007";
>> +                     reg =3D <0x49>;
>> +                     pinctrl-names =3D "default";
>> +                     pinctrl-0 =3D <&pinctrl_tsc2007_1>;
>> +                     interrupt-parent =3D <&gpio4>;
>> +                     interrupts =3D <0x0 0x8>;
>> +                     gpios =3D <&gpio4 0 0>;
>> +                     ti,x-plate-ohms =3D <180>;
>> +             };
>> +
>> +             /* ... */
>> +     };
>> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/tou=
chscreen/tsc2007.c
>> index 0b67ba4..6b1d7a9 100644
>> --- a/drivers/input/touchscreen/tsc2007.c
>> +++ b/drivers/input/touchscreen/tsc2007.c
>> @@ -26,6 +26,9 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/i2c.h>
>>  #include <linux/i2c/tsc2007.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>>
>>  #define TSC2007_MEASURE_TEMP0                (0x0 << 4)
>>  #define TSC2007_MEASURE_AUX          (0x2 << 4)
>> @@ -74,7 +77,10 @@ struct tsc2007 {
>>       u16                     max_rt;
>>       unsigned long           poll_delay;
>>       unsigned long           poll_period;
>> +     int                     fuzzy;
>> +     char                    of;
>>
>> +     unsigned                gpio;
>>       int                     irq;
>>
>>       wait_queue_head_t       wait;
>> @@ -84,6 +90,11 @@ struct tsc2007 {
>>       void                    (*clear_penirq)(void);
>>  };
>>
>> +static int tsc2007_get_pendown_state_dt(struct tsc2007 *ts)
>> +{
>> +     return !gpio_get_value(ts->gpio);
>> +}
>> +
>>  static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>>  {
>>       s32 data;
>> @@ -142,6 +153,14 @@ static u32 tsc2007_calculate_pressure(struct ts=
c2007 *tsc, struct ts_event *tc)
>>       return rt;
>>  }
>>
>> +static bool tsc2007_is_pen_down_valid(struct tsc2007 *ts)
>> +{
>> +     if (ts->of)
>> +             return gpio_is_valid(ts->gpio);
>> +     else
>> +             return ts->get_pendown_state ? true : false;
>> +}
>> +
>>  static bool tsc2007_is_pen_down(struct tsc2007 *ts)
>>  {
>>       /*
>> @@ -158,10 +177,13 @@ static bool tsc2007_is_pen_down(struct tsc2007=
 *ts)
>>        * to fall back on the pressure reading.
>>        */
>>
>> -     if (!ts->get_pendown_state)
>> +     if (!tsc2007_is_pen_down_valid(ts))
>>               return true;
>>
>> -     return ts->get_pendown_state();
>> +     if (ts->of)
>> +             return tsc2007_get_pendown_state_dt(ts);
>> +     else
>> +             return ts->get_pendown_state();
>>  }
>>
>>  static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>> @@ -178,7 +200,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, voi=
d *handle)
>>
>>               rt =3D tsc2007_calculate_pressure(ts, &tc);
>>
>> -             if (rt =3D=3D 0 && !ts->get_pendown_state) {
>> +             if (!rt && !tsc2007_is_pen_down_valid(ts)) {
>>                       /*
>>                        * If pressure reported is 0 and we don't have
>>                        * callback to check pendown state, we have to
>> @@ -228,7 +250,7 @@ static irqreturn_t tsc2007_hard_irq(int irq, voi=
d *handle)
>>  {
>>       struct tsc2007 *ts =3D handle;
>>
>> -     if (!ts->get_pendown_state || likely(ts->get_pendown_state()))
>> +     if (tsc2007_is_pen_down(ts))
>>               return IRQ_WAKE_THREAD;
>>
>>       if (ts->clear_penirq)
>> @@ -273,34 +295,65 @@ static void tsc2007_close(struct input_dev *in=
put_dev)
>>       tsc2007_stop(ts);
>>  }
>>
>> -static int tsc2007_probe(struct i2c_client *client,
>> -                                const struct i2c_device_id *id)
>> +#ifdef CONFIG_OF
>> +static int tsc2007_probe_dt(struct i2c_client *client, struct tsc20=
07 *ts,
>> +                         struct device_node *np)
>>  {
>> -     struct tsc2007 *ts;
>> -     struct tsc2007_platform_data *pdata =3D client->dev.platform_d=
ata;
>> -     struct input_dev *input_dev;
>> -     int err;
>> -
>> -     if (!pdata) {
>> -             dev_err(&client->dev, "platform data is required!\n");
>> +     int err =3D 0;
>> +     u32 val32;
>> +     u64 val64;
>> +
>> +     if (!of_property_read_u32(np, "max-rt", &val32))
>> +             ts->max_rt =3D val32;
>> +     else
>> +             ts->max_rt =3D MAX_12BIT;
>> +
>> +     if (!of_property_read_u32(np, "fuzzy", &val32))
>> +             ts->fuzzy =3D val32;
>> +
>> +     if (!of_property_read_u64(np, "poll-period", &val64))
>> +             ts->poll_period =3D val64;
>> +     else
>> +             ts->poll_period =3D 1;
>> +
>> +     if (!of_property_read_u32(np, "ti,x-plate-ohms", &val32)) {
>> +             ts->x_plate_ohms =3D val32;
>> +     } else {
>> +             dev_err(&client->dev,
>> +                     "Error: lacking ti,x-plate-ohms devicetree pro=
perty. (err %d).",
>> +                     err);
>>               return -EINVAL;
>>       }
>>
>> -     if (!i2c_check_functionality(client->adapter,
>> -                                  I2C_FUNC_SMBUS_READ_WORD_DATA))
>> -             return -EIO;
>> +     ts->gpio =3D of_get_gpio(np, 0);
>> +     if (!gpio_is_valid(ts->gpio))
>> +             dev_err(&client->dev,
>> +                     "GPIO not found (of_get_gpio returned %d)\n",
>> +                     ts->gpio);
>>
>> -     ts =3D kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
>> -     input_dev =3D input_allocate_device();
>> -     if (!ts || !input_dev) {
>> -             err =3D -ENOMEM;
>> -             goto err_free_mem;
>> -     }
>> +     /* Used to detect if it is probed trough the device tree,
>> +      * in order to be able to use that information in the IRQ hand=
ler.
>> +      */
>> +     ts->of =3D 1;
>>
>> -     ts->client =3D client;
>> -     ts->irq =3D client->irq;
>> -     ts->input =3D input_dev;
>> -     init_waitqueue_head(&ts->wait);
>> +     return 0;
>> +}
>> +#else
>> +static int tsc2007_probe_dt(struct i2c_client *client, struct tsc20=
07 *ts,
>> +                         struct device_node *np)
>> +{
>> +     return -ENODEV;
>> +}
>> +#endif
>> +
>> +static int tsc2007_probe_pdev(struct i2c_client *client, struct tsc=
2007 *ts,
>> +                           struct tsc2007_platform_data *pdata,
>> +                           const struct i2c_device_id *id)
>> +{
>> +     if (!pdata) {
>> +             dev_err(&client->dev, "platform data is required!\n");
>> +             return -EINVAL;
>> +     }
>>
>>       ts->model             =3D pdata->model;
>>       ts->x_plate_ohms      =3D pdata->x_plate_ohms;
>> @@ -309,13 +362,57 @@ static int tsc2007_probe(struct i2c_client *cl=
ient,
>>       ts->poll_period       =3D pdata->poll_period ? : 1;
>>       ts->get_pendown_state =3D pdata->get_pendown_state;
>>       ts->clear_penirq      =3D pdata->clear_penirq;
>> +     ts->fuzzy             =3D pdata->fuzzy;
>>
>>       if (pdata->x_plate_ohms =3D=3D 0) {
>>               dev_err(&client->dev, "x_plate_ohms is not set up in p=
latform data");
>> -             err =3D -EINVAL;
>> -             goto err_free_mem;
>> +             return -EINVAL;
>>       }
>>
>> +     /* Used to detect if it is probed trough the device tree,
>> +      * in order to be able to use that information in the IRQ hand=
ler.
>> +      */
>> +     ts->of =3D 0;
>> +
>> +     return 0;
>> +}
>> +
>> +static int tsc2007_probe(struct i2c_client *client,
>> +                      const struct i2c_device_id *id)
>> +{
>> +     struct device_node *np =3D client->dev.of_node;
>> +     struct tsc2007_platform_data *pdata =3D client->dev.platform_d=
ata;
>> +     struct tsc2007 *ts;
>> +     struct input_dev *input_dev;
>> +     int err =3D 0;
>> +
>> +     ts =3D devm_kzalloc(&client->dev, sizeof(struct tsc2007), GFP_=
KERNEL);
>> +     if (!ts)
>> +             return -ENOMEM;
>> +
>> +     if (np)
>> +             err =3D tsc2007_probe_dt(client, ts, np);
>> +     else
>> +             err =3D tsc2007_probe_pdev(client, ts, pdata, id);
>> +
>> +     if (err)
>> +             return err;
>> +
>> +     if (!i2c_check_functionality(client->adapter,
>> +                                  I2C_FUNC_SMBUS_READ_WORD_DATA))
>> +             return -EIO;
>> +
>> +     input_dev =3D input_allocate_device();
>> +     if (!input_dev) {
>> +             err =3D -ENOMEM;
>> +             goto err_free_input;
>> +     };
>> +
>> +     ts->client =3D client;
>> +     ts->irq =3D client->irq;
>> +     ts->input =3D input_dev;
>> +     init_waitqueue_head(&ts->wait);
>> +
>>       snprintf(ts->phys, sizeof(ts->phys),
>>                "%s/input0", dev_name(&client->dev));
>>
>> @@ -331,19 +428,21 @@ static int tsc2007_probe(struct i2c_client *cl=
ient,
>>       input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
>>       input_dev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH)=
;
>>
>> -     input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, pdata->fu=
zzx, 0);
>> -     input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, pdata->fu=
zzy, 0);
>> +     input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzy=
, 0);
>> +     input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, ts->fuzzy=
, 0);
>>       input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT,
>> -                     pdata->fuzzz, 0);
>> +                          ts->fuzzy, 0);
>>
>> -     if (pdata->init_platform_hw)
>> -             pdata->init_platform_hw();
>> +     if (!np) {
>> +             if (pdata->init_platform_hw)
>> +                     pdata->init_platform_hw();
>> +     }
>>
>>       err =3D request_threaded_irq(ts->irq, tsc2007_hard_irq, tsc200=
7_soft_irq,
>>                                  IRQF_ONESHOT, client->dev.driver->n=
ame, ts);
>>       if (err < 0) {
>>               dev_err(&client->dev, "irq %d busy?\n", ts->irq);
>> -             goto err_free_mem;
>> +             goto err_free_input;
>>       }
>>
>>       tsc2007_stop(ts);
>> @@ -358,23 +457,27 @@ static int tsc2007_probe(struct i2c_client *cl=
ient,
>>
>>   err_free_irq:
>>       free_irq(ts->irq, ts);
>> -     if (pdata->exit_platform_hw)
>> -             pdata->exit_platform_hw();
>> - err_free_mem:
>> +     if (!np) {
>> +             if (pdata->exit_platform_hw)
>> +                     pdata->exit_platform_hw();
>> +     }
>> + err_free_input:
>>       input_free_device(input_dev);
>> -     kfree(ts);
>>       return err;
>>  }
>>
>>  static int tsc2007_remove(struct i2c_client *client)
>>  {
>> +     struct device_node *np =3D client->dev.of_node;
>>       struct tsc2007  *ts =3D i2c_get_clientdata(client);
>>       struct tsc2007_platform_data *pdata =3D client->dev.platform_d=
ata;
>>
>>       free_irq(ts->irq, ts);
>>
>> -     if (pdata->exit_platform_hw)
>> -             pdata->exit_platform_hw();
>> +     if (!np) {
>> +             if (pdata->exit_platform_hw)
>> +                     pdata->exit_platform_hw();
>> +     }
>>
>>       input_unregister_device(ts->input);
>>       kfree(ts);
>> @@ -389,10 +492,19 @@ static const struct i2c_device_id tsc2007_idta=
ble[] =3D {
>>
>>  MODULE_DEVICE_TABLE(i2c, tsc2007_idtable);
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id tsc2007_of_match[] =3D {
>> +     { .compatible =3D "ti,tsc2007" },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, tsc2007_of_match);
>> +#endif
>> +
>>  static struct i2c_driver tsc2007_driver =3D {
>>       .driver =3D {
>>               .owner  =3D THIS_MODULE,
>> -             .name   =3D "tsc2007"
>> +             .name   =3D "tsc2007",
>> +             .of_match_table =3D of_match_ptr(tsc2007_of_match),
>>       },
>>       .id_table       =3D tsc2007_idtable,
>>       .probe          =3D tsc2007_probe,
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
