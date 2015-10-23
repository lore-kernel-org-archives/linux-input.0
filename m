From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH V2] hil_mlc: convert timeval to ktime_t
Date: Fri, 23 Oct 2015 15:51:44 +0200
Message-ID: <4159188.UVvamn6mDa@wuerfel>
References: <46052377.96MapaKFAy@wuerfel> <33014393.CcP7q7PhGq@wuerfel> <05CEA4E0-A8CF-42DA-89C3-F0968DE73CB4@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <05CEA4E0-A8CF-42DA-89C3-F0968DE73CB4@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: y2038@lists.linaro.org
Cc: Pingbo Wen <pingbo.wen@linaro.org>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Friday 23 October 2015 20:32:50 Pingbo Wen wrote:
> >> -            do_gettimeofday(&tv);
> >> -            tv.tv_usec += USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
> >> -            tv.tv_usec -= mlc->instart.tv_usec;
> >> -            if (tv.tv_usec >= mlc->intimeout) goto sched;
> >> -            tv.tv_usec = (mlc->intimeout - tv.tv_usec) * HZ / USEC_PER_SEC;
> >> -            if (!tv.tv_usec) goto sched;
> >> -            mod_timer(&hil_mlcs_kicker, jiffies + tv.tv_usec);
> >> +            if (tmp.tv64 >= (mlc->intimeout * NSEC_PER_USEC))
> >> +                    goto sched;
> >> +            tmp.tv64 = mlc->intimeout * NSEC_PER_USEC - tmp.tv64;
> >> +            if (tmp.tv64 < NSEC_PER_USEC)
> >> +                    goto sched;
> >> +            mod_timer(&hil_mlcs_kicker,
> >> +                            jiffies + nsecs_to_jiffies(tmp.tv64));
> >>              break;
> >>      sched:
> >>              tasklet_schedule(&hil_mlcs_tasklet);
> > 
> > If I read this right, the code is executed one for each input event such
> > as a keypress or mouse movement. In the latter case, doing nsecs_to_jiffies()
> > here is actually a bit expensive, and I stil think it can be avoided
> > by just using jiffies.
> > 
> > For the (tmp.tv64 < NSEC_PER_USEC) part, did you just do that because
> > I said this, or did you actually prove that it is required? I'm still
> > confused about what the driver is trying to achieve here.
> 
> More explanation here:)
> the judgement here is to prevent mod_timer with zero delta. I can not
> make sure whether the module have nanosecond precise, so just keep same.

Ok, I guess I was misreading the original code. What it actually does
is to check the remaining time in jiffies, not in microseconds, so the
algorithm is:

	if (already expired)
		schedule tasklet
	else {
		convert to jiffies
		if (expired just now)
			schedule tasklet
		else
			schedule tasklet from timer
	}

So the entire code is meant to guarantee that the tasklet is getting
scheduled, and the first two cases are just an optimization to avoid
going through the timer. I checked the code for mod_timer to verify
that mod_timer with an argument in the past will just cause the
handler to be called at the next tick, so we don't really need the
middle case, and the logic becomes really simple if you use jiffies
instead of ktime_t.

	Arnd
