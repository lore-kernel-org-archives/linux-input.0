From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input : wacom - report resolution for ABS_MT events
Date: Fri, 28 Jan 2011 16:05:39 -0800
Message-ID: <20110129000539.GL6252@core.coreip.homeip.net>
References: <1296179245-14614-1-git-send-email-pinglinux@gmail.com>
 <20110128173048.GC2586@polaris.bitmath.org>
 <AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
 <20110128184654.GG6252@core.coreip.homeip.net>
 <AANLkTikgTYQvhTzEHWw0Yhigno7TLJ8jm9jaw10mOhk+@mail.gmail.com>
 <20110128193731.GH6252@core.coreip.homeip.net>
 <AANLkTi=31ckFhy28R30=64+BBmHkn43DA8js1b0pdoQ4@mail.gmail.com>
 <20110128205403.GI6252@core.coreip.homeip.net>
 <AANLkTikUmajiTDxNzOKNznevdutnefO7CgTrBg8=rRCu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36803 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab1A2AFu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 19:05:50 -0500
Received: by iwn9 with SMTP id 9so3623083iwn.19
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 16:05:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikUmajiTDxNzOKNznevdutnefO7CgTrBg8=rRCu@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Fri, Jan 28, 2011 at 01:57:17PM -0800, Ping Cheng wrote:
> On Fri, Jan 28, 2011 at 12:54 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >> >> > so I believe
> >> >> > min, max and resultion should be reported on ABS_X, Y, X, etc, or, if
> >> >> > you want to have this data in ABS_MT_POSITION, it should be trhe same.
> >> >>
> >> >> max/min is different from resolution. We can scale max/min since they
> >> >> are logical data. But we can not change the device's physical size.
> >> >> That's the root cause of the "stubborn" nature of resolution.
> >> >
> >> > This is the same device so it should have the same physical dimensions,
> >> > right?
> >>
> >> No, pen and touch use different chips. They can have different sizes.
> >
> > It does not matter how many chips you have inside. What matters whether
> > they share a working surface or not. If working surface is the same (and
> > consequentially you have single input_dev structure) then dimensions are
> > the same.
> 
> They do not always share the exact same surface. Most of the devices
> do have the same working surface. But not all of them although the
> differences are normally small. To represent a finger touch, it may
> not be too big a deal. But, making the assumption that they are the
> same size doesn't sound right.
> 
> Do we ignore that small imprecision?

I think we should consider these cases as having roughly the same
dimensions of working surfaces. Because if we do what you are proposing
the next thing we'll see an MT device that can report several tools
simultaneously and your scheme breaks apart.

Devices with surface characteristics so different that they can't be
handled well by scaling to common denominator should probably be
presented as 2 independent logical devices.

Thanks.

-- 
Dmitry
