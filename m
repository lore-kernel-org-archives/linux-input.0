From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V1 4/6] input: misc: onkey: da9062: DA9062 OnKey driver
Date: Fri, 17 Apr 2015 09:12:17 -0700
Message-ID: <20150417161217.GA27440@dtor-ws>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <c05802897197e71839a33b1f5ac224031b14e65b.1429280614.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c05802897197e71839a33b1f5ac224031b14e65b.1429280614.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On Fri, Apr 17, 2015 at 03:23:33PM +0100, S Twiss wrote:
> From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> 
> Add OnKey driver support for DA9062
> 
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> 
> ---
> 
> This patch applies against linux-next and v4.0 
> 
> 
> 
>  drivers/input/misc/Kconfig        |  10 ++
>  drivers/input/misc/Makefile       |   1 +
>  drivers/input/misc/da9062-onkey.c | 223 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/input/misc/da9062-onkey.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 6deb8da..472ca38 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -586,6 +586,16 @@ config INPUT_DA9055_ONKEY
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called da9055_onkey.
>  
> +config INPUT_DA9062_ONKEY
> +	tristate "Dialog DA9062 OnKey"
> +	depends on MFD_DA9062
> +	help
> +	  Support the ONKEY of Dialog DA9062 Power Management IC as an
> +	  input device reporting power button status.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called da9062-onkey.
> +
>  config INPUT_DM355EVM
>  	tristate "TI DaVinci DM355 EVM Keypad and IR Remote"
>  	depends on MFD_DM355EVM_MSP
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 403a1a5..a631283 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
>  obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
>  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
>  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
> +obj-$(CONFIG_INPUT_DA9062_ONKEY)	+= da9062-onkey.o

Can we maybe keep the same naming convention for all of these? Also, any
chance all of them or some of them can be combined?

>  obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
>  obj-$(CONFIG_INPUT_E3X0_BUTTON)		+= e3x0-button.o
>  obj-$(CONFIG_INPUT_DRV260X_HAPTICS)	+= drv260x.o
> diff --git a/drivers/input/misc/da9062-onkey.c b/drivers/input/misc/da9062-onkey.c
> new file mode 100644
> index 0000000..c4c0295
> --- /dev/null
> +++ b/drivers/input/misc/da9062-onkey.c
> @@ -0,0 +1,223 @@
> +/*
> + * da9062-onkey.c - ONKEY device driver for DA9062
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
> +#include <linux/mfd/da9062/core.h>
> +#include <linux/mfd/da9062/registers.h>
> +
> +struct da9062_onkey {
> +	struct da9062 *hw;
> +	struct delayed_work work;
> +	struct	input_dev *input;
> +	int irq;
> +	bool key_power;
> +};
> +
> +static void da9062_poll_on(struct work_struct *work)
> +{
> +	struct da9062_onkey *onkey = container_of(work, struct da9062_onkey,
> +						  work.work);
> +	unsigned int val;
> +	int fault_log = 0;
> +	bool poll = true;
> +	int ret;
> +
> +	/* poll to see when the pin is released */
> +	ret = regmap_read(onkey->hw->regmap, DA9062AA_STATUS_A, &val);
> +	if (ret < 0) {
> +		dev_err(&onkey->input->dev,
> +			"Failed to read ON status: %d\n", ret);
> +		goto err_poll;
> +	}
> +
> +	if (!(val & DA9062AA_NONKEY_MASK)) {
> +		ret = regmap_update_bits(onkey->hw->regmap,
> +					 DA9062AA_CONTROL_B,
> +					 DA9062AA_NONKEY_LOCK_MASK, 0);
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
> +	 * then clear it and shutdown DA9062 via I2C
> +	 */
> +	ret = regmap_read(onkey->hw->regmap, DA9062AA_FAULT_LOG, &fault_log);
> +	if (ret < 0)
> +		dev_warn(&onkey->input->dev, "Cannot read FAULT_LOG\n");
> +
> +	if (fault_log & DA9062AA_KEY_RESET_MASK) {
> +		ret = regmap_write(onkey->hw->regmap,
> +				   DA9062AA_FAULT_LOG,
> +				   DA9062AA_KEY_RESET_MASK);
> +		if (ret < 0)
> +			dev_warn(&onkey->input->dev,
> +				 "Cannot reset KEY_RESET fault log\n");
> +		else {
> +			/* at this point we do any S/W housekeeping
> +			 * and then send shutdown command
> +			 */
> +			dev_info(&onkey->input->dev,
> +				 "Sending SHUTDOWN to DA9062 ...\n");
> +			ret = regmap_write(onkey->hw->regmap,
> +					   DA9062AA_CONTROL_F,
> +					   DA9062AA_SHUTDOWN_MASK);
> +			if (ret < 0)
> +				dev_err(&onkey->input->dev,
> +					"Cannot SHUTDOWN DA9062\n");
> +		}
> +	}

This entire block seems to not belong to the input portion of MFD. Why
do we do it here?

> +
> +err_poll:
> +	if (poll)
> +		schedule_delayed_work(&onkey->work, 50);
> +}
> +
> +static irqreturn_t da9062_onkey_irq_handler(int irq, void *data)
> +{
> +	struct da9062_onkey *onkey = data;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(onkey->hw->regmap, DA9062AA_STATUS_A, &val);
> +	if (onkey->key_power && (ret >= 0) && (val & DA9062AA_NONKEY_MASK)) {
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

Why do we handle KEY_POWER and KEY_SLEEP completely differently?

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int da9062_onkey_probe(struct platform_device *pdev)
> +{
> +	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
> +	struct da9062_onkey *onkey;
> +	bool kp_tmp = true;
> +	int ret = 0;
> +
> +		kp_tmp = of_property_read_bool((&pdev->dev)->of_node,
> +					       "dlg,disable-key-power");
> +		kp_tmp = !kp_tmp;

Should we just allow specifying the keycode instead of hardcoding
KEY_POWER/KEY_SLEEP?

> +
> +
> +	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9062_onkey),
> +			     GFP_KERNEL);
> +	if (!onkey) {
> +		dev_err(&pdev->dev, "Failed to allocate memory.\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	INIT_DELAYED_WORK(&onkey->work, da9062_poll_on);
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
> +				   da9062_onkey_irq_handler,
> +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +				   "ONKEY", onkey);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to request input device IRQ.\n");
> +		goto err;
> +	}
> +
> +	onkey->hw = chip;
> +	onkey->key_power = kp_tmp;
> +	onkey->input->evbit[0] = BIT_MASK(EV_KEY);
> +	onkey->input->name = "da9062-onkey";
> +	onkey->input->phys = "da9062-onkey/input0";
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
> +static int da9062_onkey_remove(struct platform_device *pdev)
> +{
> +	struct	da9062_onkey *onkey = platform_get_drvdata(pdev);
> +
> +	free_irq(onkey->irq, onkey);
> +	cancel_delayed_work_sync(&onkey->work);
> +	input_unregister_device(onkey->input);

No need to unregister explicitly if you allocated input device with
devm.

> +	return 0;
> +}
> +
> +static struct platform_driver da9062_onkey_driver = {
> +	.probe	= da9062_onkey_probe,
> +	.remove	= da9062_onkey_remove,
> +	.driver	= {
> +		.name	= "da9062-onkey",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(da9062_onkey_driver);
> +
> +MODULE_AUTHOR("S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_DESCRIPTION("ONKEY device driver for Dialog DA9062");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform: da9062-onkey");
> -- 
> end-of-patch for PATCH V1
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
