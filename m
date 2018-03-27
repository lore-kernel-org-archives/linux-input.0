From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 09/10] ARM: dts: at91: sama5d2: add channel cells for ADC device
Date: Tue, 27 Mar 2018 15:32:42 +0300
Message-ID: <1522153963-1121-10-git-send-email-eugen.hristev@microchip.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Preparing the ADC device to connect channel consumer drivers

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5..f06ba99 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -47,6 +47,7 @@
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
 
 / {
 	model = "Atmel SAMA5D2 family SoC";
@@ -1437,6 +1438,7 @@
 				atmel,max-sample-rate-hz = <20000000>;
 				atmel,startup-time-ms = <4>;
 				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
+				#io-channel-cells = <1>;
 				status = "disabled";
 			};
 
-- 
2.7.4
