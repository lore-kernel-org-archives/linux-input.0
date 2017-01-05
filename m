From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Thu, 05 Jan 2017 18:13:58 +0900
Message-ID: <586E0E56.6050608@samsung.com>
References: <1483604833-29746-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170105082716epcas1p1f2a6eea40d842e2d8f7f7f54c029bc82@epcas1p1.samsung.com>
 <1483604833-29746-4-git-send-email-jcsing.lee@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_RPP9G+IhWdufU2m0DZ9bNw)"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1483604833-29746-4-git-send-email-jcsing.lee@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jaechul Lee <jcsing.lee@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, beomho.seo@samsung.com, linux-input@vger.kernel.org, galaxyra@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_RPP9G+IhWdufU2m0DZ9bNw)
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8BIT

Hi,

I add the some comment as following:
- ldo23/25/31/38 have the different value between tm2 and tm2e.
- The patch[1] was alread posted. I think you better to rebase this patch on patch[1].
[1] https://patchwork.kernel.org/patch/9491769/
- ("ARM64: dts: TM2: comply to the samsung pinctrl naming convention")

I add detailed comments on below.

On 2017년 01월 05일 17:27, Jaechul Lee wrote:
> From: Andi Shyti <andi.shyti@samsung.com>
> 
> Currently tm2e dts includes tm2 but there are some differences
> between the two boards and tm2 has some properties that tm2e
> doesn't have.
> 
> That's why it's important to keep the two dts files independent
> and put all the commonalities in a tm2-common.dtsi file.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1116 +++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1138 +-------------------
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
>  3 files changed, 1136 insertions(+), 1120 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>  rewrite arch/arm64/boot/dts/exynos/exynos5433-tm2.dts (98%)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> new file mode 100644
> index 0000000..7ad0019
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -0,0 +1,1116 @@
> +/*
> + * SAMSUNG Exynos5433 TM2 board device tree source
> + *
> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
> + *
> + * Device tree source file for Samsung's TM2 board which is based on
> + * Samsung Exynos5433 SoC.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +#include "exynos5433.dtsi"
> +#include <dt-bindings/clock/samsung,s2mps11.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +

[snip]

> +&hsi2c_0 {
> +	status = "okay";
> +	clock-frequency = <2500000>;
> +
> +	s2mps13-pmic@66 {
> +		compatible = "samsung,s2mps13-pmic";
> +		interrupt-parent = <&gpa0>;
> +		interrupts = <7 IRQ_TYPE_NONE>;
> +		reg = <0x66>;
> +		samsung,s2mps11-wrstbi-ground;
> +
> +		s2mps13_osc: clocks {
> +			compatible = "samsung,s2mps13-clk";
> +			#clock-cells = <1>;
> +			clock-output-names = "s2mps13_ap", "s2mps13_cp",
> +				"s2mps13_bt";
> +		};
> +
> +		regulators {
> +			ldo1_reg: LDO1 {
> +				regulator-name = "VDD_ALIVE_0.9V_AP";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: LDO2 {
> +				regulator-name = "VDDQ_MMC2_2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo3_reg: LDO3 {
> +				regulator-name = "VDD1_E_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: LDO4 {
> +				regulator-name = "VDD10_MIF_PLL_1.0V_AP";
> +				regulator-min-microvolt = <1300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo5_reg: LDO5 {
> +				regulator-name = "VDD10_DPLL_1.0V_AP";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo6_reg: LDO6 {
> +				regulator-name = "VDD10_MIPI2L_1.0V_AP";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo7_reg: LDO7 {
> +				regulator-name = "VDD18_MIPI2L_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo8_reg: LDO8 {
> +				regulator-name = "VDD18_LLI_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo9_reg: LDO9 {
> +				regulator-name = "VDD18_ABB_ETC_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo10_reg: LDO10 {
> +				regulator-name = "VDD33_USB30_3.0V_AP";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo11_reg: LDO11 {
> +				regulator-name = "VDD_INT_M_1.0V_AP";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo12_reg: LDO12 {
> +				regulator-name = "VDD_KFC_M_1.1V_AP";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo13_reg: LDO13 {
> +				regulator-name = "VDD_G3D_M_0.95V_AP";
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo14_reg: LDO14 {
> +				regulator-name = "VDDQ_M1_LDO_1.2V_AP";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo15_reg: LDO15 {
> +				regulator-name = "VDDQ_M2_LDO_1.2V_AP";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo16_reg: LDO16 {
> +				regulator-name = "VDDQ_EFUSE";
> +				regulator-min-microvolt = <1400000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo17_reg: LDO17 {
> +				regulator-name = "V_TFLASH_2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +			};
> +
> +			ldo18_reg: LDO18 {
> +				regulator-name = "V_CODEC_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo19_reg: LDO19 {
> +				regulator-name = "VDDA_1.8V_COMP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo20_reg: LDO20 {
> +				regulator-name = "VCC_2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo21_reg: LDO21 {
> +				regulator-name = "VT_CAM_1.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo22_reg: LDO22 {
> +				regulator-name = "CAM_IO_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo23_reg: LDO23 {
> +				regulator-name = "CAM_SEN_CORE_1.2V_AP";
> +				regulator-min-microvolt = <1050000>;
> +				regulator-max-microvolt = <1200000>;

ldo23_reg has the different value between tm2 and tm2e.
- tm2 : name - CAM_SEN_CORE_1.2V_AP, max-microvolt :1200000
- tm2e : name - CAM_SEN_CORE_1.025V_AP, max-microvolt :1050000

> +			};
> +
> +			ldo24_reg: LDO24 {
> +				regulator-name = "VT_CAM_1.2V";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +			};
> +
> +			ldo25_reg: LDO25 {
> +				regulator-name = "CAM_SEN_A2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +			};

ldo25 is only used on TM2 and has the different name between tm2 and tm2e.
- tm2 : name - CAM_SEN_A2.8V_AP
- tm2e : name - UNUSED_LDO15

> +
> +			ldo26_reg: LDO26 {
> +				regulator-name = "CAM_AF_2.8V_AP";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +			};
> +
> +			ldo27_reg: LDO27 {
> +				regulator-name = "VCC_3.0V_LCD_AP";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +
> +			ldo28_reg: LDO28 {
> +				regulator-name = "VCC_1.8V_LCD_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo29_reg: LDO29 {
> +				regulator-name = "VT_CAM_2.8V";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +			};
> +
> +			ldo30_reg: LDO30 {
> +				regulator-name = "TSP_AVDD_3.3V_AP";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			ldo31_reg: LDO31 {
> +				regulator-name = "TSP_VDD_1.85V_AP";
> +				regulator-min-microvolt = <1850000>;
> +				regulator-max-microvolt = <1850000>;
> +			};

ldo31_reg has the different value between tm2 and tm2e.
- tm2 : name - TSP_VDD_1.85V_AP, min/max-microvolt :1850000
- tm2e : name - TSP_VDD_1.8V_AP, min/max-microvolt :1800000

> +
> +			ldo32_reg: LDO32 {
> +				regulator-name = "VTOUCH_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo33_reg: LDO33 {
> +				regulator-name = "VTOUCH_LED_3.3V";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +			};
> +
> +			ldo34_reg: LDO34 {
> +				regulator-name = "VCC_1.8V_MHL_AP";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <2100000>;
> +			};
> +
> +			ldo35_reg: LDO35 {
> +				regulator-name = "OIS_VM_2.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <2800000>;
> +			};
> +
> +			ldo36_reg: LDO36 {
> +				regulator-name = "VSIL_1.0V";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +			};
> +
> +			ldo37_reg: LDO37 {
> +				regulator-name = "VF_1.8V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo38_reg: LDO38 {
> +				regulator-name = "VCC_3.0V_MOTOR_AP";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +			};

ldo38_reg has the different value between tm2 and tm2e.
- tm2 : name - VCC_3.0V_MOTOR_AP, min/max-microvolt :3000000
- tm2e : name - VCC_3.3V_MOTOR_AP, min/max-microvolt :3300000

> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck2_reg: BUCK2 {
> +				regulator-name = "VDD_EGL_1.0V_AP";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck3_reg: BUCK3 {
> +				regulator-name = "VDD_KFC_1.0V_AP";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck4_reg: BUCK4 {
> +				regulator-name = "VDD_INT_0.95V_AP";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck5_reg: BUCK5 {
> +				regulator-name = "VDD_DISP_CAM0_0.9V_AP";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck6_reg: BUCK6 {
> +				regulator-name = "VDD_G3D_0.9V_AP";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck7_reg: BUCK7 {
> +				regulator-name = "VDD_MEM1_1.2V_AP";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +			};
> +
> +			buck8_reg: BUCK8 {
> +				regulator-name = "VDD_LLDO_1.35V_AP";
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			buck9_reg: BUCK9 {
> +				regulator-name = "VDD_MLDO_2.0V_AP";
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +
> +			buck10_reg: BUCK10 {
> +				regulator-name = "vdd_mem2";
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&hsi2c_8 {
> +	status = "okay";
> +
> +	max77843@66 {
> +		compatible = "maxim,max77843";
> +		interrupt-parent = <&gpa1>;
> +		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> +		reg = <0x66>;
> +
> +		muic: max77843-muic {
> +			compatible = "maxim,max77843-muic";
> +		};
> +
> +		regulators {
> +			compatible = "maxim,max77843-regulator";
> +			safeout1_reg: SAFEOUT1 {
> +				regulator-name = "SAFEOUT1";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <4950000>;
> +			};
> +
> +			safeout2_reg: SAFEOUT2 {
> +				regulator-name = "SAFEOUT2";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <4950000>;
> +			};
> +
> +			charger_reg: CHARGER {
> +				regulator-name = "CHARGER";
> +				regulator-min-microamp = <100000>;
> +				regulator-max-microamp = <3150000>;
> +			};
> +		};
> +
> +		haptic: max77843-haptic {
> +			compatible = "maxim,max77843-haptic";
> +			haptic-supply = <&ldo38_reg>;
> +			pwms = <&pwm 0 33670 0>;
> +			pwm-names = "haptic";
> +		};
> +	};
> +};
> +
> +&i2s0 {
> +	status = "okay";
> +};
> +
> +&mshc_0 {
> +	status = "okay";
> +	num-slots = <1>;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	cap-mmc-highspeed;
> +	non-removable;
> +	card-detect-delay = <200>;
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-sdr-timing = <0 4>;
> +	samsung,dw-mshc-ddr-timing = <0 2>;
> +	samsung,dw-mshc-hs400-timing = <0 3>;
> +	samsung,read-strobe-delay = <90>;
> +	fifo-depth = <0x80>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_qrdy &sd0_bus1 &sd0_bus4
> +			&sd0_bus8 &sd0_rdqs>;
> +	bus-width = <8>;
> +	assigned-clocks = <&cmu_top CLK_SCLK_MMC0_FSYS>;
> +	assigned-clock-rates = <800000000>;
> +};
> +
> +&mshc_2 {
> +	status = "okay";
> +	num-slots = <1>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	cd-gpios = <&gpa2 4 GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +	card-detect-delay = <200>;
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-sdr-timing = <0 4>;
> +	samsung,dw-mshc-ddr-timing = <0 2>;
> +	fifo-depth = <0x80>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus1 &sd2_bus4>;
> +	bus-width = <4>;
> +};
> +
> +&ppmu_d0_general {
> +	status = "okay";
> +	events {
> +		ppmu_event0_d0_general: ppmu-event0-d0-general {
> +			event-name = "ppmu-event0-d0-general";
> +		};
> +	};
> +};
> +
> +&ppmu_d1_general {
> +	status = "okay";
> +	events {
> +		ppmu_event0_d1_general: ppmu-event0-d1-general {
> +		       event-name = "ppmu-event0-d1-general";
> +	       };
> +       };
> +};
> +
> +&pinctrl_alive {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&initial_alive>;
> +


The following patches[1] touch the tm2.dts file about pinctrl naming convention.
So, I recommend that this patch shoud be rebased on patch[1] to prevent the merge conflict.

[1] https://patchwork.kernel.org/patch/9491769/
- ("ARM64: dts: TM2: comply to the samsung pinctrl naming convention")

> +	initial_alive: initial-state {
> +		PIN(IN, gpa0-0, DOWN, LV1);
> +		PIN(IN, gpa0-1, NONE, LV1);
> +		PIN(IN, gpa0-2, DOWN, LV1);
> +		PIN(IN, gpa0-3, NONE, LV1);
> +		PIN(IN, gpa0-4, NONE, LV1);
> +		PIN(IN, gpa0-5, DOWN, LV1);
> +		PIN(IN, gpa0-6, NONE, LV1);
> +		PIN(IN, gpa0-7, NONE, LV1);
> +
> +		PIN(IN, gpa1-0, UP, LV1);
> +		PIN(IN, gpa1-1, NONE, LV1);
> +		PIN(IN, gpa1-2, NONE, LV1);
> +		PIN(IN, gpa1-3, DOWN, LV1);
> +		PIN(IN, gpa1-4, DOWN, LV1);
> +		PIN(IN, gpa1-5, NONE, LV1);
> +		PIN(IN, gpa1-6, NONE, LV1);
> +		PIN(IN, gpa1-7, NONE, LV1);
> +
> +		PIN(IN, gpa2-0, NONE, LV1);
> +		PIN(IN, gpa2-1, NONE, LV1);
> +		PIN(IN, gpa2-2, NONE, LV1);
> +		PIN(IN, gpa2-3, DOWN, LV1);
> +		PIN(IN, gpa2-4, NONE, LV1);
> +		PIN(IN, gpa2-5, DOWN, LV1);
> +		PIN(IN, gpa2-6, DOWN, LV1);
> +		PIN(IN, gpa2-7, NONE, LV1);
> +
> +		PIN(IN, gpa3-0, DOWN, LV1);
> +		PIN(IN, gpa3-1, DOWN, LV1);
> +		PIN(IN, gpa3-2, NONE, LV1);
> +		PIN(IN, gpa3-3, DOWN, LV1);
> +		PIN(IN, gpa3-4, NONE, LV1);
> +		PIN(IN, gpa3-5, DOWN, LV1);
> +		PIN(IN, gpa3-6, DOWN, LV1);
> +		PIN(IN, gpa3-7, DOWN, LV1);
> +
> +		PIN(IN, gpf1-0, NONE, LV1);
> +		PIN(IN, gpf1-1, NONE, LV1);
> +		PIN(IN, gpf1-2, DOWN, LV1);
> +		PIN(IN, gpf1-4, UP, LV1);
> +		PIN(OUT, gpf1-5, NONE, LV1);
> +		PIN(IN, gpf1-6, DOWN, LV1);
> +		PIN(IN, gpf1-7, DOWN, LV1);
> +
> +		PIN(IN, gpf2-0, DOWN, LV1);
> +		PIN(IN, gpf2-1, DOWN, LV1);
> +		PIN(IN, gpf2-2, DOWN, LV1);
> +		PIN(IN, gpf2-3, DOWN, LV1);
> +
> +		PIN(IN, gpf3-0, DOWN, LV1);
> +		PIN(IN, gpf3-1, DOWN, LV1);
> +		PIN(IN, gpf3-2, NONE, LV1);
> +		PIN(IN, gpf3-3, DOWN, LV1);
> +
> +		PIN(IN, gpf4-0, DOWN, LV1);
> +		PIN(IN, gpf4-1, DOWN, LV1);
> +		PIN(IN, gpf4-2, DOWN, LV1);
> +		PIN(IN, gpf4-3, DOWN, LV1);
> +		PIN(IN, gpf4-4, DOWN, LV1);
> +		PIN(IN, gpf4-5, DOWN, LV1);
> +		PIN(IN, gpf4-6, DOWN, LV1);
> +		PIN(IN, gpf4-7, DOWN, LV1);
> +
> +		PIN(IN, gpf5-0, DOWN, LV1);
> +		PIN(IN, gpf5-1, DOWN, LV1);
> +		PIN(IN, gpf5-2, DOWN, LV1);
> +		PIN(IN, gpf5-3, DOWN, LV1);
> +		PIN(OUT, gpf5-4, NONE, LV1);
> +		PIN(IN, gpf5-5, DOWN, LV1);
> +		PIN(IN, gpf5-6, DOWN, LV1);
> +		PIN(IN, gpf5-7, DOWN, LV1);
> +	};

[snip]

> +/*
> + * SAMSUNG Exynos5433 TM2 board device tree source
> + *
> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
> + *
> + * Device tree source file for Samsung's TM2 board which is based on
> + * Samsung Exynos5433 SoC.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "exynos5433-tm2-common.dtsi"
> +
> +/ {
> +	model = "Samsung TM2 board";
> +	compatible = "samsung,tm2", "samsung,exynos5433";
> +};
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> index 1db4e7f..81fdbef 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
> @@ -11,7 +11,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#include "exynos5433-tm2.dts"
> +#include "exynos5433-tm2-common.dtsi"
>  
>  / {
>  	model = "Samsung TM2E board";
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

--Boundary_(ID_RPP9G+IhWdufU2m0DZ9bNw)
Content-type: text/x-vcard; CHARSET=EUC-KR; name=cw00_choi.vcf
Content-transfer-encoding: base64
Content-disposition: attachment; filename=cw00_choi.vcf

bnVsbA0K

--Boundary_(ID_RPP9G+IhWdufU2m0DZ9bNw)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--Boundary_(ID_RPP9G+IhWdufU2m0DZ9bNw)--
