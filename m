From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/6] Input: Replace KEYBOARD_CROS_EC dependency
Date: Wed, 19 Aug 2015 14:26:09 -0700
Message-ID: <20150819212609.GA19499@dtor-pixel>
References: <1439983198-4696-1-git-send-email-javier@osg.samsung.com>
 <1439983198-4696-7-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36223 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbbHSV0M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Aug 2015 17:26:12 -0400
Content-Disposition: inline
In-Reply-To: <1439983198-4696-7-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>, Doug Anderson <dianders@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org

On Wed, Aug 19, 2015 at 01:19:58PM +0200, Javier Martinez Canillas wrote:
> The ChromeOS EC keyboard driver config depend on CROS_EC_PROTO but
> MFD_CROS_EC select CROS_EC_PROTO instead. Mixing select and depends
> on is bad practice as it may lead to circular Kconfig dependencies.
> 
> Since the platform device that is matched with the keyboard driver
> is registered by the ChromeOS EC mfd driver, KEYBOARD_CROS_EC really
> should depend on MFD_CROS_EC. And because this config option selects
> CROS_EC_PROTO, that dependency is met as well. So make the driver
> to depend on MFD_CROS_EC instead of CROS_EC_PROTO.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

Applied, thank you.

> 
> 
> ---
> 
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index da53ae6a9334..2e80107ff630 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -689,7 +689,7 @@ config KEYBOARD_W90P910
>  config KEYBOARD_CROS_EC
>  	tristate "ChromeOS EC keyboard"
>  	select INPUT_MATRIXKMAP
> -	depends on CROS_EC_PROTO
> +	depends on MFD_CROS_EC
>  	help
>  	  Say Y here to enable the matrix keyboard used by ChromeOS devices
>  	  and implemented on the ChromeOS EC. You must enable one bus option
> -- 
> 2.4.3
> 

-- 
Dmitry
