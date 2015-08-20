From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input: gpio_keys_polled: Request GPIO pin as input.
Date: Thu, 20 Aug 2015 12:12:04 -0700
Message-ID: <20150820191204.GA24261@localhost>
References: <20150818120756.GI1552@lahna.fi.intel.com>
 <1440093000-16946-1-git-send-email-plr.vincent@gmail.com>
 <7d70142c2f6133128c26cc1ca3a883d8cadbce64.1440092849.git.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:32988 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbHTTMH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 15:12:07 -0400
Received: by pdrh1 with SMTP id h1so17628309pdr.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 12:12:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7d70142c2f6133128c26cc1ca3a883d8cadbce64.1440092849.git.plr.vincent@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vincent Pelletier <plr.vincent@gmail.com>
Cc: linux-input@vger.kernel.org, mika.westerberg@linux.intel.com, aaron.lu@intel.com

On Thu, Aug 20, 2015 at 07:50:00PM +0200, Vincent Pelletier wrote:
> GPIOF_IN flag was lost in:
> Commit 633a21d80b4a("input: gpio_keys_polled: Add support for GPIO
> descriptors").
> 
> Without this flag, legacy code path (for non-descriptor GPIO declarations)
> would configure GPIO as output (0 meaning GPIOF_DIR_OUT | GPIOF_INIT_LOW).
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied and tagged for stable, thank you.

> ---
>  drivers/input/keyboard/gpio_keys_polled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
> index 097d721..c6dc644 100644
> --- a/drivers/input/keyboard/gpio_keys_polled.c
> +++ b/drivers/input/keyboard/gpio_keys_polled.c
> @@ -246,7 +246,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
>  		 * convert it to descriptor.
>  		 */
>  		if (!button->gpiod && gpio_is_valid(button->gpio)) {
> -			unsigned flags = 0;
> +			unsigned flags = GPIOF_IN;
>  
>  			if (button->active_low)
>  				flags |= GPIOF_ACTIVE_LOW;
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
