From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v3 4/5] ARM: dts: imx6ul.dtsi: add TSC support
Date: Fri, 28 Aug 2015 17:09:35 +0800
Message-ID: <1440752976-9094-5-git-send-email-haibo.chen@freescale.com>
References: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0131.outbound.protection.outlook.com ([207.46.100.131]:17696
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751880AbbH1JHr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 05:07:47 -0400
In-Reply-To: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
Cc: mpa@pengutronix.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, haibo.chen@freescale.com

Add imx6ul touchscreen controller support.

TSC module need ADC2 module to measure the touchscreen
coordinate value. This patch put TSC and ADC2 together,
make ADC2 module only be used for TSC, can't be used as
a normal ADC.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 09edbed..ed86052 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -571,6 +571,17 @@
 				status = "disabled";
 			};
 
+			tsc: tsc@02040000 {
+				compatible = "fsl,imx6ul-tsc";
+				reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_IPG>,
+					 <&clks IMX6UL_CLK_ADC2>;
+				clock-names = "tsc", "adc";
+				status = "disabled";
+			};
+
 			usdhc1: usdhc@02190000 {
 				compatible = "fsl,imx6ul-usdhc", "fsl,imx6sx-usdhc";
 				reg = <0x02190000 0x4000>;
-- 
1.9.1

