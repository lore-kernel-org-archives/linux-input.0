From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] s3c24xx_ts: re-enable IRQ on resume
Date: Fri, 19 Feb 2010 01:05:07 -0800
Message-ID: <20100219090506.GA2856@core.coreip.homeip.net>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
 <1266510750-9846-5-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f200.google.com ([209.85.210.200]:36928 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab0BSJFN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Feb 2010 04:05:13 -0500
Received: by yxe38 with SMTP id 38so7258183yxe.4
        for <linux-input@vger.kernel.org>; Fri, 19 Feb 2010 01:05:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266510750-9846-5-git-send-email-anarsoul@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-input@vger.kernel.org

On Thu, Feb 18, 2010 at 06:32:30PM +0200, Vasily Khoruzhick wrote:
> IRQ should be enabled on resume, otherwise driver doesn't
> report events.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/input/touchscreen/s3c2410_ts.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index e2fe2ed..6738c26 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -401,6 +401,7 @@ static int s3c2410ts_resume(struct device *dev)
>  	struct s3c2410_ts_mach_info *info = pdev->dev.platform_data;
>  
>  	clk_enable(ts.clock);
> +	enable_irq(ts.irq_tc);
>  
>  	/* Initialise registers */
>  	if ((info->delay & 0xffff) > 0)

Applied to my 'next' branch, thank you Vasily.

-- 
Dmitry
