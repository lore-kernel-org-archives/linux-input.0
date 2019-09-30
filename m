From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 3/6] dt-bindings: regulator: max77650: convert the binding document to yaml
Date: Mon, 30 Sep 2019 15:02:43 +0200
Message-ID: <20190930130246.4860-4-brgl@bgdev.pl>
References: <20190930130246.4860-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190930130246.4860-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Convert the binding document for max77650 regulator module to yaml.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/regulator/max77650-regulator.txt | 42 +--------------
 .../regulator/max77650-regulator.yaml         | 51 +++++++++++++++++++
 2 files changed, 52 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
index f1cbe813c30f..39686610589c 100644
--- a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
@@ -1,41 +1 @@
-Regulator driver for MAX77650 PMIC from Maxim Integrated.
-
-This module is part of the MAX77650 MFD device. For more details
-see Documentation/devicetree/bindings/mfd/max77650.txt.
-
-The regulator controller is represented as a sub-node of the PMIC node
-on the device tree.
-
-The device has a single LDO regulator and a SIMO buck-boost regulator with
-three independent power rails.
-
-Required properties:
---------------------
-- compatible:		Must be "maxim,max77650-regulator"
-
-Each rail must be instantiated under the regulators subnode of the top PMIC
-node. Up to four regulators can be defined. For standard regulator properties
-refer to Documentation/devicetree/bindings/regulator/regulator.txt.
-
-Available regulator compatible strings are: "ldo", "sbb0", "sbb1", "sbb2".
-
-Example:
---------
-
-	regulators {
-		compatible = "maxim,max77650-regulator";
-
-		max77650_ldo: regulator@0 {
-			regulator-compatible = "ldo";
-			regulator-name = "max77650-ldo";
-			regulator-min-microvolt = <1350000>;
-			regulator-max-microvolt = <2937500>;
-		};
-
-		max77650_sbb0: regulator@1 {
-			regulator-compatible = "sbb0";
-			regulator-name = "max77650-sbb0";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <1587500>;
-		};
-	};
+This file has been moved to max77650-regulator.yaml.
diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
new file mode 100644
index 000000000000..c0d986948ac8
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/max77650-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator driver for MAX77650 PMIC from Maxim Integrated.
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+description: |
+  This module is part of the MAX77650 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  The device has a single LDO regulator and a SIMO buck-boost regulator with
+  three independent power rails.
+
+properties:
+  compatible:
+    const: maxim,max77650-regulator
+
+patternProperties:
+  "^regulator@[0-3]$":
+    $ref: "regulator.yaml#"
+
+required:
+  - compatible
+
+examples:
+  - |
+    regulators {
+        compatible = "maxim,max77650-regulator";
+
+        max77650_ldo: regulator@0 {
+            regulator-compatible = "ldo";
+            regulator-name = "max77650-ldo";
+            regulator-min-microvolt = <1350000>;
+            regulator-max-microvolt = <2937500>;
+        };
+
+        max77650_sbb0: regulator@1 {
+            regulator-compatible = "sbb0";
+            regulator-name = "max77650-sbb0";
+            regulator-min-microvolt = <800000>;
+            regulator-max-microvolt = <1587500>;
+        };
+    };
-- 
2.23.0
