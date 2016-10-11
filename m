From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: set default for iProc touchscreen
Date: Tue, 11 Oct 2016 10:49:49 -0700
Message-ID: <20161011174949.GA8841@dtor-ws>
References: <1475950295-9660-1-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35470 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932256AbcJKRtw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Oct 2016 13:49:52 -0400
Content-Disposition: inline
In-Reply-To: <1475950295-9660-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>

On Sat, Oct 08, 2016 at 11:11:35AM -0700, Scott Branden wrote:
> Enable the Broadcom iProc touchscreen by default for all iProc platforms.

Why? Not all of them will have touchscreen attached, will they?

Thanks.

> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/input/touchscreen/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 2fb1f43..f785371 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -364,6 +364,7 @@ config TOUCHSCREEN_ILI210X
>  config TOUCHSCREEN_IPROC
>  	tristate "IPROC touch panel driver support"
>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
> +	default ARCH_BCM_IPROC
>  	help
>  	  Say Y here if you want to add support for the IPROC touch
>  	  controller to your system.
> -- 
> 2.5.0
> 

-- 
Dmitry
