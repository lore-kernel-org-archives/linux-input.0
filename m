From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v5 5/5] arm64: dts: exynos: Add tm2 touchkey node
Date: Sat, 7 Jan 2017 06:31:21 +0900
Message-ID: <CAGTfZH2QYQK190kYFbOMqJMFgH32548ra-VqzYwc5LVBJwqisA@mail.gmail.com>
References: <CGME20170106134356epcas1p1aee9f715c58b50f6056bf0b43b849497@epcas1p1.samsung.com>
 <20170106134350.32428-1-andi.shyti@samsung.com> <20170106134350.32428-6-andi.shyti@samsung.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20170106134350.32428-6-andi.shyti@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Jaechul Lee <jcsing.lee@samsung.com>, Andi Shyti <andi@etezian.org>, Jaechul Lee <galaxyra@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

2017-01-06 22:43 GMT+09:00 Andi Shyti <andi.shyti@samsung.com>:
> From: Jaechul Lee <jcsing.lee@samsung.com>
>
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
> index 2449266b268f..92fcc4ec8319 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -18,6 +18,19 @@
>         compatible = "samsung,tm2", "samsung,exynos5433";
>  };
>
> +&hsi2c_9 {
> +       status = "okay";
> +
> +       touchkey@20 {
> +               compatible = "samsung,tm2-touchkey";
> +               reg = <0x20>;
> +               interrupt-parent = <&gpa3>;
> +               interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +               vcc-supply = <&ldo32_reg>;
> +               vdd-supply = <&ldo33_reg>;
> +       };
> +};
> +
>  &ldo31_reg {
>         regulator-name = "TSP_VDD_1.85V_AP";
>         regulator-min-microvolt = <1850000>;

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
