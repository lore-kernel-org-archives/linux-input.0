From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: arizona-haptic: Correct disable of haptics device
Date: Wed, 2 Dec 2015 16:16:57 -0800
Message-ID: <20151203001657.GA37628@dtor-ws>
References: <1448906540-15356-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33358 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816AbbLCARD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2015 19:17:03 -0500
Content-Disposition: inline
In-Reply-To: <1448906540-15356-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Mon, Nov 30, 2015 at 06:02:20PM +0000, Charles Keepax wrote:
> A small copy and paste error was preventing the haptics device being
> disabled. This patch corrects the value written on disable.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Applied, thank you.

> ---
>  drivers/input/misc/arizona-haptics.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
> index 4bf6785..d5994a7 100644
> --- a/drivers/input/misc/arizona-haptics.c
> +++ b/drivers/input/misc/arizona-haptics.c
> @@ -97,8 +97,7 @@ static void arizona_haptics_work(struct work_struct *work)
>  
>  		ret = regmap_update_bits(arizona->regmap,
>  					 ARIZONA_HAPTICS_CONTROL_1,
> -					 ARIZONA_HAP_CTRL_MASK,
> -					 1 << ARIZONA_HAP_CTRL_SHIFT);
> +					 ARIZONA_HAP_CTRL_MASK, 0);
>  		if (ret != 0) {
>  			dev_err(arizona->dev, "Failed to stop haptics: %d\n",
>  				ret);
> -- 
> 2.1.4
> 

-- 
Dmitry
