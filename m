From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v3 7/9] ARM: dts: sun5i: hsg-h702: add axp209 regulator nodes
Date: Mon, 12 Jan 2015 12:34:07 +0800
Message-ID: <1421037249-28461-8-git-send-email-wens@csie.org>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1421037249-28461-1-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch adds the regulator nodes for the axp209 by including
the axp209 dtsi. As the inputs of these regulators are from the
axp209's PS output, which is basically just a mux over the 2
inputs, it is considered to be unregulated. Thus we do not provide
input supply properties for them.

The regulator names and constraints are based on the board
schematics and the SoC datasheet.

DCDC2 is used as the cpu power supply. This patch also references
it from the cpu node.

LDO3 powers the USB WiFi module. This patch also references it
from the usb-phy node.

Also get rid of axp209 properties already set in axp209.dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

changes since v2:

    none

changes since v1:

    - Use preprocessor include for axp209.dtsi

---
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts | 46 ++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 99a5968720b4..82637db1c55a 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -68,11 +68,7 @@
 		};
 
 		usbphy: phy@01c13400 {
-			/*
-			 * There doesn't seem to be a GPIO for controlling
-			 * usb1 vbus, despite the fex file saying otherwise.
-			 */
-			usb1_vbus-supply = <&reg_vcc5v0>;
+			usb1_vbus-supply = <&reg_ldo3>;
 			status = "okay";
 		};
 
@@ -105,11 +101,8 @@
 			status = "okay";
 
 			axp209: pmic@34 {
-				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupts = <0>;
-				interrupt-controller;
-				#interrupt-cells = <1>;
 			};
 		};
 
@@ -131,3 +124,40 @@
 		};
 	};
 };
+
+#include "axp209.dtsi"
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_ldo3 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
-- 
2.1.4

