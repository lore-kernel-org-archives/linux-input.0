From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: imx_keypad - Omit error message
 devm_kzalloc() failure
Date: Mon, 17 Feb 2014 11:34:54 -0800
Message-ID: <20140217193452.GF19223@core.coreip.homeip.net>
References: <1392433187-7756-1-git-send-email-festevam@gmail.com>
 <1392433187-7756-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:35093 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbaBQTfC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 14:35:02 -0500
Received: by mail-pb0-f49.google.com with SMTP id up15so15698505pbc.36
        for <linux-input@vger.kernel.org>; Mon, 17 Feb 2014 11:35:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392433187-7756-2-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sat, Feb 15, 2014 at 12:59:47AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no need to print an error message in the driver for devm_kzalloc()
> failure because OOM core code handles it properly.

I'd rather keep this in. We may change OOM messaging at later time
making it less verbose.

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/input/keyboard/imx_keypad.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index de07035..40ad98d 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -450,10 +450,8 @@ static int imx_keypad_probe(struct platform_device *pdev)
>  
>  	keypad = devm_kzalloc(&pdev->dev, sizeof(struct imx_keypad),
>  			     GFP_KERNEL);
> -	if (!keypad) {
> -		dev_err(&pdev->dev, "not enough memory for driver data\n");
> +	if (!keypad)
>  		return -ENOMEM;
> -	}
>  
>  	keypad->input_dev = input_dev;
>  	keypad->irq = irq;
> -- 
> 1.8.1.2
> 

-- 
Dmitry
