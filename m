From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -resend] Input: i8042, lower log level when
 controller_init fails
Date: Mon, 24 Oct 2016 10:55:58 -0700
Message-ID: <20161024175558.GA24290@dtor-ws>
References: <20161003085652.15810-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34749 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbcJXR4C (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Oct 2016 13:56:02 -0400
Content-Disposition: inline
In-Reply-To: <20161003085652.15810-1-jslaby@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Oct 03, 2016 at 10:56:52AM +0200, Jiri Slaby wrote:
> There are a lot of machines without i8042 controller nowadays.
> Sometimes i8042_controller_check returns 0 because i8042_flush does
> nothing (read from the port returns 0 and the while loop does not
> execute).
> 
> In that case, the probe method is called and fails with this error
> output to console:
> i8042: Can't read CTR while initializing i8042
> i8042: probe of i8042 failed with error -5
> 
> Lower the former error message to be KERN_INFO and make the function
> in that case return -ENODEV instead of -EIO. This will suppress the
> latter.

No, this is low level enough that I would prefer keeping it as is. I
think we should instead bail out earlier, maybe in i8042_pnp_init().
Right now we only trust PNP data if we are on ia64. Maybe we could
extend it to X86_64 as well.

Thanks.

> 
> There is also an IBM support page about these messages:
> https://www-947.ibm.com/support/entry/portal/docdisplay?lndocid=migr-5082417
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/input/serio/i8042.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 405252a884dd..15c87b98d70b 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -950,8 +950,8 @@ static int i8042_controller_init(void)
>  			udelay(50);
>  
>  		if (i8042_command(&ctr[n++ % 2], I8042_CMD_CTL_RCTR)) {
> -			pr_err("Can't read CTR while initializing i8042\n");
> -			return -EIO;
> +			pr_info("Can't read CTR while initializing i8042. Either i8042 controller is not present or it does not respond.\n");
> +			return -ENODEV;
>  		}
>  
>  	} while (n < 2 || ctr[0] != ctr[1]);
> -- 
> 2.10.0
> 

-- 
Dmitry
