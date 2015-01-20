From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 3/5] ARM: sunxi: dts: Add PS2 nodes to
 dtsi for A10 and A20
Date: Tue, 20 Jan 2015 21:02:16 +0100
Message-ID: <20150120200216.GV4367@lukather>
References: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
 <1421417021-3247-4-git-send-email-vishnupatekar0510@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6qFdnjy6dKaiDX/E"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB5XJ7KSQKGQEBMUP5YY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421417021-3247-4-git-send-email-vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--6qFdnjy6dKaiDX/E
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Vishnu,

On Fri, Jan 16, 2015 at 07:33:39PM +0530, Vishnu Patekar wrote:
> Signed-off-by: VishnuPatekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Why is there Hans Signed-off here?

> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi |   16 ++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi |   16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 7b4099f..2c31242 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -795,5 +795,21 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  		};
> +
> +		ps20: ps2@01c2a000 {
> +			compatible = "allwinner,sun4i-a10-ps2";
> +			reg = <0x01c2a000 0x400>;
> +			interrupts = <62>;
> +			clocks = <&apb1_gates 6>;
> +			status = "disabled";
> +		};
> +
> +		ps21: ps2@01c2a400 {
> +			compatible = "allwinner,sun4i-a10-ps2";
> +			reg = <0x01c2a400 0x400>;
> +			interrupts = <63>;
> +			clocks = <&apb1_gates 7>;
> +			status = "disabled";
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index e21ce59..f35c691 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1093,5 +1093,21 @@
>  			#interrupt-cells = <3>;
>  			interrupts = <1 9 0xf04>;
>  		};
> +
> +		ps20: ps2@01c2a000 {
> +			compatible = "allwinner,sun4i-a10-ps2";
> +			reg = <0x01c2a000 0x400>;
> +			interrupts = <0 62 4>;
> +			clocks = <&apb1_gates 6>;
> +			status = "disabled";
> +		};
> +
> +		ps21: ps2@01c2a400 {
> +			compatible = "allwinner,sun4i-a10-ps2";
> +			reg = <0x01c2a400 0x400>;
> +			interrupts = <0 63 4>;

We recently switched to using includes and defines for these hardcoded
values.

Could you switch to it as well?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--6qFdnjy6dKaiDX/E--
