From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH RFT V2 1/3] iio: mxs-lradc: simplify TS registration
Date: Thu, 21 Apr 2016 22:39:24 +0200
Message-ID: <57193A7C.9050607@denx.de>
References: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com> <1461269478-449-2-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461269478-449-2-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 04/21/2016 10:11 PM, Stefan Wahren wrote:
> This patch simplifies the TS registration of mxs-lradc by
> using devm_input_allocate_device.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> ---
>  drivers/iio/adc/mxs-lradc.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index ad26da1..223650b 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -1120,12 +1120,11 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>  {
>  	struct input_dev *input;
>  	struct device *dev = lradc->dev;
> -	int ret;
>  
>  	if (!lradc->use_touchscreen)
>  		return 0;
>  
> -	input = input_allocate_device();
> +	input = devm_input_allocate_device(dev);
>  	if (!input)
>  		return -ENOMEM;
>  
> @@ -1146,11 +1145,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>  
>  	lradc->ts_input = input;
>  	input_set_drvdata(input, lradc);
> -	ret = input_register_device(input);
> -	if (ret)
> -		input_free_device(lradc->ts_input);
>  
> -	return ret;
> +	return input_register_device(input);
>  }
>  
>  static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
> @@ -1159,7 +1155,6 @@ static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
>  		return;
>  
>  	mxs_lradc_disable_ts(lradc);
> -	input_unregister_device(lradc->ts_input);
>  }
>  
>  /*
> 
This seems to be done right now :)

Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

-- 
Best regards,
Marek Vasut
