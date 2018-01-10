From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: of_touchscreen: add MODULE_LICENSE
Date: Wed, 10 Jan 2018 11:30:04 -0800
Message-ID: <20180110193004.olysgc36c53m5jae@dtor-ws>
References: <20180110163137.543730-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180110163137.543730-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 10, 2018 at 05:31:26PM +0100, Arnd Bergmann wrote:
> The lack of the MODULE_LICENSE tag can lead to a warning here:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/input/touchscreen/of_touchscreen.o
> 
> I'm adding a license and description tag, but no MODULE_AUTHOR()
> as this file is a collection of standalone helper functions that
> were all added by different developers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/of_touchscreen.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
> index 8d7f9c8f2771..9642f103b726 100644
> --- a/drivers/input/touchscreen/of_touchscreen.c
> +++ b/drivers/input/touchscreen/of_touchscreen.c
> @@ -13,6 +13,7 @@
>  #include <linux/input.h>
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
> +#include <linux/module.h>
>  
>  static bool touchscreen_get_prop_u32(struct device *dev,
>  				     const char *property,
> @@ -185,3 +186,6 @@ void touchscreen_report_pos(struct input_dev *input,
>  	input_report_abs(input, multitouch ? ABS_MT_POSITION_Y : ABS_Y, y);
>  }
>  EXPORT_SYMBOL(touchscreen_report_pos);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Device-tree helpers functions for touchscreen devices");
> -- 
> 2.9.0
> 

-- 
Dmitry
