From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3] input: pwm-beeper: Add devicetree probing support
Date: Sat, 3 Nov 2012 22:33:40 +0100
Message-ID: <20121103213340.GS1641@pengutronix.de>
References: <1351845842-15652-1-git-send-email-s.hauer@pengutronix.de>
 <20121103190301.GB11349@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35737 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab2KCVeH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Nov 2012 17:34:07 -0400
Content-Disposition: inline
In-Reply-To: <20121103190301.GB11349@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Thierry Reding <thierry.reding@avionic-design.de>, kernel@pengutronix.de

Hi Dmitry,

On Sat, Nov 03, 2012 at 12:03:01PM -0700, Dmitry Torokhov wrote:
> Hi Sascha.
> 
> On Fri, Nov 02, 2012 at 09:44:02AM +0100, Sascha Hauer wrote:
> >  
> > -	beeper->pwm = pwm_request(pwm_id, "pwm beeper");
> > +	beeper->pwm = pwm_get(&pdev->dev, NULL);
> > +	if (IS_ERR(beeper->pwm)) {
> > +		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
> 
> This is not an error, I'll switch it over to dev_dbg().

This is cut and paste from some other driver. I suppose it's dev_err to
motivate people to update their boards. Anyway, dev_dbg is fine with me.

Thanks,
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
