From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v2 2/4] ARM: dts: vf500-colibri: Add device tree node for touchscreen support
Date: Thu, 16 Jul 2015 20:43:20 +0530
Message-ID: <63bed3ee9ee4211df15d11becf1f78824e640a82.1437058481.git.maitysanchayan@gmail.com>
References: <cover.1437058481.git.maitysanchayan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437058481.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1437058481.git.maitysanchayan@gmail.com>
References: <cover.1437058481.git.maitysanchayan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@linaro.org, kernel@pengutronix.de, stefan@agner.ch, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sanchayan Maity <maitysanchayan@gmail.com>
List-Id: linux-input@vger.kernel.org

Add device tree node for touchscreen support on Colibri VF50. The
touchscreen functionality on VF50 uses the ADC channels of Vybrid
and some GPIOs. Also add pinctrl nodes for proper pinmux.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts |  4 +++
 arch/arm/boot/dts/vf500-colibri.dtsi        | 46 +++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
index 7fc782c..c5efb57 100644
--- a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
@@ -15,3 +15,7 @@
 	model = "Toradex Colibri VF50 on Colibri Evaluation Board";
 	compatible = "toradex,vf500-colibri_vf50-on-eval", "toradex,vf500-colibri_vf50", "fsl,vf500";
 };
+
+&touchctrl {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
index cee34a3..7cbe341 100644
--- a/arch/arm/boot/dts/vf500-colibri.dtsi
+++ b/arch/arm/boot/dts/vf500-colibri.dtsi
@@ -17,4 +17,50 @@
 	memory {
 		reg = <0x80000000 0x8000000>;
 	};
+
+	touchctrl: vf50_touchctrl {
+		compatible = "toradex,vf50-touchctrl";
+		io-channels = <&adc1 0>,<&adc0 0>,
+				<&adc0 1>,<&adc1 2>;
+		xp-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+		xm-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+		yp-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+		ym-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+		pen-detect-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+		pen-pullup-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "idle","default","gpios";
+		pinctrl-0 = <&pinctrl_touchctrl_idle>;
+		pinctrl-1 = <&pinctrl_touchctrl_default>;
+		pinctrl-2 = <&pinctrl_touchctrl_gpios>;
+		status = "disabled";
+	};
+};
+
+&iomuxc {
+	vf610-colibri {
+		pinctrl_touchctrl_idle: touchctrl_idle {
+			fsl,pins = <
+				VF610_PAD_PTA18__GPIO_8		0x206d
+				VF610_PAD_PTA19__GPIO_9		0x206d
+				>;
+		};
+
+		pinctrl_touchctrl_default: touchctrl_default {
+			fsl,pins = <
+				VF610_PAD_PTA18__ADC0_SE0	0x2060
+				VF610_PAD_PTA19__ADC0_SE1	0x2060
+				VF610_PAD_PTA16__ADC1_SE0	0x2060
+				VF610_PAD_PTB2__ADC1_SE2	0x2060
+				>;
+		};
+
+		pinctrl_touchctrl_gpios: touchctrl_gpios {
+			fsl,pins = <
+				VF610_PAD_PTA23__GPIO_13	0x22e9
+				VF610_PAD_PTB23__GPIO_93	0x22e9
+				VF610_PAD_PTA22__GPIO_12	0x22e9
+				VF610_PAD_PTA11__GPIO_4		0x22e9
+				>;
+		};
+	};
 };
-- 
2.4.6
