From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] Input: mms114 - drop platform data and use generic
 APIs
Date: Fri, 19 Jan 2018 12:42:50 -0600
Message-ID: <20180119184250.qdw3uu6tkufqhm2g@rob-hp-laptop>
References: <CGME20180113020518epcas1p3987c04ac42714710204aca5a800a4f5b@epcas1p3.samsung.com>
 <20180113020456.12391-1-simon@lineageos.org>
 <20180116075611.GC30945@gangnam.samsung>
 <20180116085206.GA18232@lineageos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39051 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbeASSmx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 13:42:53 -0500
Content-Disposition: inline
In-Reply-To: <20180116085206.GA18232@lineageos.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Shields <simon@lineageos.org>
Cc: Andi Shyti <andi.shyti@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Jan 16, 2018 at 07:52:06PM +1100, Simon Shields wrote:
> Hi Andi,
> 
> Thanks for the review!
> 
> On Tue, Jan 16, 2018 at 04:56:11PM +0900, Andi Shyti wrote:
> > Hi Simon,
> > 
> > On Sat, Jan 13, 2018 at 01:04:56PM +1100, Simon Shields wrote:
> > > The MMS114 platform data has no in-tree users, so drop it,
> > > and make the driver depend on CONFIG_OF.
> > > 
> > > Switch to using the standard touchscreen properties via
> > > touchscreen_parse_properties(), and move the old DT parsing code
> > > to use device_property_*() APIs.
> > > 
> > > Finally, use touchscreen_report_pos to report x/y coordinates
> > > and drop the custom x/y inversion code.
> > > 
> > > Signed-off-by: Simon Shields <simon@lineageos.org>
> > > ---
> > >  .../bindings/input/touchscreen/mms114.txt          |  29 ++--
> > >  drivers/input/touchscreen/Kconfig                  |   1 +
> > >  drivers/input/touchscreen/mms114.c                 | 152 +++++++++------------
> > >  include/linux/platform_data/mms114.h               |  24 ----
> > >  4 files changed, 83 insertions(+), 123 deletions(-)
> > >  delete mode 100644 include/linux/platform_data/mms114.h
> > > 
> > 
> > The patch looks good, but you would also need to update the dtsi
> > files in this same patch:

Yes, but dts updates should be a separate patch. Really, the DT docs are 
supposed to be too, but I let that go if there's no other review 
changes.

> > 
> > ./arch/arm/boot/dts/exynos4412-trats2.dts
> > ./arch/arm/boot/dts/exynos4210-trats.dts
> > 
> > and Cc the Samsung-soc mailing list.
> > 
> > For now it's a nack because the touchscreen would not work
> > anymore with the trats boards.
> 
> This patch keeps support for the old bindings. I've verified that both
> the old and new bindings work on a GT-I9300 (trats2 with a different
> bootloader/partition layout).

The driver needs to support both old and new. The dts files can be 
updated as long as they'd still work the same. Old dtb and new kernel is 
the primary case we care about preserving the ABI.

> 
> > 
> > One more thing, you forgot Rob's ACK.
> 
> I wasn't sure whether or not to keep the Reviewed-By tag, since
> this is a new version of the patch. In the future, I'll keep it.

Yes, you should as long as the binding doesn't change significantly.

Rob
