From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 1/2] dt-bindings: input: add GPIO controllable vibrator
Date: Sat,  2 Mar 2019 15:11:30 +0100
Message-ID: <20190302141132.21160-1-luca@z3ntu.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:INPUT KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN..." <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Provide a simple driver for GPIO controllable vibrators.
It will be used by the Fairphone 2.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/input/gpio-vibrator.txt  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.txt

diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.txt b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
new file mode 100644
index 000000000000..9e2e9acf497b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
@@ -0,0 +1,16 @@
+* GPIO vibrator device tree bindings
+
+Registers a GPIO device as vibrator, where the vibration motor just has the capability to turn on or off. If the device is connected to a pwm, you should use the pwm-vibrator driver instead.
+
+Required properties:
+- compatible: should contain "gpio-vibrator"
+- enable-gpios: Should contain a GPIO handle
+- vcc-supply: Phandle for the regulator supplying power
+
+Example from Fairphone 2:
+
+vibrator {
+	compatible = "gpio-vibrator";
+	enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
+	vcc-supply = <&pm8941_l18>;
+};
-- 
2.21.0
