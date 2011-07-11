From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: TPS6507X - define MFD dependencies for touch and
 regulator unit
Date: Tue, 12 Jul 2011 07:33:14 +0900
Message-ID: <20110711223312.GA32033@opensource.wolfsonmicro.com>
References: <4E1AD56B.6080306@visionsystems.de>
 <20110711122004.GA9478@sirena.org.uk>
 <20110711164124.GB1648@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50768 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758136Ab1GKWdX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 18:33:23 -0400
Content-Disposition: inline
In-Reply-To: <20110711164124.GB1648@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: yegor_sub1@visionsystems.de, linux-input@vger.kernel.org

On Mon, Jul 11, 2011 at 09:41:24AM -0700, Dmitry Torokhov wrote:
> On Mon, Jul 11, 2011 at 01:20:04PM +0100, Mark Brown wrote:

> > This isn't a good fix, the driver should depend on the MFD core not
> > select it.

> The problem with such dependencies is that user has to first enable MFD
> core and then hunt through all other menus in search of the function
> drivers for that chip...

> Depending on what other things TPS6507X depends on it might be good idea
> to go ahead and select it.

If this is an issue it's going to be much more useful to have the boards
select their MFD cores than have random function drivers do that, in
most situations it's not actually going to be useful to select the core
driver as the core driver itself needs something to select either the
I2C or SPI bus interface for the device in order to actually communicate
with it.

Remember that this is for embedded systems where the user will normally
have a pretty good idea what's on their system, someone will have had to
explicitly plumb the device into the board anyway.
