From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [rtc-linux] [PATCH V2 1/4] mfd: da9062: DA9062 MFD core driver
Date: Sat, 16 May 2015 10:53:28 +0200
Message-ID: <20150516085328.GI3338@piout.net>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <af5a7d289bb149e9111ebc70bb0589a994ee2407.1431621833.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <af5a7d289bb149e9111ebc70bb0589a994ee2407.1431621833.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 14/05/2015 at 17:43:52 +0100, S Twiss wrote :
> +config MFD_DA9062
> +	tristate "Dialog Semiconductor DA9062 PMIC Support"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C=y

Isn't depends on I2C enough?

> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> new file mode 100644
> index 0000000..e6a9878
> --- /dev/null
> +++ b/drivers/mfd/da9062-core.c
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/irq.h>
> +#include <linux/mfd/core.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +
> +#include <linux/mfd/da9062/core.h>
> +#include <linux/mfd/da9062/registers.h>
> +#include <linux/of.h>
> +#include <linux/regulator/of_regulator.h>
> +
> +#include <linux/proc_fs.h>
> +#include <linux/kthread.h>
> +#include <linux/uaccess.h>
> +

You should order the header inclusions alphabetically

[...]

> +	{
> +		.name		= "da9062-watchdog",
> +		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
> +		.resources	= da9062_wdt_resources,
> +		.of_compatible  = "dlg,da9062-wdt",
> +	},
> +	{
> +		.name		= "da9062-onkey",
> +		.num_resources	= ARRAY_SIZE(da9062_onkey_resources),
> +		.resources	= da9062_onkey_resources,
> +		.of_compatible  = "dlg,da9062-onkey",
> +	},
> +	{
> +		.name		= "da9062-thermal",
> +		.num_resources	= ARRAY_SIZE(da9062_thermal_resources),
> +		.resources	= da9062_thermal_resources,
> +		.of_compatible  = "dlg,da9062-thermal",
> +	},
> +	{
> +		.name		= "da9062-rtc",
> +		.num_resources	= ARRAY_SIZE(da9062_rtc_resources),
> +		.resources	= da9062_rtc_resources,
> +		.of_compatible  = "dlg,da9062-rtc",

Did you try to use "da9063-rtc"? The register set seems to be exactly
the same. Unfortunately, the datasheet are not available on the diasemi
website...

Also, the .of_compatibles are not necessary because you don't add any of
bindings to the underlying drivers. The match happens on .name.

> diff --git a/include/linux/mfd/da9062/registers.h b/include/linux/mfd/da9062/registers.h
> new file mode 100644
> index 0000000..d07c2bc
> --- /dev/null
> +++ b/include/linux/mfd/da9062/registers.h

Comparing that file with da9063/registers.h, It really seems that
DA062AA, DA9063AD and DA9063BB are register compatible, apart from a few
differences in the regulator and the gpio count.

Also, at least the watchdog and rtc driver are duplicating their da9063
counterpart. I'm not trying to annoy you, I just want you to understand
that the less code is duplicated, the easiest it will be to maintain
later.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
