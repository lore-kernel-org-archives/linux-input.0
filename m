From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Tue, 5 May 2015 17:01:35 -0700
Message-ID: <20150506000135.GA25707@dtor-ws>
References: <1430869596-7044-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35642 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbEFABj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 20:01:39 -0400
Received: by igbyr2 with SMTP id yr2so117540050igb.0
        for <linux-input@vger.kernel.org>; Tue, 05 May 2015 17:01:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430869596-7044-1-git-send-email-marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-input@vger.kernel.org, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Wed, May 06, 2015 at 01:46:36AM +0200, Marek Vasut wrote:
> Use msecs_to_jiffies(50) instead of plain (HZ / 50) as the
> former is independent of kernel HZ settings and provides
> stable delay.
> 
> The delay here must be stable, otherwise we might start polling
> for pen-up event too early. This would in turn render the
> touchscreen unusable.

Doesn't jiffy "size" depend on HZ value? I'd expect the delay be
"stable" regardless of the value of HZ. I do not disagree with the
patch, but I think you need better justification here (except I think
the delay should be 20 msec, not 50, and we may use a constant instead
of reevaluating it all the time).

> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/stmpe-ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> NOTE: This applies all the way back to Linux ~2.6.36, so I should
>       probably also submit this for -stable if acceptable ?

No, I do not think it needs to be in stable as it does not really fix
any bug as far as I can see. 

> 
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> index 42ce31a..a8f5ea7 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -164,7 +164,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
>  			STMPE_TSC_CTRL_TSC_EN, STMPE_TSC_CTRL_TSC_EN);
>  
>  	/* start polling for touch_det to detect release */
> -	schedule_delayed_work(&ts->work, HZ / 50);
> +	schedule_delayed_work(&ts->work, msecs_to_jiffies(50));
>  
>  	return IRQ_HANDLED;
>  }
> -- 
> 2.1.4
> 

Thanks.

-- 
Dmitry
