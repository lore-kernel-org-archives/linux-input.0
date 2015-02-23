From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v5 5/5] Documentation: Add device tree bindings document for
 max77843
Date: Mon, 23 Feb 2015 20:34:13 +0900
Message-ID: <1424691253-11429-6-git-send-email-jaewon02.kim@samsung.com>
References: <1424691253-11429-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1424691253-11429-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Cc: Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

Add document describing device tree bindings for max77843 MFD.
Drivers: MFD core, regulator, extcon, charger and fuelgauge.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 Documentation/devicetree/bindings/mfd/max77843.txt |  110 ++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77843.txt

diff --git a/Documentation/devicetree/bindings/mfd/max77843.txt b/Documentation/devicetree/bindings/mfd/max77843.txt
new file mode 100644
index 0000000..76426ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77843.txt
@@ -0,0 +1,110 @@
+Maxim MAX77843 multi-function device
+
+MAX77843 is a Multi-Function Device with the following submodules:
+- PMIC	  : 2 SAFEOUT LDOs for USB device
+- CHARGER : Li+ battery charger with Fuel Gauge
+- MUIC	  : Micro USB Interface Controller
+- HAPTIC  : Motor Controller for tactile feedback
+
+It is interfaced to host controller using I2C.
+
+Required properties:
+- compatible : Must be "maxim,max77843".
+- reg : I2C slave address of PMIC block.
+- interrupts : I2C line for main SoCs.
+- interrupt-parent : The parent of interrupt controller.
+
+Optional properties:
+- regulators : The regulators of max77843 have to be instantiated under subnode
+	named "regulators" using the following format.
+
+	[*]refer : Documentation/devicetree/bindings/regulator/regulator.txt
+
+	regulators {
+		SAFEOUT {
+			regulator-name = "SAFEOUT";
+		};
+	}
+
+	List of valid regulator names:
+	- SAFEOUT1, SAFEOUT2, CHARGER.
+
+- max77843-muic : This properties used by extcon consumers.
+	Required properties:
+		- compatible : Must be "maxim,max77842-muic".
+
+- max77843-charger : There battery charger of MAX77843 have to be instantiated
+	under sub-node named "max77843-charger" using the following format.
+	Required properties:
+		- compatible : Must be "maxim,max77842-charger".
+		- maxim,fast-charge-uamp : Fast charge current levels are
+			100 mA to 3150 mA programmed by I2C per 100 mA.
+		- maxim,top-off-uamp : Top off current threshold levels are
+			125 mA to 650 mA programmed by I2C per 75 mA.
+		- maxim,input-uamp-limit : Input current limit levels are
+			100 mA to 3533 mA programmed by I2C per 33 mA.
+
+- max77843-fuelgauge : There fuelgauge of MAX77843 have to be instantiated
+	under sub-node named "max77843-fuelgauge" using the following format.
+	Required properties:
+		- compatible : Must be "maxim,max77842-fuelgauge".
+
+- max77843-haptic : The MAX77843 haptic device provides the tactile feedback
+	to the user by using PWM(Pulse Width Modulation) signal.
+	Required properties:
+		- compatible : Must be "maxim,max77843-hpatic".
+		- haptic-supply : Power supply for the haptic motor.
+			[*] refer Documentation/devicetree/
+					bindings/regulator/regulator.txt
+		- pwms : phandle for the PWM(Pulse Width Modulation) device.
+			PWM properties should be named "pwms".
+			[*] refer Documentation/devicetree/bindings/pwm/pwm.txt
+
+Example:
+	max77843@66 {
+		compatible = "samsung,max77843";
+		reg = <0x66>;
+		interrupt-parent = <&gpa1>;
+		interrupts = <5 2>;
+
+		regulators {
+			SAFEOUT1 {
+				regulator-name = "SAFEOUT1";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <4950000>;
+			};
+			SAFEOUT2 {
+				regulator-name = "SAFEOUT2";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <4950000>;
+			};
+			CHARGER {
+				regulator-name = "CHARGER";
+				regulator-min-microamp = <100000>;
+				regulator-max-microamp = <3150000>;
+			};
+		};
+
+		haptic {
+			compatible = "maxim,max77843-haptic";
+			haptic-supply = <&haptic_supply>;
+			pwms = <&pwm 0 40000 0>;
+			pwm-names = "haptic";
+		};
+
+		max77843-muic {
+			compatible = "maxim,max77843-muic";
+		};
+
+		max77843-charger {
+			compatible = "maxim,max77843-charger";
+			maxim,fast-charge-uamp = <450000>;
+			maxim,top-off-uamp = <125000>;
+			maxim,input-uamp-limit = <500000>;
+		};
+
+		max77843-fuelgauge {
+			compatible = "maxim,max77843-fuelgauge";
+		};
+
+	};
-- 
1.7.9.5
