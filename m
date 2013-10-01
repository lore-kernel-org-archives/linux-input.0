From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/9] Staging/iio/adc/touchscreen/MXS: distinguish i.MX23's
 and i.MX28's LRADC
Date: Tue, 01 Oct 2013 11:58:52 +0100
Message-ID: <524AAAEC.8020006@kernel.org>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-3-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379946998-23041-3-git-send-email-jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 09/23/13 15:36, Juergen Beisert wrote:
> The LRADC units in i.MX23 and i.MX28 differ and we need to distinguish both
> SoC variants in order to make the touchscreen work on i.MX23
> 
> Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> CC: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
> CC: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> CC: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 00b61ac..3abc91f 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -177,6 +177,8 @@ struct mxs_lradc {
>  
>  	struct input_dev	*ts_input;
>  	struct work_struct	ts_work;
> +
> +	enum mxs_lradc_id	soc;
>  };
>  
>  #define	LRADC_CTRL0				0x00
> @@ -923,6 +925,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	}
>  
>  	lradc = iio_priv(iio);
> +	lradc->soc = (enum mxs_lradc_id)of_id->data;
>  
>  	/* Grab the memory area */
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
