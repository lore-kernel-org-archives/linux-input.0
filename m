From: Anthony Felice <tony.felice@timesys.com>
Subject: [PATCH 1/4] ARM: dts: vf610-twr: Enable display controller
Date: Fri, 24 Jun 2016 15:44:43 -0400
Message-ID: <1466797486-31558-2-git-send-email-tony.felice@timesys.com>
References: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, shawnguo@kernel.org, tony.felice@timesys.com
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de, stefan@agner.ch, linux@armlinux.org.uk, fabio.estevam@nxp.com, geert@linux-m68k.org, mwelling@ieee.org, sre@kernel.org, damien.riegel@savoirfairelinux.com, maitysanchayan@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

This adds nodes to enable tcon0 and dcu0 for the Vybrid Tower. These
are used to drive the Vybrid Tower TWR-LCD-RGB display. Also, a node
for the nec nl4827hc19-05b panel on the TWR-LCD-RGB display has been
added.

Signed-off-by: Anthony Felice <tony.felice@timesys.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index cdc1007..ad1aff9 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -66,6 +66,10 @@
 		clock-frequency = <50000000>;
 	};
 
+	panel: panel {
+		compatible = "nec,nl4827hc19-05b";
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -134,6 +138,13 @@
 				 <&clks VF610_CLK_ENET_EXT>;
 };
 
+&dcu0 {
+	fsl,panel = <&panel>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dcu0>;
+	status = "okay";
+};
+
 &dspi0 {
 	bus-num = <0>;
 	pinctrl-names = "default";
@@ -210,6 +221,39 @@
 
 &iomuxc {
 	vf610-twr {
+		pinctrl_dcu0: dcu0grp {
+			fsl,pins = <
+				VF610_PAD_PTE0__DCU0_HSYNC	0x42
+				VF610_PAD_PTE1__DCU0_VSYNC	0x42
+				VF610_PAD_PTE2__DCU0_PCLK	0x42
+				VF610_PAD_PTE4__DCU0_DE		0x42
+				VF610_PAD_PTE5__DCU0_R0		0x42
+				VF610_PAD_PTE6__DCU0_R1		0x42
+				VF610_PAD_PTE7__DCU0_R2		0x42
+				VF610_PAD_PTE8__DCU0_R3		0x42
+				VF610_PAD_PTE9__DCU0_R4		0x42
+				VF610_PAD_PTE10__DCU0_R5	0x42
+				VF610_PAD_PTE11__DCU0_R6	0x42
+				VF610_PAD_PTE12__DCU0_R7	0x42
+				VF610_PAD_PTE13__DCU0_G0	0x42
+				VF610_PAD_PTE14__DCU0_G1	0x42
+				VF610_PAD_PTE15__DCU0_G2	0x42
+				VF610_PAD_PTE16__DCU0_G3	0x42
+				VF610_PAD_PTE17__DCU0_G4	0x42
+				VF610_PAD_PTE18__DCU0_G5	0x42
+				VF610_PAD_PTE19__DCU0_G6	0x42
+				VF610_PAD_PTE20__DCU0_G7	0x42
+				VF610_PAD_PTE21__DCU0_B0	0x42
+				VF610_PAD_PTE22__DCU0_B1	0x42
+				VF610_PAD_PTE23__DCU0_B2	0x42
+				VF610_PAD_PTE24__DCU0_B3	0x42
+				VF610_PAD_PTE25__DCU0_B4	0x42
+				VF610_PAD_PTE26__DCU0_B5	0x42
+				VF610_PAD_PTE27__DCU0_B6	0x42
+				VF610_PAD_PTE28__DCU0_B7	0x42
+			>;
+		};
+
 		pinctrl_adc0_ad5: adc0ad5grp {
 			fsl,pins = <
 				VF610_PAD_PTC30__ADC0_SE5		0xa1
@@ -370,6 +414,10 @@
 	status = "okay";
 };
 
+&tcon0 {
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
2.7.4
