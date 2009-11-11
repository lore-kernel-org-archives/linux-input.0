From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
	through sysfs
Date: Wed, 11 Nov 2009 00:19:49 -0800
Message-ID: <20091111081949.GB22141@core.coreip.homeip.net>
References: <20091028054317.GB2368@core.coreip.homeip.net> <20091028105001.GB26199@esdhcp04058.research.nokia.com> <20091104090628.GG31062@gw.healthdatacare.com> <1257326759.21596.92.camel@localhost> <20091106075220.GC11311@core.coreip.homeip.net> <1257779344.21596.502.camel@localhost> <20091109171834.GA30386@core.coreip.homeip.net> <1257851059.21596.725.camel@localhost> <20091110171945.GA15263@core.coreip.homeip.net> <1257922211.21596.823.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f177.google.com ([209.85.216.177]:47930 "EHLO
	mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094AbZKKITt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 03:19:49 -0500
Received: by pxi7 with SMTP id 7so628619pxi.17
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2009 00:19:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257922211.21596.823.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Nov 11, 2009 at 08:50:11AM +0200, Artem Bityutskiy wrote:
> On Tue, 2009-11-10 at 09:19 -0800, Dmitry Torokhov wrote:
> > On Tue, Nov 10, 2009 at 01:04:19PM +0200, Artem Bityutskiy wrote:
> > > On Mon, 2009-11-09 at 09:18 -0800, Dmitry Torokhov wrote:
> > > > 
> > > > I am not sure at what level these attributes must be created. While the
> > > > easiest way is indeed per-input device attribute (for that particular
> > > > driver) the functionality does not really have anything to do with
> > > > input... I'd probably prefer having this attribute elsewhere, maybe
> > > > we should extend /sys/class/gpio/gpioN for these purposes?
> > > > 
> > > > > * could you please give an example of how would I switch off, say, the
> > > > >   SW_CAMERA_LENS_COVER gpio by the keycode.
> > > > 
> > > > If the code lies in your driver then it is easy (the driver knows the
> > > > mapping); otherwsie you'll have to go with GPIO number.
> > > 
> > > GPIO numbers are bad for us. We want to work with keycodes, and this is
> > > input subsystem after all. We do not want to do any perversions like
> > > making our user-space figuring out gpio numbers by the keycodes. This is
> > > simply wrong and bad interface.
> > > 
> > > We want to have a simple way for the application to disable any key by
> > > key code. This should be as simple as calling one single
> > > "enable/disable" ioctl for /dev/input/event2. I do not see how this
> > > could be done nicely with sysfs, still.
> > > 
> > 
> > I understand the appeal of working with the keycodes but what you are
> > asking is not simply ignoring certain keypresses (that is easy, just
> > ignore corresponding events in userspace), you want to prevent system
> > from waking up. In other words you want to "control PM layer through
> > input layer" and I believe this is wrong.
> 
> Err, this is really about disabling keys. 

If you want to stop delivery of certain keycodes to userspace then OK,
an option to subscrbe to certain events only instead of getting all
events from the device. But again, it will only work for that particular
user only, not everyone.

> If we think about this in an
> abstract way, you have an input device with many keys. And the device's
> HW allows you to disable any of it's keys. When you disable the key, the
> input device ignores it and does not generate any interrupt for it.

And the reason you want to stop interrupts?

-- 
Dmitry
