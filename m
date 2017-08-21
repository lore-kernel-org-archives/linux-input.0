From: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Subject: [PATCH v9 2/2] dt-bindings: new binding for ps/2 gpio devices
Date: Mon, 21 Aug 2017 21:31:42 +0200
Message-ID: <20170821193142.29688-3-danilokrummrich@dk-develop.de>
References: <20170821193142.29688-1-danilokrummrich@dk-develop.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170821193142.29688-1-danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The PS/2 gpio device binding defines the gpio pins (data and clock)
as well as the interrupt which should be used to drive the ps/2 bus.
It is expected to get an interrupt on the falling edge of the clock
line.

Also it can be configured whether the host should support writing to
the device.

Signed-off-by: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
---
 .../devicetree/bindings/serio/ps2-gpio.txt         | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt

diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.txt b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
new file mode 100644
index 000000000000..7b7bc9cdf986
--- /dev/null
+++ b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
@@ -0,0 +1,23 @@
+Device-Tree binding for ps/2 gpio device
+
+Required properties:
+	- compatible = "ps2-gpio"
+	- data-gpios: the data pin
+	- clk-gpios: the clock pin
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
