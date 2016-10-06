From: Sangwon Jee <jeesw@melfas.com>
Subject: Input: melfas_mip4 - add devicetree binding documentations
Date: Thu,  6 Oct 2016 15:45:34 +0900
Message-ID: <1475736334-5087-1-git-send-email-jeesw@melfas.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sbs.melfas.com ([39.118.242.30]:35259 "EHLO sbs.melfas.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752099AbcJFGpF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Oct 2016 02:45:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeesw@melfas.com

Add devicetree binding documentations.

Signed-off-by: Sangwon Jee <jeesw@melfas.com>
---
 .../bindings/input/touchscreen/melfas_mip4.txt      | 21 +++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt         |  1 +
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt b/Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt
new file mode 100644
index 0000000..4e4dfbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt
@@ -0,0 +1,21 @@
+* MELFAS MIP4 Touchscreen
+
+Required properties:
+- compatible: must be "melfas,mip4_ts"
+- reg: I2C slave address of the chip (0x48 or 0x34)
+- interrupt-parent: interrupt controller to which the chip is connected
+- interrupts: interrupt to which the chip is connected
+
+Optional properties:
+- ce-gpio: GPIO connected to the CE(chip enable) pin of the chip
+
+Example:
+	i2c@00000000 {
+		melfas_mip4_ts@48 {
+			compatible = "melfas,mip4_ts";
+			reg = <0x48>;
+			interrupt-parent = <&gpio>;
+			interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+			ce-gpio = <&gpio 0 GPIO_ACTIVE_HIGH>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 99029cf..1457fd4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -143,6 +143,7 @@ marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
 mediatek	MediaTek Inc.
 melexis	Melexis N.V.
+melfas	MELFAS Inc.
 merrii	Merrii Technology Co., Ltd.
 micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
-- 
1.9.1

