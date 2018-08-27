From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v7 RESEND 2/2] ARM: dts: at91: sama5d2: Add resistive touch device
Date: Mon, 27 Aug 2018 16:57:13 +0300
Message-ID: <1535378233-10901-2-git-send-email-eugen.hristev@microchip.com>
References: <1535378233-10901-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535378233-10901-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Add generic resistive touch device which is connected to ADC block
inside the SAMA5D2 SoC

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Resending after merge window that includes the bindings was closed.
Rebased on 4.19-rc1 : no changes

 arch/arm/boot/dts/sama5d2.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index f06ba99..a44f325 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1442,6 +1442,16 @@
 				status = "disabled";
 			};
 
+			resistive_touch: resistive-touch {
+				compatible = "resistive-adc-touch";
+				io-channels = <&adc AT91_SAMA5D2_ADC_X_CHANNEL>,
+					      <&adc AT91_SAMA5D2_ADC_Y_CHANNEL>,
+					      <&adc AT91_SAMA5D2_ADC_P_CHANNEL>;
+				io-channel-names = "x", "y", "pressure";
+				touchscreen-min-pressure = <50000>;
+				status = "disabled";
+			};
+
 			pioA: pinctrl@fc038000 {
 				compatible = "atmel,sama5d2-pinctrl";
 				reg = <0xfc038000 0x600>;
-- 
2.7.4
