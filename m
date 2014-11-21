From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH 1/2] Input: add regulator haptic driver
Date: Fri, 21 Nov 2014 10:49:53 +0900
Message-ID: <546E9A41.4030108@samsung.com>
References: <1416490300-28865-1-git-send-email-jaewon02.kim@samsung.com>
 <1416490300-28865-2-git-send-email-jaewon02.kim@samsung.com>
 <CAGcde9HNGDbm8sNHjyJ-PW75o0eaH1w6KtsOsQx6kDjVqxch5Q@mail.gmail.com>
 <546E0438.90808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:29855 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756647AbaKUBt5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 20:49:57 -0500
In-reply-to: <546E0438.90808@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Hyunhee Kim <hyunhee.kim@samsung.com>

Hi Dan,

2014=EB=85=84 11=EC=9B=94 21=EC=9D=BC 00:09=EC=97=90 Dan Murphy =EC=9D=B4=
(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> Hi
>
> On 11/20/2014 08:33 AM, Pankaj Dubey wrote:
>> Hi Jaewon,
>>
>> On 20 November 2014 19:01, Jaewon Kim <jaewon02.kim@samsung.com> wro=
te:
>>> This patch adds support for haptic driver controlled by
>>> voltage of regulator. And this driver support for
>>> Force Feedback interface from input framework
>>>
>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>>> Signed-off-by: Hyunhee Kim <hyunhee.kim@samsung.com>
>>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>>   .../devicetree/bindings/input/regulator-haptic.txt |   24 ++
>>>   drivers/input/misc/Kconfig                         |   11 +
>>>   drivers/input/misc/Makefile                        |    1 +
>>>   drivers/input/misc/regulator-haptic.c              |  241 +++++++=
+++++++++++++
>>>   4 files changed, 277 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/input/regula=
tor-haptic.txt
>>>   create mode 100644 drivers/input/misc/regulator-haptic.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/regulator-hapt=
ic.txt b/Documentation/devicetree/bindings/input/regulator-haptic.txt
>>> new file mode 100644
>>> index 0000000..9f60e17
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/input/regulator-haptic.txt
>>> @@ -0,0 +1,24 @@
>>> +* Requlator Haptic Device Tree Bindings
>>> +
>>> +The regulator haptic driver controlled by voltage of regulator.
>>> +This driver implemented via Force Feedback interface.
>>> +
>>> +Required Properties:
>>> + - compatible : Should be "regulator-haptic"
>>> + - haptic-supply : Power supply for the haptic motor.
>>> +       [*] refer Documentation/devicetree/bindings/regulator/regul=
ator.txt
>>> +
>>> + - max-microvolt : The maximum voltage value supplied to haptic mo=
tor.
>>> +               [The unit of the voltage is a micro]
>>> +
>>> + - min-microvolt : The minimum voltage value in which haptic motor=
 reacts.
>>> +               [The unit of the voltage is a micro]
>>> +
>>> +Example:
>>> +
>>> +       regulator-haptic {
> Should this be more about the function and not the driver name?
> Somehting like
>
> haptics {
Yes, haptics is better than driver name.

>
>>> +               compatible =3D "regulator-haptic";
>>> +               haptic-supply =3D <&motor_regulator>;
>>> +               max-microvolt =3D <2700000>;
>>> +               min-microvolt =3D <1100000>;
>>> +       };
>>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfi=
g
>>> index 23297ab..e5e556d 100644
>>> --- a/drivers/input/misc/Kconfig
>>> +++ b/drivers/input/misc/Kconfig
>>> @@ -394,6 +394,17 @@ config INPUT_CM109
>>>            To compile this driver as a module, choose M here: the m=
odule will be
>>>            called cm109.
>>>
>>> +config INPUT_REGULATOR_HAPTIC
>>> +       tristate "regulator haptics support"
>>> +       select INPUT_FF_MEMLESS
>>> +       help
>>> +         This option enables device driver support for the haptic =
controlled
>>> +         by regulator. This driver supports ff-memless interface
>>> +         from input framework.
>>> +
>>> +         To compile this driver as a module, choose M here: the
>>> +         module will be called regulator-haptic.
>>> +
>>>   config INPUT_RETU_PWRBUTTON
>>>          tristate "Retu Power button Driver"
>>>          depends on MFD_RETU
>>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makef=
ile
>>> index 19c7603..1f135af 100644
>>> --- a/drivers/input/misc/Makefile
>>> +++ b/drivers/input/misc/Makefile
>>> @@ -53,6 +53,7 @@ obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)   +=3D pmic8x=
xx-pwrkey.o
>>>   obj-$(CONFIG_INPUT_POWERMATE)          +=3D powermate.o
>>>   obj-$(CONFIG_INPUT_PWM_BEEPER)         +=3D pwm-beeper.o
>>>   obj-$(CONFIG_INPUT_RB532_BUTTON)       +=3D rb532_button.o
>>> +obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)   +=3D regulator-haptic.o
>>>   obj-$(CONFIG_INPUT_RETU_PWRBUTTON)     +=3D retu-pwrbutton.o
>>>   obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)        +=3D rotary_encode=
r.o
>>>   obj-$(CONFIG_INPUT_SGI_BTNS)           +=3D sgi_btns.o
>>> diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/=
misc/regulator-haptic.c
>>> new file mode 100644
>>> index 0000000..1a83ecb
>>> --- /dev/null
>>> +++ b/drivers/input/misc/regulator-haptic.c
>>> @@ -0,0 +1,241 @@
>>> +/*
>>> + * Regulator haptic driver
>>> + *
>>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>>> + * Author: Jaewon Kim <jaewon02.kim@samsung.com>
>>> + * Author: Hyunhee Kim <hyunhee.kim@samsung.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or m=
odify
>>> + * it under the terms of the GNU General Public License version 2 =
as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/input.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/of.h>
>>> +
>>> +#define MAX_MAGNITUDE_SHIFT    16
>>> +
>>> +struct regulator_haptic {
>>> +       struct device *dev;
>>> +       struct input_dev *input_dev;
>>> +       struct regulator *regulator;
>>> +       struct work_struct work;
>>> +
>>> +       bool enabled;
>>> +       bool suspend_state;
> I don't understand what you are tracking here.  You only set it and u=
nset
> this value but never do any checking
>
>>> +       unsigned int max_volt;
>>> +       unsigned int min_volt;
>>> +       unsigned int intensity;
>>> +       unsigned int magnitude;
>>> +};
>>> +
>>> +static void regulator_haptic_enable(struct regulator_haptic *hapti=
c)
>>> +{
>>> +       int error;
>>> +
>>> +       if (haptic->enabled)
>>> +               return;
>>> +
>>> +       error =3D regulator_enable(haptic->regulator);
>>> +       if (error) {
>>> +               dev_err(haptic->dev, "cannot enable regulator\n");
>>> +               return;
>>> +       }
>>> +
>>> +       haptic->enabled =3D true;
>>> +}
>>> +
>>> +static void regulator_haptic_disable(struct regulator_haptic *hapt=
ic)
>>> +{
>>> +       int error;
>>> +
>>> +       if (!haptic->enabled)
>>> +               return;
>>> +
>>> +       error =3D regulator_disable(haptic->regulator);
>>> +       if (error) {
>>> +               dev_err(haptic->dev, "cannot disable regulator\n");
>>> +               return;
>>> +       }
>>> +
>>> +       haptic->enabled =3D false;
>>> +}
> Can the enable/disable just be one function with an argument?
> Then you can centralize the check and reduce the code footprint.

Ok. I will merge two function with a boolean parameter.

>
>>> +
>>> +static void regulator_haptic_work(struct work_struct *work)
>>> +{
>>> +       struct regulator_haptic *haptic =3D container_of(work,
>>> +                                       struct regulator_haptic, wo=
rk);
>>> +       int error;
>>> +
>>> +       error =3D regulator_set_voltage(haptic->regulator,
>>> +                       haptic->intensity + haptic->min_volt, hapti=
c->max_volt);
>>> +       if (error) {
>>> +               dev_err(haptic->dev, "cannot set regulator voltage\=
n");
>>> +               return;
>>> +       }
>>> +
>>> +       if (haptic->magnitude)
>>> +               regulator_haptic_enable(haptic);
>>> +       else
>>> +               regulator_haptic_disable(haptic);
>>> +}
>>> +
>>> +static int regulator_haptic_play_effect(struct input_dev *input, v=
oid *data,
>>> +                                       struct ff_effect *effect)
>>> +{
>>> +       struct regulator_haptic *haptic =3D input_get_drvdata(input=
);
>>> +       u64 volt_mag_multi;
>>> +
>>> +       haptic->magnitude =3D effect->u.rumble.strong_magnitude;
>>> +       if (!haptic->magnitude)
>>> +               haptic->magnitude =3D effect->u.rumble.weak_magnitu=
de;
>>> +
>>> +
>>> +       volt_mag_multi =3D (u64)(haptic->max_volt - haptic->min_vol=
t) *
>>> +                                       haptic->magnitude;
>>> +       haptic->intensity =3D (unsigned int)(volt_mag_multi >>
>>> +                                       MAX_MAGNITUDE_SHIFT);
>>> +
>>> +       schedule_work(&haptic->work);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static void regulator_haptic_close(struct input_dev *input)
>>> +{
>>> +       struct regulator_haptic *haptic =3D input_get_drvdata(input=
);
>>> +
>>> +       cancel_work_sync(&haptic->work);
>>> +       regulator_haptic_disable(haptic);
>>> +}
>>> +
>>> +static int regulator_haptic_parse_dt(struct regulator_haptic *hapt=
ic)
>>> +{
>>> +       struct device_node *node =3D haptic->dev->of_node;
>>> +       int error;
>>> +
>>> +       error =3D of_property_read_u32(node, "max-microvolt", &hapt=
ic->max_volt);
>>> +       if (error) {
>>> +               dev_err(haptic->dev, "cannot parse max-microvolt\n"=
);
>>> +               return error;
>>> +       }
>>> +
>>> +       error =3D of_property_read_u32(node, "min-microvolt", &hapt=
ic->min_volt);
>>> +       if (error) {
>>> +               dev_err(haptic->dev, "cannot parse min-microvolt\n"=
);
>>> +               return error;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int regulator_haptic_probe(struct platform_device *pdev)
>>> +{
>>> +       struct regulator_haptic *haptic;
>>> +       struct input_dev *input_dev;
>>> +       int error;
>>> +
>>> +       haptic =3D devm_kzalloc(&pdev->dev, sizeof(*haptic), GFP_KE=
RNEL);
>>> +       if (!haptic)
>>> +               return -ENOMEM;
>>> +
>>> +       haptic->dev =3D &pdev->dev;
>>> +       haptic->enabled =3D false;
>>> +       haptic->suspend_state =3D false;
>>> +       INIT_WORK(&haptic->work, regulator_haptic_work);
>>> +
>>> +       error =3D regulator_haptic_parse_dt(haptic);
> Do you need platform data support for platforms that do not currently=
 support
> dt?
Ok I will support platform data in next version.

>
>>> +       if (error) {
>>> +               dev_err(&pdev->dev, "failed to parse device tree\n"=
);
>>> +               return error;
>>> +       }
>>> +
>>> +       haptic->regulator =3D devm_regulator_get(&pdev->dev, "hapti=
c");
>>> +       if (IS_ERR(haptic->regulator)) {
>>> +               dev_err(&pdev->dev, "failed to get regulator\n");
>>> +               return PTR_ERR(haptic->regulator);
>>> +       }
>>> +
>>> +       input_dev =3D devm_input_allocate_device(&pdev->dev);
>>> +       if (!input_dev)
>>> +               return  -ENOMEM;
>>> +
>>> +       haptic->input_dev =3D input_dev;
>>> +       haptic->input_dev->name =3D "regulator-haptic";
>>> +       haptic->input_dev->dev.parent =3D &pdev->dev;
>>> +       haptic->input_dev->close =3D regulator_haptic_close;
>>> +       input_set_drvdata(haptic->input_dev, haptic);
>>> +       input_set_capability(haptic->input_dev, EV_FF, FF_RUMBLE);
>>> +
>>> +       error =3D input_ff_create_memless(input_dev, NULL,
>>> +                             regulator_haptic_play_effect);
>>> +       if (error) {
>>> +               dev_err(&pdev->dev, "failed to create force-feedbac=
k\n");
>>> +               return error;
>>> +       }
>>> +
>>> +       error =3D input_register_device(haptic->input_dev);
>>> +       if (error) {
>>> +               dev_err(&pdev->dev, "failed to register input devic=
e\n");
>>> +               return error;
>>> +       }
>>> +
>>> +       platform_set_drvdata(pdev, haptic);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int __maybe_unused regulator_haptic_suspend(struct device *=
dev)
>>> +{
>>> +       struct platform_device *pdev =3D to_platform_device(dev);
>>> +       struct regulator_haptic *haptic =3D platform_get_drvdata(pd=
ev);
>>> +
>>> +       if (haptic->enabled) {
>>> +               regulator_haptic_disable(haptic);
>>> +               haptic->suspend_state =3D true;
>>>
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int __maybe_unused regulator_haptic_resume(struct device *d=
ev)
>>> +{
>>> +       struct platform_device *pdev =3D to_platform_device(dev);
>>> +       struct regulator_haptic *haptic =3D platform_get_drvdata(pd=
ev);
>>> +
>>> +       if (haptic->enabled) {
>>> +               regulator_haptic_enable(haptic);
> We enable the regulator when we do the haptics work if magnitude is >=
 0.
> And during suspend haptic->enabled may get set to false if it is true
> so wouldn't haptic->enabled always be false here?

You are right, It was my typo. It is "if (haptic->suspend_state)".
My intention is restore past state.
thanks to point error.

>
> Plus do we want to continue the haptic response when coming out of su=
spend state?
>
>>> +               haptic->suspend_state =3D false;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static SIMPLE_DEV_PM_OPS(regulator_haptic_pm_ops,
>>> +               regulator_haptic_suspend, regulator_haptic_resume);
>>> +
>>> +static struct of_device_id regulator_haptic_dt_match[] =3D {
>>> +       { .compatible =3D "regulator-haptic" },
>>> +       {},
>>> +};
>>> +
>>> +static struct platform_driver regulator_haptic_driver =3D {
>>> +       .probe          =3D regulator_haptic_probe,
>>> +       .driver         =3D {
>>> +               .name           =3D "regulator-haptic",
>>> +               .owner          =3D THIS_MODULE,
>> .owner is no more required for drivers using module_platform_driver(=
)
>>
>> Thanks,
>> Pankaj Dubey
>>
>>> +               .of_match_table =3D regulator_haptic_dt_match,
>>> +               .pm             =3D &regulator_haptic_pm_ops,
>>> +       },
>>> +};
>>> +module_platform_driver(regulator_haptic_driver);
>>> +
>>> +MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
>>> +MODULE_AUTHOR("Hyunhee Kim <hyunhee.kim@samsung.com>");
>>> +MODULE_ALIAS("platform:regulator-haptic");
>>> +MODULE_DESCRIPTION("Regulator haptic driver");
>>> +MODULE_LICENSE("GPL");
>>> --
>>> 1.7.9.5
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-sam=
sung-soc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
