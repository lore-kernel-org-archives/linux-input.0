From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys - use module_platform_driver macro
Date: Thu, 27 Oct 2016 09:48:30 -0700
Message-ID: <20161027164830.GB36933@dtor-ws>
References: <20161027141554.GA31977@x220.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34627 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934834AbcJ0Qse (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 12:48:34 -0400
Content-Disposition: inline
In-Reply-To: <20161027141554.GA31977@x220.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Slawomir Stepien <sst@poczta.fm>
Cc: ldewangan@nvidia.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Slawomir,

On Thu, Oct 27, 2016 at 04:15:54PM +0200, Slawomir Stepien wrote:
> The gpio_keys_init() and gpio_keys_exit() are not doing anything
> more then just register and unregister. Replace these functions with
> module_platform_driver.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  drivers/input/keyboard/gpio_keys.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 2909365..e54b586 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -877,18 +877,7 @@ static struct platform_driver gpio_keys_device_driver = {
>  	}
>  };
>  
> -static int __init gpio_keys_init(void)
> -{
> -	return platform_driver_register(&gpio_keys_device_driver);
> -}
> -
> -static void __exit gpio_keys_exit(void)
> -{
> -	platform_driver_unregister(&gpio_keys_device_driver);
> -}
> -
> -late_initcall(gpio_keys_init);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Because of this we can't switch to module_platform_driver(). The
late_initcall was requirement of one of platforms because of the probe
ordering issues. It may be resolved now with deferred probing, but you'd
need to confirm with all the users.

> -module_exit(gpio_keys_exit);
> +module_platform_driver(gpio_keys_device_driver);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
> -- 
> 2.10.0

Thanks.

-- 
Dmitry
