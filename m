From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Microsoft Touch Mouse driver [was: Re: your mail]
Date: Sun, 29 Jan 2012 23:27:32 -0800
Message-ID: <20120130072732.GA1855@core.coreip.homeip.net>
References: <BROWNM3h3vLgAusVxON00000cfa@brown.emailprod.vodafone.se>
 <20120125132612.GA3890@polaris.bitmath.org>
 <4F200D14.80702@gmail.com>
 <20120125150035.GA4222@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40002 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab2A3H1j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jan 2012 02:27:39 -0500
Received: by iacb35 with SMTP id b35so4809975iac.19
        for <linux-input@vger.kernel.org>; Sun, 29 Jan 2012 23:27:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120125150035.GA4222@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>, linux-input@vger.kernel.org

On Wed, Jan 25, 2012 at 04:00:35PM +0100, Henrik Rydberg wrote:
> > In my first tests, I was doing readouts in userspace using hidraw,
> > which performed quite well.
> > 
> > Bandwidth could be an issue, but I'd like to use the current APIs as
> > much as possible so I don't need to go modifying mtdev, X, ...
> 
> Unless you do clustering, filtering and what not in-kernel, something
> will have to change for sure.
> 
> > >One possible option could be to use the
> > >slots, but only send ABS_MT_TOUCH_MAJOR or ABS_MT_PRESSURE, nothing
> > >else. The device would (rightfully) not be recognized as MT since the
> > >position is missing, all data would be available for processing in
> > >userspace, and bandwidth would be minimized since there could only be
> > >so many changes coming in per millisecond.
> > 
> > So how does userspace then finds out where these pressure points are
> > located?
> > Or do you mean to just dump all data to user space (15 * 13 *
> > sizeof(ABS_MT_PRESSURE value) + overhead)?
> 
> Having each pressure point represented by one slot id was the idea.
> Userspace would have to know how the points are mapped, of
> course. Still not overly happy about the general fit, though. Dmitry?

I am having doubts that this device, as it is, is suitable for input
interface; I really do not think that bastardizing slot IDs is good
idea. Unless we move all computation necessary to identify individual
contacts into the kernel (and then use standard MT protocol), I'd
recommend looking into hidraw + uinput solution.

Thanks.

-- 
Dmitry
