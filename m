From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: imx_keypad - Propagate the real error code on
 platform_get_irq() failure
Date: Mon, 17 Feb 2014 11:33:51 -0800
Message-ID: <20140217193350.GE19223@core.coreip.homeip.net>
References: <1392433187-7756-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:44291 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbaBQTeD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 14:34:03 -0500
Received: by mail-pb0-f42.google.com with SMTP id jt11so15712230pbb.15
        for <linux-input@vger.kernel.org>; Mon, 17 Feb 2014 11:34:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392433187-7756-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sat, Feb 15, 2014 at 12:59:46AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> No need to return a 'fake' return value on platform_get_irq() failure.
> 
> Just return the error code itself instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/imx_keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index cbf4f80..de07035 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -439,7 +439,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "no irq defined in platform data\n");
> -		return -EINVAL;
> +		return irq;
>  	}
>  
>  	input_dev = devm_input_allocate_device(&pdev->dev);
> -- 
> 1.8.1.2
> 

-- 
Dmitry
