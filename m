From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input: st1232.c: Add devicetree attributes
Date: Tue, 17 Nov 2015 10:28:38 -0800
Message-ID: <20151117182838.GE29423@dtor-ws>
References: <1447604447-8932-1-git-send-email-sander@vermin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447604447-8932-1-git-send-email-sander-wENMetUwf8VmR6Xm/wNWPw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sander Vermin <sander-wENMetUwf8VmR6Xm/wNWPw@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Sander,

On Sun, Nov 15, 2015 at 05:20:47PM +0100, Sander Vermin wrote:
> -static int __maybe_unused st1232_ts_suspend(struct device *dev)
> +#ifdef CONFIG_PM_SLEEP

Why?

> +static int st1232_ts_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> -	struct st1232_ts_data *ts = i2c_get_clientdata(client);
> +	struct st1232_data *data = i2c_get_clientdata(client);
>  
> -	if (device_may_wakeup(&client->dev)) {
> -		enable_irq_wake(client->irq);
> -	} else {
> -		disable_irq(client->irq);
> -		st1232_ts_power(ts, false);
> -	}
> +	mutex_lock(&data->input_dev->mutex);
> +	if (data->input_dev->users)
> +		st1232_stop(data->input_dev);
> +	mutex_unlock(&data->input_dev->mutex);
>  
>  	return 0;
>  }
>  
> -static int __maybe_unused st1232_ts_resume(struct device *dev)
> +static int st1232_ts_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> -	struct st1232_ts_data *ts = i2c_get_clientdata(client);
> +	struct st1232_data *data = i2c_get_clientdata(client);
>  
> -	if (device_may_wakeup(&client->dev)) {
> -		disable_irq_wake(client->irq);
> -	} else {
> -		st1232_ts_power(ts, true);
> -		enable_irq(client->irq);
> -	}
> +	mutex_lock(&data->input_dev->mutex);
> +	if (data->input_dev->users)
> +		st1232_start(data->input_dev);
> +	mutex_unlock(&data->input_dev->mutex);
>  
>  	return 0;
>  }
> +#endif
>  
>  static SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
>  			 st1232_ts_suspend, st1232_ts_resume);
> @@ -282,13 +436,12 @@ static const struct i2c_device_id st1232_ts_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
>  
> -#ifdef CONFIG_OF

Why?

> -static const struct of_device_id st1232_ts_dt_ids[] = {
> +static const struct of_device_id st1232_of_match[] = {
>  	{ .compatible = "sitronix,st1232", },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
> -#endif
> +MODULE_DEVICE_TABLE(of, st1232_of_match);
> +
>  
>  static struct i2c_driver st1232_ts_driver = {
>  	.probe		= st1232_ts_probe,
> @@ -296,13 +449,14 @@ static struct i2c_driver st1232_ts_driver = {
>  	.id_table	= st1232_ts_id,
>  	.driver = {
>  		.name	= ST1232_TS_NAME,
> -		.of_match_table = of_match_ptr(st1232_ts_dt_ids),
> +		.owner	= THIS_MODULE,
> +		.of_match_table = st1232_of_match,

Why?

There seems many intermingled changes that are done to the driver, you
need to split them apart and explain why they are needed.

Thanks!

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
