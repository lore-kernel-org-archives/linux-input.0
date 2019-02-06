From: Brian Masney <masneyb@onstation.org>
Subject: [PATCH v4 1/3] dt-bindings: Input: new bindings for MSM vibrator
Date: Tue,  5 Feb 2019 20:33:27 -0500
Message-ID: <20190206013329.18195-2-masneyb@onstation.org>
References: <20190206013329.18195-1-masneyb@onstation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206013329.18195-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, andy.gross@linaro.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, jonathan@marek.ca
List-Id: linux-input@vger.kernel.org

This patch adds the device tree bindings for the vibrator found on
various Qualcomm MSM SOCs.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v3:
- None

 .../bindings/input/msm-vibrator.txt           | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/msm-vibrator.txt

diff --git a/Documentation/devicetree/bindings/input/msm-vibrator.txt b/Documentation/devicetree/bindings/input/msm-vibrator.txt
new file mode 100644
index 000000000000..8dcf014ef2e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/msm-vibrator.txt
@@ -0,0 +1,36 @@
+* Device tree bindings for the Qualcomm MSM vibrator
+
+Required properties:
+
+  - compatible: Should be one of
+		"qcom,msm8226-vibrator"
+		"qcom,msm8974-vibrator"
+  - reg: the base address and length of the IO memory for the registers.
+  - pinctrl-names: set to default.
+  - pinctrl-0: phandles pointing to pin configuration nodes. See
+               Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+  - clock-names: set to pwm
+  - clocks: phandle of the clock. See
+            Documentation/devicetree/bindings/clock/clock-bindings.txt
+  - enable-gpios: GPIO that enables the vibrator.
+
+Optional properties:
+
+  - vcc-supply: phandle to the regulator that provides power to the sensor.
+
+Example from a LG Nexus 5 (hammerhead) phone:
+
+vibrator@fd8c3450 {
+	reg = <0xfd8c3450 0x400>;
+	compatible = "qcom,msm8974-vibrator";
+
+	vcc-supply = <&pm8941_l19>;
+
+	clocks = <&mmcc CAMSS_GP1_CLK>;
+	clock-names = "pwm";
+
+	enable-gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&vibrator_pin>;
+};
-- 
2.17.2
