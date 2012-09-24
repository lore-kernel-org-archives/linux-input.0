From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] input: pwm-beeper: Add devicetree probing support
Date: Mon, 24 Sep 2012 21:19:32 +0200
Message-ID: <20120924191932.GS1322@pengutronix.de>
References: <1348472258-31519-1-git-send-email-s.hauer@pengutronix.de>
 <5060584A.80305@gmail.com>
 <20120924155639.GA1440@core.coreip.homeip.net>
 <506088C9.8030002@metafoo.de>
 <20120924184938.GQ1322@pengutronix.de>
 <5060AF17.7070409@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38700 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757845Ab2IXTTg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Sep 2012 15:19:36 -0400
Content-Disposition: inline
In-Reply-To: <5060AF17.7070409@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robherring2@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, kernel@pengutronix.de, Thierry Reding <thierry.reding@avionic-design.de>

On Mon, Sep 24, 2012 at 09:05:59PM +0200, Lars-Peter Clausen wrote:
> On 09/24/2012 08:49 PM, Sascha Hauer wrote:
> > 
> > My bad, I missed that platform_data is casted to an unsigned long. I
> > thought I would test for a pointer.
> > The obvious clean way would be to use a pointer for platform_data, but
> > given that this will vanish anyway soon, I think we could just test for
> > existence of dev->of_node instead of dev->platform_data.
> 
> I think the plan is to convert the existing board file platforms to pwm_table
> and then remove the old pwm_request API. So this wouldn't work too well if we'd
> test for of_node. Maybe we can just run pwm_get unconditionally and fallback to
> pwm_request if it failed. That's also what the PWM backlight driver currently does.

Fine with me.

> 
> > 
> >>
> >> Yes, this a bit tricky, but we only have a single in-tree user of the
> >> pwm-beeper which uses a id != 0. And now that all the PWM providers have
> >> been converted to the new generic PWM framework the old legacy API will go
> >> away soon anyway. So this if () else branch should hopefully only be
> >> necessary for a transitional period of 1-2 releases. So I think this change
> >> should be OK.
> >>
> >> But I think the patch is missing a change to the Kconfig entry to allow the
> >> driver to be selected if the generic PWM framework is available.
> >>
> >> --- a/drivers/input/misc/Kconfig
> >> +++ b/drivers/input/misc/Kconfig
> >> @@ -444,7 +444,7 @@ config INPUT_PCF8574
> >>
> >>  config INPUT_PWM_BEEPER
> >>  	tristate "PWM beeper support"
> >> -	depends on HAVE_PWM
> >> +	depends on HAVE_PWM || PWM
> > 
> > Is this the preferred way to do this? Instead of doing the above I added
> > a 'select HAVE_PWM' to the pwm framework instead. I found a patch for that,
> > but there were comments to it that this is not good
> > 
> 
> Thierry said that this is his preferred solution. Given that HAVE_PWM will be
> extinct soon anyway I think it is fine.

Ok. Will send an updated patch tomorrow.

Thanks
 Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
