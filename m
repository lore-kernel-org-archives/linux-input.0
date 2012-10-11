From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: wm831x-ts - Convert to devm_kzalloc()
Date: Thu, 11 Oct 2012 09:22:25 -0700
Message-ID: <20121011162225.GA15588@core.coreip.homeip.net>
References: <1349875236-5707-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1349875236-5707-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121011073955.GA30395@core.coreip.homeip.net>
 <20121011080722.GE11726@opensource.wolfsonmicro.com>
 <20121011082749.GD32175@core.coreip.homeip.net>
 <20121011083322.GG11726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:41839 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757738Ab2JKQWd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 12:22:33 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so837844dak.19
        for <linux-input@vger.kernel.org>; Thu, 11 Oct 2012 09:22:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121011083322.GG11726@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org

On Thu, Oct 11, 2012 at 05:33:24PM +0900, Mark Brown wrote:
> On Thu, Oct 11, 2012 at 01:27:49AM -0700, Dmitry Torokhov wrote:
> > On Thu, Oct 11, 2012 at 05:07:24PM +0900, Mark Brown wrote:
> 
> > > 
> > > What's the error pattern you're seeing?  I've not noticed much of an
> > > issue here, but if there is one perhaps we can do something to make the
> > > error more obvious or harder to introduce.
> 
> > 	devm_request_irq();
> 
> > The problem is that input device is freed but interrupts are still fully
> > functional.
> 
> Ah, yes - that one I do spot all the time.  I agree that devm_request_irq()
> is a menace, that error is far too easy to introduce and it always seems
> more work to work out if it's safe than the benefit in the cases where
> it can be used.

Right. Another one (the IRQ again): have IRQ schedule [delayed] work and
then use cancel_delayed_work() in ->remove() but rely on devres to free
IRQ which is the wrong order.

> 
> The other devm APIs are less problematic, though.

I agree, they are indeed safer. I guess if I add devm_input* the some of
the devm_request_*irq() will be safe as well, but we are not there yet.

-- 
Dmitry
