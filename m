From: Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH v2] Input: mms114 - drop platform data and use generic
 APIs
Date: Tue, 16 Jan 2018 19:52:06 +1100
Message-ID: <20180116085206.GA18232@lineageos.org>
References: <CGME20180113020518epcas1p3987c04ac42714710204aca5a800a4f5b@epcas1p3.samsung.com>
 <20180113020456.12391-1-simon@lineageos.org>
 <20180116075611.GC30945@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42800 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeAPIwO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jan 2018 03:52:14 -0500
Content-Disposition: inline
In-Reply-To: <20180116075611.GC30945@gangnam.samsung>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>

Hi Andi,

Thanks for the review!

On Tue, Jan 16, 2018 at 04:56:11PM +0900, Andi Shyti wrote:
> Hi Simon,
> 
> On Sat, Jan 13, 2018 at 01:04:56PM +1100, Simon Shields wrote:
> > The MMS114 platform data has no in-tree users, so drop it,
> > and make the driver depend on CONFIG_OF.
> > 
> > Switch to using the standard touchscreen properties via
> > touchscreen_parse_properties(), and move the old DT parsing code
> > to use device_property_*() APIs.
> > 
> > Finally, use touchscreen_report_pos to report x/y coordinates
> > and drop the custom x/y inversion code.
> > 
> > Signed-off-by: Simon Shields <simon@lineageos.org>
> > ---
> >  .../bindings/input/touchscreen/mms114.txt          |  29 ++--
> >  drivers/input/touchscreen/Kconfig                  |   1 +
> >  drivers/input/touchscreen/mms114.c                 | 152 +++++++++------------
> >  include/linux/platform_data/mms114.h               |  24 ----
> >  4 files changed, 83 insertions(+), 123 deletions(-)
> >  delete mode 100644 include/linux/platform_data/mms114.h
> > 
> 
> The patch looks good, but you would also need to update the dtsi
> files in this same patch:
> 
> ./arch/arm/boot/dts/exynos4412-trats2.dts
> ./arch/arm/boot/dts/exynos4210-trats.dts
> 
> and Cc the Samsung-soc mailing list.
> 
> For now it's a nack because the touchscreen would not work
> anymore with the trats boards.

This patch keeps support for the old bindings. I've verified that both
the old and new bindings work on a GT-I9300 (trats2 with a different
bootloader/partition layout).

> 
> One more thing, you forgot Rob's ACK.

I wasn't sure whether or not to keep the Reviewed-By tag, since
this is a new version of the patch. In the future, I'll keep it.

> 
> Andi

Cheers,
Simon
