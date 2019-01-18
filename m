From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 04/13] dt-bindings: gpio: add DT bindings for max77650
Date: Fri, 18 Jan 2019 14:42:35 +0100
Message-ID: <20190118134244.22253-5-brgl@bgdev.pl>
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

Add the DT binding document for the GPIO module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/gpio/gpio-max77650.txt           | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max77650.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-max77650.txt b/Documentation/devicetree/bindings/gpio/gpio-max77650.txt
new file mode 100644
index 000000000000..b5dbbe934deb
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-max77650.txt
@@ -0,0 +1,34 @@
+GPIO driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The GPIO controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+This device has a single GPIO pin.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-gpio"
+- gpio-controller : 	Marks the device node as a gpio controller.
+- #gpio-cells : 	Must be <2>. The first cell is the pin number and
+			the second cell is used to specify the gpio active
+			state.
+
+Optional properties:
+--------------------
+gpio-line-names:	Single string containing the name of the GPIO line.
+
+For more details, please refer to the generic GPIO DT binding document
+<devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	gpio {
+		compatible = "maxim,max77650-gpio";
+		gpio-line-names = "max77650-charger";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
-- 
2.19.1
