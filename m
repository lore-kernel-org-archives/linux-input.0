From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Input: wm831x-on - Convert to devm_kzalloc()
Date: Mon, 26 Dec 2011 20:08:46 +0100
Message-ID: <201112262008.46507.marek.vasut@gmail.com>
References: <1324925128-9161-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48839 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab1LZTIt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Dec 2011 14:08:49 -0500
Received: by eekc4 with SMTP id c4so11214707eek.19
        for <linux-input@vger.kernel.org>; Mon, 26 Dec 2011 11:08:48 -0800 (PST)
In-Reply-To: <1324925128-9161-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

> Saves a small amount of code and reduces the potential for leaks.

Shouldn't you still be kind and free the memory anyway?

M

> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/input/misc/wm831x-on.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/wm831x-on.c
> b/drivers/input/misc/wm831x-on.c index 47f18d6..aee53fb 100644
> --- a/drivers/input/misc/wm831x-on.c
> +++ b/drivers/input/misc/wm831x-on.c
> @@ -76,7 +76,8 @@ static int __devinit wm831x_on_probe(struct
> platform_device *pdev) int irq = platform_get_irq(pdev, 0);
>  	int ret;
> 
> -	wm831x_on = kzalloc(sizeof(struct wm831x_on), GFP_KERNEL);
> +	wm831x_on = devm_kzalloc(&pdev->dev, sizeof(struct wm831x_on),
> +				 GFP_KERNEL);
>  	if (!wm831x_on) {
>  		dev_err(&pdev->dev, "Can't allocate data\n");
>  		return -ENOMEM;
> @@ -120,7 +121,6 @@ err_irq:
>  err_input_dev:
>  	input_free_device(wm831x_on->dev);
>  err:
> -	kfree(wm831x_on);
>  	return ret;
>  }
> 
> @@ -132,7 +132,6 @@ static int __devexit wm831x_on_remove(struct
> platform_device *pdev) free_irq(irq, wm831x_on);
>  	cancel_delayed_work_sync(&wm831x_on->work);
>  	input_unregister_device(wm831x_on->dev);
> -	kfree(wm831x_on);
> 
>  	return 0;
>  }
