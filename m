From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 14/14] ARM: dts: at91: sama5d2: Add resistive touch device
Date: Fri, 22 Dec 2017 17:07:21 +0200
Message-ID: <1513955241-10985-15-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Add the resistive touchscreen device, and the cell numbers to the
ADC device.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index b1a26b4..30b3797 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -402,7 +402,6 @@
 					compatible = "atmel,hlcdc-display-controller";
 					#address-cells = <1>;
 					#size-cells = <0>;
-
 					port@0 {
 						#address-cells = <1>;
 						#size-cells = <0>;
@@ -1431,6 +1430,17 @@
 				atmel,max-sample-rate-hz = <20000000>;
 				atmel,startup-time-ms = <4>;
 				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
+				#io-channel-cells = <1>;
+				#io-trigger-cells = <1>;
+				status = "disabled";
+			};
+
+			resistive_touch: resistive-touch {
+				compatible = "microchip,sama5d2-resistive-touch";
+				io-channels = <&adc 19>, <&adc 20>, <&adc 21>;
+				io-channel-names = "x", "y", "pressure";
+				io-triggers = <&adc 1>;
+				microchip,pressure-threshold = <10000>;
 				status = "disabled";
 			};
 
-- 
2.7.4
