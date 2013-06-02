From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] iio/ti_am335x_adc: check if we found the value
Date: Sun, 02 Jun 2013 19:03:26 +0100
Message-ID: <51AB88EE.3090602@kernel.org>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de> <1369847397-27451-6-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369847397-27451-6-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 05/29/2013 06:09 PM, Sebastian Andrzej Siewior wrote:
> Usually we get all the values we wanted but it is possible, that te ADC
> unit is busy performing the conversation for the HW events. In that case
> -EBUSY is returned and the user may re-call the function.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index df2de4c..6a00874 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -161,6 +161,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	int i;
>  	unsigned int fifo1count, read;
>  	u32 step = UINT_MAX;
> +	bool found = false;
>  
>  	/*
>  	 * When the sub-system is first enabled,
> @@ -185,10 +186,14 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
>  	for (i = 0; i < fifo1count; i++) {
>  		read = tiadc_readl(adc_dev, REG_FIFO1);
> -		if (read >> 16 == step)
> +		if (read >> 16 == step) {
>  			*val = read & 0xfff;
> +			found = true;
> +		}
>  	}
>  	tiadc_writel(adc_dev, REG_SE, STPENB_STEPENB);
> +	if (found == false)
> +		return -EBUSY;
>  
>  	return IIO_VAL_INT;
>  }
> 
