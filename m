From: Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH v8 2/2] dt-bindings: new binding for ps/2 gpio devices
Date: Mon, 21 Aug 2017 15:31:12 +0200
Message-ID: <20170821133112.22276-3-danilokrummrich@dk-develop.de>
References: <20170821133112.22276-1-danilokrummrich@dk-develop.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821133112.22276-1-danilokrummrich@dk-develop.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, rdunlap@infradead.org, devicetree@vger.kernel.org
Cc: Danilo Krummrich <danilokrummrich@dk-develop.de>
List-Id: linux-input@vger.kernel.org

The PS/2 gpio device binding defines the gpio pins (data and clock)
as well as the interrupt which should be used to drive the ps/2 bus.
It is expected to get an interrupt on the falling edge of the clock
line.

Also it can be configured whether the host should support writing to
the device.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 .../devicetree/bindings/serio/ps2-gpio.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt

diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.txt b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
new file mode 100644
index 000000000000..83e05ea05883
--- /dev/null
+++ b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
@@ -0,0 +1,22 @@
+Device-Tree binding for ps/2 gpio device
+
+Required properties:
+	- compatible = "ps2-gpio"
+	- gpios: data and clock gpio
+	- interrupts: Should trigger on the falling edge of the clock line.
+
+Optional properties:
+	- write-enable: Indicates whether write function is provided
+	to serio device. Possibly providing the write fn will not work, because
+	of the tough timing requirements.
+
+Example nodes:
+
+ps2@0 {
+	compatible = "ps2-gpio";
+	interrupt-parent = <&gpio>;
+	interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+	data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+	clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+	write-enable;
+};
-- 
2.14.1
