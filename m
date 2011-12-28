From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: samsung-keypad - Set up driver data prior to
 registering
Date: Tue, 27 Dec 2011 20:33:54 -0800
Message-ID: <20111228043353.GA19976@core.coreip.homeip.net>
References: <1325006308-21149-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46496 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab1L1EeB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Dec 2011 23:34:01 -0500
Received: by iaeh11 with SMTP id h11so21410802iae.19
        for <linux-input@vger.kernel.org>; Tue, 27 Dec 2011 20:34:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1325006308-21149-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-input@vger.kernel.org

Hi Mark,

On Tue, Dec 27, 2011 at 05:18:27PM +0000, Mark Brown wrote:
> As soon as we register the platform device we may be opened and hence
> interrupted, meaning that we need to have the driver data set up for the
> interrupt handler to use. Move registration of the input device after the
> driver data is set up, also moving the wakeup setup for future changes.
> 

I do not think this is needed. We retrieve platform data only in
samsung_keypad_remove() and in suspend/resume methods which AFAIK will
not be called until after probe() returns.

Thanks.

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/input/keyboard/samsung-keypad.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
> index aa936ee..1aacf07 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -467,13 +467,13 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
>  		goto err_put_clk;
>  	}
>  
> +	device_init_wakeup(&pdev->dev, pdata->wakeup);
> +	platform_set_drvdata(pdev, keypad);
> +
>  	error = input_register_device(keypad->input_dev);
>  	if (error)
>  		goto err_free_irq;
>  
> -	device_init_wakeup(&pdev->dev, pdata->wakeup);
> -	platform_set_drvdata(pdev, keypad);
> -
>  	if (pdev->dev.of_node) {
>  		devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
>  		devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
> -- 
> 1.7.7.3
> 

-- 
Dmitry
