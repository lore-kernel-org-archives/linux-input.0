From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH 2/3] Documentation: devicetree: bindings: add bindings doc for ar1021 driver
Date: Tue, 11 Apr 2017 12:27:58 +0200
Message-ID: <1491906479-17639-2-git-send-email-martin.kepplinger@ginzinger.com>
References: <1491906479-17639-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491906479-17639-1-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, christian.gmeiner@gmail.com
Cc: linux@roeck-us.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

Add a simple binding document highlighting the supported devices and
I2C bus address.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 .../devicetree/bindings/input/touchscreen/ar1021.txt     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ar1021.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ar1021.txt b/Documentation/devicetree/bindings/input/touchscreen/ar1021.txt
new file mode 100644
index 0000000..87a8c72
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ar1021.txt
@@ -0,0 +1,16 @@
+* Microchip AR1020 and AR1021 touchscreen interface (I2C)
+
+Required properties:
+- compatible		: use "microchip,ar1020-i2c" or "microchip,ar1021-i2c"
+- reg			: I2C slave address
+- interrupt-parent	: the phandle for the interrupt controller
+- interrupts		: touch controller interrupt
+
+Example:
+
+	ar1020: ar1020@4d {
+		compatible = "microchip,ar1020-i2c";
+		reg = <0x4d>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
2.1.4
