From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/4] ARM: dts: sun5i: Add lradc node
Date: Tue, 21 Oct 2014 10:24:49 +0200
Message-ID: <1413879890-7254-4-git-send-email-hdegoede@redhat.com>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBYFQTCRAKGQEVNLIQZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1413879890-7254-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 36 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  7 +++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 36 ++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                 |  7 +++++
 4 files changed, 86 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index ea9519d..84df85e 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 /include/ "sun5i-a10s.dtsi"
 /include/ "sunxi-common-regulators.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Olimex A10s-Olinuxino Micro";
@@ -98,6 +99,41 @@
 			};
 		};
 
+		lradc: lradc@01c22800 {
+			vref-supply = <&reg_vcc3v0>;
+			status = "okay";
+			button@19 {
+				label = "Volume Up";
+				linux,code = <KEY_VOLUMEUP>;
+				channel = <0>;
+				voltage = <191274>;
+			};
+			button@39 {
+				label = "Volume Down";
+				linux,code = <KEY_VOLUMEDOWN>;
+				channel = <0>;
+				voltage = <392644>;
+			};
+			button@60 {
+				label = "Menu";
+				linux,code = <KEY_MENU>;
+				channel = <0>;
+				voltage = <601151>;
+			};
+			button@80 {
+				label = "Enter";
+				linux,code = <KEY_ENTER>;
+				channel = <0>;
+				voltage = <795090>;
+			};
+			button@98 {
+				label = "Home";
+				linux,code = <KEY_HOME>;
+				channel = <0>;
+				voltage = <987387>;
+			};
+		};
+
 		uart0: serial@01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 531272c..a73cec4 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -520,6 +520,13 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		lradc: lradc@01c22800 {
+			compatible = "allwinner,sun4i-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <31>;
+			status = "disabled";
+		};
+
 		sid: eeprom@01c23800 {
 			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 429994e..11ecb36 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 /include/ "sun5i-a13.dtsi"
 /include/ "sunxi-common-regulators.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Olimex A13-Olinuxino";
@@ -66,6 +67,41 @@
 			};
 		};
 
+		lradc: lradc@01c22800 {
+			vref-supply = <&reg_vcc3v0>;
+			status = "okay";
+			button@19 {
+				label = "Volume Up";
+				linux,code = <KEY_VOLUMEUP>;
+				channel = <0>;
+				voltage = <191274>;
+			};
+			button@39 {
+				label = "Volume Down";
+				linux,code = <KEY_VOLUMEDOWN>;
+				channel = <0>;
+				voltage = <392644>;
+			};
+			button@60 {
+				label = "Menu";
+				linux,code = <KEY_MENU>;
+				channel = <0>;
+				voltage = <601151>;
+			};
+			button@80 {
+				label = "Enter";
+				linux,code = <KEY_ENTER>;
+				channel = <0>;
+				voltage = <795090>;
+			};
+			button@98 {
+				label = "Home";
+				linux,code = <KEY_HOME>;
+				channel = <0>;
+				voltage = <987387>;
+			};
+		};
+
 		uart1: serial@01c28400 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pins_b>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index b131068..528d0d6 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -468,6 +468,13 @@
 			reg = <0x01c20c90 0x10>;
 		};
 
+		lradc: lradc@01c22800 {
+			compatible = "allwinner,sun4i-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <31>;
+			status = "disabled";
+		};
+
 		sid: eeprom@01c23800 {
 			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
-- 
2.1.0
