From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/4] ARM: dts: sun7i: Add lradc node
Date: Wed,  1 Jan 2014 20:30:10 +0100
Message-ID: <1388604610-20380-5-git-send-email-hdegoede@redhat.com>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBUOZSGLAKGQEOTC2NRQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1388604610-20380-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 7 +++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 0ee2641..dcf9db7 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -86,6 +86,13 @@
 			};
 		};
 
+		lradc: lradc@01c22800 {
+			allwinner,chan0-step = <200>;
+			/* VOLUMEUP VOLUMEDOWN MENU SEARCH HOME ESC ENTER */
+			allwinner,chan0-keycodes = <115 114 139 217 102 1 28>;
+			status = "okay";
+		};
+
 		uart0: serial@01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 68e825a..3484275 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -531,6 +531,13 @@
 			interrupts = <0 24 1>;
 		};
 
+		lradc: lradc@01c22800 {
+			compatible = "allwinner,sun4i-lradc-keys";
+			reg = <0x01c22800 0x100>;
+			interrupts = <0 31 4>;
+			status = "disabled";
+		};
+
 		sid: eeprom@01c23800 {
 			compatible = "allwinner,sun7i-a20-sid";
 			reg = <0x01c23800 0x200>;
-- 
1.8.4.2
