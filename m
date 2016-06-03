From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/8] iio: adc: ti_am335x_adc: use SIMPLE_DEV_PM_OPS helper
 macro
Date: Fri, 3 Jun 2016 13:16:25 +0100
Message-ID: <803110b4-997e-d8d0-dc3e-1ff6279ad202@kernel.org>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-3-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160531170013.2649-3-afd-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 31/05/16 18:00, Andrew F. Davis wrote:
> Replace ifdefs with SIMPLE_DEV_PM_OPS helper macro.
> 
> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index c1e0553..18af71d 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -531,8 +531,7 @@ static int tiadc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -static int tiadc_suspend(struct device *dev)
> +static int __maybe_unused tiadc_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> @@ -550,7 +549,7 @@ static int tiadc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int tiadc_resume(struct device *dev)
> +static int __maybe_unused tiadc_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> @@ -567,14 +566,7 @@ static int tiadc_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static const struct dev_pm_ops tiadc_pm_ops = {
> -	.suspend = tiadc_suspend,
> -	.resume = tiadc_resume,
> -};
> -#define TIADC_PM_OPS (&tiadc_pm_ops)
> -#else
> -#define TIADC_PM_OPS NULL
> -#endif
> +static SIMPLE_DEV_PM_OPS(tiadc_pm_ops, tiadc_suspend, tiadc_resume);
>  
>  static const struct of_device_id ti_adc_dt_ids[] = {
>  	{ .compatible = "ti,am3359-adc", },
> @@ -585,7 +577,7 @@ MODULE_DEVICE_TABLE(of, ti_adc_dt_ids);
>  static struct platform_driver tiadc_driver = {
>  	.driver = {
>  		.name   = "TI-am335x-adc",
> -		.pm	= TIADC_PM_OPS,
> +		.pm	= &tiadc_pm_ops,
>  		.of_match_table = ti_adc_dt_ids,
>  	},
>  	.probe	= tiadc_probe,
> 
