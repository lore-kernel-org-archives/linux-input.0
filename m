From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] Input: da9052_tsi: make TSI reference regulator configurable
Date: Fri, 22 Mar 2013 12:51:23 -0300
Message-ID: <514C7DFB.8000708@freescale.com>
References: <1363964129-23392-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:32882
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933601Ab3CVPbz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Mar 2013 11:31:55 -0400
In-Reply-To: <1363964129-23392-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, festevam@gmail.com, Ashish Jangam <ashish.jangam@kpitcummins.com>

Philipp Zabel wrote:
 
>  	if (!tsi->stopped) {
> +		error = regulator_enable(tsi->tsiref);
> +		if (error < 0) {
> +			dev_err(tsi->da9052->dev,
> +				"Failed to enable TSIREF regualtor: %d\n",

s/regualtor/regulator


> @@ -274,12 +287,20 @@ static int da9052_ts_probe(struct platform_device *pdev)
>  	/* Disable ADC */
>  	da9052_ts_adc_toggle(tsi, false);
>  
> +	tsi->tsiref = regulator_get(tsi->da9052->dev, "tsiref");

You could use devm_regulator_get here ...

> +	if (IS_ERR(tsi->tsiref)) {
> +		dev_err(tsi->da9052->dev,
> +				"Failed to get TSIREF regulator: %ld\n",
> +				PTR_ERR(tsi->tsiref));
> +		goto err_free_mem;
> +	}
> +
>  	error = da9052_request_irq(tsi->da9052, DA9052_IRQ_PENDOWN,
>  				"pendown-irq", da9052_ts_pendwn_irq, tsi);
>  	if (error) {
>  		dev_err(tsi->da9052->dev,
>  			"Failed to register PENDWN IRQ: %d\n", error);
> -		goto err_free_mem;
> +		goto err_put_reg;
>  	}
>  
>  	error = da9052_request_irq(tsi->da9052, DA9052_IRQ_TSIREADY,
> @@ -310,6 +331,8 @@ err_free_datardy_irq:
>  	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
>  err_free_pendwn_irq:
>  	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
> +err_put_reg:
> +	regulator_put(tsi->tsiref);
>  err_free_mem:
>  	kfree(tsi);
>  	input_free_device(input_dev);
> @@ -321,10 +344,9 @@ static int  da9052_ts_remove(struct platform_device *pdev)
>  {
>  	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
>  
> -	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
> -
>  	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
>  	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
> +	regulator_put(tsi->tsiref);

and then no need to use the regulator_put.

