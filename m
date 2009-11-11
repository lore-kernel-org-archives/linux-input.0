From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
	through sysfs
Date: Wed, 11 Nov 2009 09:40:10 -0800
Message-ID: <20091111174010.GB10663@core.coreip.homeip.net>
References: <20091106075220.GC11311@core.coreip.homeip.net> <1257779344.21596.502.camel@localhost> <20091109171834.GA30386@core.coreip.homeip.net> <1257851059.21596.725.camel@localhost> <20091110171945.GA15263@core.coreip.homeip.net> <1257922211.21596.823.camel@localhost> <20091111081949.GB22141@core.coreip.homeip.net> <1257929573.21596.960.camel@localhost> <20091111095956.GB3654@core.coreip.homeip.net> <1257935192.21596.1004.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:40044 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940AbZKKRkO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 12:40:14 -0500
Received: by pwi3 with SMTP id 3so813669pwi.21
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2009 09:40:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257935192.21596.1004.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Nov 11, 2009 at 12:26:32PM +0200, Artem Bityutskiy wrote:
> On Wed, 2009-11-11 at 01:59 -0800, Dmitry Torokhov wrote:
> > On Wed, Nov 11, 2009 at 10:52:53AM +0200, Artem Bityutskiy wrote:
> > > Sorry Dmitry, I'm new to the input subsystem, may be this is why I still
> > > do not see any problem with introducing a nice and useful ioctl?
> 
> I do not insist on ioctl, if you can show a nice way to use sysfs. So
> far you did suggest this way, and I also do not see any nice way.
> 
> Really, we are happy to use sysfs, just show us how.
> 
> > There are several reasons:
> > 
> > - ioctls are not useful from scripts
> 
> Not valid point. There are tons of ioctls all over the place. And no one
> prevents us from creating a userspace program which the scripts can use.
>

Which needs to be packaged and distributed... The nice thing about sysfs
is that echo and cat are always available.

> And your sysfs proposal is unusable for both the scripts and the C
> programs. It is not any better.

It is hard to say at the moment, since we don't have a concrete
proposal for sysfs interface ;)

> 
> > - 32/64 bit comapt issues
> 
> Invalid point. Real compat issues exist only for ioctls which pass
> pointers. We are not going to do this at all.

And longs... and other types that based on longs...

> 
> > - currently there islimited number of ioctls in input core, they are all
> >   concentrated in joydev and evdev, almost all of them work on all
> >   devices, verifying locking is easy
> 
> OK, but this does not look like a blocker for introducing one more
> ioctl.
> 

The dfifference in your ioctl that it leaves implementationto drivers
thus vastly expanding the scope.

> > > On Wed, 2009-11-11 at 00:19 -0800, Dmitry Torokhov wrote:
> > > > > > I understand the appeal of working with the keycodes but what you are
> > > > > > asking is not simply ignoring certain keypresses (that is easy, just
> > > > > > ignore corresponding events in userspace), you want to prevent system
> > > > > > from waking up. In other words you want to "control PM layer through
> > > > > > input layer" and I believe this is wrong.
> > > > > 
> > > > > Err, this is really about disabling keys. 
> > > > 
> > > > If you want to stop delivery of certain keycodes to userspace then OK,
> > > > an option to subscrbe to certain events only instead of getting all
> > > > events from the device. But again, it will only work for that particular
> > > > user only, not everyone.
> > > 
> > > Yes, this will work for some particular input devices only, those which
> > > support the keys masking. What is wrong with this? We have the '-ENOTTY'
> > > error code, which for ioctl's means "ioctl is not supported".
> > > 
> > > But no one prevents us from making this work for _every_ input device by
> > > implementing a default ioctl handler in evdev.c, if needed. This handler
> > > can mask certain keys in SW.
> > > 
> > > IOW:
> > >    1. if my HW supports HW key masking, the evdev ioctl calls my
> > >       handler, which is implemented in my driver.
> > >    2. if my HW does not support this, the evdev ioctl masks the keys in
> > >       SW.
> > > 
> > > We are interested in 1. And if later someone needs 2., he/she can very
> > > easily implement that. But for now we can just return -ENOTTY (or
> > > -EINVAL, which seems to be used in the input subsystem).
> > 
> > And #2 is what I think input layer should provide. Something that
> > works for all devices and is isolated (one client does not affect
> > others).
> 
> We can do this, if you believe it normal if we implement code we do not
> use and thus, we cannot really test. I do not think it is normal, but if
> you insist, we can try doing.

I certainly do not insist that you write code that you are not be using,
far from it. I am just saying that from input layer POV #2 is what makes
most sense.

OK, I can see that limiting everything at evdev layer is not enough for
you and you would prefer disabling interrupt completely. This kind of
fine-grained control is possible I think only in gpio-keys and
gpio-mouse (and maaaaybe matrix_keypad) so I do not think that plumbing
it all the way through evdev with ioctl makes much sense. Let's see if I
can scribble something sysfs-based in a couple of days or if you beat me
to it.

The basic idea is that you create a new 'disabled_keys' and
'disabled_switches' attributes for the gpio-keys platfrom device. They,
for example, may take input in form of list of keys whose interrupts
should be disabled:

133-139,143,147,369-370

See bitmap_scnlistprintf() and bitmap_parselist() for parsing to bitmap
and then you can go through all keys and disable according to said
bitmap. You would need to extend the platform data forst to allow driver
specify whether it wants to sharee interrupt or it is greedy since we
can't disable shared interrupts.

What do you think about it?

-- 
Dmitry
