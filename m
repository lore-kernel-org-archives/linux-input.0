From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v3 08/10] ARM: sun7i/sun4i: dt: Add AXP209 support to various boards
Date: Thu, 27 Mar 2014 22:29:22 +0100
Message-ID: <1395955764-18103-9-git-send-email-carlo@caione.org>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1395955764-18103-1-git-send-email-carlo@caione.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: Carlo Caione <carlo@caione.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts           | 13 +++++++++++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 13 +++++++++++++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 19 +++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 13 +++++++++++++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 19 +++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 19 +++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 13 +++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 14 ++++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 15 +++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 14 ++++++++++++++
 10 files changed, 152 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index fa746aea..cf18c4d 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -88,6 +88,19 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x@34 {
+				reg = <0x34>;
+				interrupts = <0>;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 4684cbe..52d21bb 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -80,6 +80,19 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x@34 {
+				reg = <0x34>;
+				interrupts = <0>;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
 		};
 
 		i2c1: i2c@01c2b000 {
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index d7c17e4..3960d67 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -82,6 +82,25 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		i2c0: i2c@01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x@34 {
+				reg = <0x34>;
+				interrupts = <0>;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
+		};
 	};
 
 	reg_emac_3v3: emac-3v3 {
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index fe9272e..c797f5c 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -34,6 +34,19 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x@34 {
+				reg = <0x34>;
+				interrupts = <0>;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
 		};
 
 		usbphy: phy@01c13400 {
diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
index dd84a9e..c61902d 100644
--- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -47,6 +47,25 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		i2c0: i2c@01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x@34 {
+				reg = <0x34>;
+				interrupts = <0>;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
+		};
 	};
 
 	reg_usb1_vbus: usb1-vbus {
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 66cf0c7..7e862d6 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -81,6 +81,25 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		i2c0: i2c@01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x@34 {
+				reg = <0x34>;
+				interrupts = <0>;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
+		};
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 255b47e..8ad0a86 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -66,6 +66,19 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x@34 {
+				reg = <0x34>;
+				interrupts = <0>;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 68de89f..c5c91b8 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -66,6 +66,20 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x@34 {
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
 		};
 
 		i2c1: i2c@01c2b000 {
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index cb25d3c..a42f5bc 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -73,6 +73,21 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x@34 {
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
+
 		};
 
 		i2c1: i2c@01c2b000 {
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index eeadf76..63171c4 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -95,6 +95,20 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x@34 {
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				compatible = "x-powers,axp209";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
 		};
 
 		i2c1: i2c@01c2b000 {
-- 
1.8.3.2

