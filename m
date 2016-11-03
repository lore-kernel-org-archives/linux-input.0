From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: gpio_keys - Also send release events for ABS
 codes
Date: Thu, 3 Nov 2016 09:21:59 -0700
Message-ID: <20161103162159.GB15366@dtor-ws>
References: <20161101102504.3783-1-paul@crapouillou.net>
 <20161101102504.3783-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36640 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758076AbcKCQWD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 3 Nov 2016 12:22:03 -0400
Content-Disposition: inline
In-Reply-To: <20161101102504.3783-2-paul@crapouillou.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maarten ter Huurne <maarten@treewalker.org>

On Tue, Nov 01, 2016 at 11:25:03AM +0100, Paul Cercueil wrote:
> Right now, the gpio-keys driver is mostly used with EV_KEY event types.
> However, this driver (and its devicetree bindings) support specifying
> a different input type, like EV_ABS, even though this doesn't work in
> practice: "key pressed" events are correctly received and treated, but
> "key released" are silently ignored.
> 
> With this commit, keys configured as EV_ABS will inject an event with
> the value 0 when released.

No, this will break setups like this:

gpio0 - ABS_X - 0
gpio1 - ABS_X - 1
gpio2 - ABS_X - 2
...
gpio7 - ABS_X - 7

- something like a slider built on top of gpios.

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/input/keyboard/gpio_keys.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 2909365..7018c49 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -369,6 +369,8 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
>  	if (type == EV_ABS) {
>  		if (state)
>  			input_event(input, type, button->code, button->value);
> +		else
> +			input_event(input, type, button->code, 0);
>  	} else {
>  		input_event(input, type, button->code, !!state);
>  	}
> -- 
> 2.9.3
> 

Thanks.

-- 
Dmitry
