From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 1/2] ARM: dts: sun4i: gemei-g9: Add touchscreen (Goodix gt801x2) support
Date: Mon,  7 Dec 2015 09:26:00 +0200
Message-ID: <1449473161-3535-2-git-send-email-plaes@plaes.org>
References: <1449473161-3535-1-git-send-email-plaes@plaes.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449473161-3535-1-git-send-email-plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Goodix GT801 2+1 is a touchscreen controller supporting up to
10 touches.

Enable pin and wakeup pin support is currently not implemented:
 - enable pin (PI16, specified in FEX) seems to be wrong
 - wakeup pin needs some additional reverse engineering work

Signed-off-by: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 1d73a98..52e6275 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -48,6 +48,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
 	model = "Gemei G9 Tablet";
@@ -65,11 +66,11 @@
 /*
  * TODO:
  *   2x cameras via CSI
- *   audio input
+ *   audio input (+ ext. amplifier enable GPIO)
  *   AXP battery management
  *   NAND
  *   OTG
- *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
+ *   Touchscreen enable and wakeup pins
  */
 &codec {
 	status = "okay";
@@ -114,6 +115,27 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+
+	touchscreen@55 {
+		compatible = "goodix,gt801_2plus1";
+		reg = <0x55>;
+
+		interrupt-parent = <&pio>;
+		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
+
+		/*
+		 * TODO - figure out the wakeup pin:
+		 *   ctp_wakeup = port:PB13<1><default><default><1>
+		 * TODO - find correct GPIO pin, PI16 seems to be incorrect:
+		 *   ctp_en     = port:PI16<1><default><default><0>
+		 */
+	};
+};
+
 &lradc {
 	vref-supply = <&reg_ldo2>;
 
-- 
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
