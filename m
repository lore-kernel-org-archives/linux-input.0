From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] leds-alix2: add support for button connected to J15
Date: Tue, 20 Oct 2009 21:35:53 -0700
Message-ID: <20091021043553.GA378@core.coreip.homeip.net>
References: <20091016130315.GT28832@buzzloop.caiaq.de> <20091018072738.GF3935@core.coreip.homeip.net> <20091019073728.GC28832@buzzloop.caiaq.de> <20091020013852.GC24370@core.coreip.homeip.net> <20091020101357.GR28832@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:33638 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbZJUEfy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2009 00:35:54 -0400
Content-Disposition: inline
In-Reply-To: <20091020101357.GR28832@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Constantin Baranov <const@mimas.ru>

Hi Daniel,

On Tue, Oct 20, 2009 at 12:13:57PM +0200, Daniel Mack wrote:
> +
> +	ret = input_register_polled_device(ipdev);
> +	
> +	if (ret) {
> +		input_free_polled_device(ipdev);
> +		ipdev = NULL;
> +	}
> +
> +	return ret;
> +}

Ah, don't be lazy ;)

static void alix_button_unregister(void)
{
	if (ipdev) {
		input_unregister_polled_device(ipdev);
		/* Yes, polled devices need to be freed */
		input_free_polled_device(ipdev);
		ipdev = NULL;
	}
}

> +#else
> +#define alix_button_register() (0)

static inline int alix_button_register(void) { return 0; }
static inline void alix_button_unregister(void) { }

So you get typechecking (if any).

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
> @@ -103,6 +158,12 @@ static int alix_led_remove(struct platform_device *pdev)
>  
>  	for (i = 0; i < ARRAY_SIZE(alix_leds); i++)
>  		led_classdev_unregister(&alix_leds[i].cdev);
> +
> +#ifdef CONFIG_LEDS_ALIX2_BUTTON
> +	if (ipdev)
> +		input_unregister_polled_device(ipdev);
> +#endif

	alix_button_unregister();

> +
>  	return 0;
>  }
>  

-- 
Dmitry
