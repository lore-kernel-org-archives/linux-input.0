From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Tue, 21 Jun 2011 13:48:05 -0700
Message-ID: <20110621204804.GC3731@core.coreip.homeip.net>
References: <20110616192732.GJ3795@ponder.secretlab.ca>
 <20110618101706.GB2401@core.coreip.homeip.net>
 <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
 <20110618145154.GA18190@core.coreip.homeip.net>
 <20110618151645.GG8195@ponder.secretlab.ca>
 <20110620094815.341d1cff@archvile>
 <20110620084511.GB23113@core.coreip.homeip.net>
 <20110621114631.GC25032@sirena.org.uk>
 <BANLkTikjUR_9wq_tGfomLZNdurvmEH1Jxw@mail.gmail.com>
 <20110621172744.GB26592@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40376 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756751Ab1FUUyI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 16:54:08 -0400
Received: by pwj7 with SMTP id 7so194342pwj.19
        for <linux-input@vger.kernel.org>; Tue, 21 Jun 2011 13:54:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110621172744.GB26592@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>, David Jander <david.jander@protonic.nl>

On Tue, Jun 21, 2011 at 06:27:45PM +0100, Mark Brown wrote:
> On Tue, Jun 21, 2011 at 06:34:48AM -0700, Dmitry Torokhov wrote:
> > On Jun 21, 2011 3:46 PM, "Mark Brown" <broonie@opensource.wolfsonmicro.com>
> > > On Mon, Jun 20, 2011 at 01:45:12AM -0700, Dmitry Torokhov wrote:
> 
> > > Like Grant says this really isn't terribly sustainable - it's not just
> > > the device registration you need to sort out, it's also the registration
> > > of the drivers so things actually get bound and handing of any delays in
> > > the process of getting things to appear.
> 
> > If devices are registered only when they are fully usable then driver
> > registration does not matter.
> 
> Right, but this is something that it's not reasonable to implement in
> board code - if nothing else implementing it in board code would mean
> we'd got lots of repitition of common patterns.

I agree here. I just disagree that we should be implementing this in
driver core by having special -EAGAIN handling. Having a common
library-like code (probably tied to device-tree) that handles device
dependencies would be great.

> 
> > > It's not trivial to get this
> > > right in the general case and it's not reasonable to expect individual
> > > boards to open code things,
> 
> > Board code has the ultimate knowledge about connected devices though.
> 
> Absolutely, board code or data should provide the information about how
> things are wired up.  It's the acting on it bit that's the issue.
> 
> > > > How about we do not register device until all resources are ready? This
> > > > is pretty simple concept - do not create an object until it is usable.
> > Then
> > > > nobody needs to bother with -EAGAIN or -ENOTYET or any other similar
> > > > garbage.
> 
> > > As soon as you let the user build drivers modular this goes out of the
> > > window.
> 
> > Why is that? If device is registered only when it is ready to be bound to
> > then it does not matter when the driver is registered and whether it is
> > built into the kernel or as a module.
> 
> Originally you were talking about registration ordering - solving the
> module load issues also requires dynamic delays and rollbacks when
> things get unregisterd, something that goes well beyond simple ordering
> of the registrations. 

I always was only saying that devices should be registered when they are
ready. It is my understanding that normally board code tries to register
all devices; drivers may or may not be compiled as modules. Not that we
could not have devices created by modules...

> 
> > > All the faff with initcall ordering that we do at the minute is
> > > essentially trying to implement this mechanism.
> 
> > No, what you are doing is creating devices before they are usable and
> > postponing the driver registration in hopes that devices will be ready by
> > that time.
> 
> Right, which is controlling the ordering of registration so that things
> generally work out OK as described above.
> 
> Nobody's arguing that we don't want to solve this in a better way, we're
> just saying that actually doing that requires improvements in both core
> infrastructure and the data we've got available to the infrastructure so
> there's no reasonable solutions that we can deploy which are better than
> the initcall ordering stuff we're doing at the minute.

Ah, OK, so we basically in agreement here with the exception that I do
not want the band-aid to hit mainline since it takes the heat off people
who need inter-device dependency to actually work.

Can the initcall stuff be kept out of mainline? I'd expect
there exist board-specific trees where such patches could be kept? Or
maybe interested parties could create board-crap tree to store patches
like this one?

Thanks.

-- 
Dmitry
