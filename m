From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: keyboard: omap-keypad: Fixed coding style issue.
Date: Tue, 4 Sep 2012 23:11:42 -0700
Message-ID: <20120905061142.GA31943@core.coreip.homeip.net>
References: <1345767621-27816-1-git-send-email-joshua.taylor0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37133 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab2IEGLq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Sep 2012 02:11:46 -0400
Received: by dady13 with SMTP id y13so123608dad.19
        for <linux-input@vger.kernel.org>; Tue, 04 Sep 2012 23:11:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345767621-27816-1-git-send-email-joshua.taylor0@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh <joshua.taylor0@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Aug 23, 2012 at 08:20:21PM -0400, Josh wrote:
> Fixed spacing error on if statements and fixed tab error.
> Signed-off-by: Josh <joshua.taylor0@gmail.com>

Applied, thank you Josh.

> ---
>  drivers/input/keyboard/omap-keypad.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
> index a0222db..b03c5b9 100644
> --- a/drivers/input/keyboard/omap-keypad.c
> +++ b/drivers/input/keyboard/omap-keypad.c
> @@ -214,7 +214,7 @@ static void omap_kp_tasklet(unsigned long data)
>  	memcpy(keypad_state, new_state, sizeof(keypad_state));
>  
>  	if (key_down) {
> -                int delay = HZ / 20;
> +		int delay = HZ / 20;
>  		/* some key is pressed - keep irq disabled and use timer
>  		 * to poll the keypad */
>  		if (spurious)
> @@ -413,7 +413,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
>  	}
>  	return 0;
>  err5:
> -	for (i = irq_idx - 1; i >=0; i--)
> +	for (i = irq_idx - 1; i >= 0; i--)
>  		free_irq(row_gpios[i], omap_kp);
>  err4:
>  	input_unregister_device(omap_kp->input);
> @@ -421,10 +421,10 @@ err4:
>  err3:
>  	device_remove_file(&pdev->dev, &dev_attr_enable);
>  err2:
> -	for (i = row_idx - 1; i >=0; i--)
> +	for (i = row_idx - 1; i >= 0; i--)
>  		gpio_free(row_gpios[i]);
>  err1:
> -	for (i = col_idx - 1; i >=0; i--)
> +	for (i = col_idx - 1; i >= 0; i--)
>  		gpio_free(col_gpios[i]);
>  
>  	kfree(omap_kp);
> -- 
> 1.7.9.5
> 

-- 
Dmitry
