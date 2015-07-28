From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings for
 DA9062 OnKey
Date: Tue, 28 Jul 2015 07:42:42 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B25C554@SW-EX-MBX02.diasemi.com>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws> <20150728054024.GA4558@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.147]:25594 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754458AbbG1Hmu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 03:42:50 -0400
In-Reply-To: <20150728054024.GA4558@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>

On 28 July 2015 06:40, Dmitry Torokhov wrote:

> Subject: Re: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings for DA9062 OnKey
> 
> On Mon, Jul 27, 2015 at 03:43:00PM -0700, Dmitry Torokhov wrote:
> > On Thu, Jul 23, 2015 at 05:17:41PM +0100, S Twiss wrote:
> > > From: S Twiss <stwiss.opensource@diasemi.com>
> > >
> > > Add device tree bindings for the DA9062 OnKey driver component
> > >
> > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > > ---
> > > This patch applies against linux-next and next-20150708
> > >
> > >
> > >  .../devicetree/bindings/input/da9062-onkey.txt     | 36
> ++++++++++++++++++++++
> > >  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++
> >
> > I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
> > 9063, folded into the onkey patch and applied.
> 
> Argh, da9062 core is not in mainline yet... OK, below is the patch I
> had; if Lee does not pick it up I'll re-apply it when da9062 core hits
> mainline.
> 
> Thanks.
> --
> Dmitry

Thanks Dmitry,
The DA9062 core has been in linux-next for a couple of weeks now I think.

Hi Lee,
I'm not certain of the procedure with this: the DA9062 core is in linux-next/next-2015mmdd 
but has not yet made it to a mainline/v4.2-rcX so I guess it's not getting picked up for some other
patches I have submitted for the DA9062 OnKey and RTC -- actually you already know about
those two patch threads because you reviewed the MFD and DT parts last week!
Oh well -- I guess I have drawn your attention to this anyway, I'm just not certain of the 
timeline on this because it's something I've not done before.

Regards,
Stephen

> Input: add DA9062 OnKey capability to DA9063 OnKey driver
> 
> From: S Twiss <stwiss.opensource@diasemi.com>
> 
> Add DA9062 OnKey support into the existing DA9063 OnKey driver
> component by
> using generic access tables for common register and bit mask definitions.
> 
> The following change will add generic register and bit mask support to the
> DA9063 OnKey.
> 
> The following alterations have been made to the DA9063 OnKey:
> 
> - Addition of a da906x_chip_config structure to hold all
>   generic registers and bitmasks for this type of OnKey component.
> - Addition of an struct of_device_id table for DA9063 and DA9062
>   defaults
> - Refactoring functions to use struct da9063_onkey accesses to generic
>   registers/masks instead of using defines from registers.h
> - Re-work of da9063_onkey_probe() to use of_match_node() and
>   dev_get_regmap() to provide initialisation of generic registers and
>   masks and access to regmap
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  .../devicetree/bindings/input/da9062-onkey.txt     |   32 +++++
>  drivers/input/misc/Kconfig                         |    8 +
>  drivers/input/misc/da9063_onkey.c                  |  129 ++++++++++++++++----
>  3 files changed, 140 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/da9062-
> onkey.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/da9062-onkey.txt
> b/Documentation/devicetree/bindings/input/da9062-onkey.txt
> new file mode 100644
> index 0000000..ab0e048
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/da9062-onkey.txt
> @@ -0,0 +1,32 @@
> +* Dialog DA9062/63 OnKey Module
> +
> +This module is part of the DA9062/DA9063. For more details about entire
> +chips see Documentation/devicetree/bindings/mfd/da9062.txt and
> +Documentation/devicetree/bindings/mfd/da9063.txt
> +
> +This module provides KEY_POWER, KEY_SLEEP and events.
> +
> +Required properties:
> +
> +  - compatible: should be one of:
> +	dlg,da9062-onkey
> +	dlg,da9063-onkey
> +
> +Optional properties:
> +
> +  - dlg,disable-key-power : Disable power-down using a long key-press. If
> this
> +    entry exists the OnKey driver will remove support for the KEY_POWER
> key
> +    press. If this entry does not exist then by default the key-press
> +    triggered power down is enabled and the OnKey will support both
> KEY_POWER
> +    and KEY_SLEEP.
> +
> +Example:
> +
> +	pmic0: da9062@58 {
> +
> +		onkey {
> +			compatible = "dlg,da9063-onkey";
> +			dlg,disable-key-power;
> +		};
> +
> +	};
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index d4f0a81..d4b993d 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -611,11 +611,11 @@ config INPUT_DA9055_ONKEY
>  	  will be called da9055_onkey.
> 
>  config INPUT_DA9063_ONKEY
> -	tristate "Dialog DA9063 OnKey"
> -	depends on MFD_DA9063
> +	tristate "Dialog DA9062/63 OnKey"
> +	depends on MFD_DA9063 || MFD_DA9062
>  	help
> -	  Support the ONKEY of Dialog DA9063 Power Management IC as an
> -	  input device reporting power button statue.
> +	  Support the ONKEY of Dialog DA9063 and DA9062 Power
> Management ICs
> +	  as an input device capable of reporting the power button status.
> 
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called da9063_onkey.
> diff --git a/drivers/input/misc/da9063_onkey.c
> b/drivers/input/misc/da9063_onkey.c
> index f577585..8eb697d 100644
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
> +
> +struct da906x_chip_config {
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
> +	const char *name;
> +};
> 
>  struct da9063_onkey {
> -	struct da9063 *hw;
>  	struct delayed_work work;
>  	struct input_dev *input;
>  	struct device *dev;
> +	struct regmap *regmap;
> +	const struct da906x_chip_config *config;
> +	char phys[32];
>  	bool key_power;
>  };
> 
> +static const struct da906x_chip_config da9063_regs = {
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
> +static const struct da906x_chip_config da9062_regs = {
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
> -	struct da9063_onkey *onkey = container_of(work, struct
> da9063_onkey,
> -						  work.work);
> +	struct da9063_onkey *onkey = container_of(work,
> +						struct da9063_onkey,
> +						work.work);
> +	const struct da906x_chip_config *config = onkey->config;
>  	unsigned int val;
>  	int fault_log = 0;
>  	bool poll = true;
>  	int error;
> 
>  	/* Poll to see when the pin is released */
> -	error = regmap_read(onkey->hw->regmap,
> DA9063_REG_STATUS_A, &val);
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
> @@ -70,15 +130,16 @@ static void da9063_poll_on(struct work_struct
> *work)
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
> @@ -88,10 +149,10 @@ static void da9063_poll_on(struct work_struct
> *work)
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
> @@ -107,11 +168,14 @@ err_poll:
>  static irqreturn_t da9063_onkey_irq_handler(int irq, void *data)
>  {
>  	struct da9063_onkey *onkey = data;
> +	const struct da906x_chip_config *config = onkey->config;
>  	unsigned int val;
>  	int error;
> 
> -	error = regmap_read(onkey->hw->regmap,
> DA9063_REG_STATUS_A, &val);
> -	if (onkey->key_power && !error && (val & DA9063_NONKEY)) {
> +	error = regmap_read(onkey->regmap,
> +			    config->onkey_status,
> +			    &val);
> +	if (onkey->key_power && !error && (val & config-
> >onkey_nonkey_mask)) {
>  		input_report_key(onkey->input, KEY_POWER, 1);
>  		input_sync(onkey->input);
>  		schedule_delayed_work(&onkey->work, 0);
> @@ -139,9 +203,15 @@ static int da9063_onkey_probe(struct
> platform_device *pdev)
>  	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
>  	struct da9063_pdata *pdata = dev_get_platdata(da9063->dev);
>  	struct da9063_onkey *onkey;
> +	const struct of_device_id *match;
>  	int irq;
>  	int error;
> 
> +	match = of_match_node(da9063_compatible_reg_id_table,
> +			      pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
> +
>  	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_onkey),
>  			     GFP_KERNEL);
>  	if (!onkey) {
> @@ -149,8 +219,14 @@ static int da9063_onkey_probe(struct
> platform_device *pdev)
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
> @@ -165,8 +241,10 @@ static int da9063_onkey_probe(struct
> platform_device *pdev)
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
> @@ -216,11 +294,12 @@ static struct platform_driver da9063_onkey_driver
> = {
>  	.probe	= da9063_onkey_probe,
>  	.driver	= {
>  		.name	= DA9063_DRVNAME_ONKEY,
> +		.of_match_table = da9063_compatible_reg_id_table,
>  	},
>  };
>  module_platform_driver(da9063_onkey_driver);
> 
>  MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
> -MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063");
> +MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063 and
> DA9062");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:" DA9063_DRVNAME_ONKEY);
