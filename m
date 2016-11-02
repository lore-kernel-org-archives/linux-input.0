From: Lukasz Luba <lukasz.luba-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V3 8/9] thermal: da9062/61: Thermal junction temperature
 monitoring driver
Date: Wed, 2 Nov 2016 13:28:35 +0000
Message-ID: <b5789f09-0053-f0fc-ee35-c8c32969852b@arm.com>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
 <52d74c72cc445d2bc911014f38b79c1f10426878.1477929725.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52d74c72cc445d2bc911014f38b79c1f10426878.1477929725.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Steve,

Please find my comments below.

Apart from these 2 comments, 10sec is not to long
(waiting for the temperature change)?

On 31/10/16 16:02, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> Add junction temperature monitoring supervisor device driver, compatible
> with the DA9062 and DA9061 PMICs. A MODULE_DEVICE_TABLE() macro is added.
>
> If the PMIC's internal junction temperature rises above TEMP_WARN (125
> degC) an interrupt is issued. This TEMP_WARN level is defined as the
> THERMAL_TRIP_HOT trip-wire inside the device driver.
>
> The thermal triggering mechanism is interrupt based and happens when the
> temperature rises above a given threshold level. The component cannot
> return an exact temperature, it only has knowledge if the temperature is
> above or below a given threshold value. A status bit must be polled to
> detect when the temperature falls below that threshold level again. A
> kernel work queue is configured to repeatedly poll and detect when the
> temperature falls below this trip-wire, between 1 and 10 second intervals
> (defaulting at 3 seconds).
>
> This first level of temperature supervision is intended for non-invasive
> temperature control, where the necessary measures for cooling the system
> down are left to the host software.
>
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> ---
> This patch applies against linux-next and v4.8
>
> v2 -> v3
>  - Patch renamed from [PATCH V2 09/10] to [PATCH V3 8/9]
>  - Addition of MODULE_DEVICE_TABLE macro to allow modinfo additions
>
> v1 -> v2
>  - Patch renamed from [PATCH V1 05/10] to [PATCH V2 09/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - List the header files in alphabetical order
>  - Remove "GPL v2" and replace with MODULE_LICENSE("GPL") to match the
>    copyright "GNU Public License v2 or later" option in the header
>    comment for this file. See the allowed identifiers in the file
>    include/linux/module.h +170
>  - Remove notify function "da9062_thermal_notify" function.
>  - MODULE_AUTHOR() macros removes Company Name and just gives Name in
>    accordance with include/linux/module.h +200
>  - Remove the compatible "dlg,da9061-thermal" option in the of_device_id
>    struct table. This patch now assumes the use of a DA9062 fallback
>    compatible string in the DTS when using the DA9061 thermal component
>    of the DA9061 device.
>  - Re-ordered some assignments earlier in the probe() for thermal->hw,
>    thermal->polling_period, thermal->mode, thermal->dev
>  - Added further information in the patch description to explain the use
>    of the device driver's built-in work-queue.
>
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
>
>
>  drivers/thermal/Kconfig          |  10 ++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/da9062-thermal.c | 291 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 302 insertions(+)
>  create mode 100644 drivers/thermal/da9062-thermal.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 2d702ca..da58e54 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -272,6 +272,16 @@ config DB8500_CPUFREQ_COOLING
>  	  bound cpufreq cooling device turns active to set CPU frequency low to
>  	  cool down the CPU.
>
> +config DA9062_THERMAL
> +	tristate "DA9062/DA9061 Dialog Semiconductor thermal driver"
> +	depends on MFD_DA9062
> +	depends on OF
> +	help
> +	  Enable this for the Dialog Semiconductor thermal sensor driver.
> +	  This will report PMIC junction over-temperature for one thermal trip
> +	  zone.
> +	  Compatible with the DA9062 and DA9061 PMICs.
> +
>  config INTEL_POWERCLAMP
>  	tristate "Intel PowerClamp idle injection driver"
>  	depends on THERMAL
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 10b07c1..0a2b3f2 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
>  obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
>  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
> +obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
>  obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
>  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
>  obj-$(CONFIG_INTEL_SOC_DTS_IOSF_CORE)	+= intel_soc_dts_iosf.o
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
> new file mode 100644
> index 0000000..1f0af22
> --- /dev/null
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -0,0 +1,291 @@
> +/*
> + * Thermal device driver for DA9062 and DA9061
> + * Copyright (C) 2016  Dialog Semiconductor Ltd.
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
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/mfd/da9062/core.h>
> +#include <linux/mfd/da9062/registers.h>
> +
> +#define DA9062_DEFAULT_POLLING_MS_PERIOD	3000
> +#define DA9062_MAX_POLLING_MS_PERIOD		10000
> +#define DA9062_MIN_POLLING_MS_PERIOD		1000
> +
> +#define DA9062_MILLI_CELSIUS(t)			((t)*1000)
> +
> +struct da9062_thermal_config {
> +	const char *name;
> +};
> +
> +struct da9062_thermal {
> +	struct da9062 *hw;
> +	struct delayed_work work;
> +	struct thermal_zone_device *zone;
> +	enum thermal_device_mode mode;
> +	unsigned int polling_period;
> +	struct mutex lock;
> +	int temperature;
> +	int irq;
> +	const struct da9062_thermal_config *config;
> +	struct device *dev;
> +};
> +
> +static void da9062_thermal_poll_on(struct work_struct *work)
> +{
> +	struct da9062_thermal *thermal = container_of(work,
> +						struct da9062_thermal,
> +						work.work);
> +	unsigned int val;
> +	int ret;
> +
> +	/* clear E_TEMP */
> +	ret = regmap_write(thermal->hw->regmap,
> +				DA9062AA_EVENT_B,
> +				DA9062AA_E_TEMP_MASK);
> +	if (ret < 0) {
> +		dev_err(thermal->dev,
> +			"Cannot clear the TJUNC temperature status\n");
> +		goto err_enable_irq;
> +	}
> +
> +	/* Now read E_TEMP again: it is acting like a status bit.
> +	 * If over-temperature, then this status will be true.
> +	 * If not over-temperature, this status will be false.
> +	 */
> +	ret = regmap_read(thermal->hw->regmap,
> +			  DA9062AA_EVENT_B,
> +			  &val);
> +	if (ret < 0) {
> +		dev_err(thermal->dev,
> +			"Cannot check the TJUNC temperature status\n");
> +		goto err_enable_irq;
> +	} else {
> +		if (val & DA9062AA_E_TEMP_MASK) {
> +			mutex_lock(&thermal->lock);
> +			thermal->temperature = DA9062_MILLI_CELSIUS(125);
> +			mutex_unlock(&thermal->lock);
> +			thermal_zone_device_update(thermal->zone);
> +
> +			schedule_delayed_work(&thermal->work,
> +				msecs_to_jiffies(thermal->polling_period));
> +			return;
> +		} else {
> +			mutex_lock(&thermal->lock);
> +			thermal->temperature = DA9062_MILLI_CELSIUS(0);
> +			mutex_unlock(&thermal->lock);
> +			thermal_zone_device_update(thermal->zone);
> +		}
> +	}
> +
> +err_enable_irq:
> +	enable_irq(thermal->irq);
> +}
> +
> +static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
> +{
> +	struct da9062_thermal *thermal = data;
> +
> +	disable_irq_nosync(thermal->irq);
> +	schedule_delayed_work(&thermal->work, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int da9062_thermal_get_mode(struct thermal_zone_device *z,
> +				   enum thermal_device_mode *mode)
> +{
> +	struct da9062_thermal *thermal = z->devdata;
> +	*mode = thermal->mode;
> +	return 0;
> +}
> +
> +static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
> +				int trip,
> +				enum thermal_trip_type *type)
> +{
> +	struct da9062_thermal *thermal = z->devdata;
> +
> +	switch (trip) {
> +	case 0:
> +		*type = THERMAL_TRIP_HOT;
> +		break;
> +	default:
> +		dev_err(thermal->dev,
> +			"Driver does not support more than 1 trip-wire\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int da9062_thermal_get_trip_temp(struct thermal_zone_device *z,
> +					int trip,
> +					int *temp)
> +{
> +	struct da9062_thermal *thermal = z->devdata;
> +
> +	switch (trip) {
> +	case 0:
> +		*temp = DA9062_MILLI_CELSIUS(125);
> +		break;
> +	default:
> +		dev_err(thermal->dev,
> +			"Driver does not support more than 1 trip-wire\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int da9062_thermal_get_temp(struct thermal_zone_device *z,
> +				   int *temp)
> +{
> +	struct da9062_thermal *thermal = z->devdata;
> +
> +	mutex_lock(&thermal->lock);
> +	*temp = thermal->temperature;
> +	mutex_unlock(&thermal->lock);
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_device_ops da9062_thermal_ops = {
> +	.get_temp	= da9062_thermal_get_temp,
> +	.get_mode	= da9062_thermal_get_mode,
> +	.get_trip_type	= da9062_thermal_get_trip_type,
> +	.get_trip_temp	= da9062_thermal_get_trip_temp,
> +};
> +
> +static const struct da9062_thermal_config da9062_config = {
> +	.name = "da9062-thermal",
> +};
> +
> +static const struct of_device_id da9062_compatible_reg_id_table[] = {
> +	{ .compatible = "dlg,da9062-thermal", .data = &da9062_config },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, da9062_compatible_reg_id_table);
> +
> +static int da9062_thermal_probe(struct platform_device *pdev)
> +{
> +	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
> +	struct da9062_thermal *thermal;
> +	unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
> +	const struct of_device_id *match;
> +	int ret = 0;
> +
> +	match = of_match_node(da9062_compatible_reg_id_table,
> +			      pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
> +
> +	if (pdev->dev.of_node) {
> +		if (!of_property_read_u32(pdev->dev.of_node,
> +					"dlg,tjunc-temp-polling-period-ms",
> +					&pp_tmp)) {
> +			if (pp_tmp < DA9062_MIN_POLLING_MS_PERIOD ||
> +				pp_tmp > DA9062_MAX_POLLING_MS_PERIOD)
> +				pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
Maybe it's worth to add some print here just to mention about
the DT value out of range. When you saw a dmesg with
this print on some bug report, you would know about wrong DT entry
(even if debug was not set).
> +		}
> +
> +		dev_dbg(&pdev->dev,
> +			 "TJUNC temp polling period set at %d ms\n",
> +			 pp_tmp);
> +	}
> +
> +	thermal = devm_kzalloc(&pdev->dev, sizeof(struct da9062_thermal),
> +			     GFP_KERNEL);
> +	if (!thermal) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	thermal->config = match->data;
> +	thermal->hw = chip;
> +	thermal->polling_period = pp_tmp;
> +	thermal->mode = THERMAL_DEVICE_ENABLED;
> +	thermal->dev = &pdev->dev;
> +
> +	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
> +	mutex_init(&thermal->lock);
> +
> +	thermal->zone = thermal_zone_device_register(thermal->config->name,
> +					1, 0, thermal,
> +					&da9062_thermal_ops, NULL, 0,
> +					0);
> +	if (IS_ERR(thermal->zone)) {
> +		dev_err(&pdev->dev, "Cannot register thermal zone device\n");
> +		ret = PTR_ERR(thermal->zone);
> +		goto err;
> +	}
> +
> +	ret = platform_get_irq_byname(pdev, "THERMAL");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to get platform IRQ.\n");
> +		goto err_zone;
> +	}
> +	thermal->irq = ret;
> +
> +	ret = request_threaded_irq(thermal->irq, NULL,
> +				   da9062_thermal_irq_handler,
> +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +				   "THERMAL", thermal);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to request thermal device IRQ.\n");
> +		goto err_zone;
> +	}
> +
> +	platform_set_drvdata(pdev, thermal);
> +	return 0;
> +
> +err_zone:
> +	thermal_zone_device_unregister(thermal->zone);
> +err:
> +	return ret;
> +}
> +
> +static int da9062_thermal_remove(struct platform_device *pdev)
> +{
> +	struct	da9062_thermal *thermal = platform_get_drvdata(pdev);
> +
> +	free_irq(thermal->irq, thermal);
> +	thermal_zone_device_unregister(thermal->zone);
> +	cancel_delayed_work_sync(&thermal->work);
You should change the order for these two functions
and cancel the work before unregistering thermal zone device.

> +	return 0;
> +}
> +
> +static struct platform_driver da9062_thermal_driver = {
> +	.probe	= da9062_thermal_probe,
> +	.remove	= da9062_thermal_remove,
> +	.driver	= {
> +		.name	= "da9062-thermal",
> +		.of_match_table = da9062_compatible_reg_id_table,
> +	},
> +};
> +
> +module_platform_driver(da9062_thermal_driver);
> +
> +MODULE_AUTHOR("Steve Twiss");
> +MODULE_DESCRIPTION("Thermal TJUNC device driver for Dialog DA9062 and DA9061");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:da9062-thermal");
>

Regards,
Lukasz Luba
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
