From: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] Input: Use monotonic time for event time stamps.
Date: Tue, 20 Dec 2011 18:23:31 -0800
Message-ID: <1324434211.30527.100.camel@work-vm>
References: <1324429303.30527.92.camel@work-vm>
	 <4EF1395E.405@cn.fujitsu.com>
	 <CAGS+omABqM84X=uoY1bGnAD-9DSR6qjrod8Teksm3qeiG2YGew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:34582 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab1LUCX6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 21:23:58 -0500
Received: from /spool/local
	by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-input@vger.kernel.org> from <johnstul@us.ibm.com>;
	Tue, 20 Dec 2011 21:23:56 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBL2NY5D237938
	for <linux-input@vger.kernel.org>; Tue, 20 Dec 2011 21:23:34 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pBL2NXI3020143
	for <linux-input@vger.kernel.org>; Wed, 21 Dec 2011 00:23:34 -0200
In-Reply-To: <CAGS+omABqM84X=uoY1bGnAD-9DSR6qjrod8Teksm3qeiG2YGew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@google.com>
Cc: gaowanlong@cn.fujitsu.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>

On Wed, 2011-12-21 at 10:11 +0800, Daniel Kurtz wrote:
> On Wed, Dec 21, 2011 at 9:41 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
> > On 12/21/2011 09:01 AM, john stultz wrote:
> >
> >> Hi
> >>       In reviewing the Android patch set, I noticed the following patch from
> >> Arve which looks like it resolves a reasonable issue (events using
> >> CLOCK_REALTIME timestamps, which can jump forwards or backwards via
> >> settimeofday()).
> >>
> >> I'm not very familiar with the evdev interface, so I'm not sure if
> >> changing the timestamps to CLOCK_MONOTONIC could cause an ABI problem
> >> with legacy apps. Even so, I wanted to send the patch out for review and
> >> consideration as it seems like a reasonable fix.
> 
> Maybe you will have more luck this time.  You can read the previous
> thread on this exact topic, here:
> https://lkml.org/lkml/2011/10/3/37

Interesting! Thanks for the link!

> The previous attempt got bogged down when people wanted more data on
> use cases and how this patch would promote world peace.  I strongly
> support the concept, but we found other ways to address our major
> concern at the time, so didn't invest more effort to get that patch
> accepted.
> 
> Just a question though, why ktime_get_ts() and not getrawmonotonic()?

So rawmonotonic isn't frequency corrected via NTP, while the monotonic
clock is. So if you're calculating intervals, you will get more accurate
times (where a second is a second) w/ ktime_get_ts().

The raw monotonic clock is really only useful for time correction
applications (being able to accurately measure how much of a correction
was applied), or when you really want a abstracted sense of hardware
cycles.

thanks
-john


