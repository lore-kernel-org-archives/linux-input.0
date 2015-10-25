From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: misc: e3x0-button: Fix typo in module name
Date: Sun, 25 Oct 2015 13:49:23 -0700
Message-ID: <20151025204923.GA23656@dtor-pixel>
References: <1445803567-8511-1-git-send-email-moritz.fischer@ettus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35583 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbbJYUta (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Oct 2015 16:49:30 -0400
Content-Disposition: inline
In-Reply-To: <1445803567-8511-1-git-send-email-moritz.fischer@ettus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: jaewon02.kim@samsung.com, k.kozlowski@samsung.com, dmurphy@ti.com, geert@linux-m68k.org, courtney.cavin@sonymobile.com, carlo@caione.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Moritz,

On Sun, Oct 25, 2015 at 01:06:06PM -0700, Moritz Fischer wrote:
> The produced module will be called e3x0-button, not
> e3x0_button.

This is not entirely correct. The file name is e3x0-button.ko, but the
module name is e3x0_button: when we construct KBUILD_MODNAME we
substitute commas and dashes for underscores - see scripts/Makefile.lib

> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  drivers/input/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 906dd1b..7ac277c7 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -101,7 +101,7 @@ config INPUT_E3X0_BUTTON
>  	  USRP E3x0 Button.
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called e3x0_button.
> +	  module will be called e3x0-button.
>  
>  config INPUT_PCSPKR
>  	tristate "PC Speaker support"
> -- 
> 2.6.2
> 

Thanks.

-- 
Dmitry
