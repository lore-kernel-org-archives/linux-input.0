From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 09/12] Input: Add power key driver for Rockchip RK805
 PMIC
Date: Mon, 24 Jul 2017 17:07:06 -0700
Message-ID: <20170725000706.GA1985@dtor-ws>
References: <1500635681-12477-1-git-send-email-chenjh@rock-chips.com>
 <1500635903-12767-1-git-send-email-chenjh@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38101 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbdGYAHK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 20:07:10 -0400
Content-Disposition: inline
In-Reply-To: <1500635903-12767-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joseph Chen <chenjh@rock-chips.com>
Cc: gnurou@gmail.com, linus.walleij@linaro.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, tony.xie@rock-chips.com, zhangqing@rock-chips.com, wdc@rock-chips.com, devicetree@vger.kernel.org, w.egorov@phytec.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org

Hi Joseph,

On Fri, Jul 21, 2017 at 07:18:23PM +0800, Joseph Chen wrote:
> This driver provides a input driver for the power
> key on the Rockchip RK805 PMIC.
> 
> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
> ---
>  drivers/input/misc/Kconfig        |   6 +++
>  drivers/input/misc/Makefile       |   1 +
>  drivers/input/misc/rk805-pwrkey.c | 111 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+)
>  create mode 100644 drivers/input/misc/rk805-pwrkey.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 5b6c522..72dc4f5 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -571,6 +571,12 @@ config INPUT_PWM_BEEPER
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called pwm-beeper.
>  
> +config INPUT_RK805_PWRKEY
> +	tristate "Rockchip RK805 PMIC power key support"
> +	depends on MFD_RK808
> +	help
> +	  Select this option to enable power key driver for RK805.
> +
>  config INPUT_GPIO_ROTARY_ENCODER
>  	tristate "Rotary encoders connected to GPIO pins"
>  	depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index b10523f..c27052a 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)	+= regulator-haptic.o
>  obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+= retu-pwrbutton.o
>  obj-$(CONFIG_INPUT_AXP20X_PEK)		+= axp20x-pek.o
>  obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
> +obj-$(CONFIG_INPUT_RK805_PWRKEY)	+= rk805-pwrkey.o
>  obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
>  obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
>  obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
> diff --git a/drivers/input/misc/rk805-pwrkey.c b/drivers/input/misc/rk805-pwrkey.c
> new file mode 100644
> index 0000000..e0fc66e
> --- /dev/null
> +++ b/drivers/input/misc/rk805-pwrkey.c
> @@ -0,0 +1,111 @@
> +/*
> + * Rockchip RK805 PMIC Power Key driver
> + *
> + * Copyright (c) 2017, Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Author: Joseph Chen <chenjh@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under  the terms of the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the License, or (at your
> + * option) any later version.
> + *
> + */
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +static irqreturn_t pwrkey_fall_irq(int irq, void *_pwr)
> +{
> +	struct input_dev *pwr = _pwr;
> +
> +	input_report_key(pwr, KEY_POWER, 1);
> +	input_sync(pwr);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t pwrkey_rise_irq(int irq, void *_pwr)
> +{
> +	struct input_dev *pwr = _pwr;
> +
> +	input_report_key(pwr, KEY_POWER, 0);
> +	input_sync(pwr);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rk805_pwrkey_probe(struct platform_device *pdev)
> +{
> +	struct input_dev *pwr;
> +	int fall_irq, rise_irq;
> +	int err;
> +
> +	pwr = devm_input_allocate_device(&pdev->dev);
> +	if (!pwr) {
> +		dev_err(&pdev->dev, "Can't allocate power button\n");
> +		return -ENOMEM;
> +	}
> +
> +	pwr->name = "rk805 pwrkey";
> +	pwr->phys = "rk805_pwrkey/input0";
> +	pwr->dev.parent = &pdev->dev;

This assignment is not needed because it is done for you by
devm_input_allocate_device().

I added pwr->id.bustype = BUS_HOST;

> +	input_set_capability(pwr, EV_KEY, KEY_POWER);
> +
> +	fall_irq = platform_get_irq(pdev, 0);
> +	if (fall_irq < 0) {
> +		dev_err(&pdev->dev, "Can't get fall irq: %d\n", fall_irq);
> +		return fall_irq;
> +	}
> +
> +	rise_irq = platform_get_irq(pdev, 1);
> +	if (rise_irq < 0) {
> +		dev_err(&pdev->dev, "Can't get rise irq: %d\n", rise_irq);
> +		return rise_irq;
> +	}
> +
> +	err = devm_request_any_context_irq(&pwr->dev, fall_irq,
> +					   pwrkey_fall_irq,
> +					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					   "rk805_pwrkey_fall", pwr);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "Can't register fall irq: %d\n", err);
> +		return err;
> +	}
> +
> +	err = devm_request_any_context_irq(&pwr->dev, rise_irq,
> +					   pwrkey_rise_irq,
> +					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					   "rk805_pwrkey_rise", pwr);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "Can't register rise irq: %d\n", err);
> +		return err;
> +	}
> +
> +	err = input_register_device(pwr);
> +	if (err) {
> +		dev_err(&pdev->dev, "Can't register power button: %d\n", err);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, pwr);
> +	device_init_wakeup(&pdev->dev, true);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver rk805_pwrkey_driver = {
> +	.probe	= rk805_pwrkey_probe,
> +	.driver	= {
> +		.name = "rk805-pwrkey",
> +	},
> +};
> +module_platform_driver(rk805_pwrkey_driver);
> +
> +MODULE_AUTHOR("Joseph Chen <chenjh@rock-chips.com>");
> +MODULE_DESCRIPTION("RK805 PMIC Power Key driver");
> +MODULE_LICENSE("GPL v2");

Given that the license notice says "GPL v2 or later" I changed module
license to read just "GPL" (see include/linux/module.h for various
strings accepted by MODULE_LICENSE and their meaning).

Otherwise applied.

Thanks.

-- 
Dmitry
