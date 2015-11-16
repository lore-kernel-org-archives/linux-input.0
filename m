From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v8 7/8] ARM: dts: imx25: Add TSC and ADC support
Date: Mon, 16 Nov 2015 13:01:08 +0100
Message-ID: <1447675269-8831-8-git-send-email-mpa@pengutronix.de>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47706 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbbKPMB0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 07:01:26 -0500
In-Reply-To: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Denis Carikli <denis@eukrea.com>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <festevam@gmail.com>, Markus Pargmann <mpa@pengutronix.de>

From: Denis Carikli <denis@eukrea.com>

Signed-off-by: Denis Carikli <denis@eukrea.com>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 677f81d9dcd5..7b7fc7dd10bd 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -265,13 +265,37 @@
 				status = "disabled";
 			};
 
-			tsc: tsc@50030000 {
-				compatible = "fsl,imx25-adc", "fsl,imx21-tsc";
-				reg = <0x50030000 0x4000>;
+			tscadc: tscadc@50030000 {
+				compatible = "fsl,imx25-tsadc";
+				reg = <0x50030000 0xc>;
 				interrupts = <46>;
 				clocks = <&clks 119>;
 				clock-names = "ipg";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
 				status = "disabled";
+
+				adc: adc@50030800 {
+					compatible = "fsl,imx25-gcq";
+					reg = <0x50030800 0x60>;
+					interrupt-parent = <&tscadc>;
+					interrupts = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					status = "disabled";
+				};
+
+				tsc: tcq@50030400 {
+					compatible = "fsl,imx25-tcq";
+					reg = <0x50030400 0x60>;
+					interrupt-parent = <&tscadc>;
+					interrupts = <0>;
+					fsl,wires = <4>;
+					status = "disabled";
+				};
 			};
 
 			ssi1: ssi@50034000 {
-- 
2.6.1

