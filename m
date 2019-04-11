From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v9 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date: Thu, 11 Apr 2019 14:42:03 +0200
Message-ID: <20190411124212.7612-3-brgl@bgdev.pl>
References: <20190411124212.7612-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411124212.7612-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the battery charger module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../power/supply/max77650-charger.txt         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
new file mode 100644
index 000000000000..821a2240e70f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
@@ -0,0 +1,28 @@
+Battery charger driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The charger is represented as a sub-node of the PMIC node on the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-charger"
+
+Optional properties:
+--------------------
+- input-voltage-min-microvolt:	Minimum CHGIN regulation voltage. Must be one
+				of: 4000000, 4100000, 4200000, 4300000,
+				4400000, 4500000, 4600000, 4700000.
+- input-current-limit-microamp:	CHGIN input current limit (in microamps). Must
+				be one of: 95000, 190000, 285000, 380000,
+				475000.
+
+Example:
+--------
+
+	charger {
+		compatible = "maxim,max77650-charger";
+		min-microvolt = <4200000>;
+		curr-lim-microamp = <285000>;
+	};
-- 
2.21.0
