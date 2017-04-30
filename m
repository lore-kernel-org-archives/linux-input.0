From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] input: keyboard: DT bindings for the D-Link DIR-685 touchpad
Date: Sun, 30 Apr 2017 22:55:00 +0200
Message-ID: <20170430205500.28799-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34735 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1949881AbdD3UzQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 30 Apr 2017 16:55:16 -0400
Received: by mail-lf0-f48.google.com with SMTP id t144so54485757lff.1
        for <linux-input@vger.kernel.org>; Sun, 30 Apr 2017 13:55:15 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org

This adds device tree bindings for the D-Link DIR-685 touchpad.
It's a simple homebrewn touchpad on I2C.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/input/dlink,dir685-touchpad.txt        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlink,dir685-touchpad.txt

diff --git a/Documentation/devicetree/bindings/input/dlink,dir685-touchpad.txt b/Documentation/devicetree/bindings/input/dlink,dir685-touchpad.txt
new file mode 100644
index 000000000000..25bc538a6e39
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/dlink,dir685-touchpad.txt
@@ -0,0 +1,21 @@
+* D-Link DIR-685 Touchpad
+
+This is a I2C one-off touchpad controller based on the Cypress Semiconductor
+CY8C214 MCU with some firmware in its internal 8KB flash. The circuit
+board inside the router is named E119921.
+
+The touchpad device node should be placed inside an I2C bus node.
+
+Required properties:
+- compatible: must be "dlink,dir685-touchpad"
+- reg: the I2C address of the touchpad
+- interrupts: reference to the interrupt number
+
+Example:
+
+touchpad@26 {
+	compatible = "dlink,dir685-touchpad";
+	reg = <0x26>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.9.3

