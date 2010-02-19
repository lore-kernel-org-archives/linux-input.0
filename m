From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
Date: Fri, 19 Feb 2010 01:17:55 -0800
Message-ID: <20100219091755.GB2856@core.coreip.homeip.net>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
 <1266510750-9846-3-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f200.google.com ([209.85.210.200]:37944 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab0BSJSA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Feb 2010 04:18:00 -0500
Received: by yxe38 with SMTP id 38so7263778yxe.4
        for <linux-input@vger.kernel.org>; Fri, 19 Feb 2010 01:18:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266510750-9846-3-git-send-email-anarsoul@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-input@vger.kernel.org

Hi Vasily,

On Thu, Feb 18, 2010 at 06:32:28PM +0200, Vasily Khoruzhick wrote:
> By default, driver reports touches when it gots (1 << ts.shift)
> samples, even if stylus is up. This behavior looks wrong to me.
> Patch makes driver to report touches only when stylus is down.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/input/touchscreen/s3c2410_ts.c |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index 6386b44..e2fe2ed 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -128,25 +128,25 @@ static void touch_timer_fire(unsigned long data)
>  
>  	down = get_down(data0, data1);
>  
> -	if (ts.count == (1 << ts.shift)) {
> -		ts.xp >>= ts.shift;
> -		ts.yp >>= ts.shift;
> +	if (down) {
> +		if (ts.count == (1 << ts.shift)) {
> +			ts.xp >>= ts.shift;
> +			ts.yp >>= ts.shift;
>  
> -		dev_dbg(ts.dev, "%s: X=%lu, Y=%lu, count=%d\n",
> -			__func__, ts.xp, ts.yp, ts.count);
> +			dev_dbg(ts.dev, "%s: X=%lu, Y=%lu, count=%d\n",
> +				__func__, ts.xp, ts.yp, ts.count);
>  
> -		input_report_abs(ts.input, ABS_X, ts.xp);
> -		input_report_abs(ts.input, ABS_Y, ts.yp);
> +			input_report_abs(ts.input, ABS_X, ts.xp);
> +			input_report_abs(ts.input, ABS_Y, ts.yp);
>  
> -		input_report_key(ts.input, BTN_TOUCH, 1);
> -		input_sync(ts.input);
> +			input_report_key(ts.input, BTN_TOUCH, 1);
> +			input_sync(ts.input);
>  
> +		}
>  		ts.xp = 0;
>  		ts.yp = 0;
>  		ts.count = 0;

I do not think this is right. Here you reset sampling data regardless
of whether you got the right number of samples or not. You should repeat
s3c_adc_start only if you got (1 << ts.shift) samples. But I think I see
why touchpad may stop reporintg sometimes - if timer fires before you
get the needed number of samples nothing will happen as timer is not
gettign rearmed.

> -	}
>  
> -	if (down) {
>  		s3c_adc_start(ts.client, 0, 1 << ts.shift);
>  	} else {
>  		ts.count = 0;

I also think this branch is missing ts.xp = ts.yp = 0;

-- 
Dmitry
