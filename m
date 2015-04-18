From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH V1 1/6] mfd: da9062: DA9062 MFD core driver
Date: Sat, 18 Apr 2015 10:27:25 +0200
Message-ID: <1429345645.16771.139.camel@x220>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
	 <b3bb4bc09cd94b0b13c713d98dd64576722123c1.1429280614.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b3bb4bc09cd94b0b13c713d98dd64576722123c1.1429280614.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2015-04-17 at 15:23 +0100, S Twiss wrote:
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig

> +config MFD_DA9062
> +	bool "Dialog Semiconductor DA9062 PMIC Support"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C=y
> +	help
> +	  Say yes here for support for the Dialog Semiconductor DA9062 PMIC.
> +	  This includes the I2C driver and core APIs.
> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.

> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile

> +obj-$(CONFIG_MFD_DA9062)	+= da9062-core.o

MFD_DA9062 is a bool symbol. So da9062-core.o can never be part of a
module, right?

> --- /dev/null
> +++ b/drivers/mfd/da9062-core.c

> +#include <linux/module.h>

So you might not need this include.

> +MODULE_DEVICE_TABLE(of, da9062_dt_ids);

This macro will be preprocessed away for built-in code, according to
include/linux/module.h.

> +MODULE_DEVICE_TABLE(i2c, da9062_i2c_id);

Ditto.

> +static struct i2c_driver da9062_i2c_driver = {
> +	.driver = {
> +		.name = "da9062",
> +		.of_match_table = of_match_ptr(da9062_dt_ids),
> +	},
> +	.probe    = da9062_i2c_probe,
> +	.remove   = da9062_i2c_remove,
> +	.id_table = da9062_i2c_id,
> +};
> +
> +module_i2c_driver(da9062_i2c_driver);

After looking at a few levels of #defines I think this is equivalent to
     i2c_register_driver(NULL, da9062_i2c_driver);

for built-in code. Did I grep that right?

> +MODULE_DESCRIPTION("CORE device driver for Dialog DA9062");
> +MODULE_AUTHOR("S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");

These macros will be effectively preprocessed away for built-in only
code.

Thanks,


Paul Bolle

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
