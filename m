From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio_keys_polled: Correct check for invalid gpiod
Date: Mon, 22 Feb 2016 11:54:02 -0800
Message-ID: <20160222195402.GA28343@dtor-ws>
References: <1455876273-5913-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33515 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbcBVTyG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2016 14:54:06 -0500
Content-Disposition: inline
In-Reply-To: <1455876273-5913-1-git-send-email-geert+renesas@glider.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org

On Fri, Feb 19, 2016 at 11:04:33AM +0100, Geert Uytterhoeven wrote:
> At this point in gpio_keys_polled_probe(), button->gpiod contains either
> a pointer to a GPIO descriptor or NULL, because:
>   - gpio_keys_polled_get_devtree_pdata() fills in button->gpiod only if
>     devm_get_gpiod_from_child() succeeded,
>   - gpio_to_desc() returns NULL on failure, not an ERR_PTR(),
>   - button->gpiod is untouched if it was NULL, and button->gpio is not
>     valid.
> 
> Hence check for NULL only, and return -EINVAL on failure.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Question: Should it return -ENOENT instead?
> 
> next-20160219:drivers/leds/leds-gpio.c uses -EINVAL, too.
> ---
>  drivers/input/keyboard/gpio_keys_polled.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
> index 62bdb1d48c49dbd9..1ef3c66099a50d72 100644
> --- a/drivers/input/keyboard/gpio_keys_polled.c
> +++ b/drivers/input/keyboard/gpio_keys_polled.c
> @@ -330,8 +330,8 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
>  			button->gpiod = gpio_to_desc(button->gpio);
>  		}
>  
> -		if (IS_ERR(button->gpiod))
> -			return PTR_ERR(button->gpiod);
> +		if (!button->gpiod)
> +			return -EINVAL;

I wonder if we should move this check into body of

	if (!button->gpiod && gpio_is_valid(button->gpio)) {
		...
	}

Thanks.

-- 
Dmitry
