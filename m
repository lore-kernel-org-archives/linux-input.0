From: <Frank.Li@freescale.com>
Subject: [PATCH v2 4/7] arm: dts: imx: update snvs to use syscon access register
Date: Wed, 20 May 2015 01:04:39 +0800
Message-ID: <1432055082-28983-5-git-send-email-Frank.Li@freescale.com>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bn0104.outbound.protection.outlook.com ([157.56.110.104]:41663
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751104AbbESRIE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2015 13:08:04 -0400
In-Reply-To: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, a.zummo@towertech.it, p.zabel@pengutronix.de, alexandre.belloni@free-electrons.com
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>

From: Frank Li <Frank.Li@freescale.com>

snvs is MFP device. Change dts to use syscon to allocate register resource.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++--------
 arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++--------
 arch/arm/boot/dts/imx6sx.dtsi  | 12 ++++--------
 arch/arm/boot/dts/vfxxx.dtsi   |  9 +++------
 4 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 0482a66..9df9faf 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -687,21 +687,17 @@
 			};
 
 			snvs@020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x020cc000 0x4000>;
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
+				snvs_poweroff: snvs-poweroff {
 					compatible = "fsl,sec-v4.0-poweroff";
-					reg = <0x38 0x4>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index a78e715..99f37f9 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -564,21 +564,17 @@
 			};
 
 			snvs@020cc000 {
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
 					interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>,
 						     <0 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				snvs_poweroff: snvs-poweroff@38 {
+				snvs_poweroff: snvs-poweroff {
 					compatible = "fsl,sec-v4.0-poweroff";
-					reg = <0x38 0x4>;
 					status = "disabled";
 				};
 			};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 708175d..97de407 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -662,20 +662,16 @@
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
+				snvs_poweroff: snvs-poweroff {
 					compatible = "fsl,sec-v4.0-poweroff";
-					reg = <0x38 0x4>;
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

