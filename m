From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pxa27x_keypad - remove unnecessary ARM includes
Date: Tue, 3 Feb 2015 15:13:33 -0800
Message-ID: <20150203231333.GB16639@dtor-ws>
References: <1423004670-16711-1-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46063 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbbBCXNh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Feb 2015 18:13:37 -0500
Received: by mail-ie0-f176.google.com with SMTP id at20so29117580iec.7
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2015 15:13:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423004670-16711-1-git-send-email-robh@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-input@vger.kernel.org

On Tue, Feb 03, 2015 at 05:04:30PM -0600, Rob Herring wrote:
> Remove some left-over ARM only includes in order to enable building on
> ARM64. __raw_{read,write}l were getting implicitly included, so add
> linux/io.h include.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org

Applied, thank you.

> ---
>  drivers/input/keyboard/pxa27x_keypad.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index a90d6bd..a89488a 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/input.h>
> +#include <linux/io.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> @@ -28,10 +29,6 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  
> -#include <asm/mach/arch.h>
> -#include <asm/mach/map.h>
> -
> -#include <mach/hardware.h>
>  #include <linux/platform_data/keypad-pxa27x.h>
>  /*
>   * Keypad Controller registers
> -- 
> 2.1.0
> 

-- 
Dmitry
