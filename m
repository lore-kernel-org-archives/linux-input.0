From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: pwm-beeper: Add devicetree probing support
Date: Mon, 24 Sep 2012 08:56:39 -0700
Message-ID: <20120924155639.GA1440@core.coreip.homeip.net>
References: <1348472258-31519-1-git-send-email-s.hauer@pengutronix.de>
 <5060584A.80305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43977 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603Ab2IXP4z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Sep 2012 11:56:55 -0400
Received: by pbbrr4 with SMTP id rr4so7387828pbb.19
        for <linux-input@vger.kernel.org>; Mon, 24 Sep 2012 08:56:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5060584A.80305@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de

On Mon, Sep 24, 2012 at 07:55:38AM -0500, Rob Herring wrote:
> On 09/24/2012 02:37 AM, Sascha Hauer wrote:
> > A very simple binding, the only property is the phandle to the PWM.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> > ---
> >  Documentation/devicetree/bindings/input/pwm-beeper.txt |    7 +++++++
> >  drivers/input/misc/pwm-beeper.c                        |   11 ++++++++++-
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> > new file mode 100644
> > index 0000000..7388b82
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> > @@ -0,0 +1,7 @@
> > +* PWM beeper device tree bindings
> > +
> > +Registers a PWM device as beeper.
> > +
> > +Required properties:
> > +- compatible: should be "pwm-beeper"
> > +- pwms: phandle to the physical pwm device
> > diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> > index fc84c8a..a6aa48c 100644
> > --- a/drivers/input/misc/pwm-beeper.c
> > +++ b/drivers/input/misc/pwm-beeper.c
> > @@ -75,7 +75,10 @@ static int __devinit pwm_beeper_probe(struct platform_device *pdev)
> >  	if (!beeper)
> >  		return -ENOMEM;
> >  
> > -	beeper->pwm = pwm_request(pwm_id, "pwm beeper");
> > +	if (pdev->dev.platform_data)
> > +		beeper->pwm = pwm_request(pwm_id, "pwm beeper");
> > +	else
> > +		beeper->pwm = pwm_get(&pdev->dev, NULL);

Hmm, pwm_id == 0 is a valid ID I think, but your change makes it go into
DT branch, potentially breaking it.

Thanks.

-- 
Dmitry
