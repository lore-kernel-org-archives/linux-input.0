From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] Input: mms114 - drop platform data and use generic
 APIs
Date: Tue, 23 Jan 2018 20:15:29 +0900
Message-ID: <20180123111529.GA29613@gangnam.samsung>
References: <CGME20180113020518epcas1p3987c04ac42714710204aca5a800a4f5b@epcas1p3.samsung.com>
        <20180113020456.12391-1-simon@lineageos.org>
        <20180116075611.GC30945@gangnam.samsung>
        <20180116085206.GA18232@lineageos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <20180116085206.GA18232-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Simon,

sorry for the late answer,

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
> > > Signed-off-by: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
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

Oh, yes, I read the patch partially, I didn't see that you
actually kept the back compatibility by doing this:

> +     if (mms114_parse_dt(data) < 0) {
> +             /* No valid legacy binding found, try the common one */
> +             touchscreen_parse_properties(input_dev, true, &data->props);

[...]

Sorry for the confusion, please add:

Reviewed-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Tested-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

And for reference to Dmitry, there is also Rob's ack.

Andi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
