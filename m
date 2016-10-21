From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] Input: gpio_keys_polled - fix DT node reference leak
Date: Fri, 21 Oct 2016 12:02:35 +0300
Message-ID: <20161021090235.GS24289@lahna.fi.intel.com>
References: <20161020220636.GA17948@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:17440 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932179AbcJUJCo (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Oct 2016 05:02:44 -0400
Content-Disposition: inline
In-Reply-To: <20161020220636.GA17948@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org

On Thu, Oct 20, 2016 at 03:06:36PM -0700, Dmitry Torokhov wrote:
> When someone requests button with wakeup (which this driver does not
> support) we should drop reference to the current child device node before
> returning error.
> 
> Note that when we using legacy platform data 'child' stays NULL which
> fwnode_handle_put() handles just fine.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/gpio_keys_polled.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
> index 270dcf7..72b3503 100644
> --- a/drivers/input/keyboard/gpio_keys_polled.c
> +++ b/drivers/input/keyboard/gpio_keys_polled.c
> @@ -291,6 +291,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
>  
>  		if (button->wakeup) {
>  			dev_err(dev, DRV_NAME " does not support wakeup\n");
> +			fwnode_handle_put(child);

Are you sure this is the right place?

I didn't try to compile this but to me it looks like there is no
variable named "child" in the whole gpio_keys_polled_probe() function.
Unless I'm looking at wrong branch ;-)

>  			return -EINVAL;
>  		}
>  
> -- 
> 2.8.0.rc3.226.g39d4020
> 
> 
> -- 
> Dmitry
