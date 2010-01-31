From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Securing non-root X input
Date: Sat, 30 Jan 2010 18:35:47 -0700
Message-ID: <20100131013534.GA1331@parisc-linux.org>
References: <20100129232437.GB6992@parisc-linux.org> <20100130074546.GB30378@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:35358 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab0AaBft (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jan 2010 20:35:49 -0500
Content-Disposition: inline
In-Reply-To: <20100130074546.GB30378@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, peter.hutterer@who-t.net, linux-input@vger.kernel.org, xorg@freedesktop.org

On Fri, Jan 29, 2010 at 11:45:46PM -0800, Dmitry Torokhov wrote:
> Hi Matthew,
> 
> On Fri, Jan 29, 2010 at 04:24:38PM -0700, Matthew Wilcox wrote:
> > This tiny patch allows the X server to ask how many times the device has
> > been opened.  If it's more than one, the X server can ask the user what
> > they want to do about it.  For bonus points, the X server can also run
> > programs like lsof or fuser to find out which other processes have the
> > device open, and tell the user that information too.  At that point,
> > the sysadmin can call in the ICBM strike on the offending user.
> > 
> > Does this approach work for everyone?
> 
> I do not think so. What about the cases when event devices are
> legitimately opened by several processes, like this:
> 
> [dtor@dtor-d630 work]$ ps aux | grep hald-addon-input
> root      1132  0.0  0.0  22200   824 ?        S    Jan22   0:29
> hald-addon-input: Listening on /dev/input/event7 /dev/input/event2 /dev/input/event1 /dev/input/event6 /dev/input/event0 /dev/input/event12 /dev/input/event4
> dtor     30424  0.0  0.0 102736   808 pts/3    S+   23:23   0:00 grep hald-addon-input
> [dtor@dtor-d630 work]$
> 
> It might not be hald but some other daemon monitoring key presses
> (sleep, hibernate, wifi keys and switches, etc).
> 
> If it was just about ensuring that only oneprocess accesses the device
> then we could just use EVIOCGRAB but as experience shows it is not a
> workable solution.

Yes, that's right.  I didn't quite go far enough in my explanation
above ...  the X server can look around the system to see what trusted
daemons (running as either root or the same user as the one running X)
currently have the device open, and notify the user if there's additional
openers that it isn't expecting.

Maybe we don't need a kernel patch to make this work after all, just
a suid helper for X that uses the code from lsof/fuser to list all the
current openers of /dev/input/eventN.

My only concern is if users are permitted to create other names for a
given device, lsof/fuser doesn't find that:

# ln -s /dev/input/event0 myev0
# sleep 60 < myev0 &
# lsof /dev/input/event0
COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
sleep     2223 root    0r   CHR  13,64      0t0 1667 /dev/input/event0
hald-addo 3363 root    6r   CHR  13,64      0t0 1667 /dev/input/event0
devkit-po 3588 root    9r   CHR  13,64      0t0 1667 /dev/input/event0
# rm myev0
# mknod myev0 c 13 64
# sleep 60 < myev0 &
# lsof /dev/input/event0
COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
hald-addo 3363 root    6r   CHR  13,64      0t0 1667 /dev/input/event0
devkit-po 3588 root    9r   CHR  13,64      0t0 1667 /dev/input/event0

So if we need to catch that possibility, we need something like this
kernel patch ... if we're confident that /dev/input/ will be the only
name for a given event, we don't need a kernel patch to make this work.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
