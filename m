From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: driver for touchscreen on iPaq h3xxx
Date: Sat, 12 Jul 2014 19:59:36 -0700
Message-ID: <20140713025936.GA29513@core.coreip.homeip.net>
References: <1405157481-10348-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:61298 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaGMC7o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Jul 2014 22:59:44 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so3416777pde.31
        for <linux-input@vger.kernel.org>; Sat, 12 Jul 2014 19:59:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405157481-10348-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org, Dmitry Artamonow <mad_soft@inbox.ru>, Alessandro GARDICH <gremlin@gremlin.it>

Hi Linus, Dmitry,

On Sat, Jul 12, 2014 at 11:31:21AM +0200, Linus Walleij wrote:
> From: Dmitry Artamonow <mad_soft@inbox.ru>

So is this Dmitry's or Alessandro's work?

> 
> This adds a driver for the touchscreen connected to the
> Atmel microcontroller on the iPAQ h3xxx series.
> 
> Based on a driver from handhelds.org 2.6.21 kernel, written
> by Alessandro GARDICH.
> 
> Signed-off-by: Alessandro GARDICH <gremlin@gremlin.it>
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/input/touchscreen/Kconfig         |   8 ++
>  drivers/input/touchscreen/Makefile        |   1 +
>  drivers/input/touchscreen/ipaq-micro-ts.c | 137 ++++++++++++++++++++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 drivers/input/touchscreen/ipaq-micro-ts.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index a23a94bb4bcb..26d0953c7094 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -471,6 +471,14 @@ config TOUCHSCREEN_HP7XX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called jornada720_ts.
>  
> +config TOUCHSCREEN_IPAQ_MICRO
> +	tristate "HP iPAQ Atmel Micro ASIC touchscreen"
> +	depends on MFD_IPAQ_MICRO
> +	help
> +	  This enables support for the touchscreen attached to
> +	  the Atmel Micro peripheral controller on iPAQ h3100/h3600/h3700
> +

To compile this driver as a module ...

> +
>  config TOUCHSCREEN_HTCPEN
>  	tristate "HTC Shift X9500 touchscreen"
>  	depends on ISA
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 126479d8c29a..4be94fce41af 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
>  obj-$(CONFIG_TOUCHSCREEN_MK712)		+= mk712.o
>  obj-$(CONFIG_TOUCHSCREEN_HP600)		+= hp680_ts_input.o
>  obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+= jornada720_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_IPAQ_MICRO)	+= ipaq-micro-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+= htcpen.o
>  obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
>  obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
> diff --git a/drivers/input/touchscreen/ipaq-micro-ts.c b/drivers/input/touchscreen/ipaq-micro-ts.c
> new file mode 100644
> index 000000000000..9c5e1b62d192
> --- /dev/null
> +++ b/drivers/input/touchscreen/ipaq-micro-ts.c
> @@ -0,0 +1,137 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * h3600 atmel micro companion support, touchscreen subdevice
> + * Author : Alessandro Gardich <gremlin@gremlin.it>
> + * Author : Linus Walleij <linus.walleij@linaro.org>
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/ipaq-micro.h>

Has this been merged already?

> +
> +struct touchscreen_data {
> +	struct input_dev *input;
> +	struct ipaq_micro *micro;
> +};
> +
> +static void micro_ts_receive(void *data, int len, unsigned char *msg)
> +{
> +	struct touchscreen_data *ts = data;
> +
> +	if (len == 4) {
> +		input_report_abs(ts->input, ABS_X, (msg[2]<<8)+msg[3]);

be16_to_cpup()?

> +		input_report_abs(ts->input, ABS_Y, (msg[0]<<8)+msg[1]);
> +		input_report_abs(ts->input, ABS_PRESSURE, 1);

Please no fake pressure events, update your tslib instead.

> +		input_report_key(ts->input, BTN_TOUCH, 0);

This seems completely backwards.

> +	}
> +	if (len == 0) {
> +		input_report_abs(ts->input, ABS_X, 0);
> +		input_report_abs(ts->input, ABS_Y, 0);
> +		input_report_abs(ts->input, ABS_PRESSURE, 0);
> +		input_report_key(ts->input, BTN_TOUCH, 1);
> +	}
> +	input_sync(ts->input);
> +}
> +
> +
> +static int micro_ts_probe(struct platform_device *pdev)
> +{
> +	struct touchscreen_data *ts;
> +	int ret;
> +
> +	ts = devm_kzalloc(&pdev->dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +	ts->micro = dev_get_drvdata(pdev->dev.parent);
> +
> +	platform_set_drvdata(pdev, ts);
> +
> +	ts->input = input_allocate_device();

Error handling please; also consider using devm_input_allocate_device().

> +
> +	ts->input->evbit[0] = BIT(EV_ABS);
> +	ts->input->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
> +	input_set_abs_params(ts->input, ABS_X, 0, 1023, 0, 0);
> +	input_set_abs_params(ts->input, ABS_Y, 0, 1023, 0, 0);
> +	input_set_abs_params(ts->input, ABS_PRESSURE, 0x0, 0x1, 0, 0);
> +

You are missing setting BTN_TOUCH in capabilities so events you are
trying to send in micro_ts_receive will not go anywhere.

> +	ts->input->name = "ipaq micro ts";
> +	/* ts->input->private = ts; */

Huh?

> +
> +	ret = input_register_device(ts->input);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error registering touch input\n");
> +		return ret;
> +	}
> +
> +	spin_lock(&ts->micro->lock);
> +	ts->micro->ts = micro_ts_receive;
> +	ts->micro->ts_data = ts;
> +	spin_unlock(&ts->micro->lock);
> +
> +	dev_info(&pdev->dev, "iPAQ micro touchscreen\n");
> +	return 0;
> +}
> +
> +static int micro_ts_remove(struct platform_device *pdev)
> +{
> +	struct touchscreen_data *ts = platform_get_drvdata(pdev);
> +
> +	spin_lock(&ts->micro->lock);
> +	ts->micro->ts = NULL;
> +	ts->micro->ts_data = NULL;
> +	spin_unlock(&ts->micro->lock);
> +	input_unregister_device(ts->input);
> +
> +	return 0;
> +}
> +
> +static int micro_ts_suspend(struct device *dev)
> +{
> +	struct touchscreen_data *ts = dev_get_drvdata(dev);
> +
> +	spin_lock(&ts->micro->lock);
> +	ts->micro->ts = NULL;
> +	ts->micro->ts_data = NULL;
> +	spin_unlock(&ts->micro->lock);

What is the point here?

> +	return 0;
> +}
> +
> +static int micro_ts_resume(struct device *dev)
> +{
> +	struct touchscreen_data *ts = dev_get_drvdata(dev);
> +
> +	spin_lock(&ts->micro->lock);
> +	ts->micro->ts = micro_ts_receive;
> +	ts->micro->ts_data = ts;
> +	spin_unlock(&ts->micro->lock);
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops micro_ts_dev_pm_ops = {
> +	SET_SYSTEM_SLEE`P_PM_OPS(micro_ts_suspend, micro_ts_resume)
> +};
> +
> +struct platform_driver micro_ts_device_driver = {
> +	.driver  = {
> +		.name    = "ipaq-micro-ts",
> +		.pm	= &micro_ts_dev_pm_ops,
> +	},
> +	.probe   = micro_ts_probe,
> +	.remove  = micro_ts_remove,
> +};
> +module_platform_driver(micro_ts_device_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("driver for iPAQ Atmel micro touchscreen");
> +MODULE_ALIAS("platform:ipaq-micro-ts");
> -- 
> 1.9.3
> 

Thanks.

-- 
Dmitry
