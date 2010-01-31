From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Securing non-root X input
Date: Sun, 31 Jan 2010 10:08:01 -0700
Message-ID: <20100131170801.GB1331@parisc-linux.org>
References: <20100129232437.GB6992@parisc-linux.org> <20100130074546.GB30378@core.coreip.homeip.net> <20100131013534.GA1331@parisc-linux.org> <20100131071307.GB12320@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:39202 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab0AaRIE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Jan 2010 12:08:04 -0500
Content-Disposition: inline
In-Reply-To: <20100131071307.GB12320@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, peter.hutterer@who-t.net, linux-input@vger.kernel.org, xorg@freedesktop.org

On Sat, Jan 30, 2010 at 11:13:07PM -0800, Dmitry Torokhov wrote:
> > Yes, that's right.  I didn't quite go far enough in my explanation
> > above ...  the X server can look around the system to see what trusted
> > daemons (running as either root or the same user as the one running X)
> > currently have the device open, and notify the user if there's additional
> > openers that it isn't expecting.
> 
> Then it will be constant race between X and the rest of the world with X
> pretty much always behind. Kind of like SELinux - as soon as try moving
> left or right the thing starts screaming at you...

Only if it's done badly (eg whitelisting HAL and Devkit).  The algorithm
I proposed above (allow anything owned by root, and anything owned by
the same user that is running X) should be secure, and futureproof.
Ultimately, it's up to the distro to get this right.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
