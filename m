From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] touchscreen: mms114: add support for mms152
Date: Wed, 20 Dec 2017 12:21:50 -0600
Message-ID: <20171220182150.nwbxzv5cziqdywah@rob-hp-laptop>
References: <20171218124933.1803-1-simon@lineageos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171218124933.1803-1-simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 18, 2017 at 11:49:33PM +1100, Simon Shields wrote:
> MMS152 has no configuration registers, but the packet format used in
> interrupts is identical to mms114.
> 
> Signed-off-by: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/mms114.txt          |  8 ++--
>  drivers/input/touchscreen/mms114.c                 | 55 +++++++++++++++++++---
>  include/linux/platform_data/mms114.h               |  6 +++
>  3 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> index 89d4c56c5671..733411020ced 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> @@ -1,15 +1,15 @@
> -* MELFAS MMS114 touchscreen controller
> +* MELFAS MMS114/MMS152 touchscreen controller
>  
>  Required properties:
> -- compatible: must be "melfas,mms114"
> +- compatible: "melfas,mms114" for MMS114, or "melfas,mms152" for MMS152

Please reformat to 1 per line.

>  - reg: I2C address of the chip
>  - interrupts: interrupt to which the chip is connected
>  - x-size: horizontal resolution of touchscreen
>  - y-size: vertical resolution of touchscreen
>  
>  Optional properties:
> -- contact-threshold:
> -- moving-threshold:
> +- contact-threshold: only with "melfas,mms114"
> +- moving-threshold: only with "melfas,mms114"
>  - x-invert: invert X axis
>  - y-invert: invert Y axis
>  
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
