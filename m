From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 3/3] ARM: dts: use syscon in cygnus touchscreen dt node
Date: Wed, 6 Apr 2016 10:31:40 -0700
Message-ID: <20160406173140.GB38452@dtor-ws>
References: <1456556396-4759-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1456556396-4759-4-git-send-email-raveendra.padasalagi@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456556396-4759-4-git-send-email-raveendra.padasalagi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Raveendra Padasalagi <raveendra.padasalagi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Feb 27, 2016 at 12:29:56PM +0530, Raveendra Padasalagi wrote:
> In Cygnus SOC touch screen controller registers are shared
> with ADC and flex timer. Using readl/writel could lead to
> race condition. So touchscreen driver is enhanced to support
> syscon based register access to take care of mutually exclusive
> access.
> 
> This patch enables syscon support in touchscreen driver
> by adding necessary properties in touchscreen dt node and
> in addition to this renamed existing "tsc" touchscreen node
> name to "touchscreen".
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

OK, since the new dts is really needed for the driver I'll be folding
this into the touchscreen driver patch unless I hear someone yelling at
me.

Thanks!

> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 3878793..b42fe55 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -351,9 +351,16 @@
>  					<&pinctrl 142 10 1>;
>  		};
>  
> -		touchscreen: tsc@180a6000 {
> +		ts_adc_syscon: ts_adc_syscon@180a6000 {
> +			compatible = "brcm,iproc-ts-adc-syscon", "syscon";
> +			reg = <0x180a6000 0xc30>;
> +		};
> +
> +		touchscreen: touchscreen@180a6000 {
>  			compatible = "brcm,iproc-touchscreen";
> -			reg = <0x180a6000 0x40>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ts_syscon = <&ts_adc_syscon>;
>  			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
>  			clock-names = "tsc_clk";
>  			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 1.9.1
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
