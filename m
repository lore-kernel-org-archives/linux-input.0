From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [RFC][PATCH] Input: Use monotonic time for event time stamps.
Date: Wed, 21 Dec 2011 16:54:38 +0800
Message-ID: <CAGS+omDvyNfLX20Uy2tjE7G4LYdJ8XPyuW-2Z+H3W-+p_Ofzyg@mail.gmail.com>
References: <1324429303.30527.92.camel@work-vm> <4EF1395E.405@cn.fujitsu.com>
 <CAGS+omABqM84X=uoY1bGnAD-9DSR6qjrod8Teksm3qeiG2YGew@mail.gmail.com>
 <1324434211.30527.100.camel@work-vm> <CAGS+omCsEDtLsxs-vzJxEJeGrkvoDO84O-thser3_Wdgv8fR-A@mail.gmail.com>
 <1324454001.30527.114.camel@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59396 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab1LUIzA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Dec 2011 03:55:00 -0500
Received: by iaeh11 with SMTP id h11so11583978iae.19
        for <linux-input@vger.kernel.org>; Wed, 21 Dec 2011 00:54:59 -0800 (PST)
In-Reply-To: <1324454001.30527.114.camel@work-vm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: gaowanlong@cn.fujitsu.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>

On Wed, Dec 21, 2011 at 3:53 PM, john stultz <johnstul@us.ibm.com> wrot=
e:
> On Wed, 2011-12-21 at 11:34 +0800, Daniel Kurtz wrote:
>> On Wed, Dec 21, 2011 at 10:23 AM, john stultz <johnstul@us.ibm.com> =
wrote:
>> > On Wed, 2011-12-21 at 10:11 +0800, Daniel Kurtz wrote:
>> >> On Wed, Dec 21, 2011 at 9:41 AM, Wanlong Gao <gaowanlong@cn.fujit=
su.com> wrote:
>> >> > On 12/21/2011 09:01 AM, john stultz wrote:
>> >> >
>> >> >> Hi
>> >> >> =A0 =A0 =A0 In reviewing the Android patch set, I noticed the =
following patch from
>> >> >> Arve which looks like it resolves a reasonable issue (events u=
sing
>> >> >> CLOCK_REALTIME timestamps, which can jump forwards or backward=
s via
>> >> >> settimeofday()).
>> >> >>
>> >> >> I'm not very familiar with the evdev interface, so I'm not sur=
e if
>> >> >> changing the timestamps to CLOCK_MONOTONIC could cause an ABI =
problem
>> >> >> with legacy apps. Even so, I wanted to send the patch out for =
review and
>> >> >> consideration as it seems like a reasonable fix.
>> >>
>> >> Maybe you will have more luck this time. =A0You can read the prev=
ious
>> >> thread on this exact topic, here:
>> >> https://lkml.org/lkml/2011/10/3/37
>> >
>> > Interesting! Thanks for the link!
>> >
>> >> The previous attempt got bogged down when people wanted more data=
 on
>> >> use cases and how this patch would promote world peace. =A0I stro=
ngly
>> >> support the concept, but we found other ways to address our major
>> >> concern at the time, so didn't invest more effort to get that pat=
ch
>> >> accepted.
>> >>
>> >> Just a question though, why ktime_get_ts() and not getrawmonotoni=
c()?
>> >
>> > So rawmonotonic isn't frequency corrected via NTP, while the monot=
onic
>> > clock is. So if you're calculating intervals, you will get more ac=
curate
>> > times (where a second is a second) w/ ktime_get_ts().
>> >
>> > The raw monotonic clock is really only useful for time correction
>> > applications (being able to accurately measure how much of a corre=
ction
>> > was applied), or when you really want a abstracted sense of hardwa=
re
>> > cycles.
>>
>> And here is where it gets complicated. =A0I think it depends on what=
 you
>> want from your timestamps.
>>
>> Do you care that the actual timestamps are accurate (wrt wall clock =
=3D
>> MONOTONIC), or that inter-event timetamp spacing is consistent
>> (MONOTONIC_RAW)?
>
> Although, hardware fluctuates as well (I've watched clock skew along
> with AC cycles). So neither is surely to be totally consistent.
>
>> For our use case, we don't really care about the absolute timestamp
>> itself, just relative timestamp differences. =A0We wanted to make su=
re
>> that the inter-event times were always consistent, and didn't wobble
>> about in response to cock adjustments. =A0The affect of clock skew o=
n
>> timestamp deltas is miniscule.
>
> Hrm. I'm curious. If clock skew is miniscule, any correction should b=
e
> as well. Have you seen actual issues with clock freq correction here
> that necessitated using the raw-monotonic clock? Any details if so?

Let's say a really bad clock is 1% slow.  It will be off (relative to
wallclock time) by 3 seconds every 5 minutes.  Such a clock is really
bad and will need frequent adjustments.
  * Those individual frequent clock adjustments, will probably happen
in chunks on the order of several milliseconds.  If such an adjustment
happens between two input events, the resulting timestamp delta error
is on the same order of magnitude as the timestamp delta itself, if
not orders of magnitude larger.
  * However, when looking at inter-event arrival times, the affect of
this huge clock skew is still only 1%.  So a 10ms event arrival time
will be off by 100 us.  Even for this horrible clock, this is really
very small.

Real clocks have much less skew than this, however, the ntp clock
adjustments would still be on the order of magnitude as the input
event inter-arrival times, just much less frequent.  But, the affect
on an individual inter-event time is proportional to the skew.

Sorry, I don't have real data to back this up, but this is my
understanding of how it will work.  Hopefully, I'm explaining it
clearly enough to make my point.

-Dan

> thanks
> -john
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
