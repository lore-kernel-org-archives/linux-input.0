From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/10 v3] Input: ep93xx_keypad: Fix platform_get_irq's
 error checking
Date: Sat, 18 Nov 2017 10:30:29 -0800
Message-ID: <20171118183029.zooxomhrejzatuvd@dtor-ws>
References: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:41810 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967045AbdKRSac (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 13:30:32 -0500
Content-Disposition: inline
In-Reply-To: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: maxime.ripard@free-electrons.com, wens@csie.org, mcuos.com@gmail.com, linux@roeck-us.net, linux@armlinux.org.uk, lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Nov 18, 2017 at 04:25:08PM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>                Return keypad->irq insted of -ENXIO.
> changes in v3 :
>                Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> 
>  drivers/input/keyboard/ep93xx_keypad.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index f77b295..01788a7 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -257,8 +257,8 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>  	}
>  
>  	keypad->irq = platform_get_irq(pdev, 0);
> -	if (!keypad->irq) {
> -		err = -ENXIO;
> +	if (keypad->irq <= 0) {
> +		err = keypad->irq;

Argh, so what will happen if you return with keypad->irq == 0? Can you
please stop and consider what exactly  you are doing before churning
patches like crazy?

>  		goto failed_free;
>  	}
>  
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
