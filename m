From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Warning: evdev changes - no auto-grabs anymore
Date: Fri, 15 Aug 2008 10:10:10 -0400
Message-ID: <20080815100717.ZZRA012@mailhub.coreip.homeip.net>
References: <20080814044337.GA11632@emu> <1218725645.907.27.camel@thor.sulgenrain.local> <1218736209.4467.11.camel@localhost.localdomain> <20080815002458.GA16836@emu> <20080815065159.GA16680@sci.fi> <20080815080247.GA17613@fooishbar.org> <20080815082629.GB16680@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:16763 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbYHOOKR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Aug 2008 10:10:17 -0400
Received: by qw-out-2122.google.com with SMTP id 3so75051qwe.37
        for <linux-input@vger.kernel.org>; Fri, 15 Aug 2008 07:10:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080815082629.GB16680@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville Syrj?l? <syrjala@sci.fi>
Cc: Daniel Stone <daniel@fooishbar.org>, Peter Hutterer <peter.hutterer@who-t.net>, Michel D?nzer <michel@tungstengraphics.com>, xorg@lists.freedesktop.org, linux-input@vger.kernel.org

On Fri, Aug 15, 2008 at 11:26:29AM +0300, Ville Syrj?l? wrote:
> On Fri, Aug 15, 2008 at 11:02:48AM +0300, Daniel Stone wrote:
> > On Fri, Aug 15, 2008 at 09:51:59AM +0300, Ville Syrj?l? wrote:
> > > On Fri, Aug 15, 2008 at 09:54:58AM +0930, Peter Hutterer wrote:
> > > > On Thu, Aug 14, 2008 at 01:50:09PM -0400, Adam Jackson wrote:
> > > > > This is, in fact, one of the main reasons I put SIOCGRAB there in the
> > > > > first place; you need to keep the keyboard's event stream out of the tty
> > > > > layer entirely, not just out of reach of the kbd driver.  At the time
> > > > > the argument was also that you wanted to keep them out of reach of
> > > > > normal users so you couldn't snoop passwords, but now that there's a
> > > > > ConsoleKit I think that's less true.
> > > > > 
> > > > > Mac mouse emulation we could probably just blacklist away from the evdev
> > > > > driver.  rfkill is... harder?  Does it get its own event device or not?
> > > > > I'd think it would have to get one kill device per wireless device.
> > > > 
> > > > The issue is not grabbing the mouse emulation device, it's grabbing the
> > > > keyboard that generates those keys events that should result in a button click
> > > > on a different device. So we'd need something in the kernel I guess.
> > > 
> > > I was pondering about the same issue wrt. DirectFB. I wonder if
> > > KDSETMODE/KD_GRAPHICS could be extended to take care of this or
> > > would it break some existing applications.
> > 
> > Yeah, I was thinking about that, but that would mean we have issues
> > under older kernels. I think the best was what I was proposing, which
> > would be EVIOCSERIOUSLYDONTSENDANYCONSOLEINPUTWEWILLDEALWITHIT().
> 
> Yeah that would be better since support for it could be detected runtime
> so the driver could do the right thing when running with a recent kernel,
> and it could just fall back to the normal grab with old kernels.
> 

If evdev support in X is maturing why does it even need using tty and
mousedev multiplexors? If you just use evdev for all of your devices
you would not have the problem of duplicate events coming from 2
interfaces.

-- 
Dmitry
