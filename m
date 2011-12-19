From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] Input:Add support for Wacom Stylus with I2C interface.
Date: Mon, 19 Dec 2011 13:49:27 +0800
Message-ID: <4EEED067.4080306@cn.fujitsu.com>
References: <1324273631-28671-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:51591 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab1LSFuc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Dec 2011 00:50:32 -0500
In-Reply-To: <1324273631-28671-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org, Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>, dmitry.torokhov@gmail.com

On 12/19/2011 01:47 PM, Tatsunosuke Tobita wrote:

> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> 
> This modification sets up for adding support for Wacom I2C Stylus Device.
> 
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  drivers/input/touchscreen/Kconfig  |   11 +++++++++++
>  drivers/input/touchscreen/Makefile |    1 +
>  2 files changed, 12 insertions(+), 0 deletions(-)
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
> index f957676..61bbfc8 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_WACOM_I2C)	+= wacom_i2c.o


