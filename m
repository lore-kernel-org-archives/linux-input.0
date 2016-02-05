From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] ARM: Ux500: add synaptics RMI4 for Ux500 TVK DT
Date: Fri,  5 Feb 2016 13:38:33 +0100
Message-ID: <1454675913-10165-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33265 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbcBEMik (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2016 07:38:40 -0500
Received: by mail-lb0-f171.google.com with SMTP id x4so49589717lbm.0
        for <linux-input@vger.kernel.org>; Fri, 05 Feb 2016 04:38:39 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Christopher Heiny <cheiny@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Linus Walleij <linus.walleij@linaro.org>

This adds the Synaptics RMI4 touchscreen to the Ux500 TVK
user interface board. Tested on the U8500 HREFv60plus with
the TVK UIB.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I will merge this through the ARM SoC tree, just looking for ACKs
from Andrew et al, maybe an indication from Dmitry if the RMI4
stuff will be merged so I can apply this too.
---
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 37 +++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index b7b4211c5353..55f9d0cc90f3 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -37,7 +37,6 @@
 	};
 
 	soc {
-		/* Add Synaptics touch screen, TC35893 keypad etc here */
 		i2c@80004000 {
 			tc35893@44 {
 				compatible = "toshiba,tc35893";
@@ -159,6 +158,33 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 			};
 		};
+
+		i2c@80110000 {
+			synaptics@4b {
+				/* Synaptics RMI4 TM1217 touchscreen */
+				compatible = "syna,rmi4-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x4b>;
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&synaptics_tvk_mode>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
+
+				rmi-f01@1 {
+					reg = <0x1>;
+					syna,nosleep = <1>;
+				};
+				rmi-f11@11 {
+					reg = <0x11>;
+					touchscreen-inverted-x;
+					syna,sensor-type = <1>;
+				};
+			};
+		};
+
 		pinctrl {
 			/* Pull up this GPIO pin */
 			tc35893 {
@@ -212,6 +238,15 @@
 					};
 				};
 			};
+			synaptics {
+				synaptics_tvk_mode: synaptics_tvk {
+					/* Touchscreen uses GPIO 84 */
+					tvk_cfg1 {
+						pins = "GPIO84_C2";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
 		};
 	};
 };
-- 
2.4.3

