From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 4/4] arm64: dts: exynos: Add tm2 touchkey node
Date: Tue, 3 Jan 2017 10:14:34 -0300
Message-ID: <58437de5-a837-9b34-da30-f8bc911b0854@osg.samsung.com>
References: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170103075734epcas5p439b05860a3238ce638f683d9687786a3@epcas5p4.samsung.com>
 <1483430237-26823-5-git-send-email-jcsing.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:60433
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935088AbdACNOp (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2017 08:14:45 -0500
In-Reply-To: <1483430237-26823-5-git-send-email-jcsing.lee@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andi Shyti <andi.shyti@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, beomho.seo@samsung.com, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Hello Jaechul,

On 01/03/2017 04:57 AM, Jaechul Lee wrote:
> Add DT node support for TM2 touchkey device.
> 
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> index 887a1f1..ef7d21c 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -18,3 +18,15 @@
>  	compatible = "samsung,tm2e", "samsung,exynos5433";
>  };
>  
> +&hsi2c_9 {
> +	status = "okay";
> +
> +	touchkey@20 {
> +		compatible = "samsung,tm2-touchkey";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpa3>;
> +		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +		vcc-supply = <&ldo32_reg>;
> +		vdd-supply = <&ldo33_reg>;
> +	};
> +};
> 

If you re-spin with the changes suggested by Chanwoo instead
of the commont .dtsi, feel free to add:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
