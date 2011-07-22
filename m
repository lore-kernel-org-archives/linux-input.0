From: "Patil, Rachna" <rachna@ti.com>
Subject: RE: [PATCH V2] input: add support for TI Touchscreen controller.
Date: Fri, 22 Jul 2011 14:42:26 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DC7176A@dbde02.ent.ti.com>
References: <1310619775-29886-1-git-send-email-rachna@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024DC70D25@dbde02.ent.ti.com>
 <20110722063535.GC16040@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45980 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922Ab1GVJMd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 05:12:33 -0400
In-Reply-To: <20110722063535.GC16040@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Friday, July 22, 2011 12:06 PM
> To: Patil, Rachna
> Cc: linux-input@vger.kernel.org
> Subject: Re: [PATCH V2] input: add support for TI Touchscreen controller.
> 
> Hi Rachna,
> 
> On Wed, Jul 20, 2011 at 06:42:20PM +0530, Patil, Rachna wrote:
> > Hi Dmitry,
> >
> > This is just a gentle reminder for the patch I had submitted viz.
> "[PATCH] input: add support for TI Touchscreen controller."
> > Can this patch be included in the 3.1 version?
> > I know this is a bit late but I presume that this patch just adds a new
> kind of driver and does not break anything existing.
> >
> 
> I am getting the following while building the module:
> 
> ERROR: "clk_get_rate" [drivers/input/touchscreen/ti_tscadc.ko]
> undefined!
> ERROR: "clk_enable" [drivers/input/touchscreen/ti_tscadc.ko] undefined!
> ERROR: "clk_get" [drivers/input/touchscreen/ti_tscadc.ko] undefined!
> ERROR: "clk_put" [drivers/input/touchscreen/ti_tscadc.ko] undefined!
> ERROR: "clk_disable" [drivers/input/touchscreen/ti_tscadc.ko] undefined!
> make[1]: *** [__modpost] Error 1
> 
> Apparently we need to add some arch or platform dependency... Hmm, maybe
> the driver should depend on CONFIG_HAVE_CLK?

Yes, this is platform dependent. I will add CONFIG_HAVE_CLK against
the driver.

> 
> Thanks.
> 
> --
> Dmitry

Thanks & Regards,
Rachna.
