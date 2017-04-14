From: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH v2] dt-bindings: input: add bindings document for ar1021_i2c driver
Date: Fri, 14 Apr 2017 08:11:38 +0200
Message-ID: <1492150298-15244-1-git-send-email-martin.kepplinger@ginzinger.com>
References: <20170413204041.lqtqfc24vueo5fbj@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170413204041.lqtqfc24vueo5fbj@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add a simple binding document describing the supported devices and the
I2C bus address.

Signed-off-by: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
---

revision history
----------------
v2: fixed subject line and binding; thanks Rob Herring
v1: initial idea


 .../devicetree/bindings/input/touchscreen/ar1021.txt     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ar1021.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ar1021.txt b/Documentation/devicetree/bindings/input/touchscreen/ar1021.txt
new file mode 100644
index 0000000..e459e85
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ar1021.txt
@@ -0,0 +1,16 @@
+* Microchip AR1020 and AR1021 touchscreen interface (I2C)
+
+Required properties:
+- compatible		: "microchip,ar1021-i2c"
+- reg			: I2C slave address
+- interrupt-parent	: the phandle for the interrupt controller
+- interrupts		: touch controller interrupt
+
+Example:
+
+	touchscreen@4d {
+		compatible = "microchip,ar1021-i2c";
+		reg = <0x4d>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
