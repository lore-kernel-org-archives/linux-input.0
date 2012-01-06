From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] Input: Add infrastrucutre for monotonic event time
 stamps.
Date: Thu, 5 Jan 2012 16:44:59 -0800
Message-ID: <20120106004459.GA9988@core.coreip.homeip.net>
References: <1325804465-20612-1-git-send-email-john.stultz@linaro.org>
 <20120105232853.GA1193@core.coreip.homeip.net>
 <4F063853.9070206@canonical.com>
 <1325809186.2290.84.camel@work-vm>
 <4F06422C.2060601@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49631 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443Ab2AFApE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2012 19:45:04 -0500
Received: by iaeh11 with SMTP id h11so1723541iae.19
        for <linux-input@vger.kernel.org>; Thu, 05 Jan 2012 16:45:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F06422C.2060601@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, Daniel Kurtz <djkurtz@google.com>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>

On Thu, Jan 05, 2012 at 04:37:00PM -0800, Chase Douglas wrote:
> On 01/05/2012 04:19 PM, John Stultz wrote:
> > On Thu, 2012-01-05 at 15:54 -0800, Chase Douglas wrote:
> >> On 01/05/2012 03:28 PM, Dmitry Torokhov wrote:
> >>> Hi John,
> >>>
> >>> On Thu, Jan 05, 2012 at 03:01:05PM -0800, John Stultz wrote:
> >>>>  
> >>>> +	case EVIOCMONTIME:
> >>>> +		if (copy_from_user(&i, p, sizeof(unsigned int)))
> >>>> +			return -EFAULT;
> >>>> +		client->use_monotonic = i;
> >>>> +		return 0;
> >>>
> >>> Maybe we should let users pass not boolean but CLOCK_* value (and reject
> >>> ones that we do not support) ? This way if someone wants to use some
> >>> other clock type in the future we won't need new ioctl.
> >>
> >> Could we also find a way to specify device time? Apple's Magic Mouse and
> >> Magic Trackpad spit out events with their own timestamps. Maybe there
> >> would be other devices that would support high accuracy timestamps too?
> > 
> > The dynamic posix clocks stuff already supports this sort of thing for
> > PTP, but its driver by driver, and its not all that clear that you can
> > read the device timestamp any old time you want (I suspect they're all
> > tied to device events). So it won't quite work for a clock_gettime()
> > style usage.
> > 
> > I don't really know what the best way to do this would be. We could
> > overload a negative clockid value, since you're not going to be wanting
> > thread cputime for device timestamps. But that's not super elegant
> > either.
> > 
> > But just having a specified clock id via the ioctl makes something like
> > what you're proposing possible.  Just a matter of how to cleanly specify
> > device timestamps against all the other possible ids.
> 
> I guess this is mostly what I'm after right now. I have no plans on
> implementing device timestamps, and I don't even really have time to
> think about it much right now :). As long as we have a plan for how we
> could specify it in the future, if someone wanted to implement it, then
> I'm happy.
> 

I'd consider device-generated timestamps be similar to the other
elements of input stream, like coordinates, and therefore transmitted
via their own event type, something like EV_MSC/MSC_TIME.

-- 
Dmitry
