From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 4/5] Input: add haptic drvier on max77843
Date: Mon, 2 Mar 2015 09:32:23 -0800
Message-ID: <20150302173223.GA17094@dtor-ws>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-5-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425291038-18269-5-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 02, 2015 at 07:10:37PM +0900, Jaewon Kim wrote:
> This patch adds support for haptic driver on max77843
> MFD(Multi Function Device) with PMIC, MUIC, LED, CHARGER.
> 
> This driver supports external pwm and LRA(Linear Resonant Actuator) motor.
> And it supports ff-memless interface from inpu framework.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Do you want it to go through my or MFD tree?

> ---
>  drivers/input/misc/Kconfig           |   12 ++
>  drivers/input/misc/Makefile          |    1 +
>  drivers/input/misc/max77843-haptic.c |  358 ++++++++++++++++++++++++++++++++++
>  3 files changed, 371 insertions(+)
>  create mode 100644 drivers/input/misc/max77843-haptic.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 6deb8da..aa8c072 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -165,6 +165,18 @@ config INPUT_MAX77693_HAPTIC
>  	  To compile this driver as module, choose M here: the
>  	  module will be called max77693-haptic.
>  
> +config INPUT_MAX77843_HAPTIC
> +    tristate "MAXIM MAX77843 haptic controller support"
> +    depends on MFD_MAX77843 && PWM
> +    select INPUT_FF_MEMLESS
> +    help
> +      This option enables support for the haptic controller on
> +      MAXIM MAX77843 chip. The driver supports ff-memless interface
> +      from input framework.
> +
> +      To compile this driver as module, choose M here: the
> +      module will be called max77843-haptic.
> +
>  config INPUT_MAX8925_ONKEY
>  	tristate "MAX8925 ONKEY support"
>  	depends on MFD_MAX8925
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 403a1a5..75b5884 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
>  obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
>  obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
>  obj-$(CONFIG_INPUT_MAX77693_HAPTIC)	+= max77693-haptic.o
> +obj-$(CONFIG_INPUT_MAX77843_HAPTIC)	+= max77843-haptic.o
>  obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
>  obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+= max8997_haptic.o
>  obj-$(CONFIG_INPUT_MC13783_PWRBUTTON)	+= mc13783-pwrbutton.o
> diff --git a/drivers/input/misc/max77843-haptic.c b/drivers/input/misc/max77843-haptic.c
> new file mode 100644
> index 0000000..eef9862
> --- /dev/null
> +++ b/drivers/input/misc/max77843-haptic.c
> @@ -0,0 +1,358 @@
> +/*
> + * MAXIM MAX77693 Haptic device driver
> + *
> + * Copyright (C) 2015 Samsung Electronics
> + * Author: Jaewon Kim <jaewon02.kim@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/mfd/max77843-private.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +#define MAX_MAGNITUDE_SHIFT        16
> +
> +enum max77843_haptic_motor_type {
> +	MAX77843_HAPTIC_ERM = 0,
> +	MAX77843_HAPTIC_LRA,
> +};
> +
> +enum max77843_haptic_pwm_divisor {
> +	MAX77843_HAPTIC_PWM_DIVISOR_32 = 0,
> +	MAX77843_HAPTIC_PWM_DIVISOR_64,
> +	MAX77843_HAPTIC_PWM_DIVISOR_128,
> +	MAX77843_HAPTIC_PWM_DIVISOR_256,
> +};
> +
> +struct max77843_haptic {
> +	struct regmap *regmap_haptic;
> +	struct device *dev;
> +	struct input_dev *input_dev;
> +	struct pwm_device *pwm_dev;
> +	struct regulator *motor_reg;
> +	struct work_struct work;
> +	struct mutex mutex;
> +
> +	unsigned int magnitude;
> +	unsigned int pwm_duty;
> +
> +	bool active;
> +	bool suspended;
> +
> +	enum max77843_haptic_motor_type type;
> +	enum max77843_haptic_pwm_divisor pwm_divisor;
> +};
> +
> +static int max77843_haptic_set_duty_cycle(struct max77843_haptic *haptic)
> +{
> +	int delta = (haptic->pwm_dev->period + haptic->pwm_duty) / 2;
> +	int error;
> +
> +	error = pwm_config(haptic->pwm_dev, delta, haptic->pwm_dev->period);
> +	if (error) {
> +		dev_err(haptic->dev, "failed to configure pwm: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77843_haptic_bias(struct max77843_haptic *haptic, bool on)
> +{
> +	int error;
> +
> +	error = regmap_update_bits(haptic->regmap_haptic,
> +			MAX77843_SYS_REG_MAINCTRL1,
> +			MAX77843_MAINCTRL1_BIASEN_MASK,
> +			on << MAINCTRL1_BIASEN_SHIFT);
> +	if (error) {
> +		dev_err(haptic->dev, "failed to %s bias: %d\n",
> +			on ? "enable" : "disable", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77843_haptic_config(struct max77843_haptic *haptic, bool enable)
> +{
> +	unsigned int value;
> +	int error;
> +
> +	value = ((haptic->type << MCONFIG_MODE_SHIFT) |
> +		(enable << MCONFIG_MEN_SHIFT) |
> +		(haptic->pwm_divisor << MCONFIG_PDIV_SHIFT));
> +
> +	error = regmap_write(haptic->regmap_haptic,
> +			MAX77843_HAP_REG_MCONFIG, value);
> +	if (error) {
> +		dev_err(haptic->dev,
> +			"failed to update haptic config: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77843_haptic_enable(struct max77843_haptic *haptic)
> +{
> +	int error;
> +
> +	if (haptic->active)
> +		return 0;
> +
> +	error = pwm_enable(haptic->pwm_dev);
> +	if (error) {
> +		dev_err(haptic->dev,
> +			"failed to enable pwm device: %d\n", error);
> +		return error;
> +	}
> +
> +	error = max77843_haptic_config(haptic, true);
> +	if (error)
> +		goto err_config;
> +
> +	haptic->active = true;
> +
> +	return 0;
> +
> +err_config:
> +	pwm_disable(haptic->pwm_dev);
> +
> +	return error;
> +}
> +
> +static int max77843_haptic_disable(struct max77843_haptic *haptic)
> +{
> +	int error;
> +
> +	if (!haptic->active)
> +		return 0;
> +
> +	error = max77843_haptic_config(haptic, false);
> +	if (error)
> +		return error;
> +
> +	pwm_disable(haptic->pwm_dev);
> +
> +	haptic->active = false;
> +
> +	return 0;
> +}
> +
> +static void max77843_haptic_play_work(struct work_struct *work)
> +{
> +	struct max77843_haptic *haptic =
> +			container_of(work, struct max77843_haptic, work);
> +	int error;
> +
> +	mutex_lock(&haptic->mutex);
> +
> +	if (haptic->suspended)
> +		goto out_unlock;
> +
> +	if (haptic->magnitude) {
> +		error = max77843_haptic_set_duty_cycle(haptic);
> +		if (error) {
> +			dev_err(haptic->dev,
> +				"failed to set duty cycle: %d\n", error);
> +			goto out_unlock;
> +		}
> +
> +		error = max77843_haptic_enable(haptic);
> +		if (error)
> +			dev_err(haptic->dev,
> +				"cannot enable haptic: %d\n", error);
> +	} else {
> +		error = max77843_haptic_disable(haptic);
> +		if (error)
> +			dev_err(haptic->dev,
> +				"cannot disable haptic: %d\n", error);
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&haptic->mutex);
> +}
> +
> +static int max77843_haptic_play_effect(struct input_dev *dev, void *data,
> +		struct ff_effect *effect)
> +{
> +	struct max77843_haptic *haptic = input_get_drvdata(dev);
> +	u64 period_mag_multi;
> +
> +	haptic->magnitude = effect->u.rumble.strong_magnitude;
> +	if (!haptic->magnitude)
> +		haptic->magnitude = effect->u.rumble.weak_magnitude;
> +
> +	period_mag_multi = (u64)haptic->pwm_dev->period * haptic->magnitude;
> +	haptic->pwm_duty = (unsigned int)(period_mag_multi >>
> +				MAX_MAGNITUDE_SHIFT);
> +
> +	schedule_work(&haptic->work);
> +
> +	return 0;
> +}
> +
> +static int max77843_haptic_open(struct input_dev *dev)
> +{
> +	struct max77843_haptic *haptic = input_get_drvdata(dev);
> +	int error;
> +
> +	error = max77843_haptic_bias(haptic, true);
> +	if (error)
> +		return error;
> +
> +	error = regulator_enable(haptic->motor_reg);
> +	if (error) {
> +		dev_err(haptic->dev,
> +			"failed to enable regulator: %d\n", error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static void max77843_haptic_close(struct input_dev *dev)
> +{
> +	struct max77843_haptic *haptic = input_get_drvdata(dev);
> +	int error;
> +
> +	cancel_work_sync(&haptic->work);
> +	max77843_haptic_disable(haptic);
> +
> +	error = regulator_disable(haptic->motor_reg);
> +	if (error)
> +		dev_err(haptic->dev,
> +			"failed to disable regulator: %d\n", error);
> +
> +	max77843_haptic_bias(haptic, false);
> +}
> +
> +static int max77843_haptic_probe(struct platform_device *pdev)
> +{
> +	struct max77843 *max77843 = dev_get_drvdata(pdev->dev.parent);
> +	struct max77843_haptic *haptic;
> +	int error;
> +
> +	haptic = devm_kzalloc(&pdev->dev, sizeof(*haptic), GFP_KERNEL);
> +	if (!haptic)
> +		return -ENOMEM;
> +
> +	haptic->regmap_haptic = max77843->regmap;
> +	haptic->dev = &pdev->dev;
> +	haptic->type = MAX77843_HAPTIC_LRA;
> +	haptic->pwm_divisor = MAX77843_HAPTIC_PWM_DIVISOR_128;
> +
> +	INIT_WORK(&haptic->work, max77843_haptic_play_work);
> +	mutex_init(&haptic->mutex);
> +
> +	haptic->pwm_dev = devm_pwm_get(&pdev->dev, NULL);
> +	if (IS_ERR(haptic->pwm_dev)) {
> +		dev_err(&pdev->dev, "failed to get pwm device\n");
> +		return PTR_ERR(haptic->pwm_dev);
> +	}
> +
> +	haptic->motor_reg = devm_regulator_get_exclusive(&pdev->dev, "haptic");
> +	if (IS_ERR(haptic->motor_reg)) {
> +		dev_err(&pdev->dev, "failed to get regulator\n");
> +		return PTR_ERR(haptic->motor_reg);
> +	}
> +
> +	haptic->input_dev = devm_input_allocate_device(&pdev->dev);
> +	if (!haptic->input_dev) {
> +		dev_err(&pdev->dev, "failed to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	haptic->input_dev->name = "max77843-haptic";
> +	haptic->input_dev->id.version = 1;
> +	haptic->input_dev->dev.parent = &pdev->dev;
> +	haptic->input_dev->open = max77843_haptic_open;
> +	haptic->input_dev->close = max77843_haptic_close;
> +	input_set_drvdata(haptic->input_dev, haptic);
> +	input_set_capability(haptic->input_dev, EV_FF, FF_RUMBLE);
> +
> +	error = input_ff_create_memless(haptic->input_dev, NULL,
> +			max77843_haptic_play_effect);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to create force-feedback\n");
> +		return error;
> +	}
> +
> +	error = input_register_device(haptic->input_dev);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		return error;
> +	}
> +
> +	platform_set_drvdata(pdev, haptic);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused max77843_haptic_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct max77843_haptic *haptic = platform_get_drvdata(pdev);
> +	int error;
> +
> +	error = mutex_lock_interruptible(&haptic->mutex);
> +	if (error)
> +		return error;
> +
> +	max77843_haptic_disable(haptic);
> +
> +	haptic->suspended = true;
> +
> +	mutex_unlock(&haptic->mutex);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused max77843_haptic_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct max77843_haptic *haptic = platform_get_drvdata(pdev);
> +	unsigned int magnitude;
> +
> +	mutex_lock(&haptic->mutex);
> +
> +	haptic->suspended = false;
> +
> +	magnitude = ACCESS_ONCE(haptic->magnitude);
> +	if (magnitude)
> +		max77843_haptic_enable(haptic);
> +
> +	mutex_unlock(&haptic->mutex);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(max77843_haptic_pm_ops,
> +		max77843_haptic_suspend, max77843_haptic_resume);
> +
> +static struct platform_driver max77843_haptic_driver = {
> +	.driver		= {
> +		.name	= "max77843-haptic",
> +		.pm	= &max77843_haptic_pm_ops,
> +	},
> +	.probe		= max77843_haptic_probe,
> +};
> +module_platform_driver(max77843_haptic_driver);
> +
> +MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
> +MODULE_DESCRIPTION("MAXIM MAX77843 Haptic driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.9.5
> 

Thanks.

-- 
Dmitry
