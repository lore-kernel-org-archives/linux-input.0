From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 02/15] input: sh_keysc: Restrict non-COMPILE_TEST
 compilation
Date: Thu, 28 Nov 2013 16:36:36 +0900
Message-ID: <20131128073636.GD24146@verge.net.au>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36552 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab3K1Hgi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Nov 2013 02:36:38 -0500
Content-Disposition: inline
In-Reply-To: <1385515117-23664-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, Nov 27, 2013 at 02:18:24AM +0100, Laurent Pinchart wrote:
> Hardware supported by the driver is only found on SUPERH or
> ARCH_SHMOBILE platforms. Restrict non-COMPILE_TEST compilation to them.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index bb174c1..a673c9f 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -525,7 +525,7 @@ config KEYBOARD_SUNKBD
>  
>  config KEYBOARD_SH_KEYSC
>  	tristate "SuperH KEYSC keypad support"
> -	depends on SUPERH || ARM || COMPILE_TEST
> +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>  	help
>  	  Say Y here if you want to use a keypad attached to the KEYSC block
>  	  on SuperH processors such as sh7722 and sh7343.
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
