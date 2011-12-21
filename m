From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [RFC][PATCH] Input: Use monotonic time for event time stamps.
Date: Wed, 21 Dec 2011 11:34:17 +0800
Message-ID: <CAGS+omCsEDtLsxs-vzJxEJeGrkvoDO84O-thser3_Wdgv8fR-A@mail.gmail.com>
References: <1324429303.30527.92.camel@work-vm> <4EF1395E.405@cn.fujitsu.com>
 <CAGS+omABqM84X=uoY1bGnAD-9DSR6qjrod8Teksm3qeiG2YGew@mail.gmail.com> <1324434211.30527.100.camel@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48388 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab1LUDei convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 22:34:38 -0500
Received: by iaeh11 with SMTP id h11so11208128iae.19
        for <linux-input@vger.kernel.org>; Tue, 20 Dec 2011 19:34:38 -0800 (PST)
In-Reply-To: <1324434211.30527.100.camel@work-vm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: gaowanlong@cn.fujitsu.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>

On Wed, Dec 21, 2011 at 10:23 AM, john stultz <johnstul@us.ibm.com> wro=
te:
> On Wed, 2011-12-21 at 10:11 +0800, Daniel Kurtz wrote:
>> On Wed, Dec 21, 2011 at 9:41 AM, Wanlong Gao <gaowanlong@cn.fujitsu.=
com> wrote:
>> > On 12/21/2011 09:01 AM, john stultz wrote:
>> >
>> >> Hi
>> >> =A0 =A0 =A0 In reviewing the Android patch set, I noticed the fol=
lowing patch from
>> >> Arve which looks like it resolves a reasonable issue (events usin=
g
>> >> CLOCK_REALTIME timestamps, which can jump forwards or backwards v=
ia
>> >> settimeofday()).
>> >>
>> >> I'm not very familiar with the evdev interface, so I'm not sure i=
f
>> >> changing the timestamps to CLOCK_MONOTONIC could cause an ABI pro=
blem
>> >> with legacy apps. Even so, I wanted to send the patch out for rev=
iew and
>> >> consideration as it seems like a reasonable fix.
>>
>> Maybe you will have more luck this time. =A0You can read the previou=
s
>> thread on this exact topic, here:
>> https://lkml.org/lkml/2011/10/3/37
>
> Interesting! Thanks for the link!
>
>> The previous attempt got bogged down when people wanted more data on
>> use cases and how this patch would promote world peace. =A0I strongl=
y
>> support the concept, but we found other ways to address our major
>> concern at the time, so didn't invest more effort to get that patch
>> accepted.
>>
>> Just a question though, why ktime_get_ts() and not getrawmonotonic()=
?
>
> So rawmonotonic isn't frequency corrected via NTP, while the monotoni=
c
> clock is. So if you're calculating intervals, you will get more accur=
ate
> times (where a second is a second) w/ ktime_get_ts().
>
> The raw monotonic clock is really only useful for time correction
> applications (being able to accurately measure how much of a correcti=
on
> was applied), or when you really want a abstracted sense of hardware
> cycles.

And here is where it gets complicated.  I think it depends on what you
want from your timestamps.

Do you care that the actual timestamps are accurate (wrt wall clock =3D
MONOTONIC), or that inter-event timetamp spacing is consistent
(MONOTONIC_RAW)?

=46or our use case, we don't really care about the absolute timestamp
itself, just relative timestamp differences.  We wanted to make sure
that the inter-event times were always consistent, and didn't wobble
about in response to cock adjustments.  The affect of clock skew on
timestamp deltas is miniscule.

-Dan

>
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
