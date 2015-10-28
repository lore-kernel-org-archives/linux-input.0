From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: tsc2005 - Add support for tsc2004
Date: Tue, 27 Oct 2015 23:12:58 -0700
Message-ID: <20151028061258.GD16963@localhost>
References: <201510280724.dKfeR76E%fengguang.wu@intel.com>
 <1445991421-29938-1-git-send-email-mwelling@ieee.org>
 <20151028015141.GA11237@localhost>
 <20151028052334.GA6393@deathstar>
 <20151028054152.GA16963@localhost>
 <20151028054829.GA13066@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34890 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbbJ1GNJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Oct 2015 02:13:09 -0400
Content-Disposition: inline
In-Reply-To: <20151028054829.GA13066@deathstar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Oct 28, 2015 at 12:48:29AM -0500, Michael Welling wrote:
> On Tue, Oct 27, 2015 at 10:41:52PM -0700, Dmitry Torokhov wrote:
> > On Wed, Oct 28, 2015 at 12:23:34AM -0500, Michael Welling wrote:
> > > On Tue, Oct 27, 2015 at 06:51:41PM -0700, Dmitry Torokhov wrote:
> > > > Hi Michael,
> > > > On Tue, Oct 27, 2015 at 07:17:01PM -0500, Michael Welling wrote:
> > > > > Adds support for the i2c based tsc2004. Support was added to the tsc2005 driver
> > > > > due to the similarity of the devices.
> > > > > 
> > > > > Signed-off-by: Michael Welling <mwelling@ieee.org>
> > > > > ---
> > > > > v2: Fixes Kconfig based on report for 0-day build bot.
> > > > > 
> > > > >  .../bindings/input/touchscreen/tsc2004.txt         |  38 ++++
> > > > >  drivers/input/touchscreen/Kconfig                  |   7 +-
> > > > >  drivers/input/touchscreen/tsc2005.c                | 206 ++++++++++++++++-----
> > > > 
> > > > Could we maybe split the code into core, spi and i2c drivers instead of
> > > > keeping everything together and rely on #ifdefs?
> > > >
> > > Dmitry,
> > > 
> > > So then we have three files?
> > > Perhaps:
> > > drivers/input/touchscreen/tsc2004.c
> > > drivers/input/touchscreen/tsc2005.c
> > > drivers/input/touchscreen/tsc200x-core.c
> > > 
> > > Please ellaborate exactly how you want things to be structured and named so
> > > that I don't waste time in revision.
> > 
> > Sure, the naming above is fine. You'd have to export the
> > tsc_common_probe() and put I2C and SPI bits into tsc2005.c/tsc2004.c
> > 
> > I'd probably have separate Kconfig entries for TSC2004 and TSC2005 and
> > have the core be invisible module that the former 2 explicitly "select".
> > 
> > Does this make sense?
> 
> Yes it does.
> 
> I have been told that using wildcard names is bad in other subsystems.
> Perhaps tsc200x-core.c should be called something else because it has
> nothing to do with the tsc2007 but it is covered by the wildcard.
> 
> You you think this is a big deal?

No I do not.

Thanks.

-- 
Dmitry
