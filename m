From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 9/9] ARM: dts: sun4i: cubieboard: add axp209 regulator nodes
Date: Fri,  9 Jan 2015 18:17:56 +0800
Message-ID: <1420798676-22856-10-git-send-email-wens@csie.org>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1420798676-22856-1-git-send-email-wens@csie.org>
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

Also get rid of axp209 properties already set in axp209.dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

changes since v1:

    - Use preprocessor include for axp209.dtsi

---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 87ac84db836d..4260c2b47607 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -137,12 +137,8 @@
 			status = "okay";
 
 			axp209: pmic@34 {
-				compatible = "x-powers,axp209";
 				reg = <0x34>;
 				interrupts = <0>;
-
-				interrupt-controller;
-				#interrupt-cells = <1>;
 			};
 		};
 
@@ -188,3 +184,34 @@
 		status = "okay";
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
+	regulator-max-microvolt = <1450000>;
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
-- 
2.1.4

