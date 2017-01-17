From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: exynos: Add stmfts touchscreen node for
 TM2 and TM2E
Date: Tue, 17 Jan 2017 20:39:52 +0200
Message-ID: <20170117183952.tfexmtp6723w7ism@kozik-lap>
References: <20170117135441.31450-1-andi.shyti@samsung.com>
 <CGME20170117135457epcas5p2044e9e5cd9eb6b162bb0acb4e317bdfb@epcas5p2.samsung.com>
 <20170117135441.31450-4-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36127 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdAQSoY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 17 Jan 2017 13:44:24 -0500
Content-Disposition: inline
In-Reply-To: <20170117135441.31450-4-andi.shyti@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>

On Tue, Jan 17, 2017 at 10:54:41PM +0900, Andi Shyti wrote:
> TM2 and TM2E devices are provided with a ST-Microelectronics
> Finger Tip S device with small differences:
> 
>  - screen size
>  - TM2E uses the stmfts also as a touchkey for "back" and "menu"
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 13 +++++++++++++
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts         |  5 +++++
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts        |  7 +++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index a5c866901e93..689d5c124a49 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -745,6 +745,19 @@
>  	};
>  };
>  
> +&hsi2c_5 {
> +	status = "okay";
> +
> +	touchscreen: stmfts@49 {
> +		compatible = "st,stmfts";
> +		reg = <0x49>;
> +		interrupt-parent = <&gpa1>;
> +		interrupts = <1 IRQ_TYPE_NONE>;

Looks fine to me, just wondering:
1. Are you sure this is TYPE_NONE interrupt? Sometimes we put it
   everywhere instead of checking real value.
2. Don't you have to configure the gpa1-1 to EINT? Any pull up/down?

Best regards,
Krzysztof

> +		avdd-supply = <&ldo30_reg>;
> +		vdd-supply = <&ldo31_reg>;
> +	};
> +};
> +
>  &hsi2c_7 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> index 2449266b268f..d0311d34c6bd 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -29,3 +29,8 @@
>  	regulator-min-microvolt = <3000000>;
>  	regulator-max-microvolt = <3000000>;
>  };
> +
> +&touchscreen {
> +	touchscreen-size-x = <1439>;
> +	touchscreen-size-y = <2559>;
> +};
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> index 2fbf3a860316..388880dcb5ae 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> @@ -29,3 +29,10 @@
>  	regulator-min-microvolt = <3300000>;
>  	regulator-max-microvolt = <3300000>;
>  };
> +
> +&touchscreen {
> +	touchscreen-size-x = <1599>;
> +	touchscreen-size-y = <2559>;
> +	touch-key-connected;
> +	ledvdd-supply = <&ldo33_reg>;
> +};
> -- 
> 2.11.0
> 
