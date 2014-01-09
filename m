From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko.stuebner@bqreaders.com>
Subject: [PATCH 1/3] dt-bindings: bindings for zforce touchscreens
Date: Thu, 09 Jan 2014 22:21 +0100
Message-ID: <27790911.Z86OudpR5q@phil>
References: <2587208.XYbbI8xJiH@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:34256 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756546AbaAIVVY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jan 2014 16:21:24 -0500
In-Reply-To: <2587208.XYbbI8xJiH@phil>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org

Binding documentation for Neonode zForce infrared touchscreens.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bqreaders.com>
---
 .../bindings/input/touchscreen/zforce_ts.txt       |   30 ++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
new file mode 100644
index 0000000..2f25cd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
@@ -0,0 +1,30 @@
+* Neonode infrared touchscreen controller
+
+Required properties:
+- compatible: must be "neonode,zforce"
+- reg: I2C address of the chip
+- interrupts: interrupt to which the chip is connected
+- gpios: gpios the chip is connected to
+  first one is the interrupt gpio and second one the reset gpio
+- x-size: horizontal resolution of touchscreen
+- y-size: vertical resolution of touchscreen
+
+Example:
+
+	i2c@00000000 {
+		/* ... */
+
+		zforce_ts@50 {
+			compatible = "neonode,zforce";
+			reg = <0x50>;
+			interrupts = <2 0>;
+
+			gpios = <&gpio5 6 0>, /* INT */
+				<&gpio5 9 0>; /* RST */
+
+			x-size = <800>;
+			y-size = <600>;
+		};
+
+		/* ... */
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b458760..e0b15b4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -53,6 +53,7 @@ maxim	Maxim Integrated Products
 microchip	Microchip Technology Inc.
 mosaixtech	Mosaix Technologies, Inc.
 national	National Semiconductor
+neonode		Neonode Inc.
 nintendo	Nintendo
 nvidia	NVIDIA
 nxp	NXP Semiconductors
-- 
1.7.10.4


