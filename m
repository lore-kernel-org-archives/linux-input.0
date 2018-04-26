From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: input: Add Add Spreadtrum SC27xx vibrator documentation
Date: Thu, 26 Apr 2018 17:12:33 +0800
Message-ID: <e2f85ec0b1fb66baa41dd85bb31e8113e23c704b.1524733425.git.baolin.wang@linaro.org>
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
Changes since v2:
 - No updates.

Changes since v1:
 - No updates.
---
 .../bindings/input/sprd,sc27xx-vibra.txt           |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt

diff --git a/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
new file mode 100644
index 0000000..92ead29
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
@@ -0,0 +1,12 @@
+Spreadtrum SC27xx PMIC Vibrator
+
+Required properties:
+- compatible: should be "sprd,sc27xx-vibrator".
+- reg: address of vibrator control register.
+
+Example :
+
+vibrator@eb4 {
+	compatible = "sprd,sc27xx-vibrator";
+	reg = <0xeb4>;
+};
-- 
1.7.9.5
