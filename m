From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers/input/keyboard/lm8323.c: fix incorrect left shift
Date: Sat, 5 Jan 2013 15:01:25 -0800
Message-ID: <20130105230125.GA6475@core.coreip.homeip.net>
References: <1357412945-41774-1-git-send-email-nickolai@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:63858 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935Ab3AEXBa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Jan 2013 18:01:30 -0500
Content-Disposition: inline
In-Reply-To: <1357412945-41774-1-git-send-email-nickolai@csail.mit.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, Jan 05, 2013 at 02:09:05PM -0500, Nickolai Zeldovich wrote:
> In drivers/input/keyboard/lm8323.c, INT_PWM1 is already a bitmask,
> not the bit number, so shifting by INT_PWM1 is incorrect.
> 
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>

Applied, thank you Nickolai.

> ---
>  drivers/input/keyboard/lm8323.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
> index 93c8126..0de23f4 100644
> --- a/drivers/input/keyboard/lm8323.c
> +++ b/drivers/input/keyboard/lm8323.c
> @@ -398,7 +398,7 @@ static irqreturn_t lm8323_irq(int irq, void *_lm)
>  			lm8323_configure(lm);
>  		}
>  		for (i = 0; i < LM8323_NUM_PWMS; i++) {
> -			if (ints & (1 << (INT_PWM1 + i))) {
> +			if (ints & (INT_PWM1 << i)) {
>  				dev_vdbg(&lm->client->dev,
>  					 "pwm%d engine completed\n", i);
>  				pwm_done(&lm->pwm[i]);
> -- 
> 1.7.10.4
> 

-- 
Dmitry
