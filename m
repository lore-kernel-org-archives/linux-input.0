From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: [PATCH 5/5] ARM: dts: sun6i: enable ili2139 on Colorfly
 E708 Q1
Date: Tue, 11 Oct 2016 08:33:59 +0800
Message-ID: <20161011003359.26079-5-icenowy@aosc.xyz>
References: <20161011003359.26079-1-icenowy@aosc.xyz>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBUHI6C7QKGQE2AUPV3Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Many users report that their Colorfly E708 Q1's come with ili2139 touch
IC. This patch adds the device node of this IC.

It seems that two devices are attached to I2C bus 1: a ili2139 touch
controller at 0x41, and a stil unknown device at 0x38. So make PA2
controlled by a dummy regulator node, rather than a power sequence GPIO
for ili2139.

There's also some users who report that their tablets come with touch
screen with Goodix GT911 touch IC. In the device, the touch IC is
connected on the screen rather soldered on the PCB, so the two touch
screens may be both acceptable FRUs of the tablet. They have different
addresses, and may be runtime detectable. (The Allwinner BSP kernel have
such a detection method, however, mainline kernel have no such method
now except enable both touch ICs' driver and wait for one driver's
failure)

Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
---
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
index 882a4d8..73ac574 100644
--- a/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
@@ -47,6 +47,38 @@
 / {
 	model = "Colorfly E708 Q1 tablet";
 	compatible = "colorfly,e708-q1", "allwinner,sun6i-a31s";
+
+	/* This is actually a common reset line for both the
+	 * touchscreen and the accelerometer.
+	 */
+	i2c1_on: i2c1_on {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_on_e708_q1>;
+
+		regulator-name = "i2c1_on";
+		regulator-min-microvolt = "3000000";
+		regulator-max-microvolt = "3000000";
+		regulator-always-on;
+		gpio = <&pio 0 2 GPIO_ACTIVE_HIGH>; /* PA2 */
+		enable-active-high;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+
+	ctp@41 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&ili2139_int_e708_q1>;
+
+		compatible = "ilitek,ili2139", "ili2139";
+		reg = <0x41>;
+		interrupt-parent = <&pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>; /* PA3 */
+	};
 };
 
 &lradc {
@@ -61,6 +93,22 @@
 	};
 };
 
+&pio {
+	i2c1_on_e708_q1: i2c1_on@0 {
+		allwinner,pins = "PA2";
+	        allwinner,function = "gpio_out";
+	        allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+	        allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	ili2139_int_e708_q1: ili2139_int@0 {
+		allwinner,pins = "PA3";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
 &reg_dldo2 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
2.10.1
