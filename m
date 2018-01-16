From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] Input: mms114 - drop platform data and use generic
 APIs
Date: Tue, 16 Jan 2018 16:56:11 +0900
Message-ID: <20180116075611.GC30945@gangnam.samsung>
References: <CGME20180113020518epcas1p3987c04ac42714710204aca5a800a4f5b@epcas1p3.samsung.com>
        <20180113020456.12391-1-simon@lineageos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <20180113020456.12391-1-simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Simon,

On Sat, Jan 13, 2018 at 01:04:56PM +1100, Simon Shields wrote:
> The MMS114 platform data has no in-tree users, so drop it,
> and make the driver depend on CONFIG_OF.
> 
> Switch to using the standard touchscreen properties via
> touchscreen_parse_properties(), and move the old DT parsing code
> to use device_property_*() APIs.
> 
> Finally, use touchscreen_report_pos to report x/y coordinates
> and drop the custom x/y inversion code.
> 
> Signed-off-by: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/mms114.txt          |  29 ++--
>  drivers/input/touchscreen/Kconfig                  |   1 +
>  drivers/input/touchscreen/mms114.c                 | 152 +++++++++------------
>  include/linux/platform_data/mms114.h               |  24 ----
>  4 files changed, 83 insertions(+), 123 deletions(-)
>  delete mode 100644 include/linux/platform_data/mms114.h
> 

The patch looks good, but you would also need to update the dtsi
files in this same patch:

./arch/arm/boot/dts/exynos4412-trats2.dts
./arch/arm/boot/dts/exynos4210-trats.dts

and Cc the Samsung-soc mailing list.

For now it's a nack because the touchscreen would not work
anymore with the trats boards.

One more thing, you forgot Rob's ACK.

Andi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
