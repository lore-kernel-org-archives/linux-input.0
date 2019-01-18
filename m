From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 02/13] dt-bindings: regulator: add DT bindings for max77650
Date: Fri, 18 Jan 2019 14:42:33 +0100
Message-ID: <20190118134244.22253-3-brgl@bgdev.pl>
References: <20190118134244.22253-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118134244.22253-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for max77650 regulators.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/regulator/max77650-regulator.txt | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
new file mode 100644
index 000000000000..f1cbe813c30f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
@@ -0,0 +1,41 @@
+Regulator driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The regulator controller is represented as a sub-node of the PMIC node
+on the device tree.
+
+The device has a single LDO regulator and a SIMO buck-boost regulator with
+three independent power rails.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-regulator"
+
+Each rail must be instantiated under the regulators subnode of the top PMIC
+node. Up to four regulators can be defined. For standard regulator properties
+refer to Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Available regulator compatible strings are: "ldo", "sbb0", "sbb1", "sbb2".
+
+Example:
+--------
+
+	regulators {
+		compatible = "maxim,max77650-regulator";
+
+		max77650_ldo: regulator@0 {
+			regulator-compatible = "ldo";
+			regulator-name = "max77650-ldo";
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <2937500>;
+		};
+
+		max77650_sbb0: regulator@1 {
+			regulator-compatible = "sbb0";
+			regulator-name = "max77650-sbb0";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1587500>;
+		};
+	};
-- 
2.19.1
