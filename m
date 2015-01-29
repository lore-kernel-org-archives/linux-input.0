From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: Re: [PATCH] rotary encoder: Add wake up support
Date: Thu, 29 Jan 2015 12:14:28 +0100
Message-ID: <20150129111428.GA6408@gradator.net>
References: <1421164262-28261-1-git-send-email-sylvain.rochet@finsecur.com>
 <20150129104953.GC5312@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:57725 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471AbbA2LOb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 06:14:31 -0500
Content-Disposition: inline
In-Reply-To: <20150129104953.GC5312@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>

Hello Johan,

On Thu, Jan 29, 2015 at 11:49:53AM +0100, Johan Hovold wrote:
> On Tue, Jan 13, 2015 at 04:51:02PM +0100, Sylvain Rochet wrote:
> > This patch add wake up support for rotary encoders.
> > New DT property: rotary-encoder,wakeup
> > 
> > Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> > ---
> >  .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
> >  Documentation/input/rotary-encoder.txt             |  1 +
> >  drivers/input/misc/rotary_encoder.c                | 36 ++++++++++++++++++++++
> >  include/linux/rotary_encoder.h                     |  1 +
> >  4 files changed, 39 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > index 3315495..468d545 100644
> > --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > @@ -15,6 +15,7 @@ Optional properties:
> >  - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
> >    greater than the specified steps or smaller than 0. For absolute axis only.
> >  - rotary-encoder,half-period: Makes the driver work on half-period mode.
> > +- rotary-encoder,wakeup: Boolean, rotary encoder can wake-up the system.
> 
> As Dmitry already mentioned this should probably just be
> "wakeup-source".

Yeah, I think so.


> > +static SIMPLE_DEV_PM_OPS(rotary_encoder_pm_ops, rotary_encoder_suspend, rotary_encoder_resume);
> 
> Please break this line to stay within 80 cols.

I saw that afterward, I waited the answer about DT property to propose a 
v2. Fixed.


> > +	int wakeup;			/* configure the rotary-encoder as a wake-up source */
> 
> This should be bool.

Ditto. Fixed.


> I also suggest you rename the variable wakeup_source and drop the
> verbose comment.

I agree, done !


> Looks good otherwise.

Thank for the review, v2 sent :)


Sylvain
