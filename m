From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 2/2] input: atmel-wm97xx: only build for AVR32
Date: Mon, 12 May 2014 15:16:45 +0200
Message-ID: <5370C9BD.4040201@atmel.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de> <1399560990-1402858-1-git-send-email-arnd@arndb.de> <1399560990-1402858-16-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:33924 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758158AbaELNQt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2014 09:16:49 -0400
In-Reply-To: <1399560990-1402858-16-git-send-email-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>

On 08/05/2014 16:56, Arnd Bergmann :
> Building this driver on ARM/at91 always gives us this error message:
> 
> drivers/input/touchscreen/atmel-wm97xx.c:63:2: error: #error Unknown CPU, this driver only supports AT32AP700X CPUs.
> 
> Clearly this configuration is not meant to work, so let's just prevent
> it in Kconfig. If we ever want to use it on another platform, we should
> also pass proper resources for GPIO, IRQ and memory, which are hardcoded
> to AT32AP700X at the moment.

Yes it seems so:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> ---
>  drivers/input/touchscreen/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index e2f0264..fe4c264 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -640,7 +640,7 @@ config TOUCHSCREEN_WM9713
>  
>  config TOUCHSCREEN_WM97XX_ATMEL
>  	tristate "WM97xx Atmel accelerated touch"
> -	depends on TOUCHSCREEN_WM97XX && (AVR32 || ARCH_AT91)
> +	depends on TOUCHSCREEN_WM97XX && AVR32
>  	help
>  	  Say Y here for support for streaming mode with WM97xx touchscreens
>  	  on Atmel AT91 or AVR32 systems with an AC97C module.
> 


-- 
Nicolas Ferre
