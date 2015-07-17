From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC V1 2/3] onkey: da9063: Add DA9062 OnKey capability to
 DA9063 OnKey driver
Date: Fri, 17 Jul 2015 15:50:42 -0700
Message-ID: <20150717225042.GF39282@dtor-ws>
References: <cover.1436879270.git.stwiss.opensource@diasemi.com>
 <37d843a776028807e94e513a34847a34d821bf81.1436879270.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <37d843a776028807e94e513a34847a34d821bf81.1436879270.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Steve,

On Tue, Jul 14, 2015 at 02:07:50PM +0100, S Twiss wrote:
> From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> 
> Add DA9062 OnKey support into the existing DA9063 OnKey driver component by
> using generic access tables for common register and bit mask definitions.
> 
> The following change will add generic register and bit mask support to the
> DA9063 OnKey.
> 
> The following alterations have been made to the DA9063 OnKey:
> 
> - Addition of a da9063_compatible_onkey_regmap structure to hold all
>   generic registers and bitmasks for this type of OnKey component.
> - Addition of an struct of_device_id table for DA9063 and DA9062
>   defaults
> - Refactoring functions to use struct da9063_compatible_onkey accesses
>   to generic registers/masks instead of using defines from registers.h
> - Re-work of da9063_onkey_probe() to use of_match_node() and
>   dev_get_regmap() to provide initialisation of generic registers and
>   masks and access to regmap
> 
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

Looks generally good, just a few comments.

> 
> ---
> Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
>  Kconfig                   total: 0 errors, 14 warnings, 810 lines checked
>  da9063_onkey.c            total: 0 errors, 2 warnings, 305 lines checked
> This patch applies against linux-next and next-20150708 
> 
> 
>  drivers/input/misc/Kconfig        |   6 +-
>  drivers/input/misc/da9063_onkey.c | 139 ++++++++++++++++++++++++++++++--------
>  2 files changed, 112 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index d4f0a81..42860f9 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -612,10 +612,10 @@ config INPUT_DA9055_ONKEY
>  
>  config INPUT_DA9063_ONKEY
>  	tristate "Dialog DA9063 OnKey"

"Dialog DA9062/63 OnKey" maybe?

> -	depends on MFD_DA9063
> +	depends on MFD_DA9063 || MFD_DA9062
>  	help
> -	  Support the ONKEY of Dialog DA9063 Power Management IC as an
> -	  input device reporting power button statue.
> +	  Support the ONKEY of Dialog DA9063 and DA9062 Power Management ICs
> +	  as an input device capable for reporting the power button status.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called da9063_onkey.
> diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
> index f577585..308de2e 100644
> --- a/drivers/input/misc/da9063_onkey.c
> +++ b/drivers/input/misc/da9063_onkey.c
> @@ -1,5 +1,5 @@
>  /*
> - * OnKey device driver for DA9063
> + * OnKey device driver for DA9063 and DA9062 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -24,36 +24,96 @@
>  #include <linux/mfd/da9063/core.h>
>  #include <linux/mfd/da9063/pdata.h>
>  #include <linux/mfd/da9063/registers.h>
> +#include <linux/mfd/da9062/core.h>
> +#include <linux/mfd/da9062/registers.h>
>  
> -struct da9063_onkey {
> -	struct da9063 *hw;
> +struct da9063_compatible_onkey_regmap {

Maybe call it da906x_chip_config?

> +	/* REGS */
> +	int onkey_status;
> +	int onkey_pwr_signalling;
> +	int onkey_fault_log;
> +	int onkey_shutdown;
> +	/* MASKS */
> +	int onkey_nonkey_mask;
> +	int onkey_nonkey_lock_mask;
> +	int onkey_key_reset_mask;
> +	int onkey_shutdown_mask;
> +	/* NAMES */
> +	char *name;

const char *?

> +};
> +
> +struct da9063_compatible_onkey {

If you did not rename the structure your diff would be smaller.

>  	struct delayed_work work;
>  	struct input_dev *input;
>  	struct device *dev;
> +	struct regmap *regmap;
> +	const struct da9063_compatible_onkey_regmap *config;
> +	char phys[32];
>  	bool key_power;
>  };
>  
> +static const struct da9063_compatible_onkey_regmap da9063_regs = {
> +	/* REGS */
> +	.onkey_status = DA9063_REG_STATUS_A,
> +	.onkey_pwr_signalling = DA9063_REG_CONTROL_B,
> +	.onkey_fault_log = DA9063_REG_FAULT_LOG,
> +	.onkey_shutdown = DA9063_REG_CONTROL_F,
> +	/* MASKS */
> +	.onkey_nonkey_mask = DA9063_NONKEY,
> +	.onkey_nonkey_lock_mask = DA9063_NONKEY_LOCK,
> +	.onkey_key_reset_mask = DA9063_KEY_RESET,
> +	.onkey_shutdown_mask = DA9063_SHUTDOWN,
> +	/* NAMES */
> +	.name = DA9063_DRVNAME_ONKEY,
> +};
> +
> +static const struct da9063_compatible_onkey_regmap da9062_regs = {
> +	/* REGS */
> +	.onkey_status = DA9062AA_STATUS_A,
> +	.onkey_pwr_signalling = DA9062AA_CONTROL_B,
> +	.onkey_fault_log = DA9062AA_FAULT_LOG,
> +	.onkey_shutdown = DA9062AA_CONTROL_F,
> +	/* MASKS */
> +	.onkey_nonkey_mask = DA9062AA_NONKEY_MASK,
> +	.onkey_nonkey_lock_mask = DA9062AA_NONKEY_LOCK_MASK,
> +	.onkey_key_reset_mask = DA9062AA_KEY_RESET_MASK,
> +	.onkey_shutdown_mask = DA9062AA_SHUTDOWN_MASK,
> +	/* NAMES */
> +	.name = "da9062-onkey",
> +};
> +
> +static const struct of_device_id da9063_compatible_reg_id_table[] = {
> +	{ .compatible = "dlg,da9063-onkey", .data = &da9063_regs },
> +	{ .compatible = "dlg,da9062-onkey", .data = &da9062_regs },
> +	{ },
> +};
> +
>  static void da9063_poll_on(struct work_struct *work)
>  {
> -	struct da9063_onkey *onkey = container_of(work, struct da9063_onkey,
> -						  work.work);
> +	struct da9063_compatible_onkey *onkey = container_of(work,
> +						struct da9063_compatible_onkey,
> +						work.work);
> +	const struct da9063_compatible_onkey_regmap *config = onkey->config;
>  	unsigned int val;
>  	int fault_log = 0;
>  	bool poll = true;
>  	int error;
>  
>  	/* Poll to see when the pin is released */
> -	error = regmap_read(onkey->hw->regmap, DA9063_REG_STATUS_A, &val);
> +	error = regmap_read(onkey->regmap,
> +			    config->onkey_status,
> +			    &val);
>  	if (error) {
>  		dev_err(onkey->dev,
>  			"Failed to read ON status: %d\n", error);
>  		goto err_poll;
>  	}
>  
> -	if (!(val & DA9063_NONKEY)) {
> -		error = regmap_update_bits(onkey->hw->regmap,
> -					   DA9063_REG_CONTROL_B,
> -					   DA9063_NONKEY_LOCK, 0);
> +	if (!(val & config->onkey_nonkey_mask)) {
> +		error = regmap_update_bits(onkey->regmap,
> +					   config->onkey_pwr_signalling,
> +					   config->onkey_nonkey_lock_mask,
> +					   0);
>  		if (error) {
>  			dev_err(onkey->dev,
>  				"Failed to reset the Key Delay %d\n", error);
> @@ -70,15 +130,16 @@ static void da9063_poll_on(struct work_struct *work)
>  	 * If the fault log KEY_RESET is detected, then clear it
>  	 * and shut down the system.
>  	 */
> -	error = regmap_read(onkey->hw->regmap,
> -			    DA9063_REG_FAULT_LOG, &fault_log);
> +	error = regmap_read(onkey->regmap,
> +			    config->onkey_fault_log,
> +			    &fault_log);
>  	if (error) {
>  		dev_warn(&onkey->input->dev,
>  			 "Cannot read FAULT_LOG: %d\n", error);
> -	} else if (fault_log & DA9063_KEY_RESET) {
> -		error = regmap_write(onkey->hw->regmap,
> -				     DA9063_REG_FAULT_LOG,
> -				     DA9063_KEY_RESET);
> +	} else if (fault_log & config->onkey_key_reset_mask) {
> +		error = regmap_write(onkey->regmap,
> +				     config->onkey_fault_log,
> +				     config->onkey_key_reset_mask);
>  		if (error) {
>  			dev_warn(&onkey->input->dev,
>  				 "Cannot reset KEY_RESET fault log: %d\n",
> @@ -88,10 +149,10 @@ static void da9063_poll_on(struct work_struct *work)
>  			 * and then send shutdown command
>  			 */
>  			dev_dbg(&onkey->input->dev,
> -				 "Sending SHUTDOWN to DA9063 ...\n");
> -			error = regmap_write(onkey->hw->regmap,
> -					     DA9063_REG_CONTROL_F,
> -					     DA9063_SHUTDOWN);
> +				"Sending SHUTDOWN to DA9063 ...\n");
> +			error = regmap_write(onkey->regmap,
> +					     config->onkey_shutdown,
> +					     config->onkey_shutdown_mask);
>  			if (error)
>  				dev_err(&onkey->input->dev,
>  					"Cannot SHUTDOWN DA9063: %d\n",
> @@ -106,12 +167,15 @@ err_poll:
>  
>  static irqreturn_t da9063_onkey_irq_handler(int irq, void *data)
>  {
> -	struct da9063_onkey *onkey = data;
> +	struct da9063_compatible_onkey *onkey = data;
> +	const struct da9063_compatible_onkey_regmap *config = onkey->config;
>  	unsigned int val;
>  	int error;
>  
> -	error = regmap_read(onkey->hw->regmap, DA9063_REG_STATUS_A, &val);
> -	if (onkey->key_power && !error && (val & DA9063_NONKEY)) {
> +	error = regmap_read(onkey->regmap,
> +			    config->onkey_status,
> +			    &val);
> +	if (onkey->key_power && !error && (val & config->onkey_nonkey_mask)) {
>  		input_report_key(onkey->input, KEY_POWER, 1);
>  		input_sync(onkey->input);
>  		schedule_delayed_work(&onkey->work, 0);
> @@ -129,7 +193,7 @@ static irqreturn_t da9063_onkey_irq_handler(int irq, void *data)
>  
>  static void da9063_cancel_poll(void *data)
>  {
> -	struct da9063_onkey *onkey = data;
> +	struct da9063_compatible_onkey *onkey = data;
>  
>  	cancel_delayed_work_sync(&onkey->work);
>  }
> @@ -138,19 +202,31 @@ static int da9063_onkey_probe(struct platform_device *pdev)
>  {
>  	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
>  	struct da9063_pdata *pdata = dev_get_platdata(da9063->dev);
> -	struct da9063_onkey *onkey;
> +	struct da9063_compatible_onkey *onkey;
> +	const struct of_device_id *match;
>  	int irq;
>  	int error;
>  
> -	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_onkey),
> +	match = of_match_node(da9063_compatible_reg_id_table,
> +			      pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
> +
> +	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_compatible_onkey),
>  			     GFP_KERNEL);
>  	if (!onkey) {
>  		dev_err(&pdev->dev, "Failed to allocate memory.\n");
>  		return -ENOMEM;
>  	}
>  
> +	onkey->config = match->data;
>  	onkey->dev = &pdev->dev;
> -	onkey->hw = da9063;
> +
> +	onkey->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!onkey->regmap) {
> +		dev_err(&pdev->dev, "Parent regmap unavailable.\n");
> +		return -ENXIO;
> +	}
>  
>  	if (pdata)
>  		onkey->key_power = pdata->key_power;
> @@ -165,8 +241,10 @@ static int da9063_onkey_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	onkey->input->name = DA9063_DRVNAME_ONKEY;
> -	onkey->input->phys = DA9063_DRVNAME_ONKEY "/input0";
> +	onkey->input->name = onkey->config->name;
> +	snprintf(onkey->phys, sizeof(onkey->phys), "%s/input0",
> +		 onkey->config->name);
> +	onkey->input->phys = onkey->phys;
>  	onkey->input->dev.parent = &pdev->dev;
>  
>  	if (onkey->key_power)
> @@ -216,11 +294,12 @@ static struct platform_driver da9063_onkey_driver = {
>  	.probe	= da9063_onkey_probe,
>  	.driver	= {
>  		.name	= DA9063_DRVNAME_ONKEY,
> +		.of_match_table = da9063_compatible_reg_id_table,
>  	},
>  };
>  module_platform_driver(da9063_onkey_driver);
>  
>  MODULE_AUTHOR("S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>");
> -MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063");
> +MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063 and DA9062");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:" DA9063_DRVNAME_ONKEY);
> -- 
> end-of-patch for PATCH RFC V1
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
