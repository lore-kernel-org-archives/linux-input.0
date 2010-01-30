From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Securing non-root X input
Date: Fri, 29 Jan 2010 23:45:46 -0800
Message-ID: <20100130074546.GB30378@core.coreip.homeip.net>
References: <20100129232437.GB6992@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:48110 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab0A3HxR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jan 2010 02:53:17 -0500
Received: by pxi12 with SMTP id 12so2411352pxi.33
        for <linux-input@vger.kernel.org>; Fri, 29 Jan 2010 23:53:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100129232437.GB6992@parisc-linux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Dave Airlie <airlied@gmail.com>, peter.hutterer@who-t.net, linux-input@vger.kernel.org, xorg@freedesktop.org

Hi Matthew,

On Fri, Jan 29, 2010 at 04:24:38PM -0700, Matthew Wilcox wrote:
> 
> Dave Airlie commented at LCA that the last obstacle to running X as a
> regular user (instead of setuid) was getting revoke() to work on evdev
> file descriptors so that the previous user can't snoop the keypresses /
> mouse movements / etc of the current user.
> 
> I respectfully disagree that this is the correct approach; making sure
> that legitimate apps behave correctly in the presence of revoke()
> is a significant hurdle, and one I'm not sure we want to undertake.
> It's also a pain in the arse to implement in the kernel, and may take
> an unacceptable amount of time or space to work.
> 
> Another approach we discussed was to implement O_EXCL without O_CREAT.
> ie fail the open if another process has the device open.  This turns
> out to be a bad idea as there are legitimate use cases (eg debugging)
> where we want it to work even if another process has the device open.
> 
> We also discussed using leases to ensure that a given task was the
> exclusive opener of a device, but the current lease code only works on
> regular files, and see the previous paragraph for cases where we don't
> want that behaviour anyway.
> 
> This tiny patch allows the X server to ask how many times the device has
> been opened.  If it's more than one, the X server can ask the user what
> they want to do about it.  For bonus points, the X server can also run
> programs like lsof or fuser to find out which other processes have the
> device open, and tell the user that information too.  At that point,
> the sysadmin can call in the ICBM strike on the offending user.
> 
> Does this approach work for everyone?
>

I do not think so. What about the cases when event devices are
legitimately opened by several processes, like this:

[dtor@dtor-d630 work]$ ps aux | grep hald-addon-input
root      1132  0.0  0.0  22200   824 ?        S    Jan22   0:29
hald-addon-input: Listening on /dev/input/event7 /dev/input/event2 /dev/input/event1 /dev/input/event6 /dev/input/event0 /dev/input/event12 /dev/input/event4
dtor     30424  0.0  0.0 102736   808 pts/3    S+   23:23   0:00 grep hald-addon-input
[dtor@dtor-d630 work]$

It might not be hald but some other daemon monitoring key presses
(sleep, hibernate, wifi keys and switches, etc).

If it was just about ensuring that only oneprocess accesses the device
then we could just use EVIOCGRAB but as experience shows it is not a
workable solution.

-- 
Dmitry
