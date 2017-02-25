From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] input/touchscreen: add header file to fix ad7879.c
 build errors
Date: Sat, 25 Feb 2017 10:51:11 -0800
Message-ID: <20170225185111.GA31929@dtor-ws>
References: <25206b81-0f8c-8d40-32ad-e6ad5c03098d@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34656 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdBYSvP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Feb 2017 13:51:15 -0500
Content-Disposition: inline
In-Reply-To: <25206b81-0f8c-8d40-32ad-e6ad5c03098d@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Michael Hennerich <michael.hennerich@analog.com>

On Fri, Feb 24, 2017 at 10:30:22AM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Add header file to fix these build errors:
> 
> ../drivers/input/touchscreen/ad7879.c: In function 'ad7879_parse_dt':
> ../drivers/input/touchscreen/ad7879.c:505:2: error: implicit declaration of function 'device_property_read_u32' [-Werror=implicit-function-declaration]
>   err = device_property_read_u32(dev, "adi,resistance-plate-x", &tmp);
>   ^
> ../drivers/input/touchscreen/ad7879.c:512:2: error: implicit declaration of function 'device_property_read_u8' [-Werror=implicit-function-declaration]
>   device_property_read_u8(dev, "adi,first-conversion-delay",
>   ^
> ../drivers/input/touchscreen/ad7879.c:521:2: error: implicit declaration of function 'device_property_read_bool' [-Werror=implicit-function-declaration]
>   ts->swap_xy = device_property_read_bool(dev, "touchscreen-swapped-x-y");
>   ^
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thank you.

> Cc:	Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc:	linux-input@vger.kernel.org
> Cc:	Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/input/touchscreen/ad7879.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20170224.orig/drivers/input/touchscreen/ad7879.c
> +++ linux-next-20170224/drivers/input/touchscreen/ad7879.c
> @@ -26,6 +26,7 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/gpio.h>

-- 
Dmitry
