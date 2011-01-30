From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ARM:ucb1x00-ts: ucb1x00_ts - add BTN_TOUCH event
Date: Sun, 30 Jan 2011 11:57:06 -0800
Message-ID: <20110130195705.GA19871@core.coreip.homeip.net>
References: <1296391256-2127-1-git-send-email-jochen@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64873 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab1A3T5O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jan 2011 14:57:14 -0500
Received: by iwn9 with SMTP id 9so4756497iwn.19
        for <linux-input@vger.kernel.org>; Sun, 30 Jan 2011 11:57:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296391256-2127-1-git-send-email-jochen@scram.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jochen Friedrich <jochen@scram.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>

On Sun, Jan 30, 2011 at 01:40:56PM +0100, Jochen Friedrich wrote:
> Add BTN_TOUCH event reporting to ucb1x00_ts touchscreen driver.
> This will make this touchscreen driver behave consistently wrt.
> BTN_TOUCH.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>

Acked-by: Dmitry Torokhov <dtor@mail.ru>


> ---
>  drivers/mfd/ucb1x00-ts.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
> index 92b85e2..38ffbd5 100644
> --- a/drivers/mfd/ucb1x00-ts.c
> +++ b/drivers/mfd/ucb1x00-ts.c
> @@ -60,6 +60,7 @@ static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x
>  	input_report_abs(idev, ABS_X, x);
>  	input_report_abs(idev, ABS_Y, y);
>  	input_report_abs(idev, ABS_PRESSURE, pressure);
> +	input_report_key(idev, BTN_TOUCH, 1);
>  	input_sync(idev);
>  }
>  
> @@ -68,6 +69,7 @@ static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
>  	struct input_dev *idev = ts->idev;
>  
>  	input_report_abs(idev, ABS_PRESSURE, 0);
> +	input_report_key(idev, BTN_TOUCH, 0);
>  	input_sync(idev);
>  }
>  
> @@ -384,7 +386,8 @@ static int ucb1x00_ts_add(struct ucb1x00_dev *dev)
>  	idev->open       = ucb1x00_ts_open;
>  	idev->close      = ucb1x00_ts_close;
>  
> -	__set_bit(EV_ABS, idev->evbit);
> +	idev->evbit[0]   = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
> +	idev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
>  
>  	input_set_drvdata(idev, ts);
>  
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
