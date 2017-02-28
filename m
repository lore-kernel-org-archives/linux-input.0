From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] tps6507x-ts: update to devm_* API
Date: Tue, 28 Feb 2017 10:57:46 -0800
Message-ID: <20170228185746.GJ20776@dtor-ws>
References: <1487950946-18590-1-git-send-email-yegorslists@googlemail.com>
 <1487950946-18590-2-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35556 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbdCAReU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Mar 2017 12:34:20 -0500
Received: by mail-pf0-f194.google.com with SMTP id y23so4185437pfk.2
        for <linux-input@vger.kernel.org>; Wed, 01 Mar 2017 09:34:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1487950946-18590-2-git-send-email-yegorslists@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-input@vger.kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, andrej.skvortzov@gmail.com

On Fri, Feb 24, 2017 at 04:42:24PM +0100, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Update the code to use devm_* API so that driver
> core will manage resources.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  drivers/input/touchscreen/tps6507x-ts.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
> index a340bfc..5bf1ec6 100644
> --- a/drivers/input/touchscreen/tps6507x-ts.c
> +++ b/drivers/input/touchscreen/tps6507x-ts.c
> @@ -226,7 +226,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
>  	 */
>  	init_data = tps_board->tps6507x_ts_init_data;
>  
> -	tsc = kzalloc(sizeof(struct tps6507x_ts), GFP_KERNEL);
> +	tsc = devm_kzalloc(&pdev->dev, sizeof(struct tps6507x_ts), GFP_KERNEL);

If you do this, why not use devm_input_allocate_polled_device() as well?
Then you can get rid of tps6507x_ts_remove().

Thanks.

-- 
Dmitry
