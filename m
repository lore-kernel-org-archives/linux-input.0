From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input : wacom - report resolution for ABS_MT events
Date: Fri, 28 Jan 2011 10:46:55 -0800
Message-ID: <20110128184654.GG6252@core.coreip.homeip.net>
References: <1296179245-14614-1-git-send-email-pinglinux@gmail.com>
 <20110128173048.GC2586@polaris.bitmath.org>
 <AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62120 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382Ab1A1SrG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 13:47:06 -0500
Received: by gyb11 with SMTP id 11so1197890gyb.19
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 10:47:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Fri, Jan 28, 2011 at 10:23:59AM -0800, Ping Cheng wrote:
> On Fri, Jan 28, 2011 at 9:30 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> > Hi Ping,
> >
> >> This is mainly required by the serial pen and touch devices since
> >> both pen and touch are on the same port. Updated the USB ones to
> >> keep MT event definition consistent among serial and USB devices.
> >
> > Why is this change performed? What does the patch do? Please elaborate
> > a little bit.
> 
> Let's see if I can explain it clearer or not.
> 
> We need to report resolution to userland for wacom_w8001.c. Since pen
> and touch data are reported through the same logical port for serial
> devices, using input_abs_set_res  for ABS_X/Y,  we can only pass the
> resolution for pen or touch. So, I let ABS_X/Y report pen resolution
> since most legacy ST clients process pen data over touch. However, for
> multi-touch clients, especially for those that support gestures, touch
> resolution is needed to calculate the physical distance between two
> touch points. Using  ABS_MT_POSITION_X/Y does not cause confusion and
> it is quite intuitive.

We just went through the round of why we should scale events from
different tools when they use the same event devices and I do not see
why MT data is any different.

Devices have only one set of physical axes (MT or not) so I believe
min, max and resultion should be reported on ABS_X, Y, X, etc, or, if
you want to have this data in ABS_MT_POSITION, it should be trhe same.

ABS_MT_POSITION is just a vehicle of delivering multipe contacts, not a
new device axis.

Thanks.

-- 
Dmitry
