From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V1 05/10] thermal: da9062/61: Thermal junction temperature
 monitoring driver
Date: Fri, 7 Oct 2016 10:58:59 +0530
Message-ID: <3bc9fd76-2885-b07a-9df8-7802b7535da2@ti.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <b5ce58ca00f7ab30a025d24083549241f135b0e9.1475743411.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b5ce58ca00f7ab30a025d24083549241f135b0e9.1475743411.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Steve,

On Thursday 06 October 2016 02:13 PM, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> Add junction temperature monitoring supervisor device driver, compatible
> with the DA9062 and DA9061 PMICs.
>
> If the PMIC's internal junction temperature rises above TEMP_WARN (125
> degC) an interrupt is issued. This TEMP_WARN level is defined as the
> THERMAL_TRIP_HOT trip-wire inside the device driver. A kernel work queue
> is configured to repeatedly poll this temperature trip-wire, between 1 and
> 10 second intervals (defaulting at 3 seconds).
>
> This first level of temperature supervision is intended for non-invasive
> temperature control, where the necessary measures for cooling the system
> down are left to the host software. In this case, inside the thermal
> notification function da9062_thermal_notify().
>
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> ---
> This patch applies against linux-next and v4.8
>
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
>
>
>  drivers/thermal/Kconfig          |  10 ++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/da9062-thermal.c | 313 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 324 insertions(+)
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
> index 0000000..feeabf6
> --- /dev/null
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -0,0 +1,313 @@
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
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +#include <linux/of.h>
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
> +	 * If not over-temperature, this staus will be false.
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

125C is pretty hot. Just a suggestion, do look at THERMAL_TRIP_CRITICAL.

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
> +static int da9062_thermal_notify(struct thermal_zone_device *z,
> +				 int trip,
> +				 enum thermal_trip_type type)
> +{
> +	struct da9062_thermal *thermal = z->devdata;
> +
> +	switch (type) {
> +	case THERMAL_TRIP_HOT:
> +		dev_warn(thermal->dev, "Reached HOT (125degC) temperature\n");

Any cooling action? What is done once you reach this high temperature?

> +		break;
> +	default:
> +		break;
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
> +	.notify		= da9062_thermal_notify,
> +};
> +
> +static const struct da9062_thermal_config da9062_config = {
> +	.name = "da9062-thermal",
> +};
> +
> +static const struct da9062_thermal_config da9061_config = {
> +	.name = "da9061-thermal",
> +};
> +
> +static const struct of_device_id da9062_compatible_reg_id_table[] = {
> +	{ .compatible = "dlg,da9062-thermal", .data = &da9062_config },
> +	{ .compatible = "dlg,da9061-thermal", .data = &da9061_config },

Two separate compatible values. Do you have anything different apart 
from the name? Why use 2 compatibles when there is absolutely no difference?

> +	{ },
> +};
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
> +
> +	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
> +	mutex_init(&thermal->lock);

thermal_zone_device_register itself does
INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);

refer: drivers/thermal/thermal_core.c

It does a periodic monitoring of the temperature as well. Do you really 
want to have an additional work for monitoring temperature in your 
driver also?

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
> +	thermal->hw = chip;
> +	thermal->polling_period = pp_tmp;
> +	thermal->mode = THERMAL_DEVICE_ENABLED;
> +	thermal->dev = &pdev->dev;
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
> +MODULE_AUTHOR("Steve Twiss, Dialog Semiconductor");
> +MODULE_DESCRIPTION("Thermal TJUNC device driver for Dialog DA9062 and DA9061");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:da9062-thermal");
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
