From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: [PATCH 2/5] dt-bindings: add binding for Ilitek ili2139
 touchscreen IC
Date: Tue, 11 Oct 2016 08:33:56 +0800
Message-ID: <20161011003359.26079-2-icenowy@aosc.xyz>
References: <20161011003359.26079-1-icenowy@aosc.xyz>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBTPH6C7QKGQEJXWRKCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161011003359.26079-1-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Rask Ingemann Lambertsen <ccc94453-1EA3ORoCGBhoJ7GROcy7lA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Damien Riegel <damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jeffrey Lin <jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Sangwon Jee <jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org>, Siebren Vroegindeweij <siebren.vroegindeweij-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kerne
List-Id: linux-input@vger.kernel.org

Ilitek ili2139 is a touchscreen IC used in several tablet products, for
example, Colorfly E708 Q1.

Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
---
 .../bindings/input/touchscreen/ilitek_ili2139.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ilitek_ili2139.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ilitek_ili2139.txt b/Documentation/devicetree/bindings/input/touchscreen/ilitek_ili2139.txt
new file mode 100644
index 0000000..72d2352
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ilitek_ili2139.txt
@@ -0,0 +1,19 @@
+* Ilitek ili2139 touchscreen controller
+
+Required properties:
+- compatible		  : "ilitek,ili2139"
+- reg			  : I2C slave address of the chip (0x41)
+- interrupt-parent	  : a phandle pointing to the interrupt controller
+			    serving the interrupt for this chip
+- interrupts		  : interrupt specification for the ili2139 interrupt
+
+Example:
+
+i2c@00000000 {
+	ili2139: touchscreen@41 {
+		compatible = "ilitek,ili2139"
+		reg = <0x41>;
+		interrupt-parent = <&pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.10.1
