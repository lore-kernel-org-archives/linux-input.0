From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Tue, 21 Jun 2011 18:27:45 +0100
Message-ID: <20110621172744.GB26592@opensource.wolfsonmicro.com>
References: <1308042491-20203-4-git-send-email-david@protonic.nl>
 <20110616192732.GJ3795@ponder.secretlab.ca>
 <20110618101706.GB2401@core.coreip.homeip.net>
 <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
 <20110618145154.GA18190@core.coreip.homeip.net>
 <20110618151645.GG8195@ponder.secretlab.ca>
 <20110620094815.341d1cff@archvile>
 <20110620084511.GB23113@core.coreip.homeip.net>
 <20110621114631.GC25032@sirena.org.uk>
 <BANLkTikjUR_9wq_tGfomLZNdurvmEH1Jxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40727 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756960Ab1FUR1s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 13:27:48 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikjUR_9wq_tGfomLZNdurvmEH1Jxw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>, David Jander <david.jander@protonic.nl>

On Tue, Jun 21, 2011 at 06:34:48AM -0700, Dmitry Torokhov wrote:
> On Jun 21, 2011 3:46 PM, "Mark Brown" <broonie@opensource.wolfsonmicro.com>
> > On Mon, Jun 20, 2011 at 01:45:12AM -0700, Dmitry Torokhov wrote:

> > Like Grant says this really isn't terribly sustainable - it's not just
> > the device registration you need to sort out, it's also the registration
> > of the drivers so things actually get bound and handing of any delays in
> > the process of getting things to appear.

> If devices are registered only when they are fully usable then driver
> registration does not matter.

Right, but this is something that it's not reasonable to implement in
board code - if nothing else implementing it in board code would mean
we'd got lots of repitition of common patterns.

> > It's not trivial to get this
> > right in the general case and it's not reasonable to expect individual
> > boards to open code things,

> Board code has the ultimate knowledge about connected devices though.

Absolutely, board code or data should provide the information about how
things are wired up.  It's the acting on it bit that's the issue.

> > > How about we do not register device until all resources are ready? This
> > > is pretty simple concept - do not create an object until it is usable.
> Then
> > > nobody needs to bother with -EAGAIN or -ENOTYET or any other similar
> > > garbage.

> > As soon as you let the user build drivers modular this goes out of the
> > window.

> Why is that? If device is registered only when it is ready to be bound to
> then it does not matter when the driver is registered and whether it is
> built into the kernel or as a module.

Originally you were talking about registration ordering - solving the
module load issues also requires dynamic delays and rollbacks when
things get unregisterd, something that goes well beyond simple ordering
of the registrations. 

> > All the faff with initcall ordering that we do at the minute is
> > essentially trying to implement this mechanism.

> No, what you are doing is creating devices before they are usable and
> postponing the driver registration in hopes that devices will be ready by
> that time.

Right, which is controlling the ordering of registration so that things
generally work out OK as described above.

Nobody's arguing that we don't want to solve this in a better way, we're
just saying that actually doing that requires improvements in both core
infrastructure and the data we've got available to the infrastructure so
there's no reasonable solutions that we can deploy which are better than
the initcall ordering stuff we're doing at the minute.
