From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/19] iio/ti_am335x_adc: remove platform_data support
Date: Sun, 02 Jun 2013 18:22:59 +0100
Message-ID: <51AB7F73.6050304@kernel.org>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-9-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369681926-22185-9-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
> This patch removes access to platform data mfd_tscadc_board because the
> platform is DT only.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c |   26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index e657709..d821d88 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -26,7 +26,6 @@
>  #include <linux/of_device.h>
>  
>  #include <linux/mfd/ti_am335x_tscadc.h>
> -#include <linux/platform_data/ti_am335x_adc.h>
>  
>  struct tiadc_device {
>  	struct ti_tscadc_dev *mfd_tscadc;
> @@ -143,13 +142,12 @@ static int tiadc_probe(struct platform_device *pdev)
>  	struct iio_dev		*indio_dev;
>  	struct tiadc_device	*adc_dev;
>  	struct ti_tscadc_dev	*tscadc_dev = pdev->dev.platform_data;
> -	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
>  	struct device_node	*node = tscadc_dev->dev->of_node;
>  	int			err;
>  	u32			val32;
>  
> -	if (!pdata && !node) {
> -		dev_err(&pdev->dev, "Could not find platform data\n");
> +	if (!node) {
> +		dev_err(&pdev->dev, "Could not find valid DT data.\n");
>  		return -EINVAL;
>  	}
>  
> @@ -163,18 +161,14 @@ static int tiadc_probe(struct platform_device *pdev)
>  
>  	adc_dev->mfd_tscadc = tscadc_dev;
>  
> -	if (pdata)
> -		adc_dev->channels = pdata->adc_init->adc_channels;
> -	else {
> -		node = of_get_child_by_name(node, "adc");
> -		if (!node)
> -			return  -EINVAL;
> -		err = of_property_read_u32(node,
> -				"ti,adc-channels", &val32);
> -		if (err < 0)
> -			goto err_free_device;
> -		adc_dev->channels = val32;
> -	}
> +	node = of_get_child_by_name(node, "adc");
> +	if (!node)
> +		return  -EINVAL;
> +	err = of_property_read_u32(node,
> +			"ti,adc-channels", &val32);
> +	if (err < 0)
> +		goto err_free_device;
> +	adc_dev->channels = val32;
>  
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->name = dev_name(&pdev->dev);
> 
