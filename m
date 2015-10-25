From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: misc: e3x0-button: Update Kconfig description
Date: Sun, 25 Oct 2015 13:56:08 -0700
Message-ID: <20151025205608.GB23656@dtor-pixel>
References: <1445803567-8511-1-git-send-email-moritz.fischer@ettus.com>
 <1445803567-8511-2-git-send-email-moritz.fischer@ettus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33641 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbbJYU4O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Oct 2015 16:56:14 -0400
Content-Disposition: inline
In-Reply-To: <1445803567-8511-2-git-send-email-moritz.fischer@ettus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: jaewon02.kim@samsung.com, k.kozlowski@samsung.com, dmurphy@ti.com, geert@linux-m68k.org, courtney.cavin@sonymobile.com, carlo@caione.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 25, 2015 at 01:06:07PM -0700, Moritz Fischer wrote:
> The driver is now used for the entire USRP e3xx series,
> this commit fixes the description that will be displayed in
> the menu accordingly.
> 
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>

Applied, thank you.

> ---
>  drivers/input/misc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 7ac277c7..a676c2c 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -94,11 +94,11 @@ config INPUT_BMA150
>  	  module will be called bma150.
>  
>  config INPUT_E3X0_BUTTON
> -	tristate "NI Ettus Research USRP E3x0 Button support."
> +	tristate "NI Ettus Research USRP E3xx Button support."
>  	default n
>  	help
>  	  Say Y here to enable support for the NI Ettus Research
> -	  USRP E3x0 Button.
> +	  USRP E3xx Button.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called e3x0-button.
> -- 
> 2.6.2
> 

-- 
Dmitry
