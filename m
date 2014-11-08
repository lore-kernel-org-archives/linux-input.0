From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: twl4030-pwrbutton: ensure a wakeup event is
 recorded.
Date: Sat, 8 Nov 2014 12:36:58 -0800
Message-ID: <20141108203658.GA40319@dtor-ws>
References: <20141108104015.635a7388@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:46241 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaKHUhE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Nov 2014 15:37:04 -0500
Content-Disposition: inline
In-Reply-To: <20141108104015.635a7388@notabene.brown>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>

On Sat, Nov 08, 2014 at 10:40:15AM +1100, NeilBrown wrote:
> 
> 
> This button is treated as a wakeup source, so we need to initialise it
> correctly.
> 
> Without the device_init_wakeup() call, dev->power.wakeup will
> be NULL, and pm_wakeup_event() will do nothing.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Applied, thank you.

> 
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> index fb3b63b2f85c..8400a1a34d87 100644
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -85,6 +85,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, pwr);
> +	device_init_wakeup(&pdev->dev, true);
>  
>  	return 0;
>  }



-- 
Dmitry
