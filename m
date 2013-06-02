From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] drivers/iio: am335x_adc: cleanup on missing DT nodes
Date: Sun, 02 Jun 2013 18:56:40 +0100
Message-ID: <51AB8758.5010705@kernel.org>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de> <1369847397-27451-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369847397-27451-2-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 05/29/2013 06:09 PM, Sebastian Andrzej Siewior wrote:
> Currently we leak indio_dev() if the DT has no "adc" node in it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Given you are going to end up rerolling the original series
(and it hasn't been taken by anyone yet) this wants to go
in a new version of that not as a separate patch.
> ---
>  drivers/iio/adc/ti_am335x_adc.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index d0317fc..b2f27de 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -208,8 +208,10 @@ static int tiadc_probe(struct platform_device *pdev)
>  	adc_dev->mfd_tscadc = tscadc_dev;
>  
>  	node = of_get_child_by_name(node, "adc");
> -	if (!node)
> -		return  -EINVAL;
> +	if (!node) {
> +		err = -EINVAL;
> +		goto err_free_device;
> +	}
>  	err = of_property_read_u32(node,
>  			"ti,adc-channels", &val32);
>  	if (err < 0)
> 
