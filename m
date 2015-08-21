From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v4 1/3] ARM: dts: vf500-colibri: Add device tree node for
 touchscreen support
Date: Fri, 21 Aug 2015 18:56:30 +0530
Message-ID: <a960c538cf419a816d73fbea7d4380ea773aa6ba.1440162473.git.maitysanchayan@gmail.com>
References: <cover.1440162473.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1440162473.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1440162473.git.maitysanchayan@gmail.com>
References: <cover.1440162473.git.maitysanchayan@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Sanchayan Maity <maitysanchayan@gmail.com>, shawnguo@kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch
List-Id: linux-input@vger.kernel.org

Add device tree node for touchscreen support on Colibri VF50. The
touchscreen functionality on VF50 uses the ADC channels of Vybrid
and some GPIOs. Also add pinctrl nodes for proper pinmux.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts |  4 +++
 arch/arm/boot/dts/vf500-colibri.dtsi        | 47 +++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
index 7fc782c..14c0b00 100644
--- a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
@@ -15,3 +15,7 @@
 	model = "Toradex Colibri VF50 on Colibri Evaluation Board";
 	compatible = "toradex,vf500-colibri_vf50-on-eval", "toradex,vf500-colibri_vf50", "fsl,vf500";
 };
+
+&touchscreen {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
index cee34a3..84f091d 100644
--- a/arch/arm/boot/dts/vf500-colibri.dtsi
+++ b/arch/arm/boot/dts/vf500-colibri.dtsi
@@ -17,4 +17,51 @@
 	memory {
 		reg = <0x80000000 0x8000000>;
 	};
+
+	touchscreen: vf50-touchscreen {
+		compatible = "toradex,vf50-touchscreen";
+		io-channels = <&adc1 0>,<&adc0 0>,
+				<&adc0 1>,<&adc1 2>;
+		xp-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+		xm-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+		yp-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+		ym-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "idle","default","gpios";
+		pinctrl-0 = <&pinctrl_touchctrl_idle>;
+		pinctrl-1 = <&pinctrl_touchctrl_default>;
+		pinctrl-2 = <&pinctrl_touchctrl_gpios>;
+		vf50-ts-min-pressure = <200>;
+		status = "disabled";
+	};
+};
+
+&iomuxc {
+	vf610-colibri {
+		pinctrl_touchctrl_idle: touchctrl_idle {
+			fsl,pins = <
+				VF610_PAD_PTA18__GPIO_8		0x006d
+				VF610_PAD_PTA19__GPIO_9		0x006c
+				>;
+		};
+
+		pinctrl_touchctrl_default: touchctrl_default {
+			fsl,pins = <
+				VF610_PAD_PTA18__ADC0_SE0	0x0040
+				VF610_PAD_PTA19__ADC0_SE1	0x0040
+				VF610_PAD_PTA16__ADC1_SE0	0x0040
+				VF610_PAD_PTB2__ADC1_SE2	0x0040
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
2.5.0
