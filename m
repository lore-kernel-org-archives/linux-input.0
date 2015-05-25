From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 1/6] rtc: arm: imx: snvs: change use syscon to access
 register
Date: Mon, 25 May 2015 14:44:28 +0800
Message-ID: <20150525064427.GG3264@dragon>
References: <1432305399-30571-1-git-send-email-Frank.Li@freescale.com>
 <1432305399-30571-2-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34512 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbEYGpS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 02:45:18 -0400
Received: by pabru16 with SMTP id ru16so65033602pab.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2015 23:45:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432305399-30571-2-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org

On Fri, May 22, 2015 at 10:36:34PM +0800, Frank.Li@freescale.com wrote:
>  static int snvs_rtc_probe(struct platform_device *pdev)
>  {
>  	struct snvs_rtc_data *data;
>  	struct resource *res;
>  	int ret;
> +	struct device_node *snvs_np;
> +	void __iomem *mmio;
>  
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	data->ioaddr = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(data->ioaddr))
> -		return PTR_ERR(data->ioaddr);
> +	snvs_np = of_get_parent(pdev->dev.of_node);
> +	if (!snvs_np)
> +		return -ENODEV;
> +
> +	if (of_device_is_compatible(snvs_np, "syscon")) {
> +		data->regmap = syscon_node_to_regmap(snvs_np);
> +		data->offset = 0x34;

As I commented on dts patch, we should probably follow syscon-poweroff
to have 'regmap' and 'offset' properties.

Shawn

> +	} else {
> +		pr_warn("snvs rtc: you use old dts file, please update it\n");
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +		mmio = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(mmio))
> +			return PTR_ERR(mmio);
> +
> +		data->regmap = devm_regmap_init_mmio(&pdev->dev, mmio, &snvs_rtc_config);
> +	}
> +
> +	of_node_put(snvs_np);
> +
> +	if (!data->regmap) {
> +		pr_err("Can't snvs syscon\n");
> +		return -ENODEV;
> +	}
>  
>  	data->irq = platform_get_irq(pdev, 0);
>  	if (data->irq < 0)
> @@ -276,13 +282,11 @@ static int snvs_rtc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, data);
>  
> -	spin_lock_init(&data->lock);
> -
>  	/* Initialize glitch detect */
> -	writel(SNVS_LPPGDR_INIT, data->ioaddr + SNVS_LPPGDR);
> +	regmap_write(data->regmap, data->offset + SNVS_LPPGDR, SNVS_LPPGDR_INIT);
>  
>  	/* Clear interrupt status */
> -	writel(0xffffffff, data->ioaddr + SNVS_LPSR);
> +	regmap_write(data->regmap, data->offset + SNVS_LPSR, 0xffffffff);
>  
>  	/* Enable RTC */
>  	snvs_rtc_enable(data, true);
> -- 
> 1.9.1
> 
