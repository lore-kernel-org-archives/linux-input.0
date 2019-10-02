From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] dt-bindings: serio: Convert Allwinner PS2 controller to a
 schema
Date: Wed,  2 Oct 2019 14:06:45 +0200
Message-ID: <20191002120645.102805-1-mripard@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The older Allwinner SoCs have a PS2 controller that is supported in Linux,
with a matching Device Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 .../serio/allwinner,sun4i-a10-ps2.yaml        | 51 +++++++++++++++++++
 .../bindings/serio/allwinner,sun4i-ps2.txt    | 22 --------
 2 files changed, 51 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serio/allwinner,sun4i-a10-ps2.yaml
 delete mode 100644 Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt

diff --git a/Documentation/devicetree/bindings/serio/allwinner,sun4i-a10-ps2.yaml b/Documentation/devicetree/bindings/serio/allwinner,sun4i-a10-ps2.yaml
new file mode 100644
index 000000000000..ee9712f1c97d
--- /dev/null
+++ b/Documentation/devicetree/bindings/serio/allwinner,sun4i-a10-ps2.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serio/allwinner,sun4i-a10-ps2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 PS2 Host Controller Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+description:
+  A20 PS2 is dual role controller (PS2 host and PS2 device). These
+  bindings for PS2 A10/A20 host controller. IBM compliant IBM PS2 and
+  AT-compatible keyboard and mouse can be connected.
+
+properties:
+  compatible:
+    const: allwinner,sun4i-a10-ps2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sun7i-a20-ccu.h>
+
+    ps20: ps2@1c2a000 {
+        compatible = "allwinner,sun4i-a10-ps2";
+        reg = <0x01c2a000 0x400>;
+        interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&ccu CLK_APB1_PS20>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt b/Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
deleted file mode 100644
index 75996b6111bb..000000000000
--- a/Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Device tree bindings for Allwinner A10, A20 PS2 host controller
-
-A20 PS2 is dual role controller (PS2 host and PS2 device). These bindings are
-for PS2 A10/A20 host controller. IBM compliant IBM PS2 and AT-compatible keyboard
-and mouse can be connected.
-
-Required properties:
-
- - reg             : Offset and length of the register set for the device.
- - compatible      : Should be as of the following:
-                     - "allwinner,sun4i-a10-ps2"
- - interrupts      : The interrupt line connected to the PS2.
- - clocks          : The gate clk connected to the PS2.
-
-
-Example:
-	ps20: ps2@01c2a000 {
-		compatible = "allwinner,sun4i-a10-ps2";
-		reg = <0x01c2a000 0x400>;
-		interrupts = <0 62 4>;
-		clocks = <&apb1_gates 6>;
-	};
-- 
2.23.0
