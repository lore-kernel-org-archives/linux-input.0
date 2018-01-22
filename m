From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7846 - use managed allocated resources
Date: Mon, 22 Jan 2018 11:58:08 -0800
Message-ID: <20180122195808.modzzlhiw5xnuez5@dtor-ws>
References: <20171109140038.19771-1-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171109140038.19771-1-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

Hi Andi,

On Thu, Nov 09, 2017 at 04:00:38PM +0200, Andi Shyti wrote:
> @@ -1462,31 +1435,11 @@ static int ads7846_remove(struct spi_device *spi)
>  {
>  	struct ads7846 *ts = spi_get_drvdata(spi);
>  
> -	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
> -
>  	ads7846_disable(ts);
> -	free_irq(ts->spi->irq, ts);
> -
> -	input_unregister_device(ts->input);
> -
> -	ads784x_hwmon_unregister(spi, ts);
> -
> -	regulator_put(ts->reg);
> -
> -	if (!ts->get_pendown_state) {
> -		/*
> -		 * If we are not using specialized pendown method we must
> -		 * have been relying on gpio we set up ourselves.
> -		 */
> -		gpio_free(ts->gpio_pendown);
> -	}
>  
>  	if (ts->filter_cleanup)
>  		ts->filter_cleanup(ts->filter_data);

You need to either remove custom filter support from the driver, or
install an action to use devm* to do filter cleanup. Given that, as far
as I can see, we do not have users of custom filters in mainline, and
they are not compatible with DT-based systems, I'd rather we removed
them.

>  
> -	kfree(ts->packet);
> -	kfree(ts);
> -
>  	dev_dbg(&spi->dev, "unregistered touchscreen\n");
>  
>  	return 0;
> -- 
> 2.15.0
> 

Thanks.

-- 
Dmitry
