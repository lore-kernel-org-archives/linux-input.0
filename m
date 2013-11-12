From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] Input: Add new driver for GPIO beeper
Date: Tue, 12 Nov 2013 10:59:31 +0000
Message-ID: <20131112105930.GE2976@e106331-lin.cambridge.arm.com>
References: <1384250833-4600-1-git-send-email-shc_work@mail.ru>
 <20131112101544.GD2976@e106331-lin.cambridge.arm.com>
 <1384253277.731839001@f27.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:64714 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751328Ab3KLK7l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Nov 2013 05:59:41 -0500
Content-Disposition: inline
In-Reply-To: <1384253277.731839001@f27.i.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>

On Tue, Nov 12, 2013 at 10:47:57AM +0000, Alexander Shiyan wrote:
> Hello.
> 
> > On Tue, Nov 12, 2013 at 10:07:13AM +0000, Alexander Shiyan wrote:
> > > This patch adds a new driver for the beeper controlled via GPIO pin.
> > > The driver does not depend on the architecture and is positioned as
> > > a replacement for the specific drivers that are used for this function.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ...
> > > diff --git a/Documentation/devicetree/bindings/input/gpio-beeper.txt b/Documentation/devicetree/bindings/input/gpio-beeper.txt
> ...
> > > +Example:
> > > +
> > > +beeper: input@0 {
> > > +	compatible = "gpio-beeper";
> > > +	reg = <0>;
> > > +	gpios = <&gpio3 23 0>;
> > > +};
> > 
> > What are the reg / unit-address for?
> 
> Just an example from "simple-bus" container.

If they have no meaning, they should go. They're unnecessary and make
things more confusing.

I'd expect the example to be:

beeper: beeper {
	compatible = "gpio-beeper";
	gpios - <&gpio3 23 0>;
};

And if we have multiple beepers, something like:

beeper0: beeper0 { ... };
beeper1: beeper1 { ... };

Thanks,
Mark.
