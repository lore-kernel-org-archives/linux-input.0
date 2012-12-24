From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wm831x-on - Convert to
 devm_input_allocate_device()
Date: Mon, 24 Dec 2012 09:53:28 -0800
Message-ID: <20121224175328.GB16272@core.coreip.homeip.net>
References: <1356009358-4638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:57146 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab2LXRxc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Dec 2012 12:53:32 -0500
Received: by mail-pb0-f53.google.com with SMTP id jt11so4071236pbb.40
        for <linux-input@vger.kernel.org>; Mon, 24 Dec 2012 09:53:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1356009358-4638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Thu, Dec 20, 2012 at 01:15:58PM +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied both, thanks Mark.

> ---
>  drivers/input/misc/wm831x-on.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
> index 558767d..caa2c406 100644
> --- a/drivers/input/misc/wm831x-on.c
> +++ b/drivers/input/misc/wm831x-on.c
> @@ -86,7 +86,7 @@ static int wm831x_on_probe(struct platform_device *pdev)
>  	wm831x_on->wm831x = wm831x;
>  	INIT_DELAYED_WORK(&wm831x_on->work, wm831x_poll_on);
>  
> -	wm831x_on->dev = input_allocate_device();
> +	wm831x_on->dev = devm_input_allocate_device(&pdev->dev);
>  	if (!wm831x_on->dev) {
>  		dev_err(&pdev->dev, "Can't allocate input dev\n");
>  		ret = -ENOMEM;
> @@ -119,7 +119,6 @@ static int wm831x_on_probe(struct platform_device *pdev)
>  err_irq:
>  	free_irq(irq, wm831x_on);
>  err_input_dev:
> -	input_free_device(wm831x_on->dev);
>  err:
>  	return ret;
>  }
> @@ -131,7 +130,6 @@ static int wm831x_on_remove(struct platform_device *pdev)
>  
>  	free_irq(irq, wm831x_on);
>  	cancel_delayed_work_sync(&wm831x_on->work);
> -	input_unregister_device(wm831x_on->dev);
>  
>  	return 0;
>  }
> -- 
> 1.7.10.4
> 

-- 
Dmitry
