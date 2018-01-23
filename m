From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/3] Input: ad7897 - use devm_add_action_or_reset to
 disable the device
Date: Mon, 22 Jan 2018 17:40:09 -0800
Message-ID: <20180123014009.dtk3obr4fj4vztzr@dtor-ws>
References: <20171108155020.3851-1-andi@etezian.org>
 <20171108155020.3851-3-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44645 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeAWBkM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Jan 2018 20:40:12 -0500
Content-Disposition: inline
In-Reply-To: <20171108155020.3851-3-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>

Hi Andi,

On Wed, Nov 08, 2017 at 05:50:19PM +0200, Andi Shyti wrote:
> Use the ad7877_disable() as a custom action when the driver gets
> removed instead of calling it from the remove function.
> 
> Because ad7877_remove() was just calling the disable function,
> get rid of it.
> 

There is not reason why this change needs to be split from the first
one; I folded it back in and applied, thank you.

> CC: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Andi Shyti <andi@etezian.org>
> ---
>  drivers/input/touchscreen/ad7877.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
> index dd59e4a5eb7d..04ab8fbc8184 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -417,8 +417,10 @@ static irqreturn_t ad7877_irq(int irq, void *handle)
>  	return IRQ_HANDLED;
>  }
>  
> -static void ad7877_disable(struct ad7877 *ts)
> +static void ad7877_disable(void *data)
>  {
> +	struct ad7877 *ts = data;
> +
>  	mutex_lock(&ts->mutex);
>  
>  	if (!ts->disabled) {
> @@ -712,6 +714,10 @@ static int ad7877_probe(struct spi_device *spi)
>  	if (!ts || !input_dev)
>  		return -ENOMEM;
>  
> +	err = devm_add_action_or_reset(&spi->dev, ad7877_disable, ts);
> +	if (err)
> +		return err;
> +
>  	spi_set_drvdata(spi, ts);
>  	ts->spi = spi;
>  	ts->input = input_dev;
> @@ -787,17 +793,6 @@ static int ad7877_probe(struct spi_device *spi)
>  	return input_register_device(input_dev);
>  }
>  
> -static int ad7877_remove(struct spi_device *spi)
> -{
> -	struct ad7877 *ts = spi_get_drvdata(spi);
> -
> -	ad7877_disable(ts);
> -
> -	dev_dbg(&spi->dev, "unregistered touchscreen\n");
> -
> -	return 0;
> -}
> -
>  static int __maybe_unused ad7877_suspend(struct device *dev)
>  {
>  	struct ad7877 *ts = dev_get_drvdata(dev);
> @@ -824,7 +819,6 @@ static struct spi_driver ad7877_driver = {
>  		.pm	= &ad7877_pm,
>  	},
>  	.probe		= ad7877_probe,
> -	.remove		= ad7877_remove,
>  };
>  
>  module_spi_driver(ad7877_driver);
> -- 
> 2.15.0
> 

-- 
Dmitry
