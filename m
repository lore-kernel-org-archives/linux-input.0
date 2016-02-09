From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: Allow compile test of Goodix and Colibri VF50
 if !GPIOLIB
Date: Tue, 9 Feb 2016 10:34:09 -0800
Message-ID: <20160209183409.GF40460@dtor-ws>
References: <1454854687-21114-1-git-send-email-geert@linux-m68k.org>
 <1454854687-21114-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34480 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193AbcBISeN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2016 13:34:13 -0500
Content-Disposition: inline
In-Reply-To: <1454854687-21114-2-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bastien Nocera <hadess@hadess.net>, Sanchayan Maity <maitysanchayan@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org

On Sun, Feb 07, 2016 at 03:18:07PM +0100, Geert Uytterhoeven wrote:
> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> functionality only, can still be compiled if GPIOLIB is not enabled.
> 
> If COMPILE_TEST is enabled, relax the dependency on GPIOLIB for the
> recently introduced or relaxed symbols TOUCHSCREEN_GOODIX and
> TOUCHSCREEN_COLIBRI_VF50.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 66c62641b59a31cf..fba4d5665857221b 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -334,7 +334,7 @@ config TOUCHSCREEN_FUJITSU
>  config TOUCHSCREEN_GOODIX
>  	tristate "Goodix I2C touchscreen"
>  	depends on I2C
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y here if you have the Goodix touchscreen (such as one
>  	  installed in Onda v975w tablets) connected to your
> @@ -1112,7 +1112,8 @@ config TOUCHSCREEN_ZFORCE
>  
>  config TOUCHSCREEN_COLIBRI_VF50
>  	tristate "Toradex Colibri on board touchscreen driver"
> -	depends on GPIOLIB && IIO && VF610_ADC
> +	depends on IIO && VF610_ADC
> +	depends on GPIOLIB || COMPILE_TEST
>  	help
>  	  Say Y here if you have a Colibri VF50 and plan to use
>  	  the on-board provided 4-wire touchscreen driver.
> -- 
> 1.9.1
> 

-- 
Dmitry
