From: <Frank.Li@freescale.com>
Subject: [PATCH 4/7] arm: dts: imx: update snvs to use syscon access register
Date: Fri, 15 May 2015 21:36:27 +0800
Message-ID: <1431696990-23078-5-git-send-email-Frank.Li@freescale.com>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, sachin.kamat@linaro.org, p.zabel@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>
List-Id: linux-input@vger.kernel.org

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
index 0482a66..6d8161d 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -687,21 +687,17 @@
 			};
 
 			snvs@020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x020cc000 0x4000>;
+				compatible = "fsl,sec-v4.0-mon", "syscon",  "simple-bus";
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
index a78e715..2ec9021 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -564,21 +564,17 @@
 			};
 
 			snvs@020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x020cc000 0x4000>;
+				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-bus";
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
index 708175d..7bc5b20 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -662,20 +662,16 @@
 			};
 
 			snvs: snvs@020cc000 {
-				compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x020cc000 0x4000>;
+				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-bus";
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
index 4aa3351..e038378 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -404,14 +404,11 @@
 			};
 
 			snvs0: snvs@400a7000 {
-			    compatible = "fsl,sec-v4.0-mon", "simple-bus";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges = <0 0x400a7000 0x2000>;
+			    compatible = "fsl,sec-v4.0-mon", "syscon", "simple-bus";
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

