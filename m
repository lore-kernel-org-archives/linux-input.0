From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 4/5] ARM: sunxi: dts: Add A10/A20 PS2 pin
 muxing options
Date: Tue, 20 Jan 2015 21:03:07 +0100
Message-ID: <20150120200307.GW4367@lukather>
References: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
 <1421417021-3247-5-git-send-email-vishnupatekar0510@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qndya+I13rh6QJ0p"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB57J7KSQKGQE5DU6PFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421417021-3247-5-git-send-email-vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--qndya+I13rh6QJ0p
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Jan 16, 2015 at 07:33:40PM +0530, Vishnu Patekar wrote:
> Signed-off-by: VishnuPatekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi |   14 ++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi |   14 ++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 2c31242..8fade3e 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -629,6 +629,20 @@
>  				allwinner,drive = <0>;
>  				allwinner,pull = <0>;
>  			};
> +
> +			ps20_pins_a: ps20@0 {
> +				allwinner,pins = "PI20", "PI21";
> +				allwinner,function = "ps2";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			ps21_pins_a: ps21@0 {
> +				allwinner,pins = "PH12", "PH13";
> +				allwinner,function = "ps2";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
>  		};
>  
>  		timer@01c20c00 {
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index f35c691..f9dd274 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -866,6 +866,20 @@
>  				    allwinner,drive = <0>;
>  				    allwinner,pull = <0>;
>  			};
> +
> +			ps20_pins_a: ps20@0 {
> +				allwinner,pins = "PI20", "PI21";
> +				allwinner,function = "ps2";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			ps21_pins_a: ps21@0 {
> +				allwinner,pins = "PH12", "PH13";
> +				allwinner,function = "ps2";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
>  		};

Same thing here, we're using defines now for the values in ,drive and
,pull, please use them.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--qndya+I13rh6QJ0p--
