From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH 2/2] Documentation: DT: bindings: input: Add documentation for cyttsp5
Date: Mon, 29 May 2017 16:45:38 +0200
Message-ID: <20170529144538.29187-3-mylene.josserand@free-electrons.com>
References: <20170529144538.29187-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170529144538.29187-1-mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, fery@cypress.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com
List-Id: linux-input@vger.kernel.org

Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
documentation. It can use I2C or SPI bus.
This touchscreen can handle some defined zone that are designed and
sent as button. To be able to customize the keycode sent, the
"linux,code" property in a "button" sub-node can be used.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
---
 .../bindings/input/touchscreen/cyttsp5.txt         | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp5.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cyttsp5.txt b/Documentation/devicetree/bindings/input/touchscreen/cyttsp5.txt
new file mode 100644
index 000000000000..713a377b5039
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/cyttsp5.txt
@@ -0,0 +1,55 @@
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
+Optional properties (many of them coming from touchscreen binding[1]):
+ - reset-gpios		: the reset gpio the chip is connected to
+			  (see GPIO binding[2] for more details).
+ - touchscreen-size-x	: horizontal resolution of touchscreen (in pixels)
+ - touchscreen-size-y	: vertical resolution of touchscreen (in pixels)
+ - touchscreen-fuzz-x	: horizontal noise value of the absolute input device
+			  (in pixels)
+ - touchscreen-fuzz-y	: vertical noise value of the absolute input device
+			  (in pixels)
+
+This touchscreen can handle some buttons that are touchscreen's defined zones.
+Each button's event can be customized using a sub-node properties:
+	- linux,code: Keycode to emit.
+
+[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+[1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+[2]: Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+&i2c0 {
+	[...]
+
+	tsc@24 {
+		compatible = "cypress,cyttsp5";
+		reg = <0x24>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_reset_ds203>;
+		interrupt-parent = <&pio>;
+		interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>;
+
+		button@0 {
+			linux,code = <KEY_HOMEPAGE>;
+		};
+
+		button@1 {
+			linux,code = <KEY_MENU>;
+		};
+
+		button@2 {
+			linux,code = <KEY_BACK>;
+		};
+	};
+};
-- 
2.11.0
