From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC V2] Input: cyapa: use time based retry loop
Date: Sun, 15 Jan 2017 15:19:59 -0800
Message-ID: <20170115231959.GD23285@dtor-ws>
References: <1484478758-13133-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33013 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdAOXUD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 15 Jan 2017 18:20:03 -0500
Content-Disposition: inline
In-Reply-To: <1484478758-13133-1-git-send-email-hofrat@osadl.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Dudley Du <dudl@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jan 15, 2017 at 12:12:38PM +0100, Nicholas Mc Guire wrote:
> Using counter based retry loops for peripherals results in the delay
> being significantly overrun during high-load situations where delay
> functions tend to be vary imprecise and overrun there timeouts. So
> condition the termination on the actual condition of 2s for the 
> re-calibration to have been successful.
> 
> As this is a very long delay there is no advantage in using 
> high-resolution timers thus switching this to msleep().
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied, thank you.

> ---
> 
> V2: The maximum recalibration timeout should have been 2 * HZ as
>     Dmitry Torokhov <dmitry.torokhov@gmail.com> noted - V2 sets
>     the timeout boundary to 2s now.
> 
> Problem detected with coccinelle script (usleep_range for long delay)
> 
> The basic model for the fix up here is to use
> 
>   timeout = jiffies + (retry_time)
>   do {
>       check()
>       mleep()
>   } while (time_is_after_jiffies(timeout));
> 
> rather than using a counter and have very long retry loops under load
> conditions. In the specific case it is sleep()/check() though to wait
> on the previous write to complete. The initial intent was to move the
> usleep_range() to msleep() as the delays are very long - if this
> refactoring of the timeout loop is desirable or not is not clear (both
> time and count based models seem to be common).
> 
> Patch was compile tested with: x86_64_defconfig + CONFIG_MOUSE_CYAPA=m
> 
> Patch is against 4.10-rc3 (localversion-next is next-20170113)
> 
>  drivers/input/mouse/cyapa_gen3.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
> index f9600753..0c544de 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -789,7 +789,7 @@ static ssize_t cyapa_gen3_do_calibrate(struct device *dev,
>  				     const char *buf, size_t count)
>  {
>  	struct cyapa *cyapa = dev_get_drvdata(dev);
> -	int tries;
> +	unsigned long timeout;
>  	int ret;
>  
>  	ret = cyapa_read_byte(cyapa, CYAPA_CMD_DEV_STATUS);
> @@ -812,31 +812,28 @@ static ssize_t cyapa_gen3_do_calibrate(struct device *dev,
>  		goto out;
>  	}
>  
> -	tries = 20;  /* max recalibration timeout 2s. */
> +	/* max recalibration timeout 2s. */
> +	timeout = jiffies + 2 * HZ;
>  	do {
>  		/*
>  		 * For this recalibration, the max time will not exceed 2s.
>  		 * The average time is approximately 500 - 700 ms, and we
>  		 * will check the status every 100 - 200ms.
>  		 */
> -		usleep_range(100000, 200000);
> -
> +		msleep(100);
>  		ret = cyapa_read_byte(cyapa, CYAPA_CMD_DEV_STATUS);
>  		if (ret < 0) {
> -			dev_err(dev, "Error reading dev status: %d\n",
> -				ret);
> +			dev_err(dev, "Error reading dev status: %d\n", ret);
>  			goto out;
>  		}
> -		if ((ret & CYAPA_DEV_NORMAL) == CYAPA_DEV_NORMAL)
> -			break;
> -	} while (--tries);
> +		if ((ret & CYAPA_DEV_NORMAL) == CYAPA_DEV_NORMAL) {
> +			dev_dbg(dev, "Calibration successful.\n");
> +			goto out;
> +		}
> +	} while (time_is_after_jiffies(timeout));
>  
> -	if (tries == 0) {
> -		dev_err(dev, "Failed to calibrate. Timeout.\n");
> -		ret = -ETIMEDOUT;
> -		goto out;
> -	}
> -	dev_dbg(dev, "Calibration successful.\n");
> +	dev_err(dev, "Failed to calibrate. Timeout.\n");
> +	ret = -ETIMEDOUT;
>  
>  out:
>  	return ret < 0 ? ret : count;
> -- 
> 2.1.4
> 

-- 
Dmitry
