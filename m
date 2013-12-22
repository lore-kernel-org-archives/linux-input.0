From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/5] iio: ti_am335x_adc: Adjust the closing bracket in
 tiadc_read_raw()
Date: Sun, 22 Dec 2013 16:55:15 +0000
Message-ID: <52B71973.1000907@kernel.org>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de> <1387466911-3732-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47142 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab3LVQzQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Dec 2013 11:55:16 -0500
In-Reply-To: <1387466911-3732-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/19/13 15:28, Sebastian Andrzej Siewior wrote:
> It somehow looks like the ending bracket belongs to the if statement but
> it does belong to the while loop. This patch moves the bracket where it
> belongs.
> 
> Reviewed-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

Lee, I'm assuming you are fine taking the whole series!
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index d4d7482..e948454 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -341,7 +341,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	while (tiadc_readl(adc_dev, REG_ADCFSM) & SEQ_STATUS) {
>  		if (time_after(jiffies, timeout))
>  			return -EAGAIN;
> -		}
> +	}
>  	map_val = chan->channel + TOTAL_CHANNELS;
>  
>  	/*
> 
