From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 4/6] input: keyboard: imx: add snvs power key driver
Date: Mon, 25 May 2015 15:35:23 +0800
Message-ID: <20150525073521.GI3264@dragon>
References: <1432305399-30571-1-git-send-email-Frank.Li@freescale.com>
 <1432305399-30571-5-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34032 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbbEYHgN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 03:36:13 -0400
Received: by pdbki1 with SMTP id ki1so22972711pdb.1
        for <linux-input@vger.kernel.org>; Mon, 25 May 2015 00:36:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432305399-30571-5-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Robin Gong <b38343@freescale.com>

On Fri, May 22, 2015 at 10:36:37PM +0800, Frank.Li@freescale.com wrote:
> +static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
> +{
> +	struct pwrkey_drv_data *pdata = NULL;
> +	struct input_dev *input = NULL;
> +	struct device_node *np, *snvs_np;
> +	int error;
> +
> +	/* Get SNVS register Page */
> +	np = pdev->dev.of_node;
> +	if (!np)
> +		return -ENODEV;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	snvs_np = of_get_parent(pdev->dev.of_node);
> +	if (!snvs_np)
> +		return -ENODEV;
> +
> +	pdata->snvs = syscon_node_to_regmap(snvs_np);

Same here, I suggest you have a 'regmap' property and call
syscon_regmap_lookup_by_phandle() to get regmap.

Shawn

> +	of_node_put(snvs_np);
> +
> +	if (!pdata->snvs) {
> +		pr_err("Can't get snvs syscon\n");
> +		return -ENODEV;
> +	}
> +
> +	if (of_property_read_u32(np, "linux,keycode", &pdata->keycode)) {
> +		pdata->keycode = KEY_POWER;
> +		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
> +	}
> +
> +	pdata->wakeup = of_property_read_bool(np, "wakeup");
> +
> +	pdata->irq = platform_get_irq(pdev, 0);
> +	if (pdata->irq < 0) {
> +		dev_err(&pdev->dev, "no irq defined in platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	regmap_update_bits(pdata->snvs, SNVS_LPCR_REG, SNVS_LPCR_DEP_EN, SNVS_LPCR_DEP_EN);
> +
> +	/* clear the unexpected interrupt before driver ready */
> +	regmap_write(pdata->snvs, SNVS_LPSR_REG, SNVS_LPSR_SPO);
> +
> +	setup_timer(&pdata->check_timer,
> +		    imx_imx_snvs_check_for_events, (unsigned long) pdata);
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input) {
> +		dev_err(&pdev->dev, "failed to allocate the input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	input->name = pdev->name;
> +	input->phys = "snvs-pwrkey/input0";
> +	input->id.bustype = BUS_HOST;
> +
> +	input_set_capability(input, EV_KEY, pdata->keycode);
> +
> +	/* input customer action to cancel release timer */
> +	error = devm_add_action(&pdev->dev, imx_snvs_pwrkey_act, pdata);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to register remove action\n");
> +		return error;
> +	}
> +
> +	error = devm_request_irq(&pdev->dev, pdata->irq,
> +			       imx_snvs_pwrkey_interrupt,
> +			       0, pdev->name, pdev);
> +
> +	if (error) {
> +		dev_err(&pdev->dev, "interrupt not available.\n");
> +		return error;
> +	}
> +
> +	error = input_register_device(input);
> +	if (error < 0) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		input_free_device(input);
> +		return error;
> +	}
> +
> +	pdata->input = input;
> +	platform_set_drvdata(pdev, pdata);
> +
> +	device_init_wakeup(&pdev->dev, pdata->wakeup);
> +
> +	return 0;
> +}
> +
> +static int imx_snvs_pwrkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		enable_irq_wake(pdata->irq);
> +
> +	return 0;
> +}
> +
> +static int imx_snvs_pwrkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		disable_irq_wake(pdata->irq);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx_snvs_pwrkey_ids[] = {
> +	{ .compatible = "fsl,sec-v4.0-pwrkey" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_snvs_pwrkey_ids);
> +
> +static SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops, imx_snvs_pwrkey_suspend,
> +				imx_snvs_pwrkey_resume);
> +
> +static struct platform_driver imx_snvs_pwrkey_driver = {
> +	.driver = {
> +		.name = "snvs_pwrkey",
> +		.pm     = &imx_snvs_pwrkey_pm_ops,
> +		.of_match_table = imx_snvs_pwrkey_ids,
> +	},
> +	.probe = imx_snvs_pwrkey_probe,
> +};
> +module_platform_driver(imx_snvs_pwrkey_driver);
> +
> +MODULE_AUTHOR("Freescale Semiconductor");
> +MODULE_DESCRIPTION("i.MX snvs power key Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 
