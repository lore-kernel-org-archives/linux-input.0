From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: soc_button_array - Remove duplicate inclusion
 of input.h
Date: Wed, 28 May 2014 09:34:43 -0700
Message-ID: <20140528163443.GA6043@core.coreip.homeip.net>
References: <1401277459-31247-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:50556 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbaE1Qeq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2014 12:34:46 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so11330180pab.38
        for <linux-input@vger.kernel.org>; Wed, 28 May 2014 09:34:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401277459-31247-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org

On Wed, May 28, 2014 at 05:14:19PM +0530, Sachin Kamat wrote:
> input.h was included twice.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied, thank you.

> ---
>  drivers/input/misc/soc_button_array.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 20c80f543d5e..5a6334be30b8 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -17,7 +17,6 @@
>  #include <linux/acpi.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio_keys.h>
> -#include <linux/input.h>
>  #include <linux/platform_device.h>
>  #include <linux/pnp.h>
>  
> -- 
> 1.7.9.5
> 

-- 
Dmitry
