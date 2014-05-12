From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] input: gpio-keys: Move the gpio-keys bindings documentation
Date: Mon, 12 May 2014 11:33:44 -0300
Message-ID: <1399905224-1273-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
List-Id: linux-input@vger.kernel.org

This is an input driver and belongs to input not gpio.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/gpio/gpio_keys.txt         | 36 ----------------------
 .../devicetree/bindings/input/gpio-keys.txt        | 36 ++++++++++++++++++++++
 2 files changed, 36 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio_keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/gpio-keys.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.txt b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
deleted file mode 100644
index 5c2c021..0000000
--- a/Documentation/devicetree/bindings/gpio/gpio_keys.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Device-Tree bindings for input/gpio_keys.c keyboard driver
-
-Required properties:
-	- compatible = "gpio-keys";
-
-Optional properties:
-	- autorepeat: Boolean, Enable auto repeat feature of Linux input
-	  subsystem.
-
-Each button (key) is represented as a sub-node of "gpio-keys":
-Subnode properties:
-
-	- gpios: OF device-tree gpio specification.
-	- label: Descriptive name of the key.
-	- linux,code: Keycode to emit.
-
-Optional subnode-properties:
-	- linux,input-type: Specify event type this button/key generates.
-	  If not specified defaults to <1> == EV_KEY.
-	- debounce-interval: Debouncing interval time in milliseconds.
-	  If not specified defaults to 5.
-	- gpio-key,wakeup: Boolean, button can wake-up the system.
-
-Example nodes:
-
-	gpio_keys {
-			compatible = "gpio-keys";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			autorepeat;
-			button@21 {
-				label = "GPIO Key UP";
-				linux,code = <103>;
-				gpios = <&gpio1 0 1>;
-			};
-			...
diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
new file mode 100644
index 0000000..5c2c021
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -0,0 +1,36 @@
+Device-Tree bindings for input/gpio_keys.c keyboard driver
+
+Required properties:
+	- compatible = "gpio-keys";
+
+Optional properties:
+	- autorepeat: Boolean, Enable auto repeat feature of Linux input
+	  subsystem.
+
+Each button (key) is represented as a sub-node of "gpio-keys":
+Subnode properties:
+
+	- gpios: OF device-tree gpio specification.
+	- label: Descriptive name of the key.
+	- linux,code: Keycode to emit.
+
+Optional subnode-properties:
+	- linux,input-type: Specify event type this button/key generates.
+	  If not specified defaults to <1> == EV_KEY.
+	- debounce-interval: Debouncing interval time in milliseconds.
+	  If not specified defaults to 5.
+	- gpio-key,wakeup: Boolean, button can wake-up the system.
+
+Example nodes:
+
+	gpio_keys {
+			compatible = "gpio-keys";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			autorepeat;
+			button@21 {
+				label = "GPIO Key UP";
+				linux,code = <103>;
+				gpios = <&gpio1 0 1>;
+			};
+			...
-- 
1.9.1

