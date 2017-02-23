From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 4/4] Input: soc_button_array - Propagate error from
 gpiod_count()
Date: Thu, 23 Feb 2017 00:40:32 -0800
Message-ID: <20170223084032.GG18639@dtor-ws>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
 <20170220161549.39490-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34525 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdBWImA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Feb 2017 03:42:00 -0500
Content-Disposition: inline
In-Reply-To: <20170220161549.39490-5-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org

On Mon, Feb 20, 2017 at 06:15:49PM +0200, Andy Shevchenko wrote:
> Since gpiod_count() does not return 0 anymore, we don't need to shadow
> its error code and would safely propagate to the user.
> 
> While here, replace second parameter by NULL in order to prevent side
> effects on _DSD enabled firmware.
> 
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/misc/soc_button_array.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index ddb2f22fca7a..c3b8e1fb4699 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -169,9 +169,10 @@ static int soc_button_probe(struct platform_device *pdev)
>  
>  	button_info = (struct soc_button_info *)id->driver_data;
>  
> -	if (gpiod_count(dev, KBUILD_MODNAME) <= 0) {
> +	error = gpiod_count(dev, NULL);
> +	if (error < 0) {
>  		dev_dbg(dev, "no GPIO attached, ignoring...\n");
> -		return -ENODEV;
> +		return error;
>  	}
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -- 
> 2.11.0
> 

-- 
Dmitry
