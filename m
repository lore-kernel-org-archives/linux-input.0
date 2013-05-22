From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 4/7] iio/ti_am335x_adc: remove the else case
Date: Wed, 22 May 2013 22:55:41 +0100
Message-ID: <519D3EDD.2000104@kernel.org>
References: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de> <1369256897-25984-4-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39478 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513Ab3EVVzr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 May 2013 17:55:47 -0400
In-Reply-To: <1369256897-25984-4-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Patil Rachna <rachna@ti.com>

On 05/22/2013 10:08 PM, Sebastian Andrzej Siewior wrote:
> The DT support added in ("iio: adc: am335x: Add DT support")
> added an else case which shifts the code to the righ for no reaseon.
> This patch simply removes the pointless else case and shifts the code
> back to the left.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Either I am going completely mad or I never took the original patch.
I'm not entirely sure I can remember why though.  I think there were
issues with another patch in the series and so I was waiting for
a reposting that never happened.  Looking back I think the debate
was curriously enough whether it made sense ot have the platform_data
support in there or not.

Did anyone every take any of that series?  Which tree did you base these on?
> ---
>  drivers/iio/adc/ti_am335x_adc.c |   13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index f258eb0..ac78672 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -214,14 +214,11 @@ static int tiadc_probe(struct platform_device *pdev)
>  		node = of_get_child_by_name(node, "adc");
>  		if (!node)
>  			return  -EINVAL;
> -		else {
> -			err = of_property_read_u32(node,
> -					"ti,adc-channels", &val32);
> -			if (err < 0)
> -				goto err_free_device;
> -			else
> -				adc_dev->channels = val32;
> -		}
> +		err = of_property_read_u32(node,
> +				"ti,adc-channels", &val32);
> +		if (err < 0)
> +			goto err_free_device;
> +		adc_dev->channels = val32;
>  	}
>  
>  	indio_dev->dev.parent = &pdev->dev;
> 
