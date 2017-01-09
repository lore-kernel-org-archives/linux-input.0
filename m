From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: exynos: Add tm2 touchkey node
Date: Mon, 09 Jan 2017 16:31:22 +0900
Message-ID: <58733C4A.7080707@samsung.com>
References: <1483946535-4703-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170109072219epcas5p2b1dd8d38c4ae6bd5727e68c4ecaf7f24@epcas5p2.samsung.com>
 <1483946535-4703-4-git-send-email-jcsing.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57374 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761864AbdAIHbZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2017 02:31:25 -0500
In-reply-to: <1483946535-4703-4-git-send-email-jcsing.lee@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andi Shyti <andi.shyti@samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hi Jaechul,

I tested this patch on TM2 board. It is well working
with platform.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi

On 2017년 01월 09일 16:22, Jaechul Lee wrote:
> Add DT node support for TM2 touchkey device.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> index 2449266..ddba2f8 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -18,6 +18,19 @@
>  	compatible = "samsung,tm2", "samsung,exynos5433";
>  };
>  
> +&hsi2c_9 {
> +	status = "okay";
> +
> +	touchkey@20 {
> +		compatible = "cypress,tm2-touchkey";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpa3>;
> +		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +		vcc-supply = <&ldo32_reg>;
> +		vdd-supply = <&ldo33_reg>;
> +	};
> +};
> +
>  &ldo31_reg {
>  	regulator-name = "TSP_VDD_1.85V_AP";
>  	regulator-min-microvolt = <1850000>;
> 

