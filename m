From: Pingbo Wen <pingbo.wen@linaro.org>
Subject: Re: [Y2038] [PATCH] hil_mlc: convert timeval to timespec64
Date: Fri, 23 Oct 2015 17:12:38 +0800
Message-ID: <5629FA06.2060608@linaro.org>
References: <1445161519-27000-1-git-send-email-pingbo.wen@linaro.org>
 <46052377.96MapaKFAy@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35584 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbJWJMl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2015 05:12:41 -0400
Received: by pasz6 with SMTP id z6so113338361pas.2
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2015 02:12:41 -0700 (PDT)
In-Reply-To: <46052377.96MapaKFAy@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org



On Monday, October 19, 2015 04:58 PM, Arnd Bergmann wrote:
> On Sunday 18 October 2015 17:45:19 WEN Pingbo wrote:
>> Using struct timeval will cause time overflow in 2038, replacing it with
>> a 64bit version.
>>
>> In addition, the origin driver try to covert usec to jiffies manually in
>> hilse_donode(). This is not a universal and safe way, using
>> nsecs_to_jiffies() to fix that.
>>
>> Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
> 
> You should mention somewhere that you are also converting from real
> time to monotonic time, and why this is done.
> 
>> ---
>>  drivers/input/serio/hil_mlc.c    | 31 +++++++++++++++++--------------
>>  drivers/input/serio/hp_sdc_mlc.c | 10 ++++++----
>>  include/linux/hil_mlc.h          |  4 ++--
>>  3 files changed, 25 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
>> index 65605e4..4e3b926 100644
>> --- a/drivers/input/serio/hil_mlc.c
>> +++ b/drivers/input/serio/hil_mlc.c
>> @@ -274,14 +274,14 @@ static int hilse_match(hil_mlc *mlc, int unused)
>>  /* An LCV used to prevent runaway loops, forces 5 second sleep when reset. */
>>  static int hilse_init_lcv(hil_mlc *mlc, int unused)
>>  {
>> -	struct timeval tv;
>> +	struct timespec64 ts64;
>>  
>> -	do_gettimeofday(&tv);
>> +	ktime_get_ts64(&ts64);
>>  
>> -	if (mlc->lcv && (tv.tv_sec - mlc->lcv_tv.tv_sec) < 5)
>> +	if (mlc->lcv && (ts64.tv_sec - mlc->lcv_ts64.tv_sec) < 5)
>>  		return -1;
>>  
>> -	mlc->lcv_tv = tv;
>> +	mlc->lcv_ts64 = ts64;
>>  	mlc->lcv = 0;
> 
> No need to rename the two variables here. Also, it seems we never access the
> tv_nsec portion at all, so this could use the simpler ktime_get_seconds()
> or even 'jiffies' instead.
> 
>> @@ -605,7 +605,7 @@ static inline void hilse_setup_input(hil_mlc *mlc, const struct hilse_node *node
>>  	}
>>  	mlc->istarted = 1;
>>  	mlc->intimeout = node->arg;
>> -	do_gettimeofday(&(mlc->instart));
>> +	ktime_get_ts64(&(mlc->instart));
>>  	mlc->icount = 15;
>>  	memset(mlc->ipacket, 0, 16 * sizeof(hil_packet));
>>  	BUG_ON(down_trylock(&mlc->isem));
> 
> This looks unrelated to the change above, so I would suggest making separate patches.
> 
>> @@ -710,7 +710,7 @@ static int hilse_donode(hil_mlc *mlc)
>>  			break;
>>  		}
>>  		mlc->ostarted = 0;
>> -		do_gettimeofday(&(mlc->instart));
>> +		ktime_get_ts64(&(mlc->instart));
>>  		write_unlock_irqrestore(&mlc->lock, flags);
>>  		nextidx = HILSEN_NEXT;
>>  		break;
>> @@ -731,18 +731,21 @@ static int hilse_donode(hil_mlc *mlc)
>>  #endif
>>  
>>  	while (nextidx & HILSEN_SCHED) {
>> -		struct timeval tv;
>> +		struct timespec64 ts64;
>>  
>>  		if (!sched_long)
>>  			goto sched;
>>  
>> -		do_gettimeofday(&tv);
>> -		tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
>> -		tv.tv_usec -= mlc->instart.tv_usec;
>> -		if (tv.tv_usec >= mlc->intimeout) goto sched;
>> -		tv.tv_usec = (mlc->intimeout - tv.tv_usec) * HZ / USEC_PER_SEC;
>> -		if (!tv.tv_usec) goto sched;
>> -		mod_timer(&hil_mlcs_kicker, jiffies + tv.tv_usec);
>> +		ktime_get_ts64(&ts64);
>> +		ts64.tv_nsec += NSEC_PER_SEC *
>> +			(ts64.tv_sec - mlc->instart.tv_sec);
>> +		ts64.tv_nsec -= mlc->instart.tv_nsec;
> 
> tv_nsec will overflow here for any timeout over 4.3 seconds, where it
> used to overflow after 4294 seconds. This is almost certainly a bug.
> 
> You could work around that by using ktime_get_ns() to get a nanosecond
> value right away, but a 64-bit number is more expensive to convert to
> jiffies.

You are right, I didn't notice that tv_nsec is a 32bit variable. Maybe
we should use ktime_t here, so that handling sec and nsec separately is
needless.

Using jiffies here will need to take more codes to handle jiffies overflow
carefully. I think coverting 64bit number to jiffies is the price we must 
take, if we use 64bit version here.

> 
>> +		if (ts64.tv_nsec >= (mlc->intimeout * NSEC_PER_USEC))
>> +			goto sched;
>> +		ts64.tv_nsec = mlc->intimeout * NSEC_PER_USEC - ts64.tv_nsec;
>> +		if (!ts64.tv_nsec) goto sched;
> 
> As you are modifying the line, you should also fix the coding style to
> write
> 
> 		if (!ts64.tv_nsec)
> 			goto sched;
> 
> I also notice that you modify the behavior here, by changing from
> microsecond to nanosecond resolution, the equivalent of the original
> would have been
> 
> 		if (ts64.tv_nsec < NSECS_PER_USEC)
> 
> 
> Your current version looks like it will practically never be true (meaning
> you hit the exact nanosecond). Is this conditional actually needed at all
> then? If it is, what is the intention and what should it be?
> 

Yes, compare to NSEC_PER_USEC is more safe, since we use nanosecond here. 

>> +		mod_timer(&hil_mlcs_kicker,
>> +				jiffies + nsecs_to_jiffies(ts64.tv_nsec));
>>  		break;
>>  	sched:
>>  		tasklet_schedule(&hil_mlcs_tasklet);
> 
> This part seems like it would be easier to just use jiffies instead
> of timspec64, to avoid having to convert it back.
> 
>> @@ -160,9 +160,11 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds_t timeout)
>>  			/* printk(KERN_DEBUG PREFIX ">[%x]\n", mlc->ipacket[0]); */
>>  			goto wasup;
>>  		}
>> -		do_gettimeofday(&tv);
>> -		tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
>> -		if (tv.tv_usec - mlc->instart.tv_usec > mlc->intimeout) {
>> +		ktime_get_ts64(&ts64);
>> +		ts64.tv_nsec += NSEC_PER_SEC *
>> +			(ts64.tv_sec - mlc->instart.tv_sec);
>> +		if (ts64.tv_nsec - mlc->instart.tv_nsec > mlc->intimeout *
>> +				NSEC_PER_USEC) {
>>  			/*	printk("!%i %i",
>>  				tv.tv_usec - mlc->instart.tv_usec,
>>  				mlc->intimeout);
> 
> same here.
> 
> 	Arnd
> 
