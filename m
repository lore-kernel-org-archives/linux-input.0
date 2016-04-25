From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 2/3] iio: mxs-lradc: remove mxs_lradc_ts_unregister
Date: Mon, 25 Apr 2016 14:00:41 -0700
Message-ID: <20160425210041.GB26059@dtor-ws>
References: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
 <1461441479-23218-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461441479-23218-3-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Apr 23, 2016 at 07:57:58PM +0000, Stefan Wahren wrote:
> After using devm_input_allocate_device for registration
> the function mxs_lradc_ts_unregister isn't necessary anymore
> since mxs_lradc_ts_close already does the job.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/iio/adc/mxs-lradc.c |   13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index 3d1d370..90242ba 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -1148,14 +1148,6 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>  	return input_register_device(input);
>  }
>  
> -static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
> -{
> -	if (!lradc->use_touchscreen)
> -		return;
> -
> -	mxs_lradc_disable_ts(lradc);
> -}
> -
>  /*
>   * IRQ Handling
>   */
> @@ -1715,13 +1707,11 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	ret = iio_device_register(iio);
>  	if (ret) {
>  		dev_err(dev, "Failed to register IIO device\n");
> -		goto err_ts;
> +		return ret;
>  	}
>  
>  	return 0;
>  
> -err_ts:
> -	mxs_lradc_ts_unregister(lradc);
>  err_ts_register:
>  	mxs_lradc_hw_stop(lradc);
>  err_dev:
> @@ -1739,7 +1729,6 @@ static int mxs_lradc_remove(struct platform_device *pdev)
>  	struct mxs_lradc *lradc = iio_priv(iio);
>  
>  	iio_device_unregister(iio);
> -	mxs_lradc_ts_unregister(lradc);
>  	mxs_lradc_hw_stop(lradc);
>  	mxs_lradc_trigger_remove(iio);
>  	iio_triggered_buffer_cleanup(iio);
> -- 
> 1.7.9.5
> 

-- 
Dmitry
