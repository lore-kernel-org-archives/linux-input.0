From: Ahmet Inan <inan@distec.de>
Subject: [PATCH 2/2] dt-bindings: Add I2C attached EETI EXC3000 bindings
Date: Fri, 6 Oct 2017 09:37:28 +0200
Message-ID: <20171006073728.14724-2-inan@distec.de>
References: <20171006073728.14724-1-inan@distec.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.datadisplay.de ([87.191.35.243]:10848 "EHLO
        mail.datadisplay.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdJFHiU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Oct 2017 03:38:20 -0400
In-Reply-To: <20171006073728.14724-1-inan@distec.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ahmet Inan <xdsopl@gmail.com>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Ahmet Inan <inan@distec.de>

This documents the use of the dt-bindings for the EETI EXC3000 driver
with the following example configuration:

Using the I2C address 0x2a of the touch controller in the driver.

Using pin 9 as low level-sensitive interrupt to signal the driver.

Using a 4096x4096 touch screen resolution.

Inverting the x-axis and swapping the result with the y-axis.

Signed-off-by: Ahmet Inan <inan@distec.de>
---
 .../bindings/input/touchscreen/exc3000.txt         | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/exc3000.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt b/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
new file mode 100644
index 000000000000..1dcff4a43eaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
@@ -0,0 +1,27 @@
+* EETI EXC3000 Multiple Touch Controller
+
+Required properties:
+- compatible: must be "eeti,exc3000"
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+- interrupts: touch controller interrupt
+- touchscreen-size-x: See touchscreen.txt
+- touchscreen-size-y: See touchscreen.txt
+
+Optional properties:
+- touchscreen-inverted-x: See touchscreen.txt
+- touchscreen-inverted-y: See touchscreen.txt
+- touchscreen-swapped-x-y: See touchscreen.txt
+
+Example:
+
+	touchscreen@2a {
+		compatible = "eeti,exc3000";
+		reg = <0x2a>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+		touchscreen-size-x = <4096>;
+		touchscreen-size-y = <4096>;
+		touchscreen-inverted-x;
+		touchscreen-swapped-x-y;
+	};
-- 
2.11.0

