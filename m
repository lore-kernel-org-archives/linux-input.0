From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v3 1/5] dt-bindings: input: Add Atmel PTC subsystem bindings
Date: Fri, 20 Oct 2017 15:31:17 +0200
Message-ID: <20171020133121.7992-2-ludovic.desroches@microchip.com>
References: <20171020133121.7992-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020133121.7992-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-input@vger.kernel.org

Add description of the Atmel PTC subsystem bindings.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/atmel,ptc.txt        | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/atmel,ptc.txt

diff --git a/Documentation/devicetree/bindings/input/atmel,ptc.txt b/Documentation/devicetree/bindings/input/atmel,ptc.txt
new file mode 100644
index 000000000000..a183fd511e04
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/atmel,ptc.txt
@@ -0,0 +1,67 @@
+Atmel PTC Subsystem
+
+The Atmel Peripheral Touch Controller subsystem offers built-in hardware
+for capacitive touch measurement on sensors that function as buttons, sliders
+and wheels.
+
+1) PTC Subsystem node
+
+Required properties:
+- compatible: 		Must be "atmel,sama5d2-ptc"
+- reg: 			Address, length of the shared memory and ppp registers location
+			and length.
+- clocks: 		Phandlers to the clocks.
+- clock-names: 		Must be "ptc_clk", "ptc_int_osc", "slow_clk".
+- #address-cells:	Must be one. The cell is the button or scroller id.
+- #size-cells: 		Must be zero.
+
+Example:
+	ptc@fc060000 {
+		compatible = "atmel,sama5d2-ptc";
+		reg = <0x00800000 0x10000
+		       0xfc060000 0xcf>;
+		interrupts = <58 IRQ_TYPE_LEVEL_HIGH 7>;
+		clocks = <&ptc_clk>, <&main>, <&clk32k>;
+		clock-names = "ptc_clk", "ptc_int_osc", "slow_clk";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		[ child node definitions... ]
+	};
+
+2) Scroller / buttons subnodes
+
+Subnodes describe the kind of sensors the customer want to use. They have to be
+named according to their function: button, slider or wheel.
+
+2.1) Scroller subnodes
+
+Required properties:
+- reg:	Id of the scroller, each id must be different.
+
+Example:
+	slider@0 {
+		reg = <0>;
+	};
+
+	wheel@1 {
+		reg = <1>;
+	};
+
+2.2) Button subnodes
+
+Required properties:
+- reg:			Id of node used for the button, each id must be
+			different.
+- linux,keycode: 	Key code of the button.
+
+Example:
+		button@8 {
+			reg = <8>;
+			linux,keycode = <2>;
+		};
+
+		button@9 {
+			reg = <9>;
+			linux,keycode = <3>;
+		};
-- 
2.12.2
