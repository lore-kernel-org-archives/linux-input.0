From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v2 1/5] dt-bindings: input: Add Atmel PTC subsystem bindings
Date: Fri, 21 Apr 2017 10:39:20 +0200
Message-ID: <20170421083924.15096-2-ludovic.desroches@microchip.com>
References: <20170421083924.15096-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170421083924.15096-1-ludovic.desroches@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, dmitry.torokhov@gmail.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org
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
index 0000000..a183fd5
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
2.9.0
