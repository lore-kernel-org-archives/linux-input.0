From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx_keypad - use devm_ functions
Date: Wed, 13 Mar 2013 09:38:45 -0700
Message-ID: <20130313163845.GD27269@core.coreip.homeip.net>
References: <1363148484-5920-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63921 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab3CMQit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Mar 2013 12:38:49 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so1208759pbc.19
        for <linux-input@vger.kernel.org>; Wed, 13 Mar 2013 09:38:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363148484-5920-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: s.hauer@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Fabio,

On Wed, Mar 13, 2013 at 01:21:24AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>  
> @@ -572,15 +546,6 @@ static int imx_keypad_remove(struct platform_device *pdev)
>  
>  	input_unregister_device(keypad->input_dev);
>  

With managed input devices input_unregister_device() is not needed
either, please try removing imx_keypad_remove() altogether.

Thanks.

> -	free_irq(keypad->irq, keypad);
> -	clk_put(keypad->clk);
> -
> -	iounmap(keypad->mmio_base);
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, resource_size(res));
> -
> -	kfree(keypad);
> -
>  	return 0;
>  }
>  
> -- 
> 1.7.9.5
> 

-- 
Dmitry
