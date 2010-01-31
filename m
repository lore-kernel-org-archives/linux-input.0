From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Securing non-root X input
Date: Sat, 30 Jan 2010 23:13:07 -0800
Message-ID: <20100131071307.GB12320@core.coreip.homeip.net>
References: <20100129232437.GB6992@parisc-linux.org>
 <20100130074546.GB30378@core.coreip.homeip.net>
 <20100131013534.GA1331@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:56793 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab0AaHNM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Jan 2010 02:13:12 -0500
Received: by pxi12 with SMTP id 12so3111927pxi.33
        for <linux-input@vger.kernel.org>; Sat, 30 Jan 2010 23:13:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100131013534.GA1331@parisc-linux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Dave Airlie <airlied@gmail.com>, peter.hutterer@who-t.net, linux-input@vger.kernel.org, xorg@freedesktop.org

On Sat, Jan 30, 2010 at 06:35:47PM -0700, Matthew Wilcox wrote:
> On Fri, Jan 29, 2010 at 11:45:46PM -0800, Dmitry Torokhov wrote:
> > Hi Matthew,
> > 
> > On Fri, Jan 29, 2010 at 04:24:38PM -0700, Matthew Wilcox wrote:
> > > This tiny patch allows the X server to ask how many times the device has
> > > been opened.  If it's more than one, the X server can ask the user what
> > > they want to do about it.  For bonus points, the X server can also run
> > > programs like lsof or fuser to find out which other processes have the
> > > device open, and tell the user that information too.  At that point,
> > > the sysadmin can call in the ICBM strike on the offending user.
> > > 
> > > Does this approach work for everyone?
> > 
> > I do not think so. What about the cases when event devices are
> > legitimately opened by several processes, like this:
> > 
> > [dtor@dtor-d630 work]$ ps aux | grep hald-addon-input
> > root      1132  0.0  0.0  22200   824 ?        S    Jan22   0:29
> > hald-addon-input: Listening on /dev/input/event7 /dev/input/event2 /dev/input/event1 /dev/input/event6 /dev/input/event0 /dev/input/event12 /dev/input/event4
> > dtor     30424  0.0  0.0 102736   808 pts/3    S+   23:23   0:00 grep hald-addon-input
> > [dtor@dtor-d630 work]$
> > 
> > It might not be hald but some other daemon monitoring key presses
> > (sleep, hibernate, wifi keys and switches, etc).
> > 
> > If it was just about ensuring that only oneprocess accesses the device
> > then we could just use EVIOCGRAB but as experience shows it is not a
> > workable solution.
> 
> Yes, that's right.  I didn't quite go far enough in my explanation
> above ...  the X server can look around the system to see what trusted
> daemons (running as either root or the same user as the one running X)
> currently have the device open, and notify the user if there's additional
> openers that it isn't expecting.
>

Then it will be constant race between X and the rest of the world with X
pretty much always behind. Kind of like SELinux - as soon as try moving
left or right the thing starts screaming at you...

> Maybe we don't need a kernel patch to make this work after all, just
> a suid helper for X that uses the code from lsof/fuser to list all the
> current openers of /dev/input/eventN.
> 

But what about the case where malicious user opens the devices after the
X done its scan?

> My only concern is if users are permitted to create other names for a
> given device, lsof/fuser doesn't find that:
> 
> # ln -s /dev/input/event0 myev0
> # sleep 60 < myev0 &
> # lsof /dev/input/event0
> COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
> sleep     2223 root    0r   CHR  13,64      0t0 1667 /dev/input/event0
> hald-addo 3363 root    6r   CHR  13,64      0t0 1667 /dev/input/event0
> devkit-po 3588 root    9r   CHR  13,64      0t0 1667 /dev/input/event0
> # rm myev0
> # mknod myev0 c 13 64
> # sleep 60 < myev0 &
> # lsof /dev/input/event0
> COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
> hald-addo 3363 root    6r   CHR  13,64      0t0 1667 /dev/input/event0
> devkit-po 3588 root    9r   CHR  13,64      0t0 1667 /dev/input/event0
> 
> So if we need to catch that possibility, we need something like this
> kernel patch ... if we're confident that /dev/input/ will be the only
> name for a given event, we don't need a kernel patch to make this work.
> 

mknod is a privileged operation, requiring CAP_MKNOD. Otherwise evcen
current setup would be completely insecure if any user could just mknod
in his home directory and snoop root's keypresses at console.

-- 
Dmitry
