From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] leds-alix2: add support for button connected to J15
Date: Mon, 19 Oct 2009 18:38:53 -0700
Message-ID: <20091020013852.GC24370@core.coreip.homeip.net>
References: <20091016130315.GT28832@buzzloop.caiaq.de> <20091018072738.GF3935@core.coreip.homeip.net> <20091019073728.GC28832@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:36184 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbZJTBiw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2009 21:38:52 -0400
Content-Disposition: inline
In-Reply-To: <20091019073728.GC28832@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Constantin Baranov <const@mimas.ru>

Hi Daniel,

On Mon, Oct 19, 2009 at 09:37:28AM +0200, Daniel Mack wrote:
> +#else
> +#define alix_button_register() (0)
> +#endif
> +
>  static int __init alix_led_probe(struct platform_device *pdev)
>  {
>  	int i;
> @@ -89,6 +139,11 @@ static int __init alix_led_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto fail;
>  	}
> +
> +	ret = alix_button_register();
> +	if (ret) 
> +		goto fail;
> +
>  	return 0;
>  
>  fail:
> @@ -103,6 +158,10 @@ static int alix_led_remove(struct platform_device *pdev)
>  
>  	for (i = 0; i < ARRAY_SIZE(alix_leds); i++)
>  		led_classdev_unregister(&alix_leds[i].cdev);
> +	
> +	if (ipdev)
> +		input_unregister_polled_device(ipdev);
> +	


I think it will bomb on !CONFIG_LEDS_ALIX2_BUTTON... You need
alix_button_register() and a dummy wrapper for it as well.

-- 
Dmitry
