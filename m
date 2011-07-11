From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: TPS6507X - define MFD dependencies for touch and
 regulator unit
Date: Mon, 11 Jul 2011 09:41:24 -0700
Message-ID: <20110711164124.GB1648@core.coreip.homeip.net>
References: <4E1AD56B.6080306@visionsystems.de>
 <20110711122004.GA9478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43030 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758152Ab1GKQla (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 12:41:30 -0400
Received: by iwn6 with SMTP id 6so3812921iwn.19
        for <linux-input@vger.kernel.org>; Mon, 11 Jul 2011 09:41:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110711122004.GA9478@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: yegor_sub1@visionsystems.de, linux-input@vger.kernel.org

On Mon, Jul 11, 2011 at 01:20:04PM +0100, Mark Brown wrote:
> On Mon, Jul 11, 2011 at 12:50:19PM +0200, Yegor Yefremov wrote:
> > both touchscreen and regulator units are only working if
> > mfd device is activated. So if mfd support is enabled,
> > select TPS6507X mfd support automatically.
> > 
> > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This should be split into separate patches and sent to *all* the
> relevant maintainers.
> 
> >  config TOUCHSCREEN_TPS6507X
> >  	tristate "TPS6507x based touchscreens"
> > -	depends on I2C
> > +	depends on I2C && MFD_SUPPORT
> > +	select TPS6507X
> 
> This isn't a good fix, the driver should depend on the MFD core not
> select it.

The problem with such dependencies is that user has to first enable MFD
core and then hunt through all other menus in search of the function
drivers for that chip...

Depending on what other things TPS6507X depends on it might be good idea
to go ahead and select it.

-- 
Dmitry
