From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: input: Add Add Spreadtrum SC27xx vibrator documentation
Date: Thu, 10 May 2018 13:08:33 +0800
Message-ID: <44b17778d8f0bf897a316a39516ba2cafecf43c9.1525928437.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, xiaotong.lu@spreadtrum.com
List-Id: linux-input@vger.kernel.org

From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>

This patch adds the binding documentation for Spreadtrum SC27xx series
vibrator device.

Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v3:
 - Change compatible string to explicit Soc name.
 - Add parent MFD node.

Changes since v2:
 - No updates.

Changes since v1:
  - No updates.
---
 .../bindings/input/sprd,sc27xx-vibra.txt           |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt

diff --git a/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
new file mode 100644
index 0000000..f2ec0d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
@@ -0,0 +1,23 @@
+Spreadtrum SC27xx PMIC Vibrator
+
+Required properties:
+- compatible: should be "sprd,sc2731-vibrator".
+- reg: address of vibrator control register.
+
+Example :
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vibrator@eb4 {
+			compatible = "sprd,sc2731-vibrator";
+			reg = <0xeb4>;
+		};
+	};
-- 
1.7.9.5
