From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v3] input: keyboard: DT bindings for the D-Link DIR-685 touchkeys
Date: Tue, 30 May 2017 14:09:17 +0200
Message-ID: <20170530120918.27357-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34428 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdE3MJ0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 08:09:26 -0400
Received: by mail-lf0-f54.google.com with SMTP id 99so47886411lfu.1
        for <linux-input@vger.kernel.org>; Tue, 30 May 2017 05:09:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org

This adds device tree bindings for the D-Link DIR-685 touchkeys.
It's a simple homebrewn touchkey controller (by D-Link referred
to as "touchpad") on I2C.

Cc: devicetree@vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes, just resending.
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

