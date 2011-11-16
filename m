From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/7] A few patches to cyttsp
Date: Wed, 16 Nov 2011 11:38:26 -0800
Message-ID: <20111116193826.GB26909@core.coreip.homeip.net>
References: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
 <CAAwP0s0eSfxgXWtZXZCm6dY_gtaoyu7QQpEJs7odHTMn2amxTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34613 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab1KPTih (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 14:38:37 -0500
Received: by iage36 with SMTP id e36so1049773iag.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 11:38:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAAwP0s0eSfxgXWtZXZCm6dY_gtaoyu7QQpEJs7odHTMn2amxTg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

On Wed, Nov 16, 2011 at 08:17:02PM +0100, Javier Martinez Canillas wrote:
> On Mon, Nov 14, 2011 at 9:15 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Javier,
> >
> > I am sending a few patches that I made while trying to understand the
> > Cypress TTSP driver. I am still not quite happy with the SPI read method
> > and I am also wondering if cyttsp_power_on could be made less messy.
> >
> 
> Hi Dmitry,
> 
> Thank you very much for the review and the patches. One question, when
> sending new versions of the patch-set, do you want me to keep the
> history of your patches or should I merge all of them and submit just
> three patches (core, i2c, spi) to make easier future revisions?

You may merge them, I think it will be easier.

> 
> Sure, Kevin will cleanup the SPI read method and I will make
> cyttsp_power_on more cleaner.

Thanks.

> 
> > Current open/close methods seem to be not very useful: even though we
> > stop interrupts we do not put the chip into low power mode. Is there a
> > way to do so?
> >
> 
> Yes, the controller can be put to sleep (low power mode). I will add
> that to the close function for the next version of the patch-set.

Excellent.

> 
> > Regarding PM methods - why do we have conditional 'use sleep' and what
> > exactly wakeup() method is supposed to do? Why is it a platform method?
> >
> 
> It was meant to let each board to decide if it wants to go sleep and
> to define a specific handler for wakeup.

Why would a board not want to go to sleep? Normally boards want to
specify whether they want to have device as a wakeup source and such
devices, instead of shutting down in suspend method, just configure
their IRQ as a wakeup IRQ and that is it.

> This is for example the board
> file of the OMAP Encore machine type (B & N Nook's color)
> 
> static struct cyttsp_platform_data cyttsp_i2c_platform_data = {
>         .wakeup = cyttsp_i2c_wakeup,

OK, so in this particular case what does cyttsp_i2c_wakeup actually
does?

>         .init = cyttsp_i2c_init,
> .....
> }
> 
> In the same way it exists an init board specific function that gets
> called from cyttsp_core_init() if the board has defined one:
> 
> void *cyttsp_core_init(struct cyttsp_bus_ops *bus_ops,
> 		       struct device *dev, int irq)
> {
> ....
> 	if (ts->platform_data->init) {
> 		if (ts->platform_data->init()) {
> 			dev_dbg(ts->dev, "%s: Error, platform init failed!\n",
> 				__func__);
> 			goto error_init;
> 		}
> 	}
> ....
> }
> 
> This is necessary because each board may need to configure differently
> the connection with the chip. For example, OMAP boards will have to
> configure the mux pins and so on.
> 
> Is this correct? or the driver should not have these handlers and
> trust that the platform specific code did all the set up before?

I think it depends on the kind of set up is happening. Static setup
(such as registering memory regsions, configuring IRQ type, etc) is
probably done upfront; if you need to talk to the hardware then custom
method is fine.

Thanks.

-- 
Dmitry
