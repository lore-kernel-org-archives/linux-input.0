From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH RFC 2/2] Input: raspberrypi-ts - add devicetree binding documentation
Date: Wed,  5 Dec 2018 23:09:04 +0100
Message-ID: <20181205220902.27682-3-nsaenzjulienne@suse.de>
References: <20181205220902.27682-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205220902.27682-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com, eric@anholt.net, agraf@suse.de, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Adds device tree documentation for Raspberry Pi's official 7"
touchscreen. The firmware mailbox interface allows the ARM core to
control the device.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../touchscreen/raspberrypi,firmware-ts.txt   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
new file mode 100644
index 000000000000..d28189476279
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
@@ -0,0 +1,25 @@
+Raspberry Pi 3 firmware based 7" touchscreen
+=====================================
+
+Required properties:
+ - compatible: "raspberrypi,firmware-ts"
+
+Optional properties:
+ - touchscreen-size-x: See touchscreen.txt
+ - touchscreen-size-y: See touchscreen.txt
+ - touchscreen-inverted-x: See touchscreen.txt
+ - touchscreen-inverted-y: See touchscreen.txt
+ - touchscreen-swapped-x-y: See touchscreen.txt
+
+Example:
+
+firmware: firmware-rpi {
+	compatible = "raspberrypi,bcm2835-firmware", "simple-bus";
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
