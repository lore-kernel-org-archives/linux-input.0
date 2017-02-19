From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RESEND PATCH V5 7/8] thermal: da9062/61: Thermal junction
 temperature monitoring driver
Date: Sat, 18 Feb 2017 17:40:10 -0800
Message-ID: <20170219014007.GA20845@localhost.localdomain>
References: <cover.1486026227.git.stwiss.opensource@diasemi.com>
 <6a1a651530fdaedd3e380aa33749ca5fce1a80a8.1486026227.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a1a651530fdaedd3e380aa33749ca5fce1a80a8.1486026227.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

Steve,

On Thu, Feb 02, 2017 at 09:03:47AM +0000, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Add junction temperature monitoring supervisor device driver, compatible
> with the DA9062 and DA9061 PMICs. A MODULE_DEVICE_TABLE() macro is added.
> 
> If the PMIC's internal junction temperature rises above T_WARN (125 degC)
> an interrupt is issued. This T_WARN level is defined as the
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
> This scheme is provided as an example. It would be expected that any
> final implementation will also include a notify() function and any of these
> settings could be altered to match the application where appropriate.
> 
> When over-temperature is reached, the interrupt from the DA9061/2 will be
> repeatedly triggered. The IRQ is therefore disabled when the first
> over-temperature event happens and the status bit is polled using a
> work-queue until it becomes false.
> 
> This strategy is designed to allow the periodic transmission of uevents
> (HOT trip point) as the first level of temperature supervision method. It
> is intended for non-invasive temperature control, where the necessary
> measures for cooling the system down are left to the host software. Once
> the temperature falls again, the IRQ is re-enabled so a new critical
> over-temperature event can be detected.
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 

Apologize for the very late answer on your driver. I still have few
minor requests, please check then:


> ---
> This patch applies against linux-next and v4.9
> 
> v4 -> v5
>  - Rebased from v4.8 to v4.9
>  - Updates from comments by Eduardo Valentin
>  - Replace vendor defined dlg,tjunc-temp-polling-period-ms with standard
>    thermal core polling-delay-passive as part of the device tree
>    initialisation
>  - Change to the commit message content and device driver source code to
>    include an explanation of the repeated uevent strategy for monitoring
>    over-temperature
>  - Rename warning threshold name from TEMP_WARN to T_WARN to match the
>    latest datasheet naming convention
>  - Added reviewed-by Lukasz Luba to commit message
> 
> v3 -> v4
>  - Patch renamed from [PATCH V3 8/9] to [PATCH V4 7/8]
>  - Reordering of cancel_delayed_work_sync() in remove function
>  - dev_warn() message for out-of-range polling period requests
>  - Explanatory comment for expected values defined for
>    DEFAULT_POLLING_MS_PERIOD, MAX_POLLING_MS_PERIOD and
>    MIN_POLLING_MS_PERIOD
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
>  drivers/thermal/da9062-thermal.c | 314 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 325 insertions(+)
>  create mode 100644 drivers/thermal/da9062-thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index a13541b..400d15c 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -292,6 +292,16 @@ config DB8500_CPUFREQ_COOLING
>  	  bound cpufreq cooling device turns active to set CPU frequency low to
>  	  cool down the CPU.
>  
> +config DA9062_THERMAL
> +	tristate "DA9062/DA9061 Dialog Semiconductor thermal driver"
> +	depends on MFD_DA9062

I see no reason why this driver cannot have the COMPILE_TEST flag.
Tested myself here so:

+	depends on MFD_DA9062 || COMPILE_TEST

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
> index c92eb22..f7783b3 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
>  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
>  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
> +obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
>  obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
>  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
>  obj-$(CONFIG_INTEL_SOC_DTS_IOSF_CORE)	+= intel_soc_dts_iosf.o
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
> new file mode 100644
> index 0000000..52a095d
> --- /dev/null
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -0,0 +1,314 @@
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
> +/* When over-temperature is reached, an interrupt from the device will be
> + * triggered. Following this event the interrupt will be disabled and
> + * periodic transmission of uevents (HOT trip point) should define the
> + * first level of temperature supervision. It is expected that any final
> + * implementation of the thermal driver will include a .notify() function
> + * to implement these uevents to userspace.
> + *
> + * These uevents are intended to indicate non-invasive temperature control
> + * of the system, where the necessary measures for cooling are the
> + * responsibility of the host software. Once the temperature falls again,
> + * the IRQ is re-enabled so the start of a new over-temperature event can
> + * be detected without constant software monitoring.
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


please cleanup the minor issues checkpatch complains:
/scripts/checkpatch.pl --strict <your patch>

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#203: 
new file mode 100644

CHECK: spaces preferred around that '*' (ctx:VxV)
#258: FILE: drivers/thermal/da9062-thermal.c:51:
+#define DA9062_MILLI_CELSIUS(t)			((t)*1000)
                                			    ^

CHECK: struct mutex definition without comment
#269: FILE: drivers/thermal/da9062-thermal.c:62:
+	struct mutex lock;

CHECK: Alignment should match open parenthesis
#286: FILE: drivers/thermal/da9062-thermal.c:79:
+	ret = regmap_write(thermal->hw->regmap,
+				DA9062AA_EVENT_B,

CHECK: Alignment should match open parenthesis
#314: FILE: drivers/thermal/da9062-thermal.c:107:
+			schedule_delayed_work(&thermal->work,
+				msecs_to_jiffies(thermal->zone->passive_delay));

WARNING: else is not generally useful after a break or return
#316: FILE: drivers/thermal/da9062-thermal.c:109:
+			return;
+		} else {

CHECK: Alignment should match open parenthesis
#348: FILE: drivers/thermal/da9062-thermal.c:141:
+static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
+				int trip,

WARNING: DT compatible string "dlg,da9062-thermal" appears un-documented -- check ./Documentation/devicetree/bindings/
#409: FILE: drivers/thermal/da9062-thermal.c:202:
+	{ .compatible = "dlg,da9062-thermal", .data = &da9062_config },

CHECK: Alignment should match open parenthesis
#433: FILE: drivers/thermal/da9062-thermal.c:226:
+			if (pp_tmp < DA9062_MIN_POLLING_MS_PERIOD ||
+				pp_tmp > DA9062_MAX_POLLING_MS_PERIOD) {

total: 0 errors, 3 warnings, 6 checks, 337 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/ebv/tmpatches/9 has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

> +/* Minimum, maximum and default polling millisecond periods are provided
> + * here as an example. It is expected that any final implementation to also
> + * include a modification of these settings to match the required
> + * application.
> + */
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
> +			thermal_zone_device_update(thermal->zone,
> +						   THERMAL_EVENT_UNSPECIFIED);
> +
> +			schedule_delayed_work(&thermal->work,
> +				msecs_to_jiffies(thermal->zone->passive_delay));
> +			return;
> +		} else {
> +			mutex_lock(&thermal->lock);
> +			thermal->temperature = DA9062_MILLI_CELSIUS(0);
> +			mutex_unlock(&thermal->lock);
> +			thermal_zone_device_update(thermal->zone,
> +						   THERMAL_EVENT_UNSPECIFIED);
> +		}
> +	}

The above code is a little confusing, can it be maybe, better read like
this?

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 52a095d..6ac8574 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -95,26 +95,26 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 		dev_err(thermal->dev,
 			"Cannot check the TJUNC temperature status\n");
 		goto err_enable_irq;
-	} else {
-		if (val & DA9062AA_E_TEMP_MASK) {
-			mutex_lock(&thermal->lock);
-			thermal->temperature = DA9062_MILLI_CELSIUS(125);
-			mutex_unlock(&thermal->lock);
-			thermal_zone_device_update(thermal->zone,
-						   THERMAL_EVENT_UNSPECIFIED);
-
-			schedule_delayed_work(&thermal->work,
+	}
+
+	if (val & DA9062AA_E_TEMP_MASK) {
+		mutex_lock(&thermal->lock);
+		thermal->temperature = DA9062_MILLI_CELSIUS(125);
+		mutex_unlock(&thermal->lock);
+		thermal_zone_device_update(thermal->zone,
+				THERMAL_EVENT_UNSPECIFIED);
+
+		schedule_delayed_work(&thermal->work,
 				msecs_to_jiffies(thermal->zone->passive_delay));
-			return;
-		} else {
-			mutex_lock(&thermal->lock);
-			thermal->temperature = DA9062_MILLI_CELSIUS(0);
-			mutex_unlock(&thermal->lock);
-			thermal_zone_device_update(thermal->zone,
-						   THERMAL_EVENT_UNSPECIFIED);
-		}
+		return;
 	}
 
+	mutex_lock(&thermal->lock);
+	thermal->temperature = DA9062_MILLI_CELSIUS(0);
+	mutex_unlock(&thermal->lock);
+	thermal_zone_device_update(thermal->zone,
+			THERMAL_EVENT_UNSPECIFIED);
+
 err_enable_irq:
 	enable_irq(thermal->irq);
 }


BR,

Eduardo Valentin
> -- 
> end-of-patch for RESEND PATCH V5
> 
