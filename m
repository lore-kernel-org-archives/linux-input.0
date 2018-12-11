From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 1/2] dt-bindings: input: Add Raspberry Pi Touchscreen
Date: Tue, 11 Dec 2018 12:23:53 +0100
Message-ID: <20181211112408.9524-2-nsaenzjulienne@suse.de>
References: <20181211112408.9524-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211112408.9524-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com, eric@anholt.net, agraf@suse.de, afaerber@suse.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Adds device tree documentation for Raspberry Pi's official 7"
touchscreen.

This binding is meant to be used as an overlay.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../touchscreen/raspberrypi,firmware-ts.txt   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
new file mode 100644
index 000000000000..2a1af240ccc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
@@ -0,0 +1,26 @@
+Raspberry Pi firmware based 7" touchscreen
+=====================================
+
+Required properties:
+ - compatible: "raspberrypi,firmware-ts"
+
+Optional properties:
+ - firmware: Reference to RPi's firmware device node
+ - touchscreen-size-x: See touchscreen.txt
+ - touchscreen-size-y: See touchscreen.txt
+ - touchscreen-inverted-x: See touchscreen.txt
+ - touchscreen-inverted-y: See touchscreen.txt
+ - touchscreen-swapped-x-y: See touchscreen.txt
+
+Example:
+
+firmware: firmware-rpi {
+	compatible = "raspberrypi,bcm2835-firmware";
+	mboxes = <&mailbox>;
+
+	ts: touchscreen {
+		compatible = "raspberrypi,firmware-ts";
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+	};
+};
-- 
2.19.2
