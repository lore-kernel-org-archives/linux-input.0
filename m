From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 2/3] ARM: dts: at91: sama5d2: add PTC device
Date: Fri, 10 Mar 2017 16:55:28 +0100
Message-ID: <20170310155529.7550-3-ludovic.desroches@atmel.com>
References: <20170310155529.7550-1-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exsmtp02.microchip.com ([198.175.253.38]:8793 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932482AbdCJPzu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 10:55:50 -0500
In-Reply-To: <20170310155529.7550-1-ludovic.desroches@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, nicolas.ferre@microchip.com, Ludovic Desroches <ludovic.desroches@microchip.com>

From: Ludovic Desroches <ludovic.desroches@microchip.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 468ef9c..a958456 100644
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

