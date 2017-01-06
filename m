From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Fri, 6 Jan 2017 14:12:35 +0200
Message-ID: <20170106121235.2ma67uuyveiqnarg@kozik-lap>
References: <20170106114114.19321-1-andi.shyti@samsung.com>
 <CGME20170106114120epcas5p2dde13ec37b7e53f65b6899da9e7c7e60@epcas5p2.samsung.com>
 <20170106114114.19321-3-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170106114114.19321-3-andi.shyti@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, Jaechul Lee <galaxyra@gmail.com>, Beomho Seo <beomho.seo@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 06, 2017 at 08:41:11PM +0900, Andi Shyti wrote:
> Currently tm2e dts includes tm2 but there are some differences
> between the two boards and tm2 has some properties that tm2e
> doesn't have.
> 
> That's why it's important to keep the two dts files independent
> and put all the commonalities in a tm2-common.dtsi file.
> 
> At the current status the only two differences between the two
> dts files (besides the board name) are ldo31 and ldo38.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  ...ynos5433-tm2.dts => exynos5433-tm2-common.dtsi} |   24 +-
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1153 +-------------------
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   22 +-
>  3 files changed, 56 insertions(+), 1143 deletions(-)
>  copy arch/arm64/boot/dts/exynos/{exynos5433-tm2.dts => exynos5433-tm2-common.dtsi} (98%)
>  rewrite arch/arm64/boot/dts/exynos/exynos5433-tm2.dts (98%)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> similarity index 98%
> copy from arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> copy to arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index e8971f4a5977..c43f9a38adf6 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi

Thanks. Now I can easily see the differences... and there are
differences! This is much, much easier to review then all previous
versions.

> @@ -3,8 +3,8 @@
>   *
>   * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>   *
> - * Device tree source file for Samsung's TM2 board which is based on
> - * Samsung Exynos5433 SoC.
> + * Common device tree source file for Samsung's TM2 and TM2E boards
> + * which are based on Samsung Exynos5433 SoC.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -322,7 +322,7 @@
>  				"s2mps13_bt";
>  		};
>  
> -		regulators {
> +		regulators: regulators {

I understand that you added the label to create LDO31 and LDO38
regulators in specific DTS (I read your comments below). I do not have
strong opinion but I would prefer overriding in DTS instead of new addon, so:
1. without the label above,
2. with something like:
	ldo31_reg: LDO31 {
		/*
		 * LDO31 differs from target to target,
		 * its definition is in the .dts
		 */
	};

With such empty stub, one can still find all the regulator nodes in
common DTSI. I find it more readable. What do you think?

Best regards,
Krzysztof

>  			ldo1_reg: LDO1 {
>  				regulator-name = "VDD_ALIVE_0.9V_AP";
>  				regulator-min-microvolt = <900000>;
> @@ -552,11 +552,10 @@
>  				regulator-max-microvolt = <3300000>;
>  			};
>  
> -			ldo31_reg: LDO31 {
> -				regulator-name = "TSP_VDD_1.85V_AP";
> -				regulator-min-microvolt = <1850000>;
> -				regulator-max-microvolt = <1850000>;
> -			};
> +			/*
> +			 * LDO31 differs from target to target,
> +			 * its definition is in the .dts
> +			 */
>  
>  			ldo32_reg: LDO32 {
>  				regulator-name = "VTOUCH_1.8V_AP";
> @@ -595,11 +594,10 @@
>  				regulator-max-microvolt = <1800000>;
>  			};
>  
> -			ldo38_reg: LDO38 {
> -				regulator-name = "VCC_3.0V_MOTOR_AP";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -			};
> +			/*
> +			 * LDO38 differs from target to target,
> +			 * its definition is in the .dts
> +			 */
>  
>  			ldo39_reg: LDO39 {
>  				regulator-name = "V_HRM_1.8V";
