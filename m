From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 06/19] input/ti_am33x_tsc: remove platform_data support
Date: Tue, 4 Jun 2013 09:44:22 -0700
Message-ID: <20130604164420.GC26400@core.coreip.homeip.net>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-7-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1369681926-22185-7-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, May 27, 2013 at 09:11:53PM +0200, Sebastian Andrzej Siewior wrote:
> This patch removes access to platform data mfd_tscadc_board because the
> platform is DT only.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c |   27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index b7d3c23..b467196 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -24,7 +24,6 @@
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> -#include <linux/input/ti_am335x_tsc.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -425,24 +424,6 @@ static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
>  	return err;
>  }
>  
> -static int titsc_parse_pdata(struct ti_tscadc_dev *tscadc_dev,
> -					struct titsc *ts_dev)
> -{
> -	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
> -
> -	if (!pdata)
> -		return -EINVAL;
> -
> -	ts_dev->wires = pdata->tsc_init->wires;
> -	ts_dev->x_plate_resistance =
> -		pdata->tsc_init->x_plate_resistance;
> -	ts_dev->steps_to_configure =
> -		pdata->tsc_init->steps_to_configure;
> -	memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
> -		sizeof(pdata->tsc_init->wire_config));
> -	return 0;
> -}
> -
>  /*
>   * The functions for inserting/removing driver as a module.
>   */
> @@ -468,13 +449,9 @@ static int titsc_probe(struct platform_device *pdev)
>  	ts_dev->input = input_dev;
>  	ts_dev->irq = tscadc_dev->irq;
>  
> -	if (tscadc_dev->dev->platform_data)
> -		err = titsc_parse_pdata(tscadc_dev, ts_dev);
> -	else
> -		err = titsc_parse_dt(tscadc_dev, ts_dev);
> -
> +	err = titsc_parse_dt(tscadc_dev, ts_dev);
>  	if (err) {
> -		dev_err(&pdev->dev, "Could not find platform data\n");
> +		dev_err(&pdev->dev, "Could not find valid DT data.\n");
>  		err = -EINVAL;
>  		goto err_free_mem;
>  	}
> -- 
> 1.7.10.4
> 

-- 
Dmitry
