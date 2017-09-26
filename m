From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/touchscreen: use EXPERT instead of EMBEDDED
Date: Tue, 26 Sep 2017 11:10:39 -0700
Message-ID: <20170926181039.GH14833@dtor-ws>
References: <ca02ff04-9ee4-eb3d-377b-f1fa73cce1ee@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34702 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967470AbdIZSKn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 14:10:43 -0400
Content-Disposition: inline
In-Reply-To: <ca02ff04-9ee4-eb3d-377b-f1fa73cce1ee@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Ritz <daniel.ritz@gmx.ch>

On Mon, Sep 25, 2017 at 06:47:00PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Change control of TOUCHSCREEN_USB_EASYTOUCH prompt string from
> EMBEDDED to EXPERT to match the rest of this Kconfig file.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Daniel Ritz <daniel.ritz@gmx.ch>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-414-rc2.orig/drivers/input/touchscreen/Kconfig
> +++ lnx-414-rc2/drivers/input/touchscreen/Kconfig
> @@ -949,7 +949,7 @@ config TOUCHSCREEN_USB_NEXIO
>  
>  config TOUCHSCREEN_USB_EASYTOUCH
>  	default y
> -	bool "EasyTouch USB Touch controller device support" if EMBEDDED
> +	bool "EasyTouch USB Touch controller device support" if EXPERT
>  	depends on TOUCHSCREEN_USB_COMPOSITE
>  	help
>  	  Say Y here if you have an EasyTouch USB Touch controller.
> 
> 

-- 
Dmitry
