From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] input/nomadik-ske: suspend and resume support
Date: Mon, 25 Jun 2012 00:31:25 -0700
Message-ID: <20120625073125.GE13876@core.coreip.homeip.net>
References: <1339942671-20121-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54014 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab2FYHbb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 03:31:31 -0400
Received: by pbbrp8 with SMTP id rp8so6181115pbb.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 00:31:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339942671-20121-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-input@vger.kernel.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Linus,

On Sun, Jun 17, 2012 at 04:17:51PM +0200, Linus Walleij wrote:
> From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> 
> Suspend and resume support for ske keypad by using disable or
> enable of keypad.

I do not understand this changelog entry. The driver appears to already
have suspend/resume handling, but apparently it is deficient. Please
explain exactly why old implementation is not enough.

> 
> Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/input/keyboard/nomadik-ske-keypad.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
> index 6857454..68c36a7 100644
> --- a/drivers/input/keyboard/nomadik-ske-keypad.c
> +++ b/drivers/input/keyboard/nomadik-ske-keypad.c
> @@ -368,8 +368,11 @@ static int ske_keypad_suspend(struct device *dev)
>  
>  	if (device_may_wakeup(dev))
>  		enable_irq_wake(irq);
> -	else
> +	else {
> +		disable_irq(keypad->irq);
>  		ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
> +		clk_disable(keypad->clk);
> +	}
>  
>  	return 0;
>  }
> @@ -382,8 +385,11 @@ static int ske_keypad_resume(struct device *dev)
>  
>  	if (device_may_wakeup(dev))
>  		disable_irq_wake(irq);
> -	else
> -		ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
> +	else {
> +		clk_enable(keypad->clk);
> +		enable_irq(keypad->irq);
> +		ske_keypad_chip_init(keypad);

ske_keypad_chip_init() is marked __init, if it is used in resume it has
to lose this markup.

Thanks.

-- 
Dmitry
