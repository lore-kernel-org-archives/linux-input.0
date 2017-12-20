From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH v5 2/2] dt-bindings: input: Add documentation for cyttsp5
Date: Wed, 20 Dec 2017 11:08:43 +0100
Message-ID: <20171220100843.2759-3-mylene.josserand@free-electrons.com>
References: <20171220100843.2759-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171220100843.2759-1-mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
documentation. It can use I2C or SPI bus.
This touchscreen can handle some defined zone that are designed and
sent as button. To be able to customize the keycode sent, the
"linux,keycodes" property can be used.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
---
 .../bindings/input/touchscreen/cypress,cyttsp5.txt | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt b/Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt
new file mode 100644
index 000000000000..1e0e90e322c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt
@@ -0,0 +1,39 @@
+* Cypress cyttsp touchscreen controller, generation 5
+
+Required properties:
+ - compatible		: must be "cypress,cyttsp5"
+ - reg			: Device I2C address or SPI chip select number
+ - interrupt-parent	: the phandle for the gpio controller
+			  (see interrupt binding[0]).
+ - interrupts		: (gpio) interrupt to which the chip is connected
+			  (see interrupt binding[0]).
+
+Optional properties:
+ - reset-gpios		: the reset gpio the chip is connected to
+			  (see GPIO binding[1] for more details).
+Some other touchscreen optional properties can be defined such as
+"touchscreen-size-x". See ./touchscreen.txt[2] for more details.
+
+This touchscreen can handle some buttons that are touchscreen's defined zones.
+Each button's event can be customized using a property:
+	- linux,keycodes: List of keycode to emit.
+
+[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+[1]: Documentation/devicetree/bindings/gpio/gpio.txt
+[2]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+
+Example:
+&i2c0 {
+	[...]
+
+	touchscreen@24 {
+		compatible = "cypress,cyttsp5";
+		reg = <0x24>;
+
+		interrupt-parent = <&pio>;
+		interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>;
+		touchscreen-swapped-x-y;
+		linux,keycodes = <KEY_HOMEPAGE>, <KEY_MENU>, <KEY_BACK>;
+	};
+};
-- 
2.11.0
