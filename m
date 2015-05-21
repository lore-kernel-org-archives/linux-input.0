From: <Frank.Li@freescale.com>
Subject: [PATCH v3 3/6] arm: dts: imx: update snvs to use syscon access register
Date: Fri, 22 May 2015 00:16:49 +0800
Message-ID: <1432225012-20598-4-git-send-email-Frank.Li@freescale.com>
References: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0127.outbound.protection.outlook.com ([207.46.100.127]:5872
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756456AbbEUQRu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 12:17:50 -0400
In-Reply-To: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>

From: Frank Li <Frank.Li@freescale.com>

snvs is MFP device. Change dts to use syscon to allocate register resource.
snvs power off also switch to common syscon-poweroff

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 19 +++++++++----------
 arch/arm/boot/dts/imx6sl.dtsi  | 19 +++++++++----------
 arch/arm/boot/dts/imx6sx.dtsi  | 17 ++++++++---------
 arch/arm/boot/dts/vfxxx.dtsi   |  9 +++------
 4 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 0482a66..4f3f5f4 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -686,22 +686,21 @@
 				fsl,anatop = <&anatop>;
 			};
 
-			snvs@020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x020cc000 0x4000>;
+			snvs:snvs@020cc000 {
+				compatible = "fsl,sec-v4.0-mon", "syscon",  "simple-mfd";
+				reg = <0x020cc000 0x4000>;
 
-				snvs_rtc: snvs-rtc-lp@34 {
+				snvs_rtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					reg = <0x34 0x58>;
 					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				snvs_poweroff: snvs-poweroff@38 {
-					compatible = "fsl,sec-v4.0-poweroff";
-					reg = <0x38 0x4>;
+				snvs_poweroff: snvs-poweroff {
+					compatible = "syscon-poweroff";
+					regmap = <&snvs>;
+					offset = <0x38>;
+					mask = <0x60>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index a78e715..2de6d46 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -563,22 +563,21 @@
 				fsl,anatop = <&anatop>;
 			};
 
-			snvs@020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x020cc000 0x4000>;
+			snvs:snvs@020cc000 {
+				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg = <0x020cc000 0x4000>;
 
-				snvs_rtc: snvs-rtc-lp@34 {
+				snvs_rtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					reg = <0x34 0x58>;
 					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				snvs_poweroff: snvs-poweroff@38 {
-					compatible = "fsl,sec-v4.0-poweroff";
-					reg = <0x38 0x4>;
+				snvs_poweroff: snvs-poweroff {
+					compatible = "syscon-poweroff";
+					regmap = <&snvs>;
+					offset = <0x38>;
+					mask = <0x60>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 708175d..3cb3b5b 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -662,20 +662,19 @@
 			};
 
 			snvs: snvs@020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x020cc000 0x4000>;
+				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg = <0x020cc000 0x4000>;
 
-				snvs_rtc: snvs-rtc-lp@34 {
+				snvs_rtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					reg = <0x34 0x58>;
 					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				snvs_poweroff: snvs-poweroff@38 {
-					compatible = "fsl,sec-v4.0-poweroff";
-					reg = <0x38 0x4>;
+				snvs_poweroff: snvs-poweroff {
+					compatible = "syscon-poweroff";
+					regmap = <&snvs>;
+					offset = <0x38>;
+					mask = <0x60>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 4aa3351..fccfc01 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -404,14 +404,11 @@
 			};
 
 			snvs0: snvs@400a7000 {
-			    compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x400a7000 0x2000>;
+			    compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg = <0x400a7000 0x2000>;
 
-				snvsrtc: snvs-rtc-lp@34 {
+				snvsrtc: snvs-rtc-lp {
 					compatible = "fsl,sec-v4.0-mon-rtc-lp";
-					reg = <0x34 0x58>;
 					interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks VF610_CLK_SNVS>;
 					clock-names = "snvs-rtc";
-- 
1.9.1

