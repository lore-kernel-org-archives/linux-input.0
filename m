From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 3/3] Input: goodix - update dt bindings documentation
 (axis swapping/inversion)
Date: Sun, 22 Nov 2015 16:00:32 -0600
Message-ID: <20151122220032.GA7033@rob-hp-laptop>
References: <1448112622-2062-1-git-send-email-merker@debian.org>
 <1448112622-2062-4-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448112622-2062-4-git-send-email-merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, Nov 21, 2015 at 02:30:22PM +0100, Karsten Merker wrote:
> The goodix touchscreen driver has gained support for the
> optional touchscreen-inverted-x, touchscreen-inverted-y
> and touchscreen-swapped-x-y properties as described in
> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt.
> 
> Document these properties in the goodix bindings description.
> 
> Signed-off-by: Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> Reviewed-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index a8492e3..ef5f42d 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -23,6 +23,11 @@ Optional properties:
>                              device. ESD is disabled if this property is not set
>                              or is set to 0.
>  
> + - touchscreen-inverted-x  : X axis is inverted (boolean)
> + - touchscreen-inverted-y  : Y axis is inverted (boolean)
> + - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> +                             (swapping is done after inverting the axis)
> +
>  Example:
>  
>  	i2c@00000000 {
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
