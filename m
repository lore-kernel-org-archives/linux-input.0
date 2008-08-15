From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Warning: evdev changes - no auto-grabs anymore
Date: Fri, 15 Aug 2008 10:49:12 -0400
Message-ID: <20080815104431.ZZRA012@mailhub.coreip.homeip.net>
References: <20080814044337.GA11632@emu> <1218725645.907.27.camel@thor.sulgenrain.local> <1218736209.4467.11.camel@localhost.localdomain> <20080815002458.GA16836@emu> <20080815065159.GA16680@sci.fi> <20080815080247.GA17613@fooishbar.org> <20080815082629.GB16680@sci.fi> <20080815100717.ZZRA012@mailhub.coreip.homeip.net> <20080815143119.GB2779@fooishbar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.247]:26616 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbYHOOtR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Aug 2008 10:49:17 -0400
Received: by hs-out-0708.google.com with SMTP id 4so465194hsl.5
        for <linux-input@vger.kernel.org>; Fri, 15 Aug 2008 07:49:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080815143119.GB2779@fooishbar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Stone <daniel@fooishbar.org>, Ville Syrj?l? <syrjala@sci.fi>, Peter Hutterer <peter.hutterer@who-t.net>, Michel D?nzer <michel@tungstengraphics.com>, linux-input@vger.kernel.org

On Fri, Aug 15, 2008 at 05:31:19PM +0300, Daniel Stone wrote:
> On Fri, Aug 15, 2008 at 10:10:10AM -0400, Dmitry Torokhov wrote:
> > On Fri, Aug 15, 2008 at 11:26:29AM +0300, Ville Syrj?l? wrote:
> > > On Fri, Aug 15, 2008 at 11:02:48AM +0300, Daniel Stone wrote:
> > > > On Fri, Aug 15, 2008 at 09:51:59AM +0300, Ville Syrj?l? wrote:
> > > > > I was pondering about the same issue wrt. DirectFB. I wonder if
> > > > > KDSETMODE/KD_GRAPHICS could be extended to take care of this or
> > > > > would it break some existing applications.
> > > > 
> > > > Yeah, I was thinking about that, but that would mean we have issues
> > > > under older kernels. I think the best was what I was proposing, which
> > > > would be EVIOCSERIOUSLYDONTSENDANYCONSOLEINPUTWEWILLDEALWITHIT().
> > > 
> > > Yeah that would be better since support for it could be detected runtime
> > > so the driver could do the right thing when running with a recent kernel,
> > > and it could just fall back to the normal grab with old kernels.
> > 
> > If evdev support in X is maturing why does it even need using tty and
> > mousedev multiplexors? If you just use evdev for all of your devices
> > you would not have the problem of duplicate events coming from 2
> > interfaces.
> 
> We don't, and killing them is fine.  Even so, try doing that, and
> realise that the TTY layer has helpfully spewed out every single thing
> you've typed, oh, and Ctrl-C kills the X server.
> 

[taking xorg list off as it does not take my posts...]

Would not putting VC in raw mode and just ignoring the data coming out
of it take care of this problem?

-- 
Dmitry
