From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] Input: drv2667: Fix Kconfig error for help screen
Date: Tue, 5 May 2015 07:05:24 -0500
Message-ID: <5548B204.9000008@ti.com>
References: <1429899401-7629-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59925 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161728AbbEEMF0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 May 2015 08:05:26 -0400
In-Reply-To: <1429899401-7629-1-git-send-email-dmurphy@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

Bump
On 04/24/2015 01:16 PM, Dan Murphy wrote:
> Fix the Kconfig for the drv2667 as there was a copy/paste
> error.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/input/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 4436ab1..7838f1a 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -784,6 +784,6 @@ config INPUT_DRV2667_HAPTICS
>  	  Say Y to enable support for the TI DRV2667 haptics driver.
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called drv260x-haptics.
> +	  module will be called drv2667-haptics.
>  
>  endif


-- 
------------------
Dan Murphy

