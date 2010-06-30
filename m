From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/4] Current ad7879 patches
Date: Wed, 30 Jun 2010 02:07:30 -0700
Message-ID: <20100630090729.GA23627@core.coreip.homeip.net>
References: <20100625081847.8617.31150.stgit@localhost.localdomain>
 <544AC56F16B56944AEC3BD4E3D5917712E66DFF408@LIMKCMBX1.ad.analog.com>
 <20100630080345.GC4154@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D5917712E66DFF584@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51932 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab0F3JHh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 05:07:37 -0400
Received: by pvc7 with SMTP id 7so267001pvc.19
        for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 02:07:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E66DFF584@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>

On Wed, Jun 30, 2010 at 09:40:54AM +0100, Hennerich, Michael wrote:
> Dmitry Torokhov wrote on 2010-06-30:
> > On Tue, Jun 29, 2010 at 01:10:38PM +0100, Hennerich, Michael wrote:
> >> Dmitry Torokhov wrote on 2010-06-25:
> >>> Mike, Michael,
> >>>
> >>> I was looking through outstanding patches to ad7879 and here they are.
> >>> Since I made some changes to the patches you wrote and there also some
> >>> new code and I do not have the hardware I'd appreciate if you could
> >>> try them out so they can be applied.
> >>>
> >>> Thank you.
> >>>
> >>
> >> Hi Dmitry,
> >>
> >> I tested your ad7879 patch set -
> >> A few issues see patch below.
> >>
> >> -Fix ad7879_probe() parameter passing. -Add missing input_set_drvdata()
> >> -Avoid unbalanced irq enable warning: disable_irq() after request. -Fix
> >> sysfs disable hook logic: the file is called disable so don't treat it
> >> as enable.
> >>
> >
> > Thanks for catching all the mistakes Michael. Regardgin disable_irq()
> > - do you think it would be even better to call __ad7879_disable()
> > there to make sure the chip is in low power mode?
> 
> Right - __ad7879_disable() is a good option here.
> 
> > And I guess we need
> > to add matching enable_irq() in error handlig path and in
> > ad7879_remove() in case we reload the driver...
> 
> I don't see a problem here. free_irq() will take care and unconditional
> disable the irq for us. Both the error return as well as the module
> remove path will call free_irq().

free_irq() will disable the irq in the chip and will set desc->action to
NULL but will not alter desc->depth as far as I can see.

I guess we can rely on the fact that request_irq resets desc->depth for
non-shared IRQs...

-- 
Dmitry
