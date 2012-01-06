From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC][PATCH] Input: Add infrastrucutre for monotonic event time
 stamps.
Date: Thu, 05 Jan 2012 16:19:46 -0800
Message-ID: <1325809186.2290.84.camel@work-vm>
References: <1325804465-20612-1-git-send-email-john.stultz@linaro.org>
	 <20120105232853.GA1193@core.coreip.homeip.net>
	 <4F063853.9070206@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:47757 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617Ab2AFATw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Jan 2012 19:19:52 -0500
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-input@vger.kernel.org> from <john.stultz@linaro.org>;
	Thu, 5 Jan 2012 17:19:52 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q060JoDh136140
	for <linux-input@vger.kernel.org>; Thu, 5 Jan 2012 17:19:50 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q060Jn4R013092
	for <linux-input@vger.kernel.org>; Thu, 5 Jan 2012 17:19:49 -0700
In-Reply-To: <4F063853.9070206@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Daniel Kurtz <djkurtz@google.com>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>

On Thu, 2012-01-05 at 15:54 -0800, Chase Douglas wrote:
> On 01/05/2012 03:28 PM, Dmitry Torokhov wrote:
> > Hi John,
> > 
> > On Thu, Jan 05, 2012 at 03:01:05PM -0800, John Stultz wrote:
> >>  
> >> +	case EVIOCMONTIME:
> >> +		if (copy_from_user(&i, p, sizeof(unsigned int)))
> >> +			return -EFAULT;
> >> +		client->use_monotonic = i;
> >> +		return 0;
> > 
> > Maybe we should let users pass not boolean but CLOCK_* value (and reject
> > ones that we do not support) ? This way if someone wants to use some
> > other clock type in the future we won't need new ioctl.
> 
> Could we also find a way to specify device time? Apple's Magic Mouse and
> Magic Trackpad spit out events with their own timestamps. Maybe there
> would be other devices that would support high accuracy timestamps too?

The dynamic posix clocks stuff already supports this sort of thing for
PTP, but its driver by driver, and its not all that clear that you can
read the device timestamp any old time you want (I suspect they're all
tied to device events). So it won't quite work for a clock_gettime()
style usage.

I don't really know what the best way to do this would be. We could
overload a negative clockid value, since you're not going to be wanting
thread cputime for device timestamps. But that's not super elegant
either.

But just having a specified clock id via the ioctl makes something like
what you're proposing possible.  Just a matter of how to cleanly specify
device timestamps against all the other possible ids.

thanks
-john



