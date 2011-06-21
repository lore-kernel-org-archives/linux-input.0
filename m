From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Wed, 22 Jun 2011 00:02:42 +0100
Message-ID: <20110621230242.GA8791@opensource.wolfsonmicro.com>
References: <20110618101706.GB2401@core.coreip.homeip.net>
 <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
 <20110618145154.GA18190@core.coreip.homeip.net>
 <20110618151645.GG8195@ponder.secretlab.ca>
 <20110620094815.341d1cff@archvile>
 <20110620084511.GB23113@core.coreip.homeip.net>
 <20110621114631.GC25032@sirena.org.uk>
 <BANLkTikjUR_9wq_tGfomLZNdurvmEH1Jxw@mail.gmail.com>
 <20110621172744.GB26592@opensource.wolfsonmicro.com>
 <20110621204804.GC3731@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47660 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756933Ab1FUXCp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 19:02:45 -0400
Content-Disposition: inline
In-Reply-To: <20110621204804.GC3731@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>, David Jander <david.jander@protonic.nl>

On Tue, Jun 21, 2011 at 01:48:05PM -0700, Dmitry Torokhov wrote:
> On Tue, Jun 21, 2011 at 06:27:45PM +0100, Mark Brown wrote:

> > Right, but this is something that it's not reasonable to implement in
> > board code - if nothing else implementing it in board code would mean
> > we'd got lots of repitition of common patterns.

> I agree here. I just disagree that we should be implementing this in
> driver core by having special -EAGAIN handling. Having a common
> library-like code (probably tied to device-tree) that handles device
> dependencies would be great.

Ah, that's more OK then.  I'm not entirely sure about the -EAGAIN
proposal but it does seem to have some advantages in terms of
deployment.

> Ah, OK, so we basically in agreement here with the exception that I do
> not want the band-aid to hit mainline since it takes the heat off people
> who need inter-device dependency to actually work.

> Can the initcall stuff be kept out of mainline? I'd expect

The init order stuff is in mainline already, you're far too late to the
party here.

> there exist board-specific trees where such patches could be kept? Or
> maybe interested parties could create board-crap tree to store patches
> like this one?

Keeping things in board trees is exactly the sort of thing we want to
avoid people doing.  That just means people do all sorts of stuff that
wouldn't be acceptable upstream, either out of ignorance or through
knowing that only their systems have to work with what they're doing,
and just don't bother working upstream at all half the time making life
miserable for pretty much everyone.
