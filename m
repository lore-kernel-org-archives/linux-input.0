From: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] dt: add Atmel Captouch bindings
Date: Tue, 10 May 2016 19:07:48 -0700
Message-ID: <1462932469-122552-1-git-send-email-grundler@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Daniel Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

Add binding for Atmel Capacitive Touch Button device.

Signed-off-by: Daniel Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 .../devicetree/bindings/input/atmel,captouch.txt   | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/atmel,captouch.txt

I haven't posted the corresponding device driver and dtsi changes yet but will shortly.

V2: split Documentation/devicetree/bindings from driver patch
    rename "atmel,atmegaxx_captouch" to "atmel,captouch" since it's irrelevant
           which controller implements the register set/controller.

V1: posted https://lkml.org/lkml/2016/5/3/613

diff --git a/Documentation/devicetree/bindings/input/atmel,captouch.txt b/Documentation/devicetree/bindings/input/atmel,captouch.txt
new file mode 100644
index 0000000..405d287
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/atmel,captouch.txt
@@ -0,0 +1,34 @@
+Device tree bindings for Atmel AtmegaXX capacitive touch sensor
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
+	atmel_captouch@51 {
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
