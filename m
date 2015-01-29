From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 6/8] input: touchscreen: imx25 tcq driver
Date: Thu, 29 Jan 2015 19:56:40 +0530
Message-ID: <54CA4320.4030607@gmail.com>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de> <1422540556-14828-7-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422540556-14828-7-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
Cc: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, =?windows-1252?Q?Eric_B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On Thursday 29 January 2015 07:39 PM, Markus Pargmann wrote:
> This is a driver for the imx25 ADC/TSC module. It controls the
> touchscreen conversion queue and creates a touchscreen input device.
> The driver currently only supports 4 wire touchscreens. The driver uses
> a simple conversion queue of precharge, touch detection, X measurement,
> Y measurement, precharge and another touch detection.
>
> This driver uses the regmap from the parent to setup some touch specific
> settings in the core driver and setup a idle configuration with touch
> detection.
>
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> Acked-by: Dmitry Torokhov <dtor-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>   drivers/input/touchscreen/Kconfig         |   6 +
>   drivers/input/touchscreen/Makefile        |   1 +
>   drivers/input/touchscreen/fsl-imx25-tcq.c | 587 ++++++++++++++++++++++++++++++
>   3 files changed, 594 insertions(+)
>   create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
>
(...)

> +	ret = request_threaded_irq(priv->irq, mx25_tcq_irq, mx25_tcq_irq_thread,
> +				   IRQF_ONESHOT, pdev->name, priv);

We can use devres API for request_thread_irq()...

> +	if (ret) {
> +		dev_err(dev, "Failed requesting IRQ\n");
> +		goto err_clk_unprepare;
> +	}
> +
> +	ret = mx25_tcq_init(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to init tcq\n");
> +		goto error_free_irq;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +error_free_irq:
> +	free_irq(priv->irq, priv);

This is not required if we use devres API

> +err_clk_unprepare:
> +	clk_disable_unprepare(priv->clk);
> +	return ret;
> +}
> +
> +static int mx25_tcq_remove(struct platform_device *pdev)
> +{
> +	struct mx25_tcq_priv *priv = platform_get_drvdata(pdev);
> +
> +	free_irq(priv->irq, priv);

This also..


-- 
Regards,
Varka Bhadram.
