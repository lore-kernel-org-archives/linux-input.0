From: Sangwon Jee <jeesw@melfas.com>
Subject: Input: melfas_mip4 - add documentations
Date: Tue, 27 Sep 2016 14:19:33 +0900
Message-ID: <1474953573-29327-1-git-send-email-jeesw@melfas.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sbs.melfas.com ([39.118.242.30]:21766 "EHLO sbs.melfas.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbcI0FZu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Sep 2016 01:25:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeesw@melfas.com

Add maintainer and devicetree documentations.

Signed-off-by: Sangwon Jee <jeesw@melfas.com>
---
 .../bindings/input/touchscreen/melfas_mip4.txt      | 21 +++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt         |  1 +
 MAINTAINERS                                         |  7 +++++++
 3 files changed, 29 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 630151f..9627cab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7155,6 +7155,13 @@ F:	Documentation/scsi/megaraid.txt
 F:	drivers/scsi/megaraid.*
 F:	drivers/scsi/megaraid/
 
+MELFAS MIP4 TOUCHSCREEN DRIVER
+M:	"Sangwon Jee" <jeesw@melfas.com>
+W:	http://www.melfas.com
+S:	Supported
+F:	drivers/input/touchscreen/melfas_mip4*
+F:	Documentation/devicetree/bindings/input/touchscreen/melfas_mip4*
+
 MELLANOX ETHERNET DRIVER (mlx4_en)
 M: 	Eugenia Emantayev <eugenia@mellanox.com>
 L:	netdev@vger.kernel.org
-- 
1.9.1

