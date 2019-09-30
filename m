From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/6] dt-bindings: mfd: max77650: convert the binding document to yaml
Date: Mon, 30 Sep 2019 15:02:41 +0200
Message-ID: <20190930130246.4860-2-brgl@bgdev.pl>
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

Convert the binding document for max77650 core mfd module to yaml.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
 .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++++++++
 2 files changed, 84 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml

diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
index b529d8d19335..080871686b3b 100644
--- a/Documentation/devicetree/bindings/mfd/max77650.txt
+++ b/Documentation/devicetree/bindings/mfd/max77650.txt
@@ -1,46 +1 @@
-MAX77650 ultra low-power PMIC from Maxim Integrated.
-
-Required properties:
--------------------
-- compatible:		Must be "maxim,max77650"
-- reg:			I2C device address.
-- interrupts:		The interrupt on the parent the controller is
-			connected to.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells:	Must be <2>.
-
-- gpio-controller:	Marks the device node as a gpio controller.
-- #gpio-cells:		Must be <2>. The first cell is the pin number and
-			the second cell is used to specify the gpio active
-			state.
-
-Optional properties:
---------------------
-gpio-line-names:	Single string containing the name of the GPIO line.
-
-The GPIO-controller module is represented as part of the top-level PMIC
-node. The device exposes a single GPIO line.
-
-For device-tree bindings of other sub-modules (regulator, power supply,
-LEDs and onkey) refer to the binding documents under the respective
-sub-system directories.
-
-For more details on GPIO bindings, please refer to the generic GPIO DT
-binding document <devicetree/bindings/gpio/gpio.txt>.
-
-Example:
---------
-
-	pmic@48 {
-		compatible = "maxim,max77650";
-		reg = <0x48>;
-
-		interrupt-controller;
-		interrupt-parent = <&gpio2>;
-		#interrupt-cells = <2>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-line-names = "max77650-charger";
-	};
+This file has been moved to max77650.yaml.
diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Documentation/devicetree/bindings/mfd/max77650.yaml
new file mode 100644
index 000000000000..5186ad287ec7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/max77650.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX77650 ultra low-power PMIC from Maxim Integrated.
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+description: |
+  This document describes the DT properties of the core MFD controller.
+
+  The GPIO-controller module is represented as part of the top-level PMIC
+  node. The device exposes a single GPIO line.
+
+  For device-tree bindings of other sub-modules (regulator, power supply,
+  LEDs and onkey) refer to the binding documents under the respective
+  sub-system directories.
+
+  For more details on GPIO bindings, please refer to the generic GPIO DT
+  binding document <devicetree/bindings/gpio/gpio.txt>.
+
+properties:
+  compatible:
+    const: maxim,max77650
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  interrupts:
+    description:
+      The interrupt on the parent the controller is connected to.
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger type.
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description:
+      The first cell is the pin number and the second cell is used to specify
+      the gpio active state.
+
+  gpio-line-names:
+    $ref: '/schemas/types.yaml#/definitions/string-array'
+    maxItems: 1
+    description:
+      Single string containing the name of the GPIO line.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - gpio-controller
+  - "#gpio-cells"
+
+examples:
+  - |
+    pmic@48 {
+        compatible = "maxim,max77650";
+        reg = <0x48>;
+
+        interrupt-controller;
+        interrupt-parent = <&gpio2>;
+        #interrupt-cells = <2>;
+        interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-line-names = "max77650-charger";
+    };
-- 
2.23.0
