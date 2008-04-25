From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [INPUT] ucb1400: add key interface
Date: Fri, 25 Apr 2008 11:26:23 -0400
Message-ID: <20080425112156.ZZRA012@mailhub.coreip.homeip.net>
References: <20080424110305.GA2971@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:35269 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755021AbYDYPgg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 11:36:36 -0400
Received: by yw-out-2324.google.com with SMTP id 5so556567ywh.1
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2008 08:36:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080424110305.GA2971@www.tglx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Siewior <bigeasy@linutronix.de>
Cc: linux-input@vger.kernel.org

Hi Sebastian,

On Thu, Apr 24, 2008 at 01:03:05PM +0200, Sebastian Siewior wrote:
> now the driver sends key events and feeds /dev/input/mice
> 
> Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
> ---
>  drivers/input/touchscreen/ucb1400_ts.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
> index 9337352..ad14413 100644
> --- a/drivers/input/touchscreen/ucb1400_ts.c
> +++ b/drivers/input/touchscreen/ucb1400_ts.c
> @@ -326,12 +326,14 @@ static int ucb1400_ts_thread(void *_ucb)
>  			 */
>  			if (valid) {
>  				ucb1400_ts_event_release(ucb->ts_idev);
> +				input_report_key(ucb->ts_idev, BTN_TOUCH, 0);

Why don't you put input_repoer_key() inside ts_event_release()?

>  				valid = 0;
>  			}
>  
>  			timeout = MAX_SCHEDULE_TIMEOUT;
>  		} else {
>  			valid = 1;
> +			input_report_key(ucb->ts_idev, BTN_TOUCH, 1);

And here it should go into ucb1400_ts_evt_add(). Plus, you might want
to select some kind of pressure thresholds before reporting touch press
and release.

>  			ucb1400_ts_evt_add(ucb->ts_idev, p, x, y);
>  			timeout = msecs_to_jiffies(10);
>  		}

Thanks.

-- 
Dmitry
