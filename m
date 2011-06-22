From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Wed, 22 Jun 2011 12:38:35 +0100
Message-ID: <20110622113835.GC18726@opensource.wolfsonmicro.com>
References: <20110618145154.GA18190@core.coreip.homeip.net>
 <20110618151645.GG8195@ponder.secretlab.ca>
 <20110620094815.341d1cff@archvile>
 <20110620084511.GB23113@core.coreip.homeip.net>
 <20110621114631.GC25032@sirena.org.uk>
 <BANLkTikjUR_9wq_tGfomLZNdurvmEH1Jxw@mail.gmail.com>
 <20110621172744.GB26592@opensource.wolfsonmicro.com>
 <20110621204804.GC3731@core.coreip.homeip.net>
 <20110621230242.GA8791@opensource.wolfsonmicro.com>
 <20110622070052.GA16561@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45580 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752552Ab1FVLii (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2011 07:38:38 -0400
Content-Disposition: inline
In-Reply-To: <20110622070052.GA16561@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>, David Jander <david.jander@protonic.nl>

On Wed, Jun 22, 2011 at 12:00:52AM -0700, Dmitry Torokhov wrote:
> On Wed, Jun 22, 2011 at 12:02:42AM +0100, Mark Brown wrote:
> > On Tue, Jun 21, 2011 at 01:48:05PM -0700, Dmitry Torokhov wrote:

> > > Can the initcall stuff be kept out of mainline? I'd expect

> > The init order stuff is in mainline already, you're far too late to the
> > party here.

> For some drivers it might be already in mainline, it does not matter
> that we should continue adding more.

It's not just a few drivers, there's entire subsystems that are doing
this.

> > Keeping things in board trees is exactly the sort of thing we want to
> > avoid people doing.  That just means people do all sorts of stuff that
> > wouldn't be acceptable upstream, either out of ignorance or through
> > knowing that only their systems have to work with what they're doing,
> > and just don't bother working upstream at all half the time making life
> > miserable for pretty much everyone.

> So you are saying that we should accept such crap directly into
> mainline?

Pretty much, yes.  In code terms it's not really invasive and it doesn't
have any real impact on other systems so it's the sort of thing we can
carry without too much pain.  Pragmatically it's not unreasonable.

> Again, it looks like we agree that shuffling initcalls is not proper
> solution for this problem nor it is maintainable, so it is exactly the
> kind of patches that should be kept in the board trees and out of
> mainline.

On the other hand if we're telling people that they can't run their
system usefully from mainline (in some cases we can't even boot) then
we're sending a bad message about the usefulness of mainline and we're
encouraging a space where non-mainline code is acceptable.

The situation here is similar to what we used to have with interrupt
controllers on slow buses - we spent a while working with open coded
non-genirq implementations confined to particular drivers before genirq
was able to support this sort of hardware because there wasn't a clear
route to getting that done in a reasonable timeframe.
