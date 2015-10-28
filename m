From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH v2] Input: tsc2005 - Add support for tsc2004
Date: Wed, 28 Oct 2015 00:23:34 -0500
Message-ID: <20151028052334.GA6393@deathstar>
References: <201510280724.dKfeR76E%fengguang.wu@intel.com>
 <1445991421-29938-1-git-send-email-mwelling@ieee.org>
 <20151028015141.GA11237@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34774 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbbJ1FXo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Oct 2015 01:23:44 -0400
Content-Disposition: inline
In-Reply-To: <20151028015141.GA11237@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Oct 27, 2015 at 06:51:41PM -0700, Dmitry Torokhov wrote:
> Hi Michael,
> On Tue, Oct 27, 2015 at 07:17:01PM -0500, Michael Welling wrote:
> > Adds support for the i2c based tsc2004. Support was added to the tsc2005 driver
> > due to the similarity of the devices.
> > 
> > Signed-off-by: Michael Welling <mwelling@ieee.org>
> > ---
> > v2: Fixes Kconfig based on report for 0-day build bot.
> > 
> >  .../bindings/input/touchscreen/tsc2004.txt         |  38 ++++
> >  drivers/input/touchscreen/Kconfig                  |   7 +-
> >  drivers/input/touchscreen/tsc2005.c                | 206 ++++++++++++++++-----
> 
> Could we maybe split the code into core, spi and i2c drivers instead of
> keeping everything together and rely on #ifdefs?
>
Dmitry,

So then we have three files?
Perhaps:
drivers/input/touchscreen/tsc2004.c
drivers/input/touchscreen/tsc2005.c
drivers/input/touchscreen/tsc200x-core.c

Please ellaborate exactly how you want things to be structured and named so
that I don't waste time in revision.

It appears that I can't make the build bot happy the way it is.
 
> Thanks!
> 
> -- 
> Dmitry
