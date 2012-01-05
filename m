From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC][PATCH] Input: Add infrastrucutre for monotonic event time
 stamps.
Date: Thu, 05 Jan 2012 15:51:46 -0800
Message-ID: <1325807506.2290.77.camel@work-vm>
References: <1325804465-20612-1-git-send-email-john.stultz@linaro.org>
	 <20120105232853.GA1193@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:36811 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932448Ab2AEXwc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Jan 2012 18:52:32 -0500
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-input@vger.kernel.org> from <john.stultz@linaro.org>;
	Thu, 5 Jan 2012 18:52:31 -0500
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q05NpnwW349958
	for <linux-input@vger.kernel.org>; Thu, 5 Jan 2012 18:51:49 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q05Npm6D023162
	for <linux-input@vger.kernel.org>; Thu, 5 Jan 2012 16:51:49 -0700
In-Reply-To: <20120105232853.GA1193@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Daniel Kurtz <djkurtz@google.com>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>

On Thu, 2012-01-05 at 15:28 -0800, Dmitry Torokhov wrote:
> Hi John,
> 
> On Thu, Jan 05, 2012 at 03:01:05PM -0800, John Stultz wrote:
> >  
> > +	case EVIOCMONTIME:
> > +		if (copy_from_user(&i, p, sizeof(unsigned int)))
> > +			return -EFAULT;
> > +		client->use_monotonic = i;
> > +		return 0;
> 
> Maybe we should let users pass not boolean but CLOCK_* value (and reject
> ones that we do not support) ? This way if someone wants to use some
> other clock type in the future we won't need new ioctl.

That sounds like a good idea. 
Otherwise any conceptual issues with the patch?

Arve: If this is something we can get upstream, do you see any
complications in getting the Android evdev user to use this IOCTL to
change the timestamp mode?

thanks
-john


