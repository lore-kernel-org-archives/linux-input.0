From: Dmitry Torokhov <dtor@mail.ru>
Subject: Re: input: hil_mlc: Use boot time
Date: Fri, 21 Aug 2015 09:41:33 -0700
Message-ID: <20150821164133.GF26302@localhost>
References: <CALiE4M1JTog55SKEYy_U432L5U2RUgrSH8cy5PiFzsrwnx6ucA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34908 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbHUQlg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2015 12:41:36 -0400
Received: by pdob1 with SMTP id b1so28401437pdo.2
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2015 09:41:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALiE4M1JTog55SKEYy_U432L5U2RUgrSH8cy5PiFzsrwnx6ucA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Abhilash Jindal <klock.android@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Abhilash,

On Sat, Aug 08, 2015 at 09:47:16PM -0400, Abhilash Jindal wrote:
> Wall time obtained from do_gettimeofday is susceptible to sudden jumps due
> to user setting the time or due to NTP.
> 
> Boot time is constantly increasing time better suited for comparing
> two timestamps.

Maybe also switch to ktime_t?

Also, your mailer seems to have mangled the patch; all tabs are gone.

Thanks.

> ---
>  drivers/input/serio/hil_mlc.c |   24 ++++++++++++------------
>  include/linux/hil_mlc.h       |    4 ++--
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
> index 65605e4..2bdd113 100644
> --- a/drivers/input/serio/hil_mlc.c
> +++ b/drivers/input/serio/hil_mlc.c
> @@ -274,9 +274,9 @@ static int hilse_match(hil_mlc *mlc, int unused)
>  /* An LCV used to prevent runaway loops, forces 5 second sleep when reset.
> */
>  static int hilse_init_lcv(hil_mlc *mlc, int unused)
>  {
> - struct timeval tv;
> + struct timespec tv;
> 
> - do_gettimeofday(&tv);
> + getboottime(&tv);
> 
>   if (mlc->lcv && (tv.tv_sec - mlc->lcv_tv.tv_sec) < 5)
>   return -1;
> @@ -605,7 +605,7 @@ static inline void hilse_setup_input(hil_mlc *mlc,
> const struct hilse_node *node
>   }
>   mlc->istarted = 1;
>   mlc->intimeout = node->arg;
> - do_gettimeofday(&(mlc->instart));
> + getboottime(&(mlc->instart));
>   mlc->icount = 15;
>   memset(mlc->ipacket, 0, 16 * sizeof(hil_packet));
>   BUG_ON(down_trylock(&mlc->isem));
> @@ -710,7 +710,7 @@ static int hilse_donode(hil_mlc *mlc)
>   break;
>   }
>   mlc->ostarted = 0;
> - do_gettimeofday(&(mlc->instart));
> + getboottime(&(mlc->instart));
>   write_unlock_irqrestore(&mlc->lock, flags);
>   nextidx = HILSEN_NEXT;
>   break;
> @@ -731,18 +731,18 @@ static int hilse_donode(hil_mlc *mlc)
>  #endif
> 
>   while (nextidx & HILSEN_SCHED) {
> - struct timeval tv;
> + struct timespec tv;
> 
>   if (!sched_long)
>   goto sched;
> 
> - do_gettimeofday(&tv);
> - tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
> - tv.tv_usec -= mlc->instart.tv_usec;
> - if (tv.tv_usec >= mlc->intimeout) goto sched;
> - tv.tv_usec = (mlc->intimeout - tv.tv_usec) * HZ / USEC_PER_SEC;
> - if (!tv.tv_usec) goto sched;
> - mod_timer(&hil_mlcs_kicker, jiffies + tv.tv_usec);
> + getboottime(&tv);
> + tv.tv_nsec += NSEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
> + tv.tv_nsec -= mlc->instart.tv_nsec;
> + if (tv.tv_nsec >= mlc->intimeout * NSEC_PER_USEC) goto sched;
> + tv.tv_nsec = (mlc->intimeout - tv.tv_nsec) * HZ / NSEC_PER_SEC;
> + if (!tv.tv_nsec) goto sched;
> + mod_timer(&hil_mlcs_kicker, jiffies + (tv.tv_nsec/NSEC_PER_USEC));
>   break;
>   sched:
>   tasklet_schedule(&hil_mlcs_tasklet);
> diff --git a/include/linux/hil_mlc.h b/include/linux/hil_mlc.h
> index 394a840..4892fb9 100644
> --- a/include/linux/hil_mlc.h
> +++ b/include/linux/hil_mlc.h
> @@ -144,12 +144,12 @@ struct hil_mlc {
>   hil_packet ipacket[16];
>   hil_packet imatch;
>   int icount;
> - struct timeval instart;
> + struct timespec instart;
>   suseconds_t intimeout;
> 
>   int ddi; /* Last operational device id */
>   int lcv; /* LCV to throttle loops */
> - struct timeval lcv_tv; /* Time loop was started */
> + struct timespec lcv_tv; /* Time loop was started */
> 
>   int di_map[7]; /* Maps below items to live devs */
>   struct hil_mlc_devinfo di[HIL_MLC_DEVMEM];
> -- 
> 1.7.9.5

-- 
Dmitry
