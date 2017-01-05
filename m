From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
Date: Thu, 05 Jan 2017 18:45:46 +0900
Message-ID: <586E15CA.6060002@samsung.com>
References: <1483604833-29746-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170105082716epcas1p1f2a6eea40d842e2d8f7f7f54c029bc82@epcas1p1.samsung.com>
 <1483604833-29746-4-git-send-email-jcsing.lee@samsung.com>
 <586E0E56.6050608@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_UCz0DblgX3o/EjTXYf95eA)"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <586E0E56.6050608@samsung.com>
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

--Boundary_(ID_UCz0DblgX3o/EjTXYf95eA)
Content-type: text/plain; charset=euc-kr
Content-transfer-encoding: 8BIT

Hi Andi,

I correct the my previous comment about ldo23 and ldo25
because I check the final schematic document, I worked
with wrong information of ldo23 and ldo25 on the patch[1].
[1] https://lkml.org/lkml/2016/11/3/61

I'll send the fix patch to you right now
after that you better to work for these patches.


On 2017년 01월 05일 18:13, Chanwoo Choi wrote:
> Hi,
> 
> I add the some comment as following:
> - ldo23/25/31/38 have the different value between tm2 and tm2e.
> - The patch[1] was alread posted. I think you better to rebase this patch on patch[1].
> [1] https://patchwork.kernel.org/patch/9491769/
> - ("ARM64: dts: TM2: comply to the samsung pinctrl naming convention")
> 
> I add detailed comments on below.
> 
> On 2017년 01월 05일 17:27, Jaechul Lee wrote:
>> From: Andi Shyti <andi.shyti@samsung.com>
>>
>> Currently tm2e dts includes tm2 but there are some differences
>> between the two boards and tm2 has some properties that tm2e
>> doesn't have.
>>
>> That's why it's important to keep the two dts files independent
>> and put all the commonalities in a tm2-common.dtsi file.
>>
>> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
>> ---
>>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1116 +++++++++++++++++++
>>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1138 +-------------------
>>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
>>  3 files changed, 1136 insertions(+), 1120 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>>  rewrite arch/arm64/boot/dts/exynos/exynos5433-tm2.dts (98%)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> new file mode 100644
>> index 0000000..7ad0019
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> @@ -0,0 +1,1116 @@
>> +/*
>> + * SAMSUNG Exynos5433 TM2 board device tree source
>> + *
>> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>> + *
>> + * Device tree source file for Samsung's TM2 board which is based on
>> + * Samsung Exynos5433 SoC.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/dts-v1/;
>> +#include "exynos5433.dtsi"
>> +#include <dt-bindings/clock/samsung,s2mps11.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
> 
> [snip]
> 
>> +&hsi2c_0 {
>> +	status = "okay";
>> +	clock-frequency = <2500000>;
>> +
>> +	s2mps13-pmic@66 {
>> +		compatible = "samsung,s2mps13-pmic";
>> +		interrupt-parent = <&gpa0>;
>> +		interrupts = <7 IRQ_TYPE_NONE>;
>> +		reg = <0x66>;
>> +		samsung,s2mps11-wrstbi-ground;
>> +
>> +		s2mps13_osc: clocks {
>> +			compatible = "samsung,s2mps13-clk";
>> +			#clock-cells = <1>;
>> +			clock-output-names = "s2mps13_ap", "s2mps13_cp",
>> +				"s2mps13_bt";
>> +		};
>> +
>> +		regulators {
>> +			ldo1_reg: LDO1 {
>> +				regulator-name = "VDD_ALIVE_0.9V_AP";
>> +				regulator-min-microvolt = <900000>;
>> +				regulator-max-microvolt = <900000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo2_reg: LDO2 {
>> +				regulator-name = "VDDQ_MMC2_2.8V_AP";
>> +				regulator-min-microvolt = <2800000>;
>> +				regulator-max-microvolt = <2800000>;
>> +				regulator-always-on;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo3_reg: LDO3 {
>> +				regulator-name = "VDD1_E_1.8V_AP";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo4_reg: LDO4 {
>> +				regulator-name = "VDD10_MIF_PLL_1.0V_AP";
>> +				regulator-min-microvolt = <1300000>;
>> +				regulator-max-microvolt = <1300000>;
>> +				regulator-always-on;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo5_reg: LDO5 {
>> +				regulator-name = "VDD10_DPLL_1.0V_AP";
>> +				regulator-min-microvolt = <1000000>;
>> +				regulator-max-microvolt = <1000000>;
>> +				regulator-always-on;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo6_reg: LDO6 {
>> +				regulator-name = "VDD10_MIPI2L_1.0V_AP";
>> +				regulator-min-microvolt = <1000000>;
>> +				regulator-max-microvolt = <1000000>;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo7_reg: LDO7 {
>> +				regulator-name = "VDD18_MIPI2L_1.8V_AP";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +			};
>> +
>> +			ldo8_reg: LDO8 {
>> +				regulator-name = "VDD18_LLI_1.8V_AP";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo9_reg: LDO9 {
>> +				regulator-name = "VDD18_ABB_ETC_1.8V_AP";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo10_reg: LDO10 {
>> +				regulator-name = "VDD33_USB30_3.0V_AP";
>> +				regulator-min-microvolt = <3000000>;
>> +				regulator-max-microvolt = <3000000>;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo11_reg: LDO11 {
>> +				regulator-name = "VDD_INT_M_1.0V_AP";
>> +				regulator-min-microvolt = <1000000>;
>> +				regulator-max-microvolt = <1000000>;
>> +				regulator-always-on;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo12_reg: LDO12 {
>> +				regulator-name = "VDD_KFC_M_1.1V_AP";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <1350000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo13_reg: LDO13 {
>> +				regulator-name = "VDD_G3D_M_0.95V_AP";
>> +				regulator-min-microvolt = <950000>;
>> +				regulator-max-microvolt = <950000>;
>> +				regulator-always-on;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo14_reg: LDO14 {
>> +				regulator-name = "VDDQ_M1_LDO_1.2V_AP";
>> +				regulator-min-microvolt = <1200000>;
>> +				regulator-max-microvolt = <1200000>;
>> +				regulator-always-on;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo15_reg: LDO15 {
>> +				regulator-name = "VDDQ_M2_LDO_1.2V_AP";
>> +				regulator-min-microvolt = <1200000>;
>> +				regulator-max-microvolt = <1200000>;
>> +				regulator-always-on;
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>> +			};
>> +
>> +			ldo16_reg: LDO16 {
>> +				regulator-name = "VDDQ_EFUSE";
>> +				regulator-min-microvolt = <1400000>;
>> +				regulator-max-microvolt = <3400000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo17_reg: LDO17 {
>> +				regulator-name = "V_TFLASH_2.8V_AP";
>> +				regulator-min-microvolt = <2800000>;
>> +				regulator-max-microvolt = <2800000>;
>> +			};
>> +
>> +			ldo18_reg: LDO18 {
>> +				regulator-name = "V_CODEC_1.8V_AP";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +			};
>> +
>> +			ldo19_reg: LDO19 {
>> +				regulator-name = "VDDA_1.8V_COMP";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo20_reg: LDO20 {
>> +				regulator-name = "VCC_2.8V_AP";
>> +				regulator-min-microvolt = <2800000>;
>> +				regulator-max-microvolt = <2800000>;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo21_reg: LDO21 {
>> +				regulator-name = "VT_CAM_1.8V";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +			};
>> +
>> +			ldo22_reg: LDO22 {
>> +				regulator-name = "CAM_IO_1.8V_AP";
>> +				regulator-min-microvolt = <1800000>;
>> +				regulator-max-microvolt = <1800000>;
>> +			};
>> +
>> +			ldo23_reg: LDO23 {
>> +				regulator-name = "CAM_SEN_CORE_1.2V_AP";
>> +				regulator-min-microvolt = <1050000>;
>> +				regulator-max-microvolt = <1200000>;
> 
> ldo23_reg has the different value between tm2 and tm2e.
> - tm2 : name - CAM_SEN_CORE_1.2V_AP, max-microvolt :1200000
> - tm2e : name - CAM_SEN_CORE_1.025V_AP, max-microvolt :1050000

To check the final schematic document, ldo23 is used on both tm2 and tm2e without difference.
But, name is CAM_SEN_CORE_1.05V_AP

> 
>> +			};
>> +
>> +			ldo24_reg: LDO24 {
>> +				regulator-name = "VT_CAM_1.2V";
>> +				regulator-min-microvolt = <1200000>;
>> +				regulator-max-microvolt = <1200000>;
>> +			};
>> +
>> +			ldo25_reg: LDO25 {
>> +				regulator-name = "CAM_SEN_A2.8V_AP";
>> +				regulator-min-microvolt = <2800000>;
>> +				regulator-max-microvolt = <2800000>;
>> +			};
> 
> ldo25 is only used on TM2 and has the different name between tm2 and tm2e.
> - tm2 : name - CAM_SEN_A2.8V_AP
> - tm2e : name - UNUSED_LDO15

To check the final schematic document, ldo25 is not used on both tm2 and tm2e.

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

--Boundary_(ID_UCz0DblgX3o/EjTXYf95eA)
Content-type: text/x-vcard; CHARSET=EUC-KR; name=cw00_choi.vcf
Content-transfer-encoding: base64
Content-disposition: attachment; filename=cw00_choi.vcf

bnVsbA0K

--Boundary_(ID_UCz0DblgX3o/EjTXYf95eA)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--Boundary_(ID_UCz0DblgX3o/EjTXYf95eA)--
