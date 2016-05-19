From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: migor-ts - allow driver to build if
 COMPILE_TEST is enabled
Date: Thu, 19 May 2016 09:34:19 -0700
Message-ID: <20160519163419.GD38800@dtor-ws>
References: <1463502759-14393-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33970 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300AbcESQeX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 12:34:23 -0400
Content-Disposition: inline
In-Reply-To: <1463502759-14393-1-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-input@vger.kernel.org

On Tue, May 17, 2016 at 12:32:37PM -0400, Javier Martinez Canillas wrote:
> The driver only has runtime but no build time dependency with SH_MIGOR, so
> it can be built for testing purposes if the COMPILE_TEST option is enabled.
> 
> This is useful to have more build coverage and make sure that drivers are
> not affected by changes that could cause build regressions.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thank you.

> ---
> 
>  drivers/input/touchscreen/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 8ecdc38fd489..9f6f001ccf07 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -632,7 +632,7 @@ config TOUCHSCREEN_EDT_FT5X06
>  
>  config TOUCHSCREEN_MIGOR
>  	tristate "Renesas MIGO-R touchscreen"
> -	depends on SH_MIGOR && I2C
> +	depends on (SH_MIGOR || COMPILE_TEST) && I2C
>  	help
>  	  Say Y here to enable MIGO-R touchscreen support.
>  
> -- 
> 2.5.5
> 

-- 
Dmitry
