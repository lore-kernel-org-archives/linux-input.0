From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/14] iio: adc: at91-sama5d2_adc: force trigger removal
 on module remove
Date: Fri, 29 Dec 2017 16:22:50 +0000
Message-ID: <20171229162250.7d68a0c8@archlinux>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
        <1513955241-10985-11-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513955241-10985-11-git-send-email-eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 22 Dec 2017 17:07:17 +0200
Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:

> On module remove, if we do not call trigger remove, the trigger
> stays in the subsystem, and on further module insert, we will have
> multiple triggers, and the old one is not usable.
> Have to call the remove function on module remove to solve this.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

This needs more explanation.  I can't see why the managed removal
isn't sufficient.  On removal the dev should have gone away taking
the trigger with it.

If it isn't then it looks like a straight forward bug that needs fixing.

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 4eff835..7b9febc 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1180,6 +1180,9 @@ static int at91_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> +	if (st->selected_trig->hw_trig)
> +		devm_iio_trigger_unregister(&indio_dev->dev, st->trig);
> +
>  	iio_device_unregister(indio_dev);
>  
>  	at91_adc_dma_disable(pdev);
