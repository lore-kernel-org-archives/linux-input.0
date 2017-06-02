From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: tm2-touchkey - use LEN_ON as boolean value
 instead of LED_FULL
Date: Thu, 1 Jun 2017 22:07:03 -0700
Message-ID: <20170602050703.GA18657@dtor-ws>
References: <CGME20170601014820epcas1p24563493660adc23d437c55453aa7a655@epcas1p2.samsung.com>
 <20170601014736.17808-1-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33041 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdFBFHH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Jun 2017 01:07:07 -0400
Content-Disposition: inline
In-Reply-To: <20170601014736.17808-1-andi.shyti@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>

On Thu, Jun 01, 2017 at 10:47:36AM +0900, Andi Shyti wrote:
> Commit 4e552c8cb5bc ("leds: add LED_ON brightness as boolean value")
> has introduced the LED_ON enumeration value that can be used
> instead of LED_FULL which has more of a linear value.
> 
> Because the tm2-touchscreen doesn't have brightness levels, but
> it's a simple on/off led, use LED_ON instead of LED_FULL.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Jaechul Lee <jcsing.lee@samsung.com>
> Tested-by: Jaechul Lee <jcsing.lee@samsung.com>

Applied, thank you.

> ---
> Hi Dmitry,
> 
> this is the second version of this simple patch sent here:
> 
> https://marc.info/?l=linux-kernel&m=149062143701658&w=2
> 
> no changes, just added Jaechul's review and test.
> 
> Andi
> 
>  drivers/input/keyboard/tm2-touchkey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
> index 485900f953e0..abc266e40e17 100644
> --- a/drivers/input/keyboard/tm2-touchkey.c
> +++ b/drivers/input/keyboard/tm2-touchkey.c
> @@ -213,7 +213,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
>  	/* led device */
>  	touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
>  	touchkey->led_dev.brightness = LED_FULL;
> -	touchkey->led_dev.max_brightness = LED_FULL;
> +	touchkey->led_dev.max_brightness = LED_ON;
>  	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
>  
>  	error = devm_led_classdev_register(&client->dev, &touchkey->led_dev);
> -- 
> 2.11.0
> 

-- 
Dmitry
