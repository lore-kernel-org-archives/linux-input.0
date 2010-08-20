From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7846 - move regulator codes out of spinlock
 protected area
Date: Thu, 19 Aug 2010 22:19:23 -0700
Message-ID: <20100820051921.GD12243@core.coreip.homeip.net>
References: <1282205670-30618-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45492 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab0HTFTi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Aug 2010 01:19:38 -0400
Received: by iwn5 with SMTP id 5so423445iwn.19
        for <linux-input@vger.kernel.org>; Thu, 19 Aug 2010 22:19:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282205670-30618-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: notasas@gmail.com, vapier@gentoo.org, linux-input@vger.kernel.org

On Thu, Aug 19, 2010 at 04:14:30PM +0800, Jason Wang wrote:
> The commit 9114337 introduces regulator operations in the ads7846
> touchscreen driver. Among these operations, some are called in the
> spinlock protected context.
> On most platforms, the regulator operation is achieved through
> i2c/spi bus transfer operations, some of bus transfer operations will
> call wait_for_completion function. It isn't allowable  to call
> sleepable function in the atomic context. So move them out from the
> atomic context.

I do not believe simply moving calls out of splnlock-protected area is
enough. Are all regulator drivers allow regulator_enable() and
regulator_disable() to be called simultaneously? Even if they do allow
it I think there still a race between ads7846_enable/disable/suspend/resume
and you need to wrap all of it in a mutex...

> 
> [tested on TI OMAP3530EVM board]
> 
> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
> ---
>  drivers/input/touchscreen/ads7846.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 1603193..9421df9 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -531,6 +531,9 @@ static ssize_t ads7846_disable_store(struct device *dev,
>  	if (strict_strtoul(buf, 10, &i))
>  		return -EINVAL;
>  
> +	if (!i)
> +		regulator_enable(ts->reg);
> +
>  	spin_lock_irq(&ts->lock);
>  
>  	if (i)
> @@ -540,6 +543,9 @@ static ssize_t ads7846_disable_store(struct device *dev,
>  
>  	spin_unlock_irq(&ts->lock);
>  
> +	if (i)
> +		regulator_disable(ts->reg);
> +
>  	return count;
>  }
>  
> @@ -855,8 +861,6 @@ static void ads7846_disable(struct ads7846 *ts)
>  		}
>  	}
>  
> -	regulator_disable(ts->reg);
> -
>  	/* we know the chip's in lowpower mode since we always
>  	 * leave it that way after every request
>  	 */
> @@ -868,8 +872,6 @@ static void ads7846_enable(struct ads7846 *ts)
>  	if (!ts->disabled)
>  		return;
>  
> -	regulator_enable(ts->reg);
> -
>  	ts->disabled = 0;
>  	ts->irq_disabled = 0;
>  	enable_irq(ts->spi->irq);
> @@ -886,6 +888,8 @@ static int ads7846_suspend(struct spi_device *spi, pm_message_t message)
>  
>  	spin_unlock_irq(&ts->lock);
>  
> +	regulator_disable(ts->reg);
> +
>  	if (device_may_wakeup(&ts->spi->dev))
>  		enable_irq_wake(ts->spi->irq);
>  
> @@ -900,6 +904,8 @@ static int ads7846_resume(struct spi_device *spi)
>  	if (device_may_wakeup(&ts->spi->dev))
>  		disable_irq_wake(ts->spi->irq);
>  
> +	regulator_enable(ts->reg);
> +
>  	spin_lock_irq(&ts->lock);
>  
>  	ts->is_suspended = 0;
> -- 
> 1.5.6.5
> 

-- 
Dmitry
