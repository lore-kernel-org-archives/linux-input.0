From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v1 1/4] ARM: dts: vfxxx: Add io-channel-cells property for ADC node
Date: Tue, 30 Jun 2015 12:24:45 +0530
Message-ID: <916569b56d60d41f9cd12c5244be3778857a971b.1435646447.git.maitysanchayan@gmail.com>
References: <cover.1435646447.git.maitysanchayan@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33808 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbbF3G5s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jun 2015 02:57:48 -0400
In-Reply-To: <cover.1435646447.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1435646447.git.maitysanchayan@gmail.com>
References: <cover.1435646447.git.maitysanchayan@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@linaro.org, kernel@pengutronix.de, stefan@agner.ch, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sanchayan Maity <maitysanchayan@gmail.com>

This commit adds io-channel-cells property to the ADC node. This
property is required in order for an IIO consumer driver to work.
Especially required for Colibri VF50, as the touchscreen driver
uses ADC channels with the ADC driver based on IIO framework.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2c20f3f..f7d8fb6 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -227,6 +227,7 @@
 				clocks = <&clks VF610_CLK_ADC0>;
 				clock-names = "adc";
 				status = "disabled";
+				#io-channel-cells = <1>;
 			};
 
 			tcon0: tcon@4003d000 {
@@ -461,6 +462,7 @@
 				clocks = <&clks VF610_CLK_ADC1>;
 				clock-names = "adc";
 				status = "disabled";
+				#io-channel-cells = <1>;
 			};
 
 			esdhc1: esdhc@400b2000 {
-- 
2.4.5

