From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 15/17] ARM: dts: sun4i: cubieboard: add axp209 regulator nodes
Date: Tue,  6 Jan 2015 10:35:25 +0800
Message-ID: <1420511727-8242-16-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40999 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbbAFCfs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 21:35:48 -0500
In-Reply-To: <1420511727-8242-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

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
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 140e3ee0c15f..312bb288d764 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -134,12 +134,8 @@
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
 
@@ -185,3 +181,34 @@
 		status = "okay";
 	};
 };
+
+/include/ "axp209.dtsi"
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

