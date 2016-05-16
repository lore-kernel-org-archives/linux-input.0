From: Grant Grundler <grundler@chromium.org>
Subject: [PATCH 1/2 V3] dt: add Atmel Captouch bindings
Date: Mon, 16 May 2016 13:54:53 -0700
Message-ID: <1463432094-146726-1-git-send-email-grundler@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hung-yu Wu <hywu@google.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, Grant Grundler <grundler@chromium.org>
List-Id: linux-input@vger.kernel.org

From: Daniel Hung-yu Wu <hywu@google.com>

Add binding for Atmel Capacitive Touch Button device.

Signed-off-by: Daniel Hung-yu Wu <hywu@google.com>
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 .../devicetree/bindings/input/atmel,captouch.txt   | 36 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/atmel,captouch.txt

V3: doh! use dash, not underscore in node names. Wordsmith description.

V2: split Documentation/devicetree/bindings from driver patch
    rename "atmel,atmegaxx_captouch" to "atmel,captouch" since it's irrelevant
           which controller implements the register set/controller.

V1: posted https://lkml.org/lkml/2016/5/3/613

diff --git a/Documentation/devicetree/bindings/input/atmel,captouch.txt b/Documentation/devicetree/bindings/input/atmel,captouch.txt
new file mode 100644
index 0000000..405d287
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/atmel,captouch.txt
@@ -0,0 +1,36 @@
+Device tree bindings for Atmel capacitive touch device, typically
+an Atmel touch sensor connected to AtmegaXX MCU running firmware
+based on Qtouch library.
+
+The node for this device must be a child of a I2C controller node, as the
+device communicates via I2C.
+
+Required properties:
+
+	compatible:	Must be "atmel,captouch".
+	reg:		The I2C slave address of the device.
+	interrupts:	Property describing the interrupt line the device
+			is connected to. The device only has one interrupt
+			source.
+	linux,keycodes:	Specifies an array of numeric keycode values to
+			be used for reporting button presses. The array can
+			contain up to 8 entries.
+
+Optional properties:
+
+	autorepeat:	Enables the Linux input system's autorepeat
+			feature on the input device.
+
+Example:
+
+	atmel-captouch@51 {
+		compatible = "atmel,captouch";
+		reg = <0x51>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
+		linux,keycodes = <BTN_0>, <BTN_1>,
+			<BTN_2>, <BTN_3>,
+			<BTN_4>, <BTN_5>,
+			<BTN_6>, <BTN_7>;
+		autorepeat;
+	};
-- 
2.1.2
