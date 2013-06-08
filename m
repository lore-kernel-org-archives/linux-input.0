From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 17/22] mfd & iio/ti_am335x_adc: rename device from tiadc
 to TI-am335x-adc
Date: Sat, 08 Jun 2013 10:19:28 +0100
Message-ID: <51B2F720.9090708@kernel.org>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-18-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370449495-29981-18-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 06/05/2013 05:24 PM, Sebastian Andrzej Siewior wrote:
> TI-adc reads a little better compared to tiadc. And if we add am335x to
> it then we have the same naming scheme as the tsc side.
> While here add an alias so the driver is loaded on demand.
Good, I also prefer this naming.

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c |    4 ++--
>  drivers/mfd/ti_am335x_tscadc.c  |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index c6695a8..38f2415 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -318,14 +318,14 @@ static const struct dev_pm_ops tiadc_pm_ops = {
>  
>  static struct platform_driver tiadc_driver = {
>  	.driver = {
> -		.name   = "tiadc",
> +		.name   = "TI-am335x-adc",
>  		.owner	= THIS_MODULE,
>  		.pm	= TIADC_PM_OPS,
>  	},
>  	.probe	= tiadc_probe,
>  	.remove	= tiadc_remove,
>  };
> -
> +MODULE_ALIAS("platform:TI-am335x-adc");
>  module_platform_driver(tiadc_driver);
>  
>  MODULE_DESCRIPTION("TI ADC controller driver");
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index ba9235a..8bdab8d 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -203,7 +203,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (adc_channels > 0) {
>  		tscadc->adc_cell = tscadc->used_cells;
>  		cell = &tscadc->cells[tscadc->used_cells++];
> -		cell->name = "tiadc";
> +		cell->name = "TI-am335x-adc";
>  		cell->platform_data = &tscadc;
>  		cell->pdata_size = sizeof(tscadc);
>  	}
> 
