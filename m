From: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v2 4/5] ARM: dts: at91: sama5d2: add PTC subsystem device
Date: Fri, 21 Apr 2017 10:39:23 +0200
Message-ID: <20170421083924.15096-5-ludovic.desroches@microchip.com>
References: <20170421083924.15096-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170421083924.15096-1-ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add the Atmel Peripheral Touch Controller subsystem.

Signed-off-by: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 arch/arm/boot/dts/sama5d2.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 8067c71..fa4ed56 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -762,6 +762,12 @@
 						atmel,clk-output-range = <0 83000000>;
 					};
 
+					ptc_clk: ptc_clk {
+						#clock-cells = <0>;
+						reg = <58>;
+						atmel,clk-output-range = <0 83000000>;
+					};
+
 					classd_clk: classd_clk {
 						#clock-cells = <0>;
 						reg = <59>;
@@ -1310,6 +1316,16 @@
 				reg = <0xfc05c000 0x20>;
 			};
 
+			ptc@fc060000 {
+				compatible = "atmel,sama5d2-ptc";
+				reg = <0x00800000 0x10000
+				       0xfc060000 0xcf>;
+				interrupts = <58 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&ptc_clk>, <&main>, <&clk32k>;
+				clock-names = "ptc_clk", "ptc_int_osc", "slow_clk";
+				status = "disabled";
+			};
+
 			chipid@fc069000 {
 				compatible = "atmel,sama5d2-chipid";
 				reg = <0xfc069000 0x8>;
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
