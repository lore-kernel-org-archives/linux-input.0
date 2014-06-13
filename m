From: Denis Carikli <denis@eukrea.com>
Subject: [PATCH v2 4/6] ARM: dts: imx25: Add touchscreen support
Date: Fri, 13 Jun 2014 17:21:37 +0200
Message-ID: <1402672899-6995-5-git-send-email-denis@eukrea.com>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1402672899-6995-1-git-send-email-denis@eukrea.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:15368 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbaFMPVq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Jun 2014 11:21:46 -0400
In-Reply-To: <1402672899-6995-1-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Markus Pargmann <mpa@pengutronix.de>, Denis Carikli <denis@eukrea.com>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 98783f5..5564167 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -264,12 +264,17 @@
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
 			};
 
-- 
1.7.9.5

