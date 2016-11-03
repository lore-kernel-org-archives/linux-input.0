From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: gpio_keys - Set ABS params when using axes
Date: Thu, 3 Nov 2016 09:24:01 -0700
Message-ID: <20161103162401.GC15366@dtor-ws>
References: <20161101102504.3783-1-paul@crapouillou.net>
 <20161101102504.3783-3-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161101102504.3783-3-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maarten ter Huurne <maarten@treewalker.org>
List-Id: linux-input@vger.kernel.org

On Tue, Nov 01, 2016 at 11:25:04AM +0100, Paul Cercueil wrote:
> The gpio-keys supports the EV_ABS event type, but does not actually
> configure the input device to work with that mode.
> 
> This patch configures the axis corresponding to button->code as being
> in the range [-1,+1]. This makes it possible to use gpio-keys to
> implement a hat (using the ABS_HAT0X /ABS_HAT0Y axes, with two GPIOs
> each with values -1/+1).

What if I am emitting values of 10?

Also, reporting limits on axis is not a requirement, it is simply a
hint. If your userspace refuses axis with unrefined (aka 0) min and max
you need to fix it.

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/input/keyboard/gpio_keys.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 7018c49..1f2850a 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -540,6 +540,9 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  
>  	input_set_capability(input, button->type ?: EV_KEY, button->code);
>  
> +	if (button->type == EV_ABS)
> +		input_set_abs_params(input, button->code, -1, 1, 0, 0);
> +
>  	/*
>  	 * Install custom action to cancel release timer and
>  	 * workqueue item.
> -- 
> 2.9.3
> 

Thanks.

-- 
Dmitry
