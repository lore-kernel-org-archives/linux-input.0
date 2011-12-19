From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] Adding Wacom I2C stylus support
Date: Mon, 19 Dec 2011 13:22:38 +0800
Message-ID: <4EEECA1E.7050103@cn.fujitsu.com>
References: <1324271114-25673-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:49985 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750907Ab1LSFXn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Dec 2011 00:23:43 -0500
In-Reply-To: <1324271114-25673-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org, Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>, dmitry.torokhov@gmail.com

On 12/19/2011 01:05 PM, Tatsunosuke Tobita wrote:

> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> 
> 


At least, add a short comment here?

> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> ---
>  drivers/input/touchscreen/Kconfig  |   11 +++++++++++
>  drivers/input/touchscreen/Makefile |    2 ++
>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 3488ffe..cae448e 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -738,4 +738,15 @@ config TOUCHSCREEN_TPS6507X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tps6507x_ts.
>  
> +config TOUCHSCREEN_WACOM_I2C
> +	tristate "Wacom Tablet support(I2C)"
> +	depends on I2C
> +	help
> +	 Say Y here if you want to use the I2C version of the Wacom Pen.
> +	 Make sure to say Y to "Mouse support" (CONFIG_INPUT_MOUSEDEV)
> +	 and/or "Event interface support" (CONFIG_INPUT_EVDEV) as well.
> +
> +	 To compile this driver as a module, choose M here: the module
> +	 will be called wacom_i2c.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index f957676..216dd57 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -5,6 +5,7 @@
>  # Each configuration option enables a list of files.
>  
>  wm97xx-ts-y := wm97xx-core.o
> +wacom_i2c-ts-objs := wacom_i2c_func.o wacom_i2c.o


Why do you add this line? or if I missed something?

Thanks
-Wanlong Gao

>  
>  obj-$(CONFIG_TOUCHSCREEN_88PM860X)	+= 88pm860x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_AD7877)	+= ad7877.o
> @@ -61,3 +62,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_WACOM_I2C)	+= wacom_i2c-ts.o


