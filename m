From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] input: keyboard: DT bindings for the D-Link DIR-685 touchkeys
Date: Sat, 20 May 2017 18:56:48 +0200
Message-ID: <20170520165649.13118-1-linus.walleij@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This adds device tree bindings for the D-Link DIR-685 touchkeys.
It's a simple homebrewn touchkey controller (by D-Link referred
to as "touchpad") on I2C.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
ChangeLog v1->v2:
- Rename from "touchpad" to touchkeys" consistently.
- Add Rob's ACK.
---
 .../bindings/input/dlink,dir685-touchkeys.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlink,dir685-touchkeys.txt

diff --git a/Documentation/devicetree/bindings/input/dlink,dir685-touchkeys.txt b/Documentation/devicetree/bindings/input/dlink,dir685-touchkeys.txt
new file mode 100644
index 000000000000..10dec1c57abf
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/dlink,dir685-touchkeys.txt
@@ -0,0 +1,21 @@
+* D-Link DIR-685 Touchkeys
+
+This is a I2C one-off touchkey controller based on the Cypress Semiconductor
+CY8C214 MCU with some firmware in its internal 8KB flash. The circuit
+board inside the router is named E119921.
+
+The touchkey device node should be placed inside an I2C bus node.
+
+Required properties:
+- compatible: must be "dlink,dir685-touchkeys"
+- reg: the I2C address of the touchkeys
+- interrupts: reference to the interrupt number
+
+Example:
+
+touchkeys@26 {
+	compatible = "dlink,dir685-touchkeys";
+	reg = <0x26>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.9.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
