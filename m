From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] input : wacom - report resolution for ABS_MT events
Date: Fri, 28 Jan 2011 20:12:03 +0100
Message-ID: <20110128191203.GA2729@polaris.bitmath.org>
References: <1296179245-14614-1-git-send-email-pinglinux@gmail.com>
 <20110128173048.GC2586@polaris.bitmath.org>
 <AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:38899 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755224Ab1A1TLM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 14:11:12 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

> >> This is mainly required by the serial pen and touch devices since
> >> both pen and touch are on the same port. Updated the USB ones to
> >> keep MT event definition consistent among serial and USB devices.
> >
> > Why is this change performed? What does the patch do? Please elaborate
> > a little bit.
> 
> Let's see if I can explain it clearer or not.
> 
> We need to report resolution to userland for wacom_w8001.c.

Thanks, perfect - sentences like this one is great to put in the patch
description.

> Since pen
> and touch data are reported through the same logical port for serial
> devices, using input_abs_set_res  for ABS_X/Y,  we can only pass the
> resolution for pen or touch. So, I let ABS_X/Y report pen resolution
> since most legacy ST clients process pen data over touch. However, for
> multi-touch clients, especially for those that support gestures, touch
> resolution is needed to calculate the physical distance between two
> touch points. Using  ABS_MT_POSITION_X/Y does not cause confusion and
> it is quite intuitive.

I thought this was solved by reporting both pen and touch on the same
scale, which would render this problem moot. Or?

[...]
> > Is this for the BAMBOO_PT case? What about the extra x/y scaling for
> > some of those devices?
> 
> Yes, it is for Bamboo. We do not need to scale the value here since
> touch and pen are on different ports. We had to scale the value for
> wacom_w8001 since both pen and touch are on the same port. Without
> scaling the data, the pen/finger tip will not follow the cursor on the
> screen (wacom_w8001 is a touchscren device).

I was thinking of the scaling quirk in effect for the Bamboo
Touch. The resolution would have to change as well.

Thanks,
Henrik
