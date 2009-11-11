From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
	through sysfs
Date: Wed, 11 Nov 2009 01:59:56 -0800
Message-ID: <20091111095956.GB3654@core.coreip.homeip.net>
References: <20091104090628.GG31062@gw.healthdatacare.com> <1257326759.21596.92.camel@localhost> <20091106075220.GC11311@core.coreip.homeip.net> <1257779344.21596.502.camel@localhost> <20091109171834.GA30386@core.coreip.homeip.net> <1257851059.21596.725.camel@localhost> <20091110171945.GA15263@core.coreip.homeip.net> <1257922211.21596.823.camel@localhost> <20091111081949.GB22141@core.coreip.homeip.net> <1257929573.21596.960.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f177.google.com ([209.85.216.177]:61616 "EHLO
	mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbZKKJ7z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 04:59:55 -0500
Received: by pxi7 with SMTP id 7so674844pxi.17
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2009 02:00:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257929573.21596.960.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Nov 11, 2009 at 10:52:53AM +0200, Artem Bityutskiy wrote:
> Sorry Dmitry, I'm new to the input subsystem, may be this is why I still
> do not see any problem with introducing a nice and useful ioctl?

There are several reasons:

- ioctls are not useful from scripts
- 32/64 bit comapt issues
- currently there islimited number of ioctls in input core, they are all
  concentrated in joydev and evdev, almost all of them work on all
  devices, verifying locking is easy

> 
> On Wed, 2009-11-11 at 00:19 -0800, Dmitry Torokhov wrote:
> > > > I understand the appeal of working with the keycodes but what you are
> > > > asking is not simply ignoring certain keypresses (that is easy, just
> > > > ignore corresponding events in userspace), you want to prevent system
> > > > from waking up. In other words you want to "control PM layer through
> > > > input layer" and I believe this is wrong.
> > > 
> > > Err, this is really about disabling keys. 
> > 
> > If you want to stop delivery of certain keycodes to userspace then OK,
> > an option to subscrbe to certain events only instead of getting all
> > events from the device. But again, it will only work for that particular
> > user only, not everyone.
> 
> Yes, this will work for some particular input devices only, those which
> support the keys masking. What is wrong with this? We have the '-ENOTTY'
> error code, which for ioctl's means "ioctl is not supported".
> 
> But no one prevents us from making this work for _every_ input device by
> implementing a default ioctl handler in evdev.c, if needed. This handler
> can mask certain keys in SW.
> 
> IOW:
>    1. if my HW supports HW key masking, the evdev ioctl calls my
>       handler, which is implemented in my driver.
>    2. if my HW does not support this, the evdev ioctl masks the keys in
>       SW.
> 
> We are interested in 1. And if later someone needs 2., he/she can very
> easily implement that. But for now we can just return -ENOTTY (or
> -EINVAL, which seems to be used in the input subsystem).

And #2 is what I think input layer should provide. Something that
works for all devices and is isolated (one client does not affect
others).

> 
> > > If we think about this in an
> > > abstract way, you have an input device with many keys. And the device's
> > > HW allows you to disable any of it's keys. When you disable the key, the
> > > input device ignores it and does not generate any interrupt for it.
> > 
> > And the reason you want to stop interrupts?
> 
> The reason is that I want simply mute certain keys. This is the only
> reason.
> 
> Now the question is _how_ I want to mute the key. My HW supports muting,
> so I want to mute it in HW level, just because it is much better and
> more efficient. Just because in this case I will not have any interrupt
> and my device will wake up less.

And the reason you care about number of wake ups is not saving power by
any chance?

-- 
Dmitry
