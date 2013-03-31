From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: eeti_ts - Remove redundant null check
Date: Sun, 31 Mar 2013 00:26:03 -0700
Message-ID: <20130331072603.GB7919@core.coreip.homeip.net>
References: <1364457222-4381-1-git-send-email-sachin.kamat@linaro.org>
 <1364457222-4381-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:32979 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab3CaH0H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Mar 2013 03:26:07 -0400
Received: by mail-da0-f54.google.com with SMTP id p1so690024dad.27
        for <linux-input@vger.kernel.org>; Sun, 31 Mar 2013 00:26:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364457222-4381-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org

On Thu, Mar 28, 2013 at 01:23:42PM +0530, Sachin Kamat wrote:
> 'pdata' is already dereferenced earlier. Hence this check is
> meaningless.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/input/touchscreen/eeti_ts.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
> index 55255a9..8fe5086 100644
> --- a/drivers/input/touchscreen/eeti_ts.c
> +++ b/drivers/input/touchscreen/eeti_ts.c
> @@ -206,8 +206,7 @@ static int eeti_ts_probe(struct i2c_client *client,
>  	if (err < 0)
>  		goto err1;
>  
> -	if (pdata)
> -		priv->irq_active_high = pdata->irq_active_high;
> +	priv->irq_active_high = pdata->irq_active_high;
>  
>  	irq_flags = priv->irq_active_high ?
>  		IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
> -- 
> 1.7.4.1
> 

Applied both, thank you Sachin.

-- 
Dmitry
