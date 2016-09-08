From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] Input: jornada720_kbd - remove unneeded
 mach/hardware.h include
Date: Wed, 7 Sep 2016 19:21:22 -0700
Message-ID: <20160908022122.GC6445@dtor-ws>
References: <20160907095029.GL1041@n2100.armlinux.org.uk>
 <E1bhZVi-0005cf-AK@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35365 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbcIHCV0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2016 22:21:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id n24so1765266pfb.2
        for <linux-input@vger.kernel.org>; Wed, 07 Sep 2016 19:21:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1bhZVi-0005cf-AK@rmk-PC.armlinux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-input@vger.kernel.org

On Wed, Sep 07, 2016 at 10:51:14AM +0100, Russell King wrote:
> The Jornada720 keyboard driver does not make use of anything from the
> mach/hardware.h header, so this header can be removed.
> 
> Tested-by: Adam Wysocki <armlinux@chmurka.net>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied, thank you.

> ---
>  drivers/input/keyboard/jornada720_kbd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
> index 6ac9fee1d8fa..3d29e5e392c2 100644
> --- a/drivers/input/keyboard/jornada720_kbd.c
> +++ b/drivers/input/keyboard/jornada720_kbd.c
> @@ -25,7 +25,6 @@
>  #include <linux/slab.h>
>  
>  #include <mach/jornada720.h>
> -#include <mach/hardware.h>
>  
>  MODULE_AUTHOR("Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
>  MODULE_DESCRIPTION("HP Jornada 710/720/728 keyboard driver");
> -- 
> 2.1.0
> 

-- 
Dmitry
