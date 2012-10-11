From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: wm831x-ts - Convert to devm_kzalloc()
Date: Thu, 11 Oct 2012 00:39:55 -0700
Message-ID: <20121011073955.GA30395@core.coreip.homeip.net>
References: <1349875236-5707-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1349875236-5707-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38440 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897Ab2JKHj7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 03:39:59 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1576766pbb.19
        for <linux-input@vger.kernel.org>; Thu, 11 Oct 2012 00:39:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1349875236-5707-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org

On Wed, Oct 10, 2012 at 10:20:35PM +0900, Mark Brown wrote:
> Saves a little code and eliminates the possibility of introducing some
> leaks.
> 

*sigh* OK, I guess devm_* is here to stay and I have to get on with the
program. I am still unhappy that half of the patches converting/using
devm_* APIs are wrong (not these ones), but I will apply these 3.

Thanks.

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/input/touchscreen/wm831x-ts.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wm831x-ts.c b/drivers/input/touchscreen/wm831x-ts.c
> index bf0a4a6..c7eee56 100644
> --- a/drivers/input/touchscreen/wm831x-ts.c
> +++ b/drivers/input/touchscreen/wm831x-ts.c
> @@ -245,7 +245,8 @@ static __devinit int wm831x_ts_probe(struct platform_device *pdev)
>  	if (core_pdata)
>  		pdata = core_pdata->touch;
>  
> -	wm831x_ts = kzalloc(sizeof(struct wm831x_ts), GFP_KERNEL);
> +	wm831x_ts = devm_kzalloc(&pdev->dev, sizeof(struct wm831x_ts),
> +				 GFP_KERNEL);
>  	input_dev = input_allocate_device();
>  	if (!wm831x_ts || !input_dev) {
>  		error = -ENOMEM;
> @@ -376,7 +377,6 @@ err_data_irq:
>  	free_irq(wm831x_ts->data_irq, wm831x_ts);
>  err_alloc:
>  	input_free_device(input_dev);
> -	kfree(wm831x_ts);
>  
>  	return error;
>  }
> @@ -388,7 +388,6 @@ static __devexit int wm831x_ts_remove(struct platform_device *pdev)
>  	free_irq(wm831x_ts->pd_irq, wm831x_ts);
>  	free_irq(wm831x_ts->data_irq, wm831x_ts);
>  	input_unregister_device(wm831x_ts->input_dev);
> -	kfree(wm831x_ts);
>  
>  	return 0;
>  }
> -- 
> 1.7.10.4
> 

-- 
Dmitry
