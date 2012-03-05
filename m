From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/2] input: add driver support for MAX8997-haptic
Date: Mon, 05 Mar 2012 10:18:23 +0900
Message-ID: <4F54145F.5000002@samsung.com>
References: <1325757876-17659-1-git-send-email-dg77.kim@samsung.com>
 <1325757876-17659-3-git-send-email-dg77.kim@samsung.com>
 <20120304182358.GF27647@core.coreip.homeip.net>
 <CAH9JG2UhcCfQanEY5CRtoCqMrVPW4Z3tXn6-pXJZdMeAoFVtpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:46371 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab2CEBSZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Mar 2012 20:18:25 -0500
In-reply-to: <CAH9JG2UhcCfQanEY5CRtoCqMrVPW4Z3tXn6-pXJZdMeAoFVtpw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Donggeun Kim <dg77.kim@samsung.com>, linux-input@vger.kernel.org, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com

2012=EB=85=84 03=EC=9B=94 05=EC=9D=BC 09:56, Kyungmin Park =EC=93=B4 =EA=
=B8=80:
> Hi Dmitry,
>
> As Mr. Kim Donggeun leaved the company as personal reason. Mr. Choi
> will follow up the remaining works.
>
> To Mr. Choi,
> Can you test the below patch?
>
I will test modified patch according to Dmitry comment
and resend this patch.

Thank you,
Chanwoo Choi
> Thank you,
> Kyungmin Park
>
> On 3/5/12, Dmitry Torokhov<dmitry.torokhov@gmail.com>  wrote:
>> Hi Donggeun,
>>
>> On Thu, Jan 05, 2012 at 07:04:36PM +0900, Donggeun Kim wrote:
>>> The MAX8997-haptic function can be used to control motor.
>>> User can control the haptic driver by using force feedback framewor=
k.
>>> This patch supports the haptic function in MAX8997.
>>>
>> Overall looks reasonable, just a few comments below.
>>
>>> Signed-off-by: Donggeun Kim<dg77.kim@samsung.com>
>>> Signed-off-by: MyungJoo Ham<myungjoo.ham@samsung.com>
>>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>>> ---
>>>   drivers/input/misc/Kconfig          |   12 ++
>>>   drivers/input/misc/Makefile         |    1 +
>>>   drivers/input/misc/max8997_haptic.c |  366
>>> +++++++++++++++++++++++++++++++++++
>>>   3 files changed, 379 insertions(+), 0 deletions(-)
>>>   create mode 100644 drivers/input/misc/max8997_haptic.c
>>>
>>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfi=
g
>>> index 22d875f..695e1fd 100644
>>> --- a/drivers/input/misc/Kconfig
>>> +++ b/drivers/input/misc/Kconfig
>>> @@ -134,6 +134,18 @@ config INPUT_MAX8925_ONKEY
>>>   	  To compile this driver as a module, choose M here: the module
>>>   	  will be called max8925_onkey.
>>>
>>> +config INPUT_MAX8997_HAPTIC
>>> +	tristate "MAXIM MAX8997 haptic controller support"
>>> +	depends on HAVE_PWM&&  MFD_MAX8997
>>> +	select INPUT_FF_MEMLESS
>>> +	help
>>> +	  This option enables device driver support for the haptic contro=
ller
>>> +	  on MAXIM MAX8997 chip. This driver supports ff-memless interfac=
e
>>> +	  from input framework.
>>> +
>>> +	  To compile this driver as module, choose M here: the
>>> +	  module will be called max8997-haptic.
>>> +
>>>   config INPUT_MC13783_PWRBUTTON
>>>   	tristate "MC13783 ON buttons"
>>>   	depends on MFD_MC13783
>>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makef=
ile
>>> index a244fc6..083df5a 100644
>>> --- a/drivers/input/misc/Makefile
>>> +++ b/drivers/input/misc/Makefile
>>> @@ -28,6 +28,7 @@ obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+=3D keyspan_r=
emote.o
>>>   obj-$(CONFIG_INPUT_KXTJ9)		+=3D kxtj9.o
>>>   obj-$(CONFIG_INPUT_M68K_BEEP)		+=3D m68kspkr.o
>>>   obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+=3D max8925_onkey.o
>>> +obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+=3D max8997_haptic.o
>>>   obj-$(CONFIG_INPUT_MC13783_PWRBUTTON)	+=3D mc13783-pwrbutton.o
>>>   obj-$(CONFIG_INPUT_MMA8450)		+=3D mma8450.o
>>>   obj-$(CONFIG_INPUT_MPU3050)		+=3D mpu3050.o
>>> diff --git a/drivers/input/misc/max8997_haptic.c
>>> b/drivers/input/misc/max8997_haptic.c
>>> new file mode 100644
>>> index 0000000..d7114ad
>>> --- /dev/null
>>> +++ b/drivers/input/misc/max8997_haptic.c
>>> @@ -0,0 +1,366 @@
>>> +/*
>>> + *  max8997_haptic.c - MAX8997-haptic controller driver
>> Please no file names in comments - easiter to move files around.
>>
>>> + *
>>> + *  Copyright (C) 2012 Samsung Electronics
>>> + *  Donggeun Kim<dg77.kim@samsung.com>
>>> + *
>>> + * This program is not provided / owned by Maxim Integrated Produc=
ts.
>>> + *
>>> + * This program is free software; you can redistribute it and/or m=
odify
>>> + * it under the terms of the GNU General Public License as publish=
ed by
>>> + * the Free Software Foundation; either version 2 of the License, =
or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public Licen=
se
>>> + * along with this program; if not, write to the Free Software
>>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111=
-1307
>>> USA
>>> + *
>>> + */
>>> +
>>> +#include<linux/module.h>
>>> +#include<linux/init.h>
>>> +#include<linux/slab.h>
>>> +#include<linux/platform_device.h>
>>> +#include<linux/err.h>
>>> +#include<linux/pwm.h>
>>> +#include<linux/input.h>
>>> +#include<linux/mfd/max8997-private.h>
>>> +#include<linux/mfd/max8997.h>
>>> +#include<linux/regulator/consumer.h>
>>> +
>>> +/* Haptic configuration 2 register */
>>> +#define MAX8997_MOTOR_TYPE_SHIFT	7
>>> +#define MAX8997_ENABLE_SHIFT		6
>>> +#define MAX8997_MODE_SHIFT		5
>>> +
>>> +/* Haptic driver configuration register */
>>> +#define MAX8997_CYCLE_SHIFT		6
>>> +#define MAX8997_SIG_PERIOD_SHIFT	4
>>> +#define MAX8997_SIG_DUTY_SHIFT		2
>>> +#define MAX8997_PWM_DUTY_SHIFT		0
>>> +
>>> +struct max8997_haptic {
>>> +	struct device *dev;
>>> +	struct i2c_client *client;
>>> +	struct input_dev *input_dev;
>>> +	struct regulator *regulator;
>>> +
>>> +	bool enabled;
>>> +
>>> +	int level;
>> It looks like this should be unsigned.
>>
>>> +
>>> +	struct pwm_device *pwm;
>>> +	int pwm_period;
>>> +	enum max8997_haptic_pwm_divisor pwm_divisor;
>>> +
>>> +	enum max8997_haptic_motor_type type;
>>> +	enum max8997_haptic_pulse_mode mode;
>>> +
>>> +	int internal_mode_pattern;
>>> +	int pattern_cycle;
>>> +	int pattern_signal_period;
>>> +};
>>> +
>>> +static int max8997_haptic_set_duty_cycle(struct max8997_haptic *ch=
ip)
>>> +{
>>> +	int duty, i;
>>> +	int ret;
>>> +	u8 duty_index;
>>> +
>>> +	if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE) {
>>> +		duty =3D chip->pwm_period * chip->level / 100;
>>> +		ret =3D pwm_config(chip->pwm, duty, chip->pwm_period);
>>> +	} else {
>>> +		for (i =3D 0; i<=3D 64; i++) {
>>> +			if (chip->level<=3D i * 100 / 64) {
>>> +				duty_index =3D i;
>>> +				break;
>>> +			}
>>> +		}
>>> +		switch (chip->internal_mode_pattern) {
>>> +		case 0:
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_SIGPWMDC1, duty_index);
>>> +			break;
>>> +		case 1:
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_SIGPWMDC2, duty_index);
>>> +			break;
>>> +		case 2:
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_SIGPWMDC3, duty_index);
>>> +			break;
>>> +		case 3:
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_SIGPWMDC4, duty_index);
>>> +			break;
>>> +		default:
>>> +			break;
>>> +		}
>>> +	}
>>> +	return ret;
>>> +}
>>> +
>>> +static void max8997_haptic_configure(struct max8997_haptic *chip)
>>> +{
>>> +	u8 value;
>>> +
>>> +	value =3D chip->type<<  MAX8997_MOTOR_TYPE_SHIFT |
>>> +		chip->enabled<<  MAX8997_ENABLE_SHIFT |
>>> +		chip->mode<<  MAX8997_MODE_SHIFT | chip->pwm_divisor;
>>> +	max8997_write_reg(chip->client, MAX8997_HAPTIC_REG_CONF2, value);
>>> +
>>> +	if (chip->mode =3D=3D MAX8997_INTERNAL_MODE&&  chip->enabled) {
>>> +		value =3D chip->internal_mode_pattern<<  MAX8997_CYCLE_SHIFT |
>>> +		      chip->internal_mode_pattern<<  MAX8997_SIG_PERIOD_SHIFT |
>>> +		      chip->internal_mode_pattern<<  MAX8997_SIG_DUTY_SHIFT |
>>> +		      chip->internal_mode_pattern<<  MAX8997_PWM_DUTY_SHIFT;
>>> +		max8997_write_reg(chip->client,
>>> +			MAX8997_HAPTIC_REG_DRVCONF, value);
>>> +
>>> +		switch (chip->internal_mode_pattern) {
>>> +		case 0:
>>> +			value =3D chip->pattern_cycle<<  4;
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_CYCLECONF1, value);
>>> +			value =3D chip->pattern_signal_period;
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_SIGCONF1, value);
>>> +			break;
>>> +		case 1:
>>> +			value =3D chip->pattern_cycle;
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_CYCLECONF1, value);
>>> +			value =3D chip->pattern_signal_period;
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_SIGCONF2, value);
>>> +			break;
>>> +		case 2:
>>> +			value =3D chip->pattern_cycle<<  4;
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_CYCLECONF2, value);
>>> +			value =3D chip->pattern_signal_period;
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_SIGCONF3, value);
>>> +			break;
>>> +		case 3:
>>> +			value =3D chip->pattern_cycle;
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_CYCLECONF2, value);
>>> +			value =3D chip->pattern_signal_period;
>>> +			max8997_write_reg(chip->client,
>>> +				MAX8997_HAPTIC_REG_SIGCONF4, value);
>>> +			break;
>>> +		default:
>>> +			break;
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static void max8997_haptic_enable(struct max8997_haptic *chip, boo=
l
>>> enable)
>>> +{
>>> +	if (chip->enabled =3D=3D enable)
>>> +		return;
>>> +
>>> +	chip->enabled =3D enable;
>>> +
>>> +	if (enable) {
>>> +		regulator_enable(chip->regulator);
>>> +		max8997_haptic_configure(chip);
>>> +		if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>>> +			pwm_enable(chip->pwm);
>>> +	} else {
>>> +		max8997_haptic_configure(chip);
>>> +		if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>>> +			pwm_disable(chip->pwm);
>>> +		regulator_disable(chip->regulator);
>>> +	}
>>> +}
>>> +
>>> +static void max8997_haptic_close(struct input_dev *dev)
>>> +{
>>> +	struct max8997_haptic *chip =3D input_get_drvdata(dev);
>>> +
>>> +	if (chip->enabled)
>>> +		max8997_haptic_enable(chip, false);
>> This should not be needed as input core/evdev "flushes" (stops) all
>> FF effects played by a given client when closing the device.
>>
>>> +}
>>> +
>>> +static int max8997_haptic_play_effect(struct input_dev *dev, void =
*data,
>>> +				  struct ff_effect *effect)
>>> +{
>>> +	struct max8997_haptic *chip =3D input_get_drvdata(dev);
>>> +	int ret;
>>> +
>>> +	chip->level =3D effect->u.rumble.strong_magnitude;
>>> +	if (!chip->level)
>>> +		chip->level =3D effect->u.rumble.weak_magnitude;
>>> +
>>> +	if (chip->level) {
>>> +		ret =3D max8997_haptic_set_duty_cycle(chip);
>>> +		if (ret) {
>>> +			dev_err(chip->dev, "set_pwm_cycle failed\n");
>>> +			return ret;
>>> +		}
>>> +		max8997_haptic_enable(chip, true);
>>> +	} else {
>>> +		max8997_haptic_enable(chip, false);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int __devinit max8997_haptic_probe(struct platform_device *=
pdev)
>>> +{
>>> +	struct max8997_dev *iodev =3D dev_get_drvdata(pdev->dev.parent);
>>> +	struct max8997_platform_data *pdata =3D dev_get_platdata(iodev->d=
ev);
>>> +	struct max8997_haptic_platform_data *haptic_pdata =3D
>>> +						pdata->haptic_pdata;
>>> +	struct max8997_haptic *chip;
>>> +	struct input_dev *input_dev;
>>> +	int ret;
>>> +
>>> +	if (!haptic_pdata) {
>>> +		dev_err(&pdev->dev, "no haptic platform data\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	chip =3D kzalloc(sizeof(struct max8997_haptic), GFP_KERNEL);
>>> +	input_dev =3D input_allocate_device();
>>> +	if (!chip || !input_dev) {
>>> +		dev_err(&pdev->dev, "unable to allocate memory\n");
>>> +		return -ENOMEM;
>> This leaks memory.
>>
>>> +	}
>>> +
>>> +	chip->client =3D iodev->haptic;
>>> +	chip->dev =3D&pdev->dev;
>>> +	chip->input_dev =3D input_dev;
>>> +	chip->pwm_period =3D haptic_pdata->pwm_period;
>>> +	chip->type =3D haptic_pdata->type;
>>> +	chip->mode =3D haptic_pdata->mode;
>>> +	chip->pwm_divisor =3D haptic_pdata->pwm_divisor;
>>> +	if (chip->mode =3D=3D MAX8997_INTERNAL_MODE) {
>>> +		chip->internal_mode_pattern =3D
>>> +				haptic_pdata->internal_mode_pattern;
>>> +		chip->pattern_cycle =3D haptic_pdata->pattern_cycle;
>>> +		chip->pattern_signal_period =3D
>>> +				haptic_pdata->pattern_signal_period;
>>> +	}
>>> +
>>> +	if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE) {
>>> +		chip->pwm =3D pwm_request(haptic_pdata->pwm_channel_id,
>>> +					"max8997-haptic");
>>> +		if (IS_ERR(chip->pwm)) {
>>> +			dev_err(&pdev->dev,
>>> +				"unable to request PWM for haptic\n");
>>> +			ret =3D PTR_RET(chip->pwm);
>> Why PTR_RET? Should be PTR_ERR (we do know we got an error).
>>
>>> +			goto err_pwm;
>>> +		}
>>> +	}
>>> +
>>> +	chip->regulator =3D regulator_get(&pdev->dev, "inmotor");
>>> +	if (IS_ERR(chip->regulator)) {
>>> +		dev_err(&pdev->dev, "unable to get regulator\n");
>>> +		ret =3D PTR_RET(chip->regulator);
>> PTR_ERR()
>>
>>> +		goto err_regulator;
>>> +	}
>>> +
>>> +	platform_set_drvdata(pdev, chip);
>>> +
>>> +	input_dev->name =3D "max8997-haptic";
>>> +	input_dev->id.version =3D 1;
>>> +	input_dev->dev.parent =3D&pdev->dev;
>>> +	input_dev->close =3D max8997_haptic_close;
>> Not needed.
>>
>>> +	input_set_drvdata(input_dev, chip);
>>> +	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
>>> +
>>> +	ret =3D input_ff_create_memless(input_dev, NULL,
>>> +				max8997_haptic_play_effect);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev,
>>> +			"unable to create FF device(ret : %d)\n", ret);
>>> +		goto err_ff_memless;
>>> +	}
>>> +
>>> +	ret =3D input_register_device(input_dev);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev,
>>> +			"unable to register input device(ret : %d)\n", ret);
>>> +		goto err_input_register;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +err_input_register:
>>> +	input_ff_destroy(input_dev);
>>> +err_ff_memless:
>>> +	regulator_put(chip->regulator);
>>> +err_regulator:
>>> +	if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>>> +		pwm_free(chip->pwm);
>>> +err_pwm:
>>> +	kfree(chip);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int __devexit max8997_haptic_remove(struct platform_device =
*pdev)
>>> +{
>>> +	struct max8997_haptic *chip =3D platform_get_drvdata(pdev);
>>> +
>>> +	input_unregister_device(chip->input_dev);
>>> +	regulator_put(chip->regulator);
>>> +
>>> +	if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>>> +		pwm_free(chip->pwm);
>>> +
>>> +	kfree(chip);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int max8997_haptic_suspend(struct device *dev)
>>> +{
>>> +	struct platform_device *pdev =3D to_platform_device(dev);
>>> +	struct max8997_haptic *chip =3D platform_get_drvdata(pdev);
>>> +
>>> +	max8997_haptic_enable(chip, false);
>> This may race with max8997_haptic_play_effect() and thus you should =
take
>> input_dev->event_lock.
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int max8997_haptic_resume(struct device *dev)
>>> +{
>>> +	return 0;
>>> +}
>> Not needed.
>>
>>> +
>>> +static SIMPLE_DEV_PM_OPS(max8997_haptic_pm_ops, max8997_haptic_sus=
pend,
>>> +	max8997_haptic_resume);
>>> +
>>> +static const struct platform_device_id max8997_haptic_id[] =3D {
>>> +	{ "max8997-haptic", 0 },
>>> +	{ },
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, max8997_haptic_id);
>>> +
>>> +static struct platform_driver max8997_haptic_driver =3D {
>>> +	.driver	=3D {
>>> +		.name	=3D "max8997-haptic",
>>> +		.owner	=3D THIS_MODULE,
>>> +		.pm	=3D&max8997_haptic_pm_ops,
>>> +	},
>>> +	.probe		=3D max8997_haptic_probe,
>>> +	.remove		=3D __devexit_p(max8997_haptic_remove),
>>> +	.id_table	=3D max8997_haptic_id,
>>> +};
>>> +
>>> +module_platform_driver(max8997_haptic_driver);
>>> +
>>> +MODULE_ALIAS("platform:max8997-haptic");
>>> +MODULE_AUTHOR("Donggeun Kim<dg77.kim@samsung.com>");
>>> +MODULE_DESCRIPTION("max8997_haptic driver");
>>> +MODULE_LICENSE("GPL");
>> Does the patch below work for you?
>>
>> Thanks.
>>
>> --
>> Dmitry
>>
>> Input: add driver support for MAX8997-haptic
>>
>> From: Donggeun Kim<dg77.kim@samsung.com>
>>
>> The MAX8997-haptic function can be used to control motor. User can
>> control the haptic driver by using force feedback framework.
>>
>> Signed-off-by: Donggeun Kim<dg77.kim@samsung.com>
>> Signed-off-by: MyungJoo Ham<myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>> Signed-off-by: Dmitry Torokhov<dtor@mail.ru>
>> ---
>>
>>   drivers/input/misc/Kconfig          |   12 +
>>   drivers/input/misc/Makefile         |    1
>>   drivers/input/misc/max8997_haptic.c |  367
>> +++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/max8997.h         |   53 +++++
>>   4 files changed, 432 insertions(+), 1 deletions(-)
>>   create mode 100644 drivers/input/misc/max8997_haptic.c
>>
>>
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index 2337c3e..ee077a4 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -134,6 +134,18 @@ config INPUT_MAX8925_ONKEY
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called max8925_onkey.
>>
>> +config INPUT_MAX8997_HAPTIC
>> +	tristate "MAXIM MAX8997 haptic controller support"
>> +	depends on HAVE_PWM&&  MFD_MAX8997
>> +	select INPUT_FF_MEMLESS
>> +	help
>> +	  This option enables device driver support for the haptic control=
ler
>> +	  on MAXIM MAX8997 chip. This driver supports ff-memless interface
>> +	  from input framework.
>> +
>> +	  To compile this driver as module, choose M here: the
>> +	  module will be called max8997-haptic.
>> +
>>   config INPUT_MC13783_PWRBUTTON
>>   	tristate "MC13783 ON buttons"
>>   	depends on MFD_MC13783
>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefi=
le
>> index a6d8de0..f55cdf4 100644
>> --- a/drivers/input/misc/Makefile
>> +++ b/drivers/input/misc/Makefile
>> @@ -31,6 +31,7 @@ obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+=3D keyspan_re=
mote.o
>>   obj-$(CONFIG_INPUT_KXTJ9)		+=3D kxtj9.o
>>   obj-$(CONFIG_INPUT_M68K_BEEP)		+=3D m68kspkr.o
>>   obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+=3D max8925_onkey.o
>> +obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+=3D max8997_haptic.o
>>   obj-$(CONFIG_INPUT_MC13783_PWRBUTTON)	+=3D mc13783-pwrbutton.o
>>   obj-$(CONFIG_INPUT_MMA8450)		+=3D mma8450.o
>>   obj-$(CONFIG_INPUT_MPU3050)		+=3D mpu3050.o
>> diff --git a/drivers/input/misc/max8997_haptic.c
>> b/drivers/input/misc/max8997_haptic.c
>> new file mode 100644
>> index 0000000..74cbc13
>> --- /dev/null
>> +++ b/drivers/input/misc/max8997_haptic.c
>> @@ -0,0 +1,367 @@
>> +/*
>> + * MAX8997-haptic controller driver
>> + *
>> + * Copyright (C) 2012 Samsung Electronics
>> + * Donggeun Kim<dg77.kim@samsung.com>
>> + *
>> + * This program is not provided / owned by Maxim Integrated Product=
s.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-=
1307
>> USA
>> + *
>> + */
>> +
>> +#include<linux/module.h>
>> +#include<linux/init.h>
>> +#include<linux/slab.h>
>> +#include<linux/platform_device.h>
>> +#include<linux/err.h>
>> +#include<linux/pwm.h>
>> +#include<linux/input.h>
>> +#include<linux/mfd/max8997-private.h>
>> +#include<linux/mfd/max8997.h>
>> +#include<linux/regulator/consumer.h>
>> +
>> +/* Haptic configuration 2 register */
>> +#define MAX8997_MOTOR_TYPE_SHIFT	7
>> +#define MAX8997_ENABLE_SHIFT		6
>> +#define MAX8997_MODE_SHIFT		5
>> +
>> +/* Haptic driver configuration register */
>> +#define MAX8997_CYCLE_SHIFT		6
>> +#define MAX8997_SIG_PERIOD_SHIFT	4
>> +#define MAX8997_SIG_DUTY_SHIFT		2
>> +#define MAX8997_PWM_DUTY_SHIFT		0
>> +
>> +struct max8997_haptic {
>> +	struct device *dev;
>> +	struct i2c_client *client;
>> +	struct input_dev *input_dev;
>> +	struct regulator *regulator;
>> +
>> +	bool enabled;
>> +
>> +	unsigned int level;
>> +
>> +	struct pwm_device *pwm;
>> +	int pwm_period;
>> +	enum max8997_haptic_pwm_divisor pwm_divisor;
>> +
>> +	enum max8997_haptic_motor_type type;
>> +	enum max8997_haptic_pulse_mode mode;
>> +
>> +	int internal_mode_pattern;
>> +	int pattern_cycle;
>> +	int pattern_signal_period;
>> +};
>> +
>> +static int max8997_haptic_set_duty_cycle(struct max8997_haptic *chi=
p)
>> +{
>> +	int ret =3D 0;
>> +
>> +	if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE) {
>> +		int duty =3D chip->pwm_period * chip->level / 100;
>> +		ret =3D pwm_config(chip->pwm, duty, chip->pwm_period);
>> +	} else {
>> +		int i;
>> +		u8 duty_index =3D 0;
>> +
>> +		for (i =3D 0; i<=3D 64; i++) {
>> +			if (chip->level<=3D i * 100 / 64) {
>> +				duty_index =3D i;
>> +				break;
>> +			}
>> +		}
>> +		switch (chip->internal_mode_pattern) {
>> +		case 0:
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_SIGPWMDC1, duty_index);
>> +			break;
>> +		case 1:
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_SIGPWMDC2, duty_index);
>> +			break;
>> +		case 2:
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_SIGPWMDC3, duty_index);
>> +			break;
>> +		case 3:
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_SIGPWMDC4, duty_index);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>> +static void max8997_haptic_configure(struct max8997_haptic *chip)
>> +{
>> +	u8 value;
>> +
>> +	value =3D chip->type<<  MAX8997_MOTOR_TYPE_SHIFT |
>> +		chip->enabled<<  MAX8997_ENABLE_SHIFT |
>> +		chip->mode<<  MAX8997_MODE_SHIFT | chip->pwm_divisor;
>> +	max8997_write_reg(chip->client, MAX8997_HAPTIC_REG_CONF2, value);
>> +
>> +	if (chip->mode =3D=3D MAX8997_INTERNAL_MODE&&  chip->enabled) {
>> +		value =3D chip->internal_mode_pattern<<  MAX8997_CYCLE_SHIFT |
>> +		      chip->internal_mode_pattern<<  MAX8997_SIG_PERIOD_SHIFT |
>> +		      chip->internal_mode_pattern<<  MAX8997_SIG_DUTY_SHIFT |
>> +		      chip->internal_mode_pattern<<  MAX8997_PWM_DUTY_SHIFT;
>> +		max8997_write_reg(chip->client,
>> +			MAX8997_HAPTIC_REG_DRVCONF, value);
>> +
>> +		switch (chip->internal_mode_pattern) {
>> +		case 0:
>> +			value =3D chip->pattern_cycle<<  4;
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_CYCLECONF1, value);
>> +			value =3D chip->pattern_signal_period;
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_SIGCONF1, value);
>> +			break;
>> +		case 1:
>> +			value =3D chip->pattern_cycle;
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_CYCLECONF1, value);
>> +			value =3D chip->pattern_signal_period;
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_SIGCONF2, value);
>> +			break;
>> +		case 2:
>> +			value =3D chip->pattern_cycle<<  4;
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_CYCLECONF2, value);
>> +			value =3D chip->pattern_signal_period;
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_SIGCONF3, value);
>> +			break;
>> +		case 3:
>> +			value =3D chip->pattern_cycle;
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_CYCLECONF2, value);
>> +			value =3D chip->pattern_signal_period;
>> +			max8997_write_reg(chip->client,
>> +				MAX8997_HAPTIC_REG_SIGCONF4, value);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static void max8997_haptic_enable(struct max8997_haptic *chip)
>> +{
>> +	if (!chip->enabled) {
>> +		regulator_enable(chip->regulator);
>> +		max8997_haptic_configure(chip);
>> +		if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>> +			pwm_enable(chip->pwm);
>> +		chip->enabled =3D true;
>> +	}
>> +}
>> +
>> +static void max8997_haptic_disable(struct max8997_haptic *chip)
>> +{
>> +	if (chip->enabled) {
>> +		max8997_haptic_configure(chip);
>> +		if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>> +			pwm_disable(chip->pwm);
>> +		regulator_disable(chip->regulator);
>> +		chip->enabled =3D false;
>> +	}
>> +}
>> +
>> +
>> +static int max8997_haptic_play_effect(struct input_dev *dev, void *=
data,
>> +				  struct ff_effect *effect)
>> +{
>> +	struct max8997_haptic *chip =3D input_get_drvdata(dev);
>> +	int error;
>> +
>> +	chip->level =3D effect->u.rumble.strong_magnitude;
>> +	if (!chip->level)
>> +		chip->level =3D effect->u.rumble.weak_magnitude;
>> +
>> +	if (chip->level) {
>> +		error =3D max8997_haptic_set_duty_cycle(chip);
>> +		if (error) {
>> +			dev_err(chip->dev, "set_pwm_cycle failed\n");
>> +			return error;
>> +		}
>> +		max8997_haptic_enable(chip);
>> +	} else {
>> +		max8997_haptic_disable(chip);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __devinit max8997_haptic_probe(struct platform_device *p=
dev)
>> +{
>> +	struct max8997_dev *iodev =3D dev_get_drvdata(pdev->dev.parent);
>> +	const struct max8997_platform_data *pdata =3D
>> +					dev_get_platdata(iodev->dev);
>> +	const struct max8997_haptic_platform_data *haptic_pdata =3D
>> +					pdata->haptic_pdata;
>> +	struct max8997_haptic *chip;
>> +	struct input_dev *input_dev;
>> +	int error;
>> +
>> +	if (!haptic_pdata) {
>> +		dev_err(&pdev->dev, "no haptic platform data\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	chip =3D kzalloc(sizeof(struct max8997_haptic), GFP_KERNEL);
>> +	input_dev =3D input_allocate_device();
>> +	if (!chip || !input_dev) {
>> +		dev_err(&pdev->dev, "unable to allocate memory\n");
>> +		error =3D -ENOMEM;
>> +		goto err_free_mem;
>> +	}
>> +
>> +	chip->client =3D iodev->haptic;
>> +	chip->dev =3D&pdev->dev;
>> +	chip->input_dev =3D input_dev;
>> +	chip->pwm_period =3D haptic_pdata->pwm_period;
>> +	chip->type =3D haptic_pdata->type;
>> +	chip->mode =3D haptic_pdata->mode;
>> +	chip->pwm_divisor =3D haptic_pdata->pwm_divisor;
>> +	if (chip->mode =3D=3D MAX8997_INTERNAL_MODE) {
>> +		chip->internal_mode_pattern =3D
>> +				haptic_pdata->internal_mode_pattern;
>> +		chip->pattern_cycle =3D haptic_pdata->pattern_cycle;
>> +		chip->pattern_signal_period =3D
>> +				haptic_pdata->pattern_signal_period;
>> +	}
>> +
>> +	if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE) {
>> +		chip->pwm =3D pwm_request(haptic_pdata->pwm_channel_id,
>> +					"max8997-haptic");
>> +		if (IS_ERR(chip->pwm)) {
>> +			error =3D PTR_ERR(chip->pwm);
>> +			dev_err(&pdev->dev,
>> +				"unable to request PWM for haptic, error: %d\n",
>> +				error);
>> +			goto err_free_mem;
>> +		}
>> +	}
>> +
>> +	chip->regulator =3D regulator_get(&pdev->dev, "inmotor");
>> +	if (IS_ERR(chip->regulator)) {
>> +		error =3D PTR_ERR(chip->regulator);
>> +		dev_err(&pdev->dev,
>> +			"unable to get regulator, error: %d\n",
>> +			error);
>> +		goto err_free_pwm;
>> +	}
>> +
>> +	input_dev->name =3D "max8997-haptic";
>> +	input_dev->id.version =3D 1;
>> +	input_dev->dev.parent =3D&pdev->dev;
>> +	input_set_drvdata(input_dev, chip);
>> +	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
>> +
>> +	error =3D input_ff_create_memless(input_dev, NULL,
>> +				max8997_haptic_play_effect);
>> +	if (error) {
>> +		dev_err(&pdev->dev,
>> +			"unable to create FF device, error: %d\n",
>> +			error);
>> +		goto err_put_regulator;
>> +	}
>> +
>> +	error =3D input_register_device(input_dev);
>> +	if (error) {
>> +		dev_err(&pdev->dev,
>> +			"unable to register input device, error: %d\n",
>> +			error);
>> +		goto err_destroy_ff;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, chip);
>> +	return 0;
>> +
>> +err_destroy_ff:
>> +	input_ff_destroy(input_dev);
>> +err_put_regulator:
>> +	regulator_put(chip->regulator);
>> +err_free_pwm:
>> +	if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>> +		pwm_free(chip->pwm);
>> +err_free_mem:
>> +	input_free_device(input_dev);
>> +	kfree(chip);
>> +
>> +	return error;
>> +}
>> +
>> +static int __devexit max8997_haptic_remove(struct platform_device *=
pdev)
>> +{
>> +	struct max8997_haptic *chip =3D platform_get_drvdata(pdev);
>> +
>> +	input_unregister_device(chip->input_dev);
>> +	regulator_put(chip->regulator);
>> +
>> +	if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>> +		pwm_free(chip->pwm);
>> +
>> +	kfree(chip);
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int max8997_haptic_suspend(struct device *dev)
>> +{
>> +	struct platform_device *pdev =3D to_platform_device(dev);
>> +	struct max8997_haptic *chip =3D platform_get_drvdata(pdev);
>> +	struct input_dev *input_dev =3D chip->input_dev;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&input_dev->event_lock, flags);
>> +	max8997_haptic_disable(chip);
>> +	spin_unlock_irqrestore(&input_dev->event_lock, flags);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(max8997_haptic_pm_ops, max8997_haptic_susp=
end,
>> NULL);
>> +
>> +static const struct platform_device_id max8997_haptic_id[] =3D {
>> +	{ "max8997-haptic", 0 },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(i2c, max8997_haptic_id);
>> +
>> +static struct platform_driver max8997_haptic_driver =3D {
>> +	.driver	=3D {
>> +		.name	=3D "max8997-haptic",
>> +		.owner	=3D THIS_MODULE,
>> +		.pm	=3D&max8997_haptic_pm_ops,
>> +	},
>> +	.probe		=3D max8997_haptic_probe,
>> +	.remove		=3D __devexit_p(max8997_haptic_remove),
>> +	.id_table	=3D max8997_haptic_id,
>> +};
>> +module_platform_driver(max8997_haptic_driver);
>> +
>> +MODULE_ALIAS("platform:max8997-haptic");
>> +MODULE_AUTHOR("Donggeun Kim<dg77.kim@samsung.com>");
>> +MODULE_DESCRIPTION("max8997_haptic driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/mfd/max8997.h b/include/linux/mfd/max8997=
=2Eh
>> index fff5905..3a00c95 100644
>> --- a/include/linux/mfd/max8997.h
>> +++ b/include/linux/mfd/max8997.h
>> @@ -131,6 +131,55 @@ struct max8997_muic_platform_data {
>>   	int num_init_data;
>>   };
>>
>> +enum max8997_haptic_motor_type {
>> +	MAX8997_HAPTIC_ERM,
>> +	MAX8997_HAPTIC_LRA,
>> +};
>> +
>> +enum max8997_haptic_pulse_mode {
>> +	MAX8997_EXTERNAL_MODE,
>> +	MAX8997_INTERNAL_MODE,
>> +};
>> +
>> +enum max8997_haptic_pwm_divisor {
>> +	MAX8997_PWM_DIVISOR_32,
>> +	MAX8997_PWM_DIVISOR_64,
>> +	MAX8997_PWM_DIVISOR_128,
>> +	MAX8997_PWM_DIVISOR_256,
>> +};
>> +
>> +/**
>> + * max8997_haptic_platform_data
>> + * @pwm_channel_id: channel number of PWM device
>> + *		    valid for MAX8997_EXTERNAL_MODE
>> + * @pwm_period: period in nano second for PWM device
>> + *		valid for MAX8997_EXTERNAL_MODE
>> + * @type: motor type
>> + * @mode: pulse mode
>> + *     MAX8997_EXTERNAL_MODE: external PWM device is used to contro=
l motor
>> + *     MAX8997_INTERNAL_MODE: internal pulse generator is used to c=
ontrol
>> motor
>> + * @pwm_divisor: divisor for external PWM device
>> + * @internal_mode_pattern: internal mode pattern for internal mode
>> + *     [0 - 3]: valid pattern number
>> + * @pattern_cycle: the number of cycles of the waveform
>> + *		   for the internal mode pattern
>> + *     [0 - 15]: available cycles
>> + * @pattern_signal_period: period of the waveform for the internal =
mode
>> pattern
>> + *     [0 - 255]: available period
>> + */
>> +struct max8997_haptic_platform_data {
>> +	int pwm_channel_id;
>> +	int pwm_period;
>> +
>> +	enum max8997_haptic_motor_type type;
>> +	enum max8997_haptic_pulse_mode mode;
>> +	enum max8997_haptic_pwm_divisor pwm_divisor;
>> +
>> +	int internal_mode_pattern;
>> +	int pattern_cycle;
>> +	int pattern_signal_period;
>> +};
>> +
>>   enum max8997_led_mode {
>>   	MAX8997_NONE,
>>   	MAX8997_FLASH_MODE,
>> @@ -192,7 +241,9 @@ struct max8997_platform_data {
>>   	/* ---- MUIC ---- */
>>   	struct max8997_muic_platform_data *muic_pdata;
>>
>> -	/* HAPTIC: Not implemented */
>> +	/* ---- HAPTIC ---- */
>> +	struct max8997_haptic_platform_data *haptic_pdata;
>> +
>>   	/* RTC: Not implemented */
>>   	/* ---- LED ---- */
>>   	struct max8997_led_platform_data *led_pdata;
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
