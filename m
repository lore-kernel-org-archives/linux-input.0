From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v3 4/5] ARM: dts: at91: sama5d2: add PTC subsystem device
Date: Fri, 20 Oct 2017 15:31:20 +0200
Message-ID: <20171020133121.7992-5-ludovic.desroches@microchip.com>
References: <20171020133121.7992-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171020133121.7992-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-input@vger.kernel.org

Add the Atmel Peripheral Touch Controller subsystem.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index b1a26b42d190..04e74013defb 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -840,6 +840,12 @@
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
@@ -1503,6 +1509,16 @@
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
2.12.2
