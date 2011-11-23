From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
	SSP/SPI) driver
Date: Wed, 23 Nov 2011 23:01:38 +0000
Message-ID: <20111123230138.GL9581@n2100.arm.linux.org.uk>
References: <1322066725.99549.YahooMailClassic@web29017.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56141 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab1KWXBw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 18:01:52 -0500
Content-Disposition: inline
In-Reply-To: <1322066725.99549.YahooMailClassic@web29017.mail.ird.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, koen@dominion.thruhere.net, dmitry.torokhov@gmail.com, eric.y.miao@gmail.com, philipp.zabel@gmail.com, mad_soft@inbox.ru

On Wed, Nov 23, 2011 at 04:45:25PM +0000, Paul Parsons wrote:
> +static irqreturn_t navpoint_int(int irq, void *dev)
> +{
> +	struct driver_data *drv_data = dev;

So 'dev' is a driver_data structure.

> +	struct ssp_device *ssp = drv_data->ssp;
> +	u32 status;
> +	irqreturn_t ret;
> +
> +	status = pxa_ssp_read_reg(ssp, SSSR);
> +	ret = IRQ_NONE;
> +
> +	if (status & sssr) {
> +		dev_warn(dev, "spurious interrupt: 0x%02x\n", status);

but you pass it to dev_warn().  This is not what dev_warn() is expecting.

> +		pxa_ssp_write_reg(ssp, SSSR, (status & sssr));
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if (status & SSSR_RFS) {
> +		while (status & SSSR_RNE) {
> +			u32 data;
> +
> +			data = pxa_ssp_read_reg(ssp, SSDR);
> +			drv_data->data[drv_data->index + 0] = (data >> 8);
> +			drv_data->data[drv_data->index + 1] = data;
> +			drv_data->index += 2;
> +			if (HEADER_LENGTH(drv_data->data[0]) < drv_data->index)
> +				navpoint_packet(dev);
> +			status = pxa_ssp_read_reg(ssp, SSSR);
> +		}
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	return ret;
> +}
> +
> +int navpoint_suspend(struct device *dev)

static?

> +{
> +	struct driver_data *drv_data = dev_get_drvdata(dev);
> +	struct ssp_device *ssp = drv_data->ssp;
> +
> +	gpio_set_value(drv_data->gpio, 0);
> +
> +	pxa_ssp_write_reg(ssp, SSCR0, 0);
> +
> +	clk_disable(ssp->clk);
> +
> +	return 0;
> +}
> +
> +int navpoint_resume(struct device *dev)

static?

> +{
> +	struct driver_data *drv_data = dev_get_drvdata(dev);
> +	struct ssp_device *ssp = drv_data->ssp;
> +
> +	clk_enable(ssp->clk);
> +
> +	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
> +	pxa_ssp_write_reg(ssp, SSSR, sssr);
> +	pxa_ssp_write_reg(ssp, SSTO, 0);
> +	pxa_ssp_write_reg(ssp, SSCR0, sscr0);	/* SSCR0_SSE written last */
> +
> +	gpio_set_value(drv_data->gpio, 1);
> +
> +	/* Wait until SSP port is ready for slave clock operations */
> +	while (pxa_ssp_read_reg(ssp, SSSR) & SSSR_CSS)
> +		msleep(1);

What if it never becomes ready?  Should this time out?

> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_SUSPEND
> +static const struct dev_pm_ops navpoint_pm_ops = {
> +	.suspend	= navpoint_suspend,
> +	.resume		= navpoint_resume,
> +};
> +#endif
> +
> +static int __devinit navpoint_probe(struct platform_device *pdev)
> +{
> +	struct navpoint_platform_data *pdata = pdev->dev.platform_data;
> +	int ret;
> +	struct driver_data *drv_data;
> +	struct ssp_device *ssp;
> +	struct input_dev *input;
> +
> +	drv_data = kzalloc(sizeof(struct driver_data), GFP_KERNEL);

We normally like to see sizeof(*drv_data) now.

> +	if (!drv_data) {
> +		ret = -ENOMEM;
> +		goto ret0;
> +	}
> +
> +	ssp = pxa_ssp_request(pdata->port, pdev->name);
> +	if (!ssp) {
> +		ret = -ENODEV;
> +		goto ret1;
> +	}
> +
> +	ret = request_irq(ssp->irq, navpoint_int, 0, pdev->name, drv_data);
> +	if (ret)
> +		goto ret2;

What if you immediately receive an interrupt right now, after requesting
this interrupt?  Will your handler try to dereference anything in
drv_data which is -currently- NULL ?  (I think you'll oops when
dereferencing drv_data->ssp->something.)

> +
> +	input = input_allocate_device();
> +	if (!input) {
> +		ret = -ENOMEM;
> +		goto ret3;
> +	}
> +	input->name = pdev->name;
> +	__set_bit(EV_KEY, input->evbit);
> +	__set_bit(KEY_ENTER, input->keybit);
> +	__set_bit(KEY_UP, input->keybit);
> +	__set_bit(KEY_LEFT, input->keybit);
> +	__set_bit(KEY_RIGHT, input->keybit);
> +	__set_bit(KEY_DOWN, input->keybit);
> +	input->dev.parent = &pdev->dev;
> +	ret = input_register_device(input);
> +	if (ret)
> +		goto ret4;
> +
> +	drv_data->ssp = ssp;
> +	drv_data->gpio = pdata->gpio;
> +	drv_data->input = input;
> +
> +	platform_set_drvdata(pdev, drv_data);
> +
> +	(void) navpoint_resume(&pdev->dev);

That cast to 'void' is not required.

> +
> +	dev_info(&pdev->dev, "ssp%d, irq %d\n", pdata->port, ssp->irq);
> +
> +	return 0;
> +
> +ret4:
> +	input_free_device(input);
> +ret3:
> +	free_irq(ssp->irq, drv_data);
> +ret2:
> +	pxa_ssp_free(ssp);
> +ret1:
> +	kfree(drv_data);
> +ret0:
> +	return ret;
> +}
> +
> +static int __devexit navpoint_remove(struct platform_device *pdev)
> +{
> +	struct driver_data *drv_data = platform_get_drvdata(pdev);
> +	struct ssp_device *ssp = drv_data->ssp;
> +	struct input_dev *input = drv_data->input;
> +
> +	(void) navpoint_suspend(&pdev->dev);

Cast to void is not required.

> +
> +	input_unregister_device(input);
> +
> +	free_irq(ssp->irq, drv_data);
> +
> +	pxa_ssp_free(ssp);
> +
> +	kfree(drv_data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver navpoint_driver = {
> +	.probe		= navpoint_probe,
> +	.remove		= __devexit_p(navpoint_remove),
> +	.driver = {
> +		.name	= "navpoint",
> +		.owner	= THIS_MODULE,
> +#ifdef CONFIG_SUSPEND
> +		.pm	= &navpoint_pm_ops,
> +#endif
> +	},
> +};
> +
> +static int __init navpoint_init(void)
> +{
> +	return platform_driver_register(&navpoint_driver);
> +}
> +
> +static void __exit navpoint_exit(void)
> +{
> +	platform_driver_unregister(&navpoint_driver);
> +}
> +
> +module_init(navpoint_init);
> +module_exit(navpoint_exit);
> +
> +MODULE_AUTHOR("Paul Parsons <lost.distance@yahoo.com>");
> +MODULE_DESCRIPTION("Synaptics NavPoint (PXA27x SSP/SPI) driver");
> +MODULE_LICENSE("GPL");
> diff -uprN clean-3.2-rc2/include/linux/input/navpoint.h linux-3.2-rc2/include/linux/input/navpoint.h
> --- clean-3.2-rc2/include/linux/input/navpoint.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-3.2-rc2/include/linux/input/navpoint.h	2011-11-20 00:12:00.947519171 +0000
> @@ -0,0 +1,12 @@
> +/*
> + *  Copyright (C) 2011 Paul Parsons <lost.distance@yahoo.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +struct navpoint_platform_data {
> +	int		port;		/* PXA SSP port for pxa_ssp_request() */
> +	int		gpio;		/* GPIO for power on/off */
> +};
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
