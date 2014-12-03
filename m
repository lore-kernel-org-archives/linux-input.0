From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH v4 1/2] Input: add regulator haptic driver
Date: Wed, 03 Dec 2014 15:29:01 +0900
Message-ID: <547EADAD.9060100@samsung.com>
References: <1417399873-19575-1-git-send-email-jaewon02.kim@samsung.com>
 <1417399873-19575-2-git-send-email-jaewon02.kim@samsung.com>
 <20141203060247.GE7411@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20141203060247.GE7411@dtor-glaptop>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, Hyunhee Kim <hyunhee.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

2014=EB=85=84 12=EC=9B=94 03=EC=9D=BC 15:02=EC=97=90 Dmitry Torokhov =EC=
=9D=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> Hi Jaewon,
>
> On Mon, Dec 01, 2014 at 11:11:12AM +0900, Jaewon Kim wrote:
>> This patch adds support for haptic driver controlled by
>> voltage of regulator. And this driver support for
>> Force Feedback interface from input framework
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> Signed-off-by: Hyunhee Kim <hyunhee.kim@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   .../devicetree/bindings/input/regulator-haptic.txt |   21 ++
>>   drivers/input/misc/Kconfig                         |   11 +
>>   drivers/input/misc/Makefile                        |    1 +
>>   drivers/input/misc/regulator-haptic.c              |  247 ++++++++=
++++++++++++
>>   include/linux/input/regulator-haptic.h             |   31 +++
>>   5 files changed, 311 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/input/regulat=
or-haptic.txt
>>   create mode 100644 drivers/input/misc/regulator-haptic.c
>>   create mode 100644 include/linux/input/regulator-haptic.h
>>
>> diff --git a/Documentation/devicetree/bindings/input/regulator-hapti=
c.txt b/Documentation/devicetree/bindings/input/regulator-haptic.txt
>> new file mode 100644
>> index 0000000..3ed1c7e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/regulator-haptic.txt
>> @@ -0,0 +1,21 @@
>> +* Regulator Haptic Device Tree Bindings
>> +
>> +Required Properties:
>> + - compatible : Should be "regulator-haptic"
>> + - haptic-supply : Power supply to the haptic motor.
>> +	[*] refer Documentation/devicetree/bindings/regulator/regulator.tx=
t
>> +
>> + - max-microvolt : The maximum voltage value supplied to the haptic=
 motor.
>> +		[The unit of the voltage is a micro]
>> +
>> + - min-microvolt : The minimum voltage value supplied to the haptic=
 motor.
>> +		[The unit of the voltage is a micro]
>> +
>> +Example:
>> +
>> +	haptics {
>> +		compatible =3D "regulator-haptic";
>> +		haptic-supply =3D <&motor_regulator>;
>> +		max-microvolt =3D <2700000>;
>> +		min-microvolt =3D <1100000>;
>> +	};
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index 23297ab..e5e556d 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -394,6 +394,17 @@ config INPUT_CM109
>>   	  To compile this driver as a module, choose M here: the module w=
ill be
>>   	  called cm109.
>>  =20
>> +config INPUT_REGULATOR_HAPTIC
>> +	tristate "regulator haptics support"
>> +	select INPUT_FF_MEMLESS
>> +	help
>> +	  This option enables device driver support for the haptic control=
led
>> +	  by regulator. This driver supports ff-memless interface
>> +	  from input framework.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called regulator-haptic.
>> +
>>   config INPUT_RETU_PWRBUTTON
>>   	tristate "Retu Power button Driver"
>>   	depends on MFD_RETU
>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefi=
le
>> index 19c7603..1f135af 100644
>> --- a/drivers/input/misc/Makefile
>> +++ b/drivers/input/misc/Makefile
>> @@ -53,6 +53,7 @@ obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+=3D pmic8xxx-=
pwrkey.o
>>   obj-$(CONFIG_INPUT_POWERMATE)		+=3D powermate.o
>>   obj-$(CONFIG_INPUT_PWM_BEEPER)		+=3D pwm-beeper.o
>>   obj-$(CONFIG_INPUT_RB532_BUTTON)	+=3D rb532_button.o
>> +obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)	+=3D regulator-haptic.o
>>   obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+=3D retu-pwrbutton.o
>>   obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+=3D rotary_encoder.o
>>   obj-$(CONFIG_INPUT_SGI_BTNS)		+=3D sgi_btns.o
>> diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/m=
isc/regulator-haptic.c
>> new file mode 100644
>> index 0000000..6bc8e45
>> --- /dev/null
>> +++ b/drivers/input/misc/regulator-haptic.c
>> @@ -0,0 +1,247 @@
>> +/*
>> + * Regulator haptic driver
>> + *
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + * Author: Jaewon Kim <jaewon02.kim@samsung.com>
>> + * Author: Hyunhee Kim <hyunhee.kim@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/input.h>
>> +#include <linux/input/regulator-haptic.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/slab.h>
>> +
>> +#define MAX_MAGNITUDE_SHIFT	16
>> +
>> +struct regulator_haptic {
>> +	struct device *dev;
>> +	struct input_dev *input_dev;
>> +	struct regulator *regulator;
>> +	struct work_struct work;
>> +
>> +	bool enabled;
>> +	bool suspend_state;
>> +	unsigned int max_volt;
>> +	unsigned int min_volt;
>> +	unsigned int intensity;
>> +	unsigned int magnitude;
>> +};
>> +
>> +static void regulator_haptic_enable(struct regulator_haptic *haptic=
, bool state)
>> +{
>> +	int error;
>> +
>> +	if (haptic->enabled =3D=3D state)
>> +		return;
>> +
>> +	if (state)
>> +		error =3D regulator_enable(haptic->regulator);
>> +	else
>> +		error =3D regulator_disable(haptic->regulator);
>> +	if (error) {
>> +		dev_err(haptic->dev, "cannot enable regulator\n");
>> +		return;
>> +	}
>> +
>> +	haptic->enabled =3D state;
>> +}
>> +
>> +static void regulator_haptic_work(struct work_struct *work)
>> +{
>> +	struct regulator_haptic *haptic =3D container_of(work,
>> +					struct regulator_haptic, work);
>> +	int error;
>> +
>> +	error =3D regulator_set_voltage(haptic->regulator,
>> +			haptic->intensity + haptic->min_volt, haptic->max_volt);
>> +	if (error) {
>> +		dev_err(haptic->dev, "cannot set regulator voltage\n");
>> +		return;
>> +	}
>> +
>> +	if (haptic->magnitude)
>> +		regulator_haptic_enable(haptic, true);
>> +	else
>> +		regulator_haptic_enable(haptic, false);
>> +}
>> +
>> +static int regulator_haptic_play_effect(struct input_dev *input, vo=
id *data,
>> +					struct ff_effect *effect)
>> +{
>> +	struct regulator_haptic *haptic =3D input_get_drvdata(input);
>> +	u64 volt_mag_multi;
>> +
>> +	haptic->magnitude =3D effect->u.rumble.strong_magnitude;
>> +	if (!haptic->magnitude)
>> +		haptic->magnitude =3D effect->u.rumble.weak_magnitude;
>> +
>> +
>> +	volt_mag_multi =3D (u64)(haptic->max_volt - haptic->min_volt) *
>> +					haptic->magnitude;
>> +	haptic->intensity =3D (unsigned int)(volt_mag_multi >>
>> +					MAX_MAGNITUDE_SHIFT);
>> +
>> +	schedule_work(&haptic->work);
>> +
>> +	return 0;
>> +}
>> +
>> +static void regulator_haptic_close(struct input_dev *input)
>> +{
>> +	struct regulator_haptic *haptic =3D input_get_drvdata(input);
>> +
>> +	cancel_work_sync(&haptic->work);
>> +	regulator_haptic_enable(haptic, false);
>> +}
>> +
>> +#ifdef CONFIG_OF
>> +static int regulator_haptic_parse_dt(struct regulator_haptic *hapti=
c)
>> +{
>> +	struct device_node *node =3D haptic->dev->of_node;
>> +	int error;
>> +
>> +	error =3D of_property_read_u32(node, "max-microvolt", &haptic->max=
_volt);
>> +	if (error) {
>> +		dev_err(haptic->dev, "cannot parse max-microvolt\n");
>> +		return error;
>> +	}
>> +
>> +	error =3D of_property_read_u32(node, "min-microvolt", &haptic->min=
_volt);
>> +	if (error) {
>> +		dev_err(haptic->dev, "cannot parse min-microvolt\n");
>> +		return error;
>> +	}
>> +
>> +	return 0;
>> +}
>> +#else
>> +static int regulator_haptic_parse_dt(struct regulator_haptic *hapti=
c)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_OF */
>> +
>> +static int regulator_haptic_probe(struct platform_device *pdev)
>> +{
>> +	struct regulator_haptic *haptic;
>> +	struct regulator_haptic_data *data;
>> +	struct input_dev *input_dev;
>> +	int error;
>> +
>> +	haptic =3D devm_kzalloc(&pdev->dev, sizeof(*haptic), GFP_KERNEL);
>> +	if (!haptic)
>> +		return -ENOMEM;
>> +
>> +	haptic->dev =3D &pdev->dev;
>> +	haptic->enabled =3D false;
>> +	haptic->suspend_state =3D false;
>> +	INIT_WORK(&haptic->work, regulator_haptic_work);
>> +
>> +	if (pdev->dev.of_node) {
>> +		error =3D regulator_haptic_parse_dt(haptic);
>> +		if (error) {
>> +			dev_err(&pdev->dev, "failed to parse device tree\n");
>> +			return error;
>> +		}
>> +	} else {
>> +		data =3D dev_get_platdata(&pdev->dev);
>> +		if (data) {
>> +			dev_err(&pdev->dev, "failed to get platdata\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		haptic->regulator =3D data->regulator;
>> +		haptic->max_volt =3D data->max_volt;
>> +		haptic->min_volt =3D data->min_volt;
> Please give preference to platform data if supplied, and if not then =
try
> fetching settings from device tree.

Ok. i will give prefrence to platform data in next version.

>
>> +	}
>> +
>> +	haptic->regulator =3D devm_regulator_get_exclusive(&pdev->dev, "ha=
ptic");
>> +	if (IS_ERR(haptic->regulator)) {
>> +		dev_err(&pdev->dev, "failed to get regulator\n");
>> +		return PTR_ERR(haptic->regulator);
>> +	}
>> +
>> +	input_dev =3D devm_input_allocate_device(&pdev->dev);
>> +	if (!input_dev)
>> +		return  -ENOMEM;
>> +
>> +	haptic->input_dev =3D input_dev;
>> +	haptic->input_dev->name =3D "regulator-haptic";
>> +	haptic->input_dev->dev.parent =3D &pdev->dev;
>> +	haptic->input_dev->close =3D regulator_haptic_close;
>> +	input_set_drvdata(haptic->input_dev, haptic);
>> +	input_set_capability(haptic->input_dev, EV_FF, FF_RUMBLE);
>> +
>> +	error =3D input_ff_create_memless(input_dev, NULL,
>> +			      regulator_haptic_play_effect);
>> +	if (error) {
>> +		dev_err(&pdev->dev, "failed to create force-feedback\n");
>> +		return error;
>> +	}
>> +
>> +	error =3D input_register_device(haptic->input_dev);
>> +	if (error) {
>> +		dev_err(&pdev->dev, "failed to register input device\n");
>> +		return error;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, haptic);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused regulator_haptic_suspend(struct device *d=
ev)
>> +{
>> +	struct platform_device *pdev =3D to_platform_device(dev);
>> +	struct regulator_haptic *haptic =3D platform_get_drvdata(pdev);
>> +
>> +	if (haptic->enabled) {
> You need to protect this code from racing with the work item.
>
>> +		regulator_haptic_enable(haptic, false);
>> +		haptic->suspend_state =3D true;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused regulator_haptic_resume(struct device *de=
v)
>> +{
>> +	struct platform_device *pdev =3D to_platform_device(dev);
>> +	struct regulator_haptic *haptic =3D platform_get_drvdata(pdev);
>> +
>> +	if (haptic->suspend_state) {
>> +		regulator_haptic_enable(haptic, true);
>> +		haptic->suspend_state =3D false;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(regulator_haptic_pm_ops,
>> +		regulator_haptic_suspend, regulator_haptic_resume);
>> +
>> +static struct of_device_id regulator_haptic_dt_match[] =3D {
>> +	{ .compatible =3D "regulator-haptic" },
>> +	{ /* sentinel */ },
>> +};
>> +
>> +static struct platform_driver regulator_haptic_driver =3D {
>> +	.probe		=3D regulator_haptic_probe,
>> +	.driver		=3D {
>> +		.name		=3D "regulator-haptic",
>> +		.of_match_table =3D regulator_haptic_dt_match,
>> +		.pm		=3D &regulator_haptic_pm_ops,
>> +	},
>> +};
>> +module_platform_driver(regulator_haptic_driver);
>> +
>> +MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
>> +MODULE_AUTHOR("Hyunhee Kim <hyunhee.kim@samsung.com>");
>> +MODULE_DESCRIPTION("Regulator haptic driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/input/regulator-haptic.h b/include/linux/=
input/regulator-haptic.h
>> new file mode 100644
>> index 0000000..05ae038
>> --- /dev/null
>> +++ b/include/linux/input/regulator-haptic.h
>> @@ -0,0 +1,31 @@
>> +/*
>> + * Regulator Haptic Platform Data
>> + *
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + * Author: Jaewon Kim <jaewon02.kim@samsung.com>
>> + * Author: Hyunhee Kim <hyunhee.kim@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef _REGULATOR_HAPTIC_H
>> +#define _REGULATOR_HAPTIC_H
>> +
>> +/*
>> + * struct regulator_haptic_data - Platform device data
>> + *
>> + * @regulator: Power supply to the haptic motor
>> + * @max_volt: maximum voltage value supplied to the haptic motor.
>> + * 		<The unit of the voltage is a micro>
>> + * @min_volt: minimum voltage value supplied to the haptic motor.
>> + * 		<The unit of the voltage is a micro>
>> + */
>> +struct regulator_haptic_data {
>> +	struct regulator *regulator;
>> +	unsigned int max_volt;
>> +	unsigned int min_volt;
>> +};
>> +
>> +#endif /* _REGULATOR_HAPTIC_H */
>> --=20
>> 1.7.9.5
>>
> Thanks.
>

Thanks.
Jaewon Kim.
