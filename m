From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Pegatron Lucid accelerometer
Date: Sat, 15 Jan 2011 14:16:21 -0800
Message-ID: <20110115221621.GD19872@core.coreip.homeip.net>
References: <1295036050-10553-1-git-send-email-andy@windriver.com>
 <1295036050-10553-2-git-send-email-andy@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1295036050-10553-2-git-send-email-andy@windriver.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Ross <andy@windriver.com>
Cc: Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 14, 2011 at 12:14:09PM -0800, Andy Ross wrote:
> From: Andy Ross <andy.ross@windriver.com>
> 
> Add driver for the ACPI accelerometer interface on the Pegatron Lucid
> tablet.
> 
> Signed-off-by: Andy Ross <andy.ross@windriver.com>
> ---
>  drivers/input/misc/Kconfig      |   11 +++
>  drivers/input/misc/Makefile     |    2 +-
>  drivers/input/misc/pega-accel.c |  133 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/input/misc/pega-accel.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index b99b8cb..268c11d 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -448,4 +448,15 @@ config INPUT_ADXL34X_SPI
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adxl34x-spi.
>  
> +config INPUT_PEGA_ACCEL
> +       tristate "Support Pegatron Lucid accelerometer"
> +       depends on ASUS_LAPTOP
> +       default y

This is not a critical component; default should be 'n' (or just omit
default statement).

> +       help
> +         Say Y here if you want support for the built-in ACPI
> +         accelerometer device on Pegatron Lucid tablet devices.
> +
> +	 To compile this driver as a module, choose M here: the module
> +	 will be called pega_accel.
> +
>  endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 1fe1f6c..2475305 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -42,4 +42,4 @@ obj-$(CONFIG_INPUT_WINBOND_CIR)		+= winbond-cir.o
>  obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
>  obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
>  obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
> -
> +obj-$(CONFIG_INPUT_PEGA_ACCEL)		+= pega-accel.o

Please keep Kconfig and Makefile sorted alphabetically.

> diff --git a/drivers/input/misc/pega-accel.c b/drivers/input/misc/pega-accel.c
> new file mode 100644
> index 0000000..9b7ef05
> --- /dev/null
> +++ b/drivers/input/misc/pega-accel.c
> @@ -0,0 +1,133 @@
> +/*
> + * pega_accel.c - driver for accelerometer in Pegatron Lucid tablets

What's up with people loving to put filename into comments? It just
makes renaming files more4 difficult.

> + *
> + * Copyright (c) 2011 Wind River Systems
> + *
> + * Author: Andy Ross <andy.ross@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/input-polldev.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <acpi/acpi_bus.h>
> +
> +#define DRIVER_NAME "pega_accel"
> +#define DRIVER_DESC "Pegatron Lucid Tablet Accelerometer"
> +
> +/* 1G accel is reported as ~256, so clamp to 2G */
> +#define CLAMP 512
> +
> +static struct input_polled_dev *ipdev;
> +
> +/* FIXME: this mechanism is *very* slow: ~50ms to read the three
> + * values.  Pre-caching an acpi handle with acpi_get_handle has no
> + * effect, so the issue isn't in the parsing or tree walking... */
> +static int acpi_s16(char *method)
> +{
> +	unsigned long long val = 0;
> +	acpi_evaluate_integer(NULL, method, NULL, &val);
> +	return (short)val;
> +}
> +
> +static void pega_accel_poll(struct input_polled_dev *ipdev)
> +{
> +	/* Note transform, convert to "right/up/out" in the native
> +	 * landscape orientation (i.e. the vector is the direction of
> +	 * "real up" in the device's cartiesian coordinates).  FIXME:
> +	 * is there a relevant convention to adhere to? */
> +	int x = -acpi_s16("\\_SB.ATKD.XLRX");
> +	int y = -acpi_s16("\\_SB.ATKD.XLRY");
> +	int z =  acpi_s16("\\_SB.ATKD.XLRZ");
> +
> +	x = clamp_val(x, -CLAMP, CLAMP);
> +	y = clamp_val(y, -CLAMP, CLAMP);
> +	z = clamp_val(z, -CLAMP, CLAMP);
> +
> +	input_report_abs(ipdev->input, ABS_X, x);
> +	input_report_abs(ipdev->input, ABS_Y, y);
> +	input_report_abs(ipdev->input, ABS_Z, z);
> +	input_sync(ipdev->input);
> +}
> +
> +static void dev_noop_release(struct device *d) {}
> +
> +static int __devinit platform_probe(struct platform_device *pd)
> +{
> +	int err = 0;

No need to initialize to 0, in fact, it is quite often dangerous as it
masks compiler warnings.

> +
> +	ipdev = input_allocate_polled_device();
> +	if (!ipdev)
> +		return -ENOMEM;
> +
> +	ipdev->poll = pega_accel_poll;
> +	ipdev->poll_interval = 100;
> +	ipdev->poll_interval_min = 10;
> +	ipdev->poll_interval_max = 2000;
> +
> +	ipdev->input->dev.parent = &pd->dev;
> +	ipdev->input->dev.release = dev_noop_release;

WTH is this???

> +	ipdev->input->id.bustype = BUS_HOST;
> +
> +	ipdev->input->name = DRIVER_DESC;
> +	ipdev->input->phys = DRIVER_NAME "/input0";
> +
> +	set_bit(EV_ABS, ipdev->input->evbit);
> +	input_set_abs_params(ipdev->input, ABS_X, -CLAMP, CLAMP, 0, 0);
> +	input_set_abs_params(ipdev->input, ABS_Y, -CLAMP, CLAMP, 0, 0);
> +	input_set_abs_params(ipdev->input, ABS_Z, -CLAMP, CLAMP, 0, 0);
> +
> +	err = input_register_polled_device(ipdev);
> +	if (err)
> +		input_free_polled_device(ipdev);
> +
> +	return err;
> +}
> +
> +static int __devexit platform_remove(struct platform_device *pd)
> +{
> +	input_unregister_polled_device(ipdev);
> +	input_free_polled_device(ipdev);
> +	ipdev = NULL;
> +	return 0;
> +}
> +
> +static struct platform_driver platform_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name  = DRIVER_NAME,
> +	},
> +	.probe  = platform_probe,
> +	.remove = __devexit_p(platform_remove),
> +};
> +
> +static int __init mod_init(void)
> +{
> +	return platform_driver_register(&platform_driver);
> +}
> +
> +static void __exit mod_exit(void)
> +{
> +	platform_driver_unregister(&platform_driver);
> +}
> +
> +module_init(mod_init);
> +module_exit(mod_exit);
> +
> +MODULE_AUTHOR("Andy Ross <andy.ross@windriver.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_ALIAS("dmi:*:bvrLucid-CE-133:*");
> -- 
> 1.7.1
> 

Thanks.

-- 
Dmitry
