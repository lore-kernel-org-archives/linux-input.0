From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Securing non-root X input
Date: Sun, 31 Jan 2010 18:03:01 -0800
Message-ID: <20100201020301.GB24188@core.coreip.homeip.net>
References: <20100129232437.GB6992@parisc-linux.org>
 <20100130074546.GB30378@core.coreip.homeip.net>
 <20100131013534.GA1331@parisc-linux.org>
 <20100131071307.GB12320@core.coreip.homeip.net>
 <20100131170801.GB1331@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:39133 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab0BACDG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Jan 2010 21:03:06 -0500
Received: by pxi12 with SMTP id 12so3701161pxi.33
        for <linux-input@vger.kernel.org>; Sun, 31 Jan 2010 18:03:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100131170801.GB1331@parisc-linux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Dave Airlie <airlied@gmail.com>, peter.hutterer@who-t.net, linux-input@vger.kernel.org, xorg@freedesktop.org

On Sun, Jan 31, 2010 at 10:08:01AM -0700, Matthew Wilcox wrote:
> On Sat, Jan 30, 2010 at 11:13:07PM -0800, Dmitry Torokhov wrote:
> > > Yes, that's right.  I didn't quite go far enough in my explanation
> > > above ...  the X server can look around the system to see what trusted
> > > daemons (running as either root or the same user as the one running X)
> > > currently have the device open, and notify the user if there's additional
> > > openers that it isn't expecting.
> > 
> > Then it will be constant race between X and the rest of the world with X
> > pretty much always behind. Kind of like SELinux - as soon as try moving
> > left or right the thing starts screaming at you...
> 
> Only if it's done badly (eg whitelisting HAL and Devkit).  The algorithm
> I proposed above (allow anything owned by root, and anything owned by
> the same user that is running X) should be secure, and futureproof.
> Ultimately, it's up to the distro to get this right.
> 

Ah, OK then. Well, I don't think that we need any special support from
kernel then. If users could create device nodes on their own we'd be in
trouble right now, but since they can't by default we should be good.

-- 
Dmitry
