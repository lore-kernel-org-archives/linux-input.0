From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 17/19] mfd / iio: ti_am335x_adc: rename device from tiadc
 to TI-adc
Date: Sun, 02 Jun 2013 18:50:19 +0100
Message-ID: <51AB85DB.2000305@kernel.org>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-18-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369681926-22185-18-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 05/27/2013 08:12 PM, Sebastian Andrzej Siewior wrote:
> TI-adc reads a little better compared to tiadc.
> While here add an alias so the driver is loaded on demand.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

but you'll be wanting a few more acks on a name change...
> ---
>  drivers/iio/adc/ti_am335x_adc.c |    4 ++--
>  drivers/mfd/ti_am335x_tscadc.c  |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 72ffe89..d0317fc 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -299,14 +299,14 @@ static const struct dev_pm_ops tiadc_pm_ops = {
>  
>  static struct platform_driver tiadc_driver = {
>  	.driver = {
> -		.name   = "tiadc",
> +		.name   = "TI-adc",
>  		.owner	= THIS_MODULE,
>  		.pm	= TIADC_PM_OPS,
>  	},
>  	.probe	= tiadc_probe,
>  	.remove	= tiadc_remove,
>  };
> -
> +MODULE_ALIAS("platform:TI-adc");
>  module_platform_driver(tiadc_driver);
>  
>  MODULE_DESCRIPTION("TI ADC controller driver");
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index c25fe00..014df14 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -193,7 +193,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (adc_channels > 0) {
>  		tscadc->adc_cell = tscadc->used_cells;
>  		cell = &tscadc->cells[tscadc->used_cells++];
> -		cell->name = "tiadc";
> +		cell->name = "TI-adc";
>  		cell->platform_data = tscadc;
>  		cell->pdata_size = sizeof(*tscadc);
>  	}
> 
