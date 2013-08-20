From: Michael Grzeschik <mgr@pengutronix.de>
Subject: Re: [PATCH] mc13xxx-ts: use zero as default value if no pdata was
 defined
Date: Tue, 20 Aug 2013 11:53:24 +0200
Message-ID: <20130820095324.GD26693@pengutronix.de>
References: <1376396070-24507-1-git-send-email-m.grzeschik@pengutronix.de>
 <20130820013433.GE13324@zurbaran>
 <20130820093432.GC26693@pengutronix.de>
 <20130820095048.GC17521@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42284 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab3HTJxa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Aug 2013 05:53:30 -0400
Content-Disposition: inline
In-Reply-To: <20130820095048.GC17521@zurbaran>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>

On Tue, Aug 20, 2013 at 11:50:48AM +0200, Samuel Ortiz wrote:
> Hi Michael,
> 
> On Tue, Aug 20, 2013 at 11:34:32AM +0200, Michael Grzeschik wrote:
> > On Tue, Aug 20, 2013 at 03:34:33AM +0200, Samuel Ortiz wrote:
> > > On Tue, Aug 13, 2013 at 02:14:30PM +0200, Michael Grzeschik wrote:
> > > > In case of devicetree, we currently don't have a way to append pdata for
> > > > the touchscreen. The current approach is to bail out in that case.
> > > > This patch makes it possible to probe the touchscreen without pdata
> > > > and use zero as default values for the atox and ato adc conversion.
> > > Would that still make the touchscreen somehow functional ?
> > 
> > Yes, it still works. It just defaults to zero values in no pdata case.
> > 
> > > If that's the case, and if Dmitry is fine with the ts part of this
> > > patch, could you please separate the mfd part of this patch into a
> > > separate one ?
> > 
> > Why?
> To avoid cross tree commits as much as possible.
> 
> 
> > The purpose of this patch is to have both cases working, pdata and no
> > pdata. 
> I understood that part. But you can still split the patch in 2 as the ts
> driver will not be probed without pdata until the mfd patch is merged
> upstream.
> 
> > This patch is actually fixing the patch of Michael Thalmeier.
> > There we changed the mfd and touch in one patch as well.
> There was a build time dependency between the ts driver and the MFD
> changes, so the patch had to be merged atomically.
> That is not the case with your patch.

All right then. I will resend them and the codec mfd patch together with
the oftree patches I am currently working on.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
