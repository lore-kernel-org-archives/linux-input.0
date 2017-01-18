From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 10/33] Input: twl4030_keypad - Drop unnecessary call to
 platform_set_drvdata and other changes
Date: Wed, 18 Jan 2017 11:45:43 -0800
Message-ID: <20170118194543.GM33920@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-11-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34069 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdARTpq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 14:45:46 -0500
Content-Disposition: inline
In-Reply-To: <1484761614-12225-11-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rui Teng <rui.teng@linux.vnet.ibm.com>

On Wed, Jan 18, 2017 at 09:46:31AM -0800, Guenter Roeck wrote:
> There is no call to platform_get_drvdata() or dev_get_drvdata().
> Drop the unnecessary call to platform_set_drvdata().
> 
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Drop platform_set_drvdata()
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thank you.

> ---
>  drivers/input/keyboard/twl4030_keypad.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
> index 323a0fb575a4..29396ca69416 100644
> --- a/drivers/input/keyboard/twl4030_keypad.c
> +++ b/drivers/input/keyboard/twl4030_keypad.c
> @@ -441,7 +441,6 @@ static int twl4030_kp_probe(struct platform_device *pdev)
>  		return -EIO;
>  	}
>  
> -	platform_set_drvdata(pdev, kp);
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
