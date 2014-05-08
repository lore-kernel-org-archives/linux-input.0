From: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH] input: rotary encoder: implement quarter period mode
Date: Thu, 8 May 2014 14:01:33 -0300
Message-ID: <20140508170133.GA1199@arch.cereza>
References: <1387377798-22344-1-git-send-email-s.hauer@pengutronix.de>
 <20140507144543.GE27177@e106331-lin.cambridge.arm.com>
 <20140507185932.GA22973@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:64496 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbaEHRCH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 13:02:07 -0400
Received: by mail-yk0-f176.google.com with SMTP id q9so2390389ykb.21
        for <linux-input@vger.kernel.org>; Thu, 08 May 2014 10:02:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140507185932.GA22973@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Daniel Mack <daniel@zonque.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 07 May 11:59 AM, Dmitry Torokhov wrote:
> On Wed, May 07, 2014 at 03:45:43PM +0100, Mark Rutland wrote:
> > Hi,
> > 
> > On Wed, Dec 18, 2013 at 02:43:18PM +0000, Sascha Hauer wrote:
> > > Some rotary encoders have a stable state in all output state
> > > combinations. Add support for this type of encoder.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: Daniel Mack <daniel@zonque.org>
> > > Cc: linux-input@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > ---
> > >  .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
> > >  Documentation/input/rotary-encoder.txt             |  9 +++++--
> > >  drivers/input/misc/rotary_encoder.c                | 30 ++++++++++++++++++++--
> > >  include/linux/rotary_encoder.h                     |  1 +
> > >  4 files changed, 37 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > > index 3315495..cbdb29b 100644
> > > --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > > +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > > @@ -15,6 +15,7 @@ Optional properties:
> > >  - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
> > >    greater than the specified steps or smaller than 0. For absolute axis only.
> > >  - rotary-encoder,half-period: Makes the driver work on half-period mode.
> > > +- rotary-encoder,quarter-period: Makes the driver work on quarter-period mode.
> > 
> > The new property looks as sane to me as the half-period property, so for
> > the binding addition:
> 
> Actually, maybe we should deprecate rotary-encoder,half-period and
> instead add rotary-encoder,type property?
> 

Mark: what do you say?

I can fix a few patches if everyone agrees...
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
