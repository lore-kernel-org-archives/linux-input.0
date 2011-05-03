From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ads7846: fix gpio_pendown configuration
Date: Tue, 3 May 2011 09:18:18 -0700
Message-ID: <20110503161818.GD6509@core.coreip.homeip.net>
References: <1304438573-7692-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48420 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab1ECQSY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2011 12:18:24 -0400
Received: by pvg12 with SMTP id 12so96887pvg.19
        for <linux-input@vger.kernel.org>; Tue, 03 May 2011 09:18:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304438573-7692-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-input@vger.kernel.org

On Tue, May 03, 2011 at 07:02:53PM +0300, Igor Grinberg wrote:
> The pendown gpio was requested but not configured for input.
> Request and configure it in one shot.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

There is no significant change from the previos version of the patch by
Sourav Poddar that I tried to apply and had to revert. Does it compile
if !CONFIG_GENERIC_GPIO?

> ---
>  drivers/input/touchscreen/ads7846.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index c24946f..bf067aa 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -956,7 +956,8 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>  		ts->get_pendown_state = pdata->get_pendown_state;
>  	} else if (gpio_is_valid(pdata->gpio_pendown)) {
>  
> -		err = gpio_request(pdata->gpio_pendown, "ads7846_pendown");
> +		err = gpio_request_one(pdata->gpio_pendown, GPIOF_IN,
> +				       "ads7846_pendown");
>  		if (err) {
>  			dev_err(&spi->dev, "failed to request pendown GPIO%d\n",
>  				pdata->gpio_pendown);
> -- 
> 1.7.3.4
> 

-- 
Dmitry
