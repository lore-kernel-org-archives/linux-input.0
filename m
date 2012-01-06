From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC][PATCH] Input: Add infrastrucutre for selecting clockid
 for event time stamps.
Date: Fri, 06 Jan 2012 11:39:16 -0800
Message-ID: <1325878756.2290.101.camel@work-vm>
References: <1325818212-24752-1-git-send-email-john.stultz@linaro.org>
	 <CAGS+omCB7L7w1NXiaNdBPWPjx4+5soeg8Qq9TLQtmn=b13cSAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:34714 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab2AFTjW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2012 14:39:22 -0500
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-input@vger.kernel.org> from <john.stultz@linaro.org>;
	Fri, 6 Jan 2012 12:39:21 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q06JdI6d030126
	for <linux-input@vger.kernel.org>; Fri, 6 Jan 2012 12:39:18 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q06JdHYO001932
	for <linux-input@vger.kernel.org>; Fri, 6 Jan 2012 12:39:18 -0700
In-Reply-To: <CAGS+omCB7L7w1NXiaNdBPWPjx4+5soeg8Qq9TLQtmn=b13cSAg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@google.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>

On Fri, 2012-01-06 at 17:20 +0800, Daniel Kurtz wrote:
> On Fri, Jan 6, 2012 at 10:50 AM, John Stultz <john.stultz@linaro.org> wrote:
> > Here's another revision, incorperating Dmitry's suggestion.
> >
> > As noted by Arve and others, since wall time can jump backwards, it
> > is difficult to use for input because one cannot determine if one
> > event occured before another or for how long a key was pressed.
> >
> > However, the timestamp field is part of the kernel ABI, and cannot
> > be changed without possibly breaking existing users.
> >
> > This patch adds a new IOCTL that allows a clockid to be set in
> > the evdev_client struct that will specify which time base to
> > use for event timestamps (ie: CLOCK_MONOTONIC instead
> > of CLOCK_REALTIME).
> >
> > For now we only support CLOCK_MONOTONIC and CLOCK_REALTIME, but
> > in the future we could support other clockids if appropriate.
> 
> What about CLOCK_MONOTONIC_RAW?

It could be used here, although I'm still not clear on the benefit of
using monotonic raw over just monotonic.

> Last time we discussed, I thought this clock was the most useful for
> use with input devices.  But, you wrote this:
> > So rawmonotonic isn't frequency corrected via NTP, while the monotonic
> > clock is. So if you're calculating intervals, you will get more accurate
> > times (where a second is a second) w/ ktime_get_ts().
> 
> Does this frequency correction involve timestamp jumps?

No. clock monotonic isn't jumped. But its rate may be slightly adjusted
(max of +/- 500ppm), so that it accurately matches the passing of time. 

> If so, of what magnitude?

At worse, assuming some sort of terribly mis-configured or malicious ntp
daemon, if you had two one second intervals that you had measured, they
could actually differ by up to a millisecond. 

> In my experience, input event timestamp intervals are usually on the
> order of a few milliseconds (5-25 ms).  If CLOCK_MONOTONIC experiences
> frequent adjustments near this order of magnitude, I still think
> CLOCK_MONOTONIC_RAW might be a better choice for event timestamps.

So for 5-25 ms intervals, you're looking at a worse case difference of
5-25 us. And again, this isn't likely, as the ntp freq adjustment would
have to go from -500ppm to +500ppm mid-interval. 

So I really suspect there isn't much practical difference between
CLOCK_MONOTONIC and CLOCK_MONOTONIC_RAW for input events. But I'd be
interested to hear if anyone has actually run into such complications.

CLOCK_MONOTONIC_RAW can be useful (especially for providing a stable
baseline when doing time adjustment calculations), but the downside is
that measurements (especially longer measurements) with
CLOCK_MONOTONIC_RAW may not be accurate.

And as it always is with time, everything is relative: even
CLOCK_MONOTONIC_RAW can vary over time, as the crystal driving the
clocksource may slightly fluctuate with temperature.

But again, nothing is keeping CLOCK_MONOTONIC_RAW from being supported
via the proposed ioctl.

> > +       bool timestamp_clkid;
> 
> This isn't bool anymore.

Good catch!

thanks!
-john

