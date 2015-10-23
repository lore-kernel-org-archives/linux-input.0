From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH V2] hil_mlc: convert timeval to ktime_t
Date: Fri, 23 Oct 2015 11:55:07 +0200
Message-ID: <33014393.CcP7q7PhGq@wuerfel>
References: <46052377.96MapaKFAy@wuerfel> <1445592300-30894-1-git-send-email-pingbo.wen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:51323 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbbJWJzL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2015 05:55:11 -0400
In-Reply-To: <1445592300-30894-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: y2038@lists.linaro.org
Cc: WEN Pingbo <pingbo.wen@linaro.org>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Friday 23 October 2015 17:24:59 WEN Pingbo wrote:
> Using struct timeval will cause time overflow in 2038, replacing it with
> ktime_t. And we don't need to handle sec and nsec separately.
> 
> Since mlc->lcv_t is only interested in seconds, directly using
> time64_t here.
> 
> And monotonic time is better here, since the original driver don't care
> the wall time.
> 
> In addition, the original driver try to covert usec to jiffies manually in
> hilse_donode(). This is not a universal and safe way, using
> nsecs_to_jiffies() to fix that.
> 
> Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>

The changelog text looks good.

> +++ b/drivers/input/serio/hil_mlc.c
> @@ -274,14 +274,12 @@ static int hilse_match(hil_mlc *mlc, int unused)
>  /* An LCV used to prevent runaway loops, forces 5 second sleep when reset. */
>  static int hilse_init_lcv(hil_mlc *mlc, int unused)
>  {
> -	struct timeval tv;
> +	time64_t now = ktime_get_seconds();
>  
> -	do_gettimeofday(&tv);
> -
> -	if (mlc->lcv && (tv.tv_sec - mlc->lcv_tv.tv_sec) < 5)
> +	if (mlc->lcv && (now - mlc->lcv_t) < 5)
>  		return -1;
>  
> -	mlc->lcv_tv = tv;
> +	mlc->lcv_t = now;
>  	mlc->lcv = 0;
>  
>  	return 0;

This part looks good now, but as I commented in version 1, it should
really be a separate patch rather than combined with the rest that
is dealing with another use of timeval.
>  
> -		do_gettimeofday(&tv);
> -		tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
> -		tv.tv_usec -= mlc->instart.tv_usec;
> -		if (tv.tv_usec >= mlc->intimeout) goto sched;
> -		tv.tv_usec = (mlc->intimeout - tv.tv_usec) * HZ / USEC_PER_SEC;
> -		if (!tv.tv_usec) goto sched;
> -		mod_timer(&hil_mlcs_kicker, jiffies + tv.tv_usec);
> +		if (tmp.tv64 >= (mlc->intimeout * NSEC_PER_USEC))
> +			goto sched;
> +		tmp.tv64 = mlc->intimeout * NSEC_PER_USEC - tmp.tv64;
> +		if (tmp.tv64 < NSEC_PER_USEC)
> +			goto sched;
> +		mod_timer(&hil_mlcs_kicker,
> +				jiffies + nsecs_to_jiffies(tmp.tv64));
>  		break;
>  	sched:
>  		tasklet_schedule(&hil_mlcs_tasklet);

If I read this right, the code is executed one for each input event such
as a keypress or mouse movement. In the latter case, doing nsecs_to_jiffies()
here is actually a bit expensive, and I stil think it can be avoided
by just using jiffies.

For the (tmp.tv64 < NSEC_PER_USEC) part, did you just do that because
I said this, or did you actually prove that it is required? I'm still
confused about what the driver is trying to achieve here.

> diff --git a/drivers/input/serio/hp_sdc_mlc.c b/drivers/input/serio/hp_sdc_mlc.c
> index d50f067..0a27b89 100644
> --- a/drivers/input/serio/hp_sdc_mlc.c
> +++ b/drivers/input/serio/hp_sdc_mlc.c
> @@ -149,7 +149,8 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds_t timeout)
>  
>  	/* Try to down the semaphore */
>  	if (down_trylock(&mlc->isem)) {
> -		struct timeval tv;
> +		ktime_t tmp = ktime_sub(ktime_get(), mlc->instart);
> +
>  		if (priv->emtestmode) {
>  			mlc->ipacket[0] =
>  				HIL_ERR_INT | (mlc->opacket &

Maybe give the variable a more useful name than 'tmp'?

You could also remove the variable entirely if you slightly restructure
the condition below.

> @@ -160,9 +161,8 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds_t timeout)
>  			/* printk(KERN_DEBUG PREFIX ">[%x]\n", mlc->ipacket[0]); */
>  			goto wasup;
>  		}
> -		do_gettimeofday(&tv);
> -		tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
> -		if (tv.tv_usec - mlc->instart.tv_usec > mlc->intimeout) {
> +
> +		if (tmp.tv64 > mlc->intimeout * NSEC_PER_USEC) {
>  			/*	printk("!%i %i",
>  				tv.tv_usec - mlc->instart.tv_usec,
>  				mlc->intimeout);

As I mentioned, better use ktime_to_ns() instead of accessing the tv64 member
directly, but that is just a small style question.

	Arnd
