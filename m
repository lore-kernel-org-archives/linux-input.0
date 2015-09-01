From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v5 2/3] input: Add DT binding documentation for Colibri VF50 touchscreen
Date: Tue,  1 Sep 2015 18:06:54 +0530
Message-ID: <2cb0283cfd209bf8335e00c7e1e318aefd312429.1441110400.git.maitysanchayan@gmail.com>
References: <cover.1441110400.git.maitysanchayan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441110400.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1441110400.git.maitysanchayan@gmail.com>
References: <cover.1441110400.git.maitysanchayan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: shawnguo@kernel.org, stefan@agner.ch, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sanchayan Maity <maitysanchayan@gmail.com>
List-Id: linux-input@vger.kernel.org

This adds device tree binding documentation for the Colibri VF50
touchscreen driver.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 .../bindings/input/touchscreen/colibri-vf50-ts.txt | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
new file mode 100644
index 0000000..9d9e930
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
@@ -0,0 +1,36 @@
+* Toradex Colibri VF50 Touchscreen driver
+
+Required Properties:
+- compatible must be toradex,vf50-touchscreen
+- io-channels: adc channels being used by the Colibri VF50 module
+- xp-gpios: FET gate driver for input of X+
+- xm-gpios: FET gate driver for input of X-
+- yp-gpios: FET gate driver for input of Y+
+- ym-gpios: FET gate driver for input of Y-
+- interrupt-parent: phandle for the interrupt controller
+- interrupts: pen irq interrupt for touch detection
+- pinctrl-names: "idle", "default", "gpios"
+- pinctrl-0: pinctrl node for pen/touch detection state pinmux
+- pinctrl-1: pinctrl node for X/Y and pressure measurement (ADC) state pinmux
+- pinctrl-2: pinctrl node for gpios functioning as FET gate drivers
+- vf50-ts-min-pressure: pressure level at which to stop measuring X/Y values
+
+Example:
+
+	touchctrl: vf50_touchctrl {
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
-- 
2.5.0
