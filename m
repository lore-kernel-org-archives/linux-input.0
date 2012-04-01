From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Input: st1232 - switch to using SIMPLE_DEV_PM_OPS
Date: Sun, 1 Apr 2012 07:58:56 +0200
Message-ID: <201204010758.56276.rjw@sisk.pl>
References: <20120331061801.GA20441@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120331061801.GA20441@core.coreip.homeip.net>
Sender: linux-sh-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Saturday, March 31, 2012, Dmitry Torokhov wrote:
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Looks good.

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
> 
> Just compiled, not tested...
> 
>  drivers/input/touchscreen/st1232.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index e22e27e..a9be39f 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -218,7 +218,7 @@ static int __devexit st1232_ts_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int st1232_ts_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> @@ -243,12 +243,11 @@ static int st1232_ts_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static const struct dev_pm_ops st1232_ts_pm_ops = {
> -	.suspend	= st1232_ts_suspend,
> -	.resume		= st1232_ts_resume,
> -};
>  #endif
>  
> +static SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
> +			 st1232_ts_suspend, st1232_ts_resume);
> +
>  static const struct i2c_device_id st1232_ts_id[] = {
>  	{ ST1232_TS_NAME, 0 },
>  	{ }
> @@ -269,9 +268,7 @@ static struct i2c_driver st1232_ts_driver = {
>  		.name	= ST1232_TS_NAME,
>  		.owner	= THIS_MODULE,
>  		.of_match_table = st1232_ts_dt_ids,
> -#ifdef CONFIG_PM
>  		.pm	= &st1232_ts_pm_ops,
> -#endif
>  	},
>  };
>  
> 

