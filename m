From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] ARM: shmobile: kzm9g dts: Add adxl345-specific compatible property
Date: Mon, 06 Jul 2015 13:17:13 +0300
Message-ID: <1980362.9qv8Mc7ut7@avalon>
References: <1436176746-10995-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436176746-10995-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 06 July 2015 11:59:06 Geert Uytterhoeven wrote:
> The accelerometer node used the generic compatible property only.
> Add the device-specific one, to make it future proof.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> Depends on commit 3a38958d2477b718 ("Input: adxl34x - add OF match
> support"), which is in v4.2-rc1.
> ---
>  arch/arm/boot/dts/sh73a0-kzm9g.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> b/arch/arm/boot/dts/sh73a0-kzm9g.dts index
> 24b4cd24dceb2f9e..ae91278d77b45b38 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
> @@ -206,7 +206,7 @@
>  	};
> 
>  	accelerometer@1d {
> -		compatible = "adi,adxl34x";
> +		compatible = "adi,adxl345", "adi,adxl34x";

"adi,adxl34x" is deprecated and shouldn't be used in DT. You can just specify 
"adi,adxl345".

>  		reg = <0x1d>;
>  		interrupt-parent = <&irqpin3>;
>  		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
