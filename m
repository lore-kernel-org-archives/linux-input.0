From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH V2 1/2] input: misc: da9063: OnKey driver
Date: Fri, 17 Apr 2015 09:15:55 -0700
Message-ID: <20150417161555.GB27440@dtor-ws>
References: <cover.1429272200.git.stwiss.opensource@diasemi.com>
 <b9068c6e41a08b620c9e1674e17e508ab0d76d55.1429272200.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34241 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbbDQQQA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2015 12:16:00 -0400
Content-Disposition: inline
In-Reply-To: <b9068c6e41a08b620c9e1674e17e508ab0d76d55.1429272200.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>

On Fri, Apr 17, 2015 at 01:03:20PM +0100, S Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Add OnKey driver support for DA9063
> 

Isn't this almost to the letter identical to da9062 that I just looked
at? Please find a way to not make a brand new driver for the slightest
variation of the chip...

Thanks.

> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> Changes from PATCH V1 to V2
> ---------------------------
> - Remove the circular dependency comment in the main e-mail body
>   linking PATCH V1 1/2 and 2/2
> - Alter the copyright header information to match expected GPLv2
>   text from http://www.gnu.org/licenses/gpl-2.0.html
> 
> This patch applies against linux-next and v4.0-rc6 
> 
> 
>  MAINTAINERS                       |   2 +-
>  drivers/input/misc/Kconfig        |  10 ++
>  drivers/input/misc/Makefile       |   1 +
>  drivers/input/misc/da9063-onkey.c | 228 ++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/da9063-core.c         |  55 +++++++++
>  include/linux/mfd/da9063/pdata.h  |   1 +
>  6 files changed, 296 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/input/misc/da9063-onkey.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1de6afa..97e20cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3138,7 +3138,7 @@ S:	Supported
>  F:	Documentation/hwmon/da90??
>  F:	drivers/gpio/gpio-da90??.c
>  F:	drivers/hwmon/da90??-hwmon.c
> -F:	drivers/input/misc/da90??_onkey.c
> +F:	drivers/input/misc/da90???onkey.c
>  F:	drivers/input/touchscreen/da9052_tsi.c
>  F:	drivers/leds/leds-da90??.c
>  F:	drivers/mfd/da903x.c
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 6deb8da..9d7a79d 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -586,6 +586,16 @@ config INPUT_DA9055_ONKEY
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called da9055_onkey.
>  
> +config INPUT_DA9063_ONKEY
> +	tristate "Dialog DA9063 OnKey"
> +	depends on MFD_DA9063
> +	help
> +	  Support the ONKEY of Dialog DA9063 Power Management IC as an
> +	  input device reporting power button statue.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called da9063-onkey.
> +
>  config INPUT_DM355EVM
>  	tristate "TI DaVinci DM355 EVM Keypad and IR Remote"
>  	depends on MFD_DM355EVM_MSP
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 403a1a5..50ae57e 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
>  obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
>  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
> +obj-$(CONFIG_INPUT_DA9063_ONKEY)	+= da9063-onkey.o
>  obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
>  obj-$(CONFIG_INPUT_E3X0_BUTTON)		+= e3x0-button.o
>  obj-$(CONFIG_INPUT_DRV260X_HAPTICS)	+= drv260x.o
> diff --git a/drivers/input/misc/da9063-onkey.c b/drivers/input/misc/da9063-onkey.c
> new file mode 100644
> index 0000000..9e41a2d
> --- /dev/null
> +++ b/drivers/input/misc/da9063-onkey.c
> @@ -0,0 +1,228 @@
> +/*
> + * da9063-onkey.c - Onkey device driver for DA9063
> + * Copyright (C) 2015  Dialog Semiconductor Ltd.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/mfd/da9063/core.h>
> +#include <linux/mfd/da9063/pdata.h>
> +#include <linux/mfd/da9063/registers.h>
> +
> +struct da9063_onkey {
> +	struct	da9063 *hw;
> +	struct delayed_work work;
> +	struct	input_dev *input;
> +	int irq;
> +	bool key_power;
> +};
> +
> +static void da9063_poll_on(struct work_struct *work)
> +{
> +	struct da9063_onkey *onkey = container_of(work, struct da9063_onkey,
> +						  work.work);
> +	unsigned int val;
> +	int fault_log = 0;
> +	bool poll = true;
> +	int ret;
> +
> +	/* poll to see when the pin is released */
> +	ret = regmap_read(onkey->hw->regmap, DA9063_REG_STATUS_A, &val);
> +	if (ret < 0) {
> +		dev_err(&onkey->input->dev,
> +			"Failed to read ON status: %d\n", ret);
> +		goto err_poll;
> +	}
> +
> +	if (!(val & DA9063_NONKEY)) {
> +		ret = regmap_update_bits(onkey->hw->regmap,
> +					 DA9063_REG_CONTROL_B,
> +					 DA9063_NONKEY_LOCK, 0);
> +		if (ret < 0) {
> +			dev_err(&onkey->input->dev,
> +				"Failed to reset the Key Delay %d\n", ret);
> +			goto err_poll;
> +		}
> +
> +		input_report_key(onkey->input, KEY_POWER, 0);
> +		input_sync(onkey->input);
> +
> +		poll = false;
> +	}
> +
> +	/* if the fault log KEY_RESET is detected,
> +	 * then clear it and shutdown via I2C
> +	 */
> +	ret = regmap_read(onkey->hw->regmap, DA9063_REG_FAULT_LOG, &fault_log);
> +	if (ret < 0)
> +		dev_warn(&onkey->input->dev, "Cannot read FAULT_LOG\n");
> +
> +	if (fault_log & DA9063_KEY_RESET) {
> +		ret = regmap_write(onkey->hw->regmap,
> +				   DA9063_REG_FAULT_LOG,
> +				   DA9063_KEY_RESET);
> +		if (ret < 0)
> +			dev_warn(&onkey->input->dev,
> +				 "Cannot reset KEY_RESET fault log\n");
> +		else {
> +			/* at this point we do any S/W housekeeping
> +			 * and then send shutdown command
> +			 */
> +			dev_info(&onkey->input->dev,
> +				 "Sending SHUTDOWN to DA9063 ...\n");
> +			ret = regmap_write(onkey->hw->regmap,
> +					   DA9063_REG_CONTROL_F,
> +					   DA9063_SHUTDOWN);
> +			if (ret < 0)
> +				dev_err(&onkey->input->dev,
> +					"Cannot SHUTDOWN DA9063\n");
> +		}
> +	}
> +
> +err_poll:
> +	if (poll)
> +		schedule_delayed_work(&onkey->work, 50);
> +}
> +
> +static irqreturn_t da9063_onkey_irq_handler(int irq, void *data)
> +{
> +	struct da9063_onkey *onkey = data;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(onkey->hw->regmap, DA9063_REG_STATUS_A, &val);
> +	if (onkey->key_power && (ret >= 0) && (val & DA9063_NONKEY)) {
> +		input_report_key(onkey->input, KEY_POWER, 1);
> +		input_sync(onkey->input);
> +		schedule_delayed_work(&onkey->work, 0);
> +		dev_notice(&onkey->input->dev, "KEY_POWER pressed.\n");
> +	} else {
> +		input_report_key(onkey->input, KEY_SLEEP, 1);
> +		input_sync(onkey->input);
> +		input_report_key(onkey->input, KEY_SLEEP, 0);
> +		input_sync(onkey->input);
> +		dev_notice(&onkey->input->dev, "KEY_SLEEP pressed.\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int da9063_onkey_probe(struct platform_device *pdev)
> +{
> +	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
> +	struct da9063_pdata *pdata = dev_get_platdata(da9063->dev);
> +	struct da9063_onkey *onkey;
> +	bool kp_tmp = true;
> +	int ret = 0;
> +
> +	if (pdata)
> +		kp_tmp = pdata->key_power;
> +	else {
> +		kp_tmp = of_property_read_bool((&pdev->dev)->of_node,
> +					       "dlg,disable-key-power");
> +		kp_tmp = !kp_tmp;
> +	}
> +
> +	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_onkey),
> +			     GFP_KERNEL);
> +	if (!onkey) {
> +		dev_err(&pdev->dev, "Failed to allocate memory.\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	INIT_DELAYED_WORK(&onkey->work, da9063_poll_on);
> +
> +	onkey->input = devm_input_allocate_device(&pdev->dev);
> +	if (!onkey->input) {
> +		dev_err(&pdev->dev, "Failed to allocated input device.\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	ret = platform_get_irq_byname(pdev, "ONKEY");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to get platform IRQ.\n");
> +		goto err;
> +	}
> +	onkey->irq = ret;
> +
> +	ret = request_threaded_irq(onkey->irq, NULL,
> +				   da9063_onkey_irq_handler,
> +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +				   "ONKEY", onkey);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to request input device IRQ.\n");
> +		goto err;
> +	}
> +
> +	onkey->hw = da9063;
> +	onkey->key_power = kp_tmp;
> +	onkey->input->evbit[0] = BIT_MASK(EV_KEY);
> +	onkey->input->name = DA9063_DRVNAME_ONKEY;
> +	onkey->input->phys = DA9063_DRVNAME_ONKEY "/input0";
> +	onkey->input->dev.parent = &pdev->dev;
> +
> +	if (onkey->key_power)
> +		input_set_capability(onkey->input, EV_KEY, KEY_POWER);
> +	input_set_capability(onkey->input, EV_KEY, KEY_SLEEP);
> +
> +	ret = input_register_device(onkey->input);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to register input device.\n");
> +		goto err_irq;
> +	}
> +
> +	platform_set_drvdata(pdev, onkey);
> +	return 0;
> +
> +err_irq:
> +	free_irq(onkey->irq, onkey);
> +	cancel_delayed_work_sync(&onkey->work);
> +err:
> +	return ret;
> +}
> +
> +static int da9063_onkey_remove(struct platform_device *pdev)
> +{
> +	struct	da9063_onkey *onkey = platform_get_drvdata(pdev);
> +
> +	free_irq(onkey->irq, onkey);
> +	cancel_delayed_work_sync(&onkey->work);
> +	input_unregister_device(onkey->input);
> +	return 0;
> +}
> +
> +static struct platform_driver da9063_onkey_driver = {
> +	.probe	= da9063_onkey_probe,
> +	.remove	= da9063_onkey_remove,
> +	.driver	= {
> +		.name	= DA9063_DRVNAME_ONKEY,
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(da9063_onkey_driver);
> +
> +MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
> +MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DA9063_DRVNAME_ONKEY);
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index facd361..b6d6f18 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -60,6 +60,7 @@ static struct resource da9063_rtc_resources[] = {
>  
>  static struct resource da9063_onkey_resources[] = {
>  	{
> +		.name	= "ONKEY",
>  		.start	= DA9063_IRQ_ONKEY,
>  		.end	= DA9063_IRQ_ONKEY,
>  		.flags	= IORESOURCE_IRQ,
> @@ -97,6 +98,7 @@ static const struct mfd_cell da9063_devs[] = {
>  		.name		= DA9063_DRVNAME_ONKEY,
>  		.num_resources	= ARRAY_SIZE(da9063_onkey_resources),
>  		.resources	= da9063_onkey_resources,
> +		.of_compatible = "dlg,da9063-onkey",
>  	},
>  	{
>  		.name		= DA9063_DRVNAME_RTC,
> @@ -109,12 +111,64 @@ static const struct mfd_cell da9063_devs[] = {
>  	},
>  };
>  
> +static int da9063_clear_fault_log(struct da9063 *da9063)
> +{
> +	int ret = 0;
> +	int fault_log = 0;
> +
> +	ret = regmap_read(da9063->regmap, DA9063_REG_FAULT_LOG, &fault_log);
> +	if (ret < 0) {
> +		dev_err(da9063->dev, "Cannot read FAULT_LOG.\n");
> +		return -EIO;
> +	}
> +
> +	if (fault_log) {
> +		if (fault_log & DA9063_TWD_ERROR)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_TWD_ERROR\n");
> +		if (fault_log & DA9063_POR)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_POR\n");
> +		if (fault_log & DA9063_VDD_FAULT)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_VDD_FAULT\n");
> +		if (fault_log & DA9063_VDD_START)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_VDD_START\n");
> +		if (fault_log & DA9063_TEMP_CRIT)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_TEMP_CRIT\n");
> +		if (fault_log & DA9063_KEY_RESET)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_KEY_RESET\n");
> +		if (fault_log & DA9063_NSHUTDOWN)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_NSHUTDOWN\n");
> +		if (fault_log & DA9063_WAIT_SHUT)
> +			dev_dbg(da9063->dev,
> +				"Fault log entry detected: DA9063_WAIT_SHUT\n");
> +	}
> +
> +	ret = regmap_write(da9063->regmap,
> +			   DA9063_REG_FAULT_LOG,
> +			   fault_log);
> +	if (ret < 0)
> +		dev_err(da9063->dev,
> +			"Cannot reset FAULT_LOG values %d\n", ret);
> +
> +	return ret;
> +}
> +
>  int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  {
>  	struct da9063_pdata *pdata = da9063->dev->platform_data;
>  	int model, variant_id, variant_code;
>  	int ret;
>  
> +	ret = da9063_clear_fault_log(da9063);
> +	if (ret < 0)
> +		dev_err(da9063->dev, "Cannot clear fault log\n");
> +
>  	if (pdata) {
>  		da9063->flags = pdata->flags;
>  		da9063->irq_base = pdata->irq_base;
> @@ -178,6 +232,7 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  	if (ret)
>  		dev_err(da9063->dev, "Cannot add MFD cells\n");
>  
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
> index 95c8742..612383b 100644
> --- a/include/linux/mfd/da9063/pdata.h
> +++ b/include/linux/mfd/da9063/pdata.h
> @@ -103,6 +103,7 @@ struct da9063;
>  struct da9063_pdata {
>  	int				(*init)(struct da9063 *da9063);
>  	int				irq_base;
> +	bool				key_power;
>  	unsigned			flags;
>  	struct da9063_regulators_pdata	*regulators_pdata;
>  	struct led_platform_data	*leds_pdata;
> -- 
> end-of-patch for RESEND PATCH V2
> 

-- 
Dmitry
