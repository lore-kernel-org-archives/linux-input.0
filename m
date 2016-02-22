From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] input: gpio_keys: Make use of the device property API
Date: Mon, 22 Feb 2016 11:58:15 -0800
Message-ID: <20160222195815.GB28343@dtor-ws>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
 <1455876982-6743-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455876982-6743-4-git-send-email-geert+renesas@glider.be>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 19, 2016 at 11:16:22AM +0100, Geert Uytterhoeven wrote:
> @@ -887,7 +870,7 @@ static struct platform_driver gpio_keys_device_driver = {
>  	.driver		= {
>  		.name	= "gpio-keys",
>  		.pm	= &gpio_keys_pm_ops,
> -		.of_match_table = of_match_ptr(gpio_keys_of_match),
> +		.of_match_table = gpio_keys_of_match,

Why are we changing this? I think match table should still be guarded
by #ifdef CONFIG_OF.

Thanks.

-- 
Dmitry
