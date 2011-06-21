From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Tue, 21 Jun 2011 16:36:20 +0200
Message-ID: <20110621163620.646da4c2@archvile>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
	<1308042491-20203-4-git-send-email-david@protonic.nl>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:20609 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754Ab1FUOgP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 10:36:15 -0400
In-Reply-To: <BANLkTikjUR_9wq_tGfomLZNdurvmEH1Jxw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

On Tue, 21 Jun 2011 06:34:48 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Jun 21, 2011 3:46 PM, "Mark Brown" <broonie@opensource.wolfsonmicro.com>
> wrote:
> >
> > On Mon, Jun 20, 2011 at 01:45:12AM -0700, Dmitry Torokhov wrote:
> >
> > > This is a laudable goal, but then device-tree needs to be able to
> > > express device dependencies better. Until then board-specific code is
> > > needed to register devices in proper order.
> >
> > Like Grant says this really isn't terribly sustainable - it's not just
> > the device registration you need to sort out, it's also the registration
> > of the drivers so things actually get bound and handing of any delays in
> > the process of getting things to appear.
> 
> If devices are registered only when they are fully usable then driver
> registration does not matter.
> 
> > It's not trivial to get this
> > right in the general case and it's not reasonable to expect individual
> > boards to open code things,
> 
> Board code has the ultimate knowledge about connected devices though.

Ok, let me try this essay:
Board code, if there is any, or device-tree, or any other source of setup
information knows best what needs to be initialized or bound when and in which
order. If there is board code, one could solve this by embedding the logic in
synchronous (initcall-based) or asynchronous (thread) board setup code. It is
done on ARM that way, and IMHO it stinks, and AFAICS even Linus would
probably agree (see
http://thread.gmane.org/gmane.linux.ports.arm.kernel/113483/focus=113895 ).
But we already have one example of non-code based setup information sources,
which is the device-tree. A flexible system should not lock out the
possibility that there are other such sources which favor generic code and
dis-favor specific board setup code (reinventing wheels btw).
So I guess everyone agrees that some core-infrastructure is missing to solve
this problem "correctly". Since requiring board-specific code is not
desirable due to the reasons stated above, what should we do in the meantime?

IMHO, the late_initcall thing is both simple and should increase chances of
success by a reasonable amount, while waiting for the correct solution to be
implemented: An interface in the device/driver core infrastructure to specify
device-dependencies in a generic and flexible way, so it can be sourced from a
device-tree, board setup code (if you must) or any other source for that
matter. At that moment, it is a matter of grepping for late_initcall and
reverting these changes, if needed.

Also, something like a keyboard driver (the part that generates input events,
gpio_keys.c in this case), hardly could be a prerequisite for anything else,
since it is clearly at the end of the driver food-chain. So what could possibly
break by this change?

Best regards,

-- 
David Jander
Protonic Holland.
