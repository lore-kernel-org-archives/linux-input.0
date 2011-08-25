From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/RFT][PATCH] Input: tsc2007 - convert to threaded IRQ
Date: Thu, 25 Aug 2011 01:05:52 -0700
Message-ID: <20110825080551.GD24739@core.coreip.homeip.net>
References: <20110823061738.GA25272@core.coreip.homeip.net>
 <20110825062159.GB25708@avionic-0098.mockup.avionic-design.de>
 <20110825064333.GA15655@core.coreip.homeip.net>
 <20110825070657.GA29512@avionic-0098.adnet.avionic-design.de>
 <20110825073427.GB24739@core.coreip.homeip.net>
 <20110825075253.GA10702@avionic-0098.adnet.avionic-design.de>
 <20110825075624.GC24739@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53048 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab1HYIF6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Aug 2011 04:05:58 -0400
Received: by gwaa12 with SMTP id a12so1542447gwa.19
        for <linux-input@vger.kernel.org>; Thu, 25 Aug 2011 01:05:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110825075624.GC24739@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Linux Input <linux-input@vger.kernel.org>, Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>

On Thu, Aug 25, 2011 at 12:56:25AM -0700, Dmitry Torokhov wrote:
> On Thu, Aug 25, 2011 at 09:52:54AM +0200, Thierry Reding wrote:
> > * Dmitry Torokhov wrote:
> > > On Thu, Aug 25, 2011 at 09:06:57AM +0200, Thierry Reding wrote:
> > > > * Dmitry Torokhov wrote:
> > > > > On Thu, Aug 25, 2011 at 08:21:59AM +0200, Thierry Reding wrote:
> > > > > > * Dmitry Torokhov wrote:
> > > > > > > This is completely untested but I believe it should work better than original
> > > > > > > workqueue solution, especially when we do not have get_pendown_state method
> > > > > > > available. I wonder if it will help Richard's issue with IRQ getting re-raised
> > > > > > > after pen up event.
> > > > > > > 
> > > > > > > Anyone who has hardware - please give it a spin.
> > > > > > 
> > > > > > I can see no noticeable changes with this patch.
> > > > > > 
> > > > > 
> > > > > That's the result I was aiming for ;) Thanks for testing.
> > > > > 
> > > > > Oh, crap... Does it still work if you change IRQ flags in
> > > > > request_threaded_irq() from 0 to IRQF_ONESHOT? 
> > > > > 
> > > > > Also, while we are at it would you ming trying out another patch
> > > > > (below)?
> > > > 
> > > > With both your patch applied and the change from 0 to IRQF_ONESHOT the driver
> > > > oopses when loaded. I didn't have time to investigate further, but I think I
> > > > could perhaps test a couple more patches if you provide them.
> > > 
> > > Hmm, can't spot the problem... Where does it die?
> > 
> > I'll see if I can track it down, but I have very limited time.
> 
> Don't worry, there is no rush whatsoever... I'll try to ponder the code
> some more.

I think we fail in tsc2007_open(), instead of "if (err) {" it should say
"if (err < 0) {"... but I still wonder why this causes oops...

Thanks.

-- 
Dmitry
