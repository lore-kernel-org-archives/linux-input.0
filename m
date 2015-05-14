From: <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 4/7] arm: dts: imx: update snvs to use syscon access register
Date: Fri, 15 May 2015 01:18:50 +0800
Message-ID: <1431623933-3473-5-git-send-email-Frank.Li@freescale.com>
References: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431623933-3473-1-git-send-email-Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lznuaa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

snvs is MFP device. Change dts to use syscon to allocate register resource.

Signed-off-by: Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
