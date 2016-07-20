From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
Date: Wed, 20 Jul 2016 10:25:32 -0700
Message-ID: <20160720172532.GE25655@dtor-ws>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469003351-15263-5-git-send-email-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Quentin,

On Wed, Jul 20, 2016 at 10:29:10AM +0200, Quentin Schulz wrote:
> This adds support for Allwinner SoCs' (A10, A13 and A31) resistive
> touchscreen. This driver is probed by the MFD sunxi-gpadc-mfd.
> 
> This driver uses ADC channels exposed through the IIO framework by
> sunxi-gpadc-iio to get its data. When opening this input device, it will
> start buffering in the ADC driver and enable a TP_UP_PENDING irq. The ADC
> driver will fill in a buffer with all data and call the callback the input
> device associated with this buffer. The input device will then read the
> buffer two by two and send X and Y coordinates to the input framework based
> on what it received from the ADC's buffer. When closing this input device,
> the buffering is stopped.
> 
> Note that locations in the first received buffer after an TP_UP_PENDING irq
> occurred are unreliable, thus dropped.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/input/touchscreen/Kconfig          |  11 +-
>  drivers/input/touchscreen/Makefile         |   2 +-
>  drivers/input/touchscreen/sun4i-ts.c       | 419 -----------------------------
>  drivers/input/touchscreen/sunxi-gpadc-ts.c | 195 ++++++++++++++
>  4 files changed, 201 insertions(+), 426 deletions(-)
>  delete mode 100644 drivers/input/touchscreen/sun4i-ts.c
>  create mode 100644 drivers/input/touchscreen/sunxi-gpadc-ts.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 8ecdc38..f16ce36 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1072,14 +1072,13 @@ config TOUCHSCREEN_STMPE
>  config TOUCHSCREEN_SUN4I
>  	tristate "Allwinner sun4i resistive touchscreen controller support"
>  	depends on ARCH_SUNXI || COMPILE_TEST
> -	depends on HWMON
> -	depends on THERMAL || !THERMAL_OF
> +	depends on SUNXI_ADC
>  	help
> -	  This selects support for the resistive touchscreen controller
> -	  found on Allwinner sunxi SoCs.
> +	  This selects support for the resistive touchscreen controller found
> +	  on Allwinner SoCs (A10, A13, A31).
>  
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called sun4i-ts.
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sunxi-gpadc-ts.
>  
>  config TOUCHSCREEN_SUR40
>  	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index f42975e..bdc1889 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -65,7 +65,7 @@ obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+= pixcir_i2c_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
>  obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
> -obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+= sun4i-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+= sunxi-gpadc-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_SUR40)		+= sur40.o
>  obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)	+= ti_am335x_tsc.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
> deleted file mode 100644
> index d07dd29..0000000
...
> diff --git a/drivers/input/touchscreen/sunxi-gpadc-ts.c b/drivers/input/touchscreen/sunxi-gpadc-ts.c
> new file mode 100644
> index 0000000..410d14f
> --- /dev/null
> +++ b/drivers/input/touchscreen/sunxi-gpadc-ts.c
> @@ -0,0 +1,195 @@
> +/* Touchscreen driver for Allwinner SoCs (A10, A13, A31) GPADC
> + *
> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/consumer.h>
> +#include <linux/mfd/sunxi-gpadc-mfd.h>
> +
> +struct sunxi_gpadc_ts {
> +	struct iio_cb_buffer	*buffer;
> +	struct input_dev	*input;
> +	struct platform_device	*pdev;
> +	unsigned int		tp_up_irq;
> +	bool			ignore_fifo_data;
> +};
> +
> +static int sunxi_gpadc_ts_open(struct input_dev *dev)
> +{
> +	struct sunxi_gpadc_ts *info = input_get_drvdata(dev);
> +	int ret;
> +
> +	ret = iio_channel_start_all_cb(info->buffer);
> +	if (ret) {
> +		dev_err(dev->dev.parent,
> +			"failed to start iio channels with callback\n");
> +		return ret;
> +	}
> +
> +	enable_irq(info->tp_up_irq);
> +
> +	return 0;
> +}
> +
> +static void sunxi_gpadc_ts_close(struct input_dev *dev)
> +{
> +	struct sunxi_gpadc_ts *info = input_get_drvdata(dev);
> +
> +	iio_channel_stop_all_cb(info->buffer);
> +
> +	disable_irq(info->tp_up_irq);
> +}
> +
> +/*
> + * This function will be called by iio_push_to_buffers from another driver
> + * (namely sunxi-gpadc-iio). It will be passed the buffer filled with input
> + * values (X value then Y value) and the sunxi_gpadc_ts structure representing
> + * the device.
> + */
> +static int sunxi_gpadc_ts_callback(const void *data, void *private)
> +{
> +	const struct sunxi_gpadc_buffer *buffer = data;
> +	struct sunxi_gpadc_ts *info = private;
> +	int i = 0;
> +
> +	/* Locations in the first buffer after an up event are unreliable */
> +	if (info->ignore_fifo_data) {
> +		info->ignore_fifo_data = false;
> +		return 0;
> +	}
> +
> +	while (i + 1 < buffer->buff_size) {
> +		input_event(info->input, EV_ABS, ABS_X, buffer->buffer[i++]);
> +		input_event(info->input, EV_ABS, ABS_Y, buffer->buffer[i++]);
> +		input_event(info->input, EV_KEY, BTN_TOUCH, 1);
> +		input_sync(info->input);
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t sunxi_gpadc_tp_up_irq_handler(int irq, void *dev_id)
> +{
> +	struct sunxi_gpadc_ts *info = dev_id;
> +
> +	info->ignore_fifo_data = true;
> +
> +	input_event(info->input, EV_KEY, BTN_TOUCH, 0);
> +	input_sync(info->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sunxi_gpadc_ts_probe(struct platform_device *pdev)
> +{
> +	struct input_dev *input;
> +	struct sunxi_gpadc_ts *info;
> +	int ret, irq;
> +	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev;
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->buffer = iio_channel_get_all_cb(&pdev->dev,
> +					      &sunxi_gpadc_ts_callback,
> +					      (void *)info);

Any chance we could introduce devm-variant here? If you do not want to
wait for IIO to add it you can temporarily add call
devm_add_action_or_reset() after getting channels and remove it when IIO
API catches up.

> +	if (IS_ERR(info->buffer)) {
> +		if (PTR_ERR(info->buffer) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(info->buffer);
> +	}
> +
> +	info->pdev = pdev;
> +	info->input = input;
> +	info->ignore_fifo_data = false;
> +	platform_set_drvdata(pdev, info);
> +
> +	input->dev.parent = &pdev->dev;

Not needed for input devices allocated with devm.

> +	input->name = "sunxi-gpadc-ts";
> +	input->id.bustype = BUS_HOST;
> +	input->open = sunxi_gpadc_ts_open;
> +	input->close = sunxi_gpadc_ts_close;
> +	__set_bit(EV_SYN, input->evbit);

This not needed.

> +	input_set_capability(input, EV_KEY, BTN_TOUCH);
> +	input_set_abs_params(input, ABS_X, 0, 4095, 0, 0);
> +	input_set_abs_params(input, ABS_Y, 0, 4095, 0, 0);
> +	input_set_drvdata(input, info);
> +
> +	irq = platform_get_irq_byname(pdev, "TP_UP_PENDING");
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no TP_UP_PENDING interrupt registered\n");
> +		ret = irq;
> +		goto err;
> +	}
> +
> +	sunxi_gpadc_mfd_dev = dev_get_drvdata(pdev->dev.parent);
> +
> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
> +					   sunxi_gpadc_tp_up_irq_handler, 0,
> +					   "tp_up", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"could not request TP_UP_PENDING interrupt: %d\n", ret);
> +		goto err;
> +	}
> +
> +	info->tp_up_irq = irq;
> +	disable_irq(irq);
> +
> +	ret = input_register_device(input);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	iio_channel_release_all_cb(info->buffer);
> +
> +	return ret;
> +}
> +
> +static int sunxi_gpadc_ts_remove(struct platform_device *pdev)
> +{
> +	struct sunxi_gpadc_ts *info = platform_get_drvdata(pdev);
> +
> +	iio_channel_stop_all_cb(info->buffer);
> +	iio_channel_release_all_cb(info->buffer);
> +
> +	disable_irq(info->tp_up_irq);

You are mixing devm and non-devm so your unwind order is completely out
of wack. If input device is opened while you are unloading (or
unbinding) the dirver, then you'll release channels, then input device's
close() will be called, which will try to stop the IIO channels again
and disable IRQ yet again.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver sunxi_gpadc_ts_driver = {
> +	.driver = {
> +		.name = "sunxi-gpadc-ts",
> +	},
> +	.probe = sunxi_gpadc_ts_probe,
> +	.remove = sunxi_gpadc_ts_remove,
> +};
> +
> +module_platform_driver(sunxi_gpadc_ts_driver);
> +
> +MODULE_DESCRIPTION("Touchscreen driver for Allwinner SoCs (A10, A13, A31) GPADC");
> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.5.0
> 

Thanks.

-- 
Dmitry
