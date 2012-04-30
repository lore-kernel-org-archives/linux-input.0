From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: usbtouchscreen: fix typo
Date: Sun, 29 Apr 2012 22:32:46 -0700
Message-ID: <20120430053246.GB10766@core.coreip.homeip.net>
References: <1335759459-669-1-git-send-email-shawnlandden@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:42739 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab2D3Fcv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 01:32:51 -0400
Content-Disposition: inline
In-Reply-To: <1335759459-669-1-git-send-email-shawnlandden@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Landden <shawnlandden@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Apr 29, 2012 at 09:17:39PM -0700, Shawn Landden wrote:
> 
> Signed-off-by: Shawn Landden <shawnlandden@gmail.com>

Applied both, thank you Shawn.

> ---
>  drivers/input/touchscreen/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index a31b05f..350d9db 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -745,7 +745,7 @@ config TOUCHSCREEN_USB_EASYTOUCH
>  	bool "EasyTouch USB Touch controller device support" if EMBEDDED
>  	depends on TOUCHSCREEN_USB_COMPOSITE
>  	help
> -	  Say Y here if you have a EasyTouch USB Touch controller device support.
> +	  Say Y here if you have an EasyTouch USB Touch controller.
>  	  If unsure, say N.
>  
>  config TOUCHSCREEN_TOUCHIT213
> -- 
> 1.7.9.5
> 

-- 
Dmitry
