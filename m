From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] input: touchscreen: introduce tsc2005 driver
Date: Fri, 17 Dec 2010 09:50:49 -0800
Message-ID: <20101217175048.GP5941@atomide.com>
References: <1290699913-26540-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
 <20101213085143.GE21401@core.coreip.homeip.net>
 <4D088CC0.9080402@nokia.com>
 <20101216075716.GD26567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41289 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab0LQRu5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Dec 2010 12:50:57 -0500
Content-Disposition: inline
In-Reply-To: <20101216075716.GD26567@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, aaro.koskinen@nokia.com, ext-phil.2.carmody@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [101215 23:57]:
> On Wed, Dec 15, 2010 at 11:39:12AM +0200, Srikar wrote:
> > Hi ToroKhov,
> >               TSC2005 is using SPI interface/driver  and TSC2007 driver
> > is using i2C Interface/driver are main differences.
> 
> I see. In this case I believe that, instead of creating completely
> separate driver, we need to abstract bus access from tsc2007 and convert
> the driver into tsc200x-core.c core piece and tcs2005.c/tsc2007.c
> implementing just bus access methods. Pretty much what was done for
> ad714x, adxl34x, ad7879 and other drivers.
> 
> > I have a question, Can I release patch to input for enabling the driver
> > tsc2005 located at *arch/arm/mach-omap2/*
> > 
> > As commented below by Tony Lindgren,
> > This does not exist in mainline yet, please send this patch
> > along with the tsc2005 driver via the input list. For this one:
> > 
> 
> I am not sure what this means... If you want to submit parts of platform
> code through my tree that should be fine as long as respective
> maintainer of given arch is OK with it as well.

Yeah the platform code depends on the tsc2005 header which
does not exist in the mainline kernel yet. I think I already
acked the platform related code to be merged via the input
list.

Regards,

Tony
