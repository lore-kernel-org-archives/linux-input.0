From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: twl4030-pwrbutton: Use input_set_capability()
 helper
Date: Fri, 28 Apr 2017 10:28:03 -0700
Message-ID: <20170428172803.GE4949@dtor-ws>
References: <20170428122855.3185-1-sebastian.reichel@collabora.co.uk>
 <20170428122855.3185-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34193 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939887AbdD1R2R (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 13:28:17 -0400
Content-Disposition: inline
In-Reply-To: <20170428122855.3185-2-sebastian.reichel@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 28, 2017 at 02:28:55PM +0200, Sebastian Reichel wrote:
> Cleanup driver slightly by using input_set_capability() instead
> of manually setting the required bits.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Applied, thank you.

> ---
>  drivers/input/misc/twl4030-pwrbutton.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> index 7c4504c31b07..1c13005b228f 100644
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -64,8 +64,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	pwr->evbit[0] = BIT_MASK(EV_KEY);
> -	pwr->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
> +	input_set_capability(pwr, EV_KEY, KEY_POWER);
>  	pwr->name = "twl4030_pwrbutton";
>  	pwr->phys = "twl4030_pwrbutton/input0";
>  	pwr->dev.parent = &pdev->dev;
> -- 
> 2.11.0
> 

-- 
Dmitry
