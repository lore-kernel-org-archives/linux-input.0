From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/19] iio: adc: am335x: Add DT support
Date: Sun, 02 Jun 2013 17:58:54 +0100
Message-ID: <51AB79CE.2000001@kernel.org>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-8-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369681926-22185-8-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
> From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
> 
> Add DT support for client ADC driver.
> 
> [ panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org : use of_get_child_by_name
> 	instead of of_find_node_by_name ]
> 
> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
> Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> [bigeasy: shift the code to the left]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

I would take this directly but then I'd imagine that will cause havoc
when the later patches are applied and touch both iio and mfd.


> ---
>  drivers/iio/adc/ti_am335x_adc.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 5f9a7e7..e657709 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -22,6 +22,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/iio/iio.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/mfd/ti_am335x_tscadc.h>
>  #include <linux/platform_data/ti_am335x_adc.h>
> @@ -141,11 +143,12 @@ static int tiadc_probe(struct platform_device *pdev)
>  	struct iio_dev		*indio_dev;
>  	struct tiadc_device	*adc_dev;
>  	struct ti_tscadc_dev	*tscadc_dev = pdev->dev.platform_data;
> -	struct mfd_tscadc_board	*pdata;
> +	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
> +	struct device_node	*node = tscadc_dev->dev->of_node;
>  	int			err;
> +	u32			val32;
>  
> -	pdata = tscadc_dev->dev->platform_data;
> -	if (!pdata || !pdata->adc_init) {
> +	if (!pdata && !node) {
>  		dev_err(&pdev->dev, "Could not find platform data\n");
>  		return -EINVAL;
>  	}
> @@ -159,7 +162,19 @@ static int tiadc_probe(struct platform_device *pdev)
>  	adc_dev = iio_priv(indio_dev);
>  
>  	adc_dev->mfd_tscadc = tscadc_dev;
> -	adc_dev->channels = pdata->adc_init->adc_channels;
> +
> +	if (pdata)
> +		adc_dev->channels = pdata->adc_init->adc_channels;
> +	else {
> +		node = of_get_child_by_name(node, "adc");
> +		if (!node)
> +			return  -EINVAL;
> +		err = of_property_read_u32(node,
> +				"ti,adc-channels", &val32);
> +		if (err < 0)
> +			goto err_free_device;
> +		adc_dev->channels = val32;
> +	}
>  
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->name = dev_name(&pdev->dev);
> 
