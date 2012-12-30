From: Liu Ying <Ying.Liu@freescale.com>
Subject: [PATCH 2/3] ARM: dts: imx: Add imx51 KPP entry
Date: Sun, 30 Dec 2012 21:09:05 +0800
Message-ID: <1356872946-2810-2-git-send-email-Ying.Liu@freescale.com>
References: <1356872946-2810-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1356872946-2810-1-git-send-email-Ying.Liu@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com, shawn.guo@linaro.org, s.hauer@pengutronix.de, linus.walleij@linaro.org, cjb@laptop.org, broonie@opensource.wolfsonmicro.com
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, liu.y.victor@gmail.com, Liu Ying <Ying.Liu@freescale.com>
List-Id: linux-input@vger.kernel.org

1) Add KPP device node entry.
2) Add one KPP pinctrl entry.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 arch/arm/boot/dts/imx51.dtsi |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 1f5d45e..3150a31 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -221,6 +221,14 @@
 				#interrupt-cells = <2>;
 			};
 
+			kpp: kpp@73f94000 {
+				compatible = "fsl,imx-kpp";
+				reg = <0x73f94000 0x4000>;
+				interrupts = <60>;
+				clocks = <&clks 0>;
+				status = "disabled";
+			};
+
 			wdog1: wdog@73f98000 {
 				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
 				reg = <0x73f98000 0x4000>;
@@ -410,6 +418,20 @@
 						>;
 					};
 				};
+				kpp {
+					pinctrl_kpp_1: kppgrp-1 {
+						fsl,pins = <
+							438 0xe0	/* MX51_PAD_KEY_ROW0__KEY_ROW0 */
+							439 0xe0	/* MX51_PAD_KEY_ROW1__KEY_ROW1 */
+							440 0xe0	/* MX51_PAD_KEY_ROW2__KEY_ROW2 */
+							441 0xe0	/* MX51_PAD_KEY_ROW3__KEY_ROW3 */
+							442 0xe8	/* MX51_PAD_KEY_COL0__KEY_COL0 */
+							444 0xe8	/* MX51_PAD_KEY_COL1__KEY_COL1 */
+							446 0xe8	/* MX51_PAD_KEY_COL2__KEY_COL2 */
+							448 0xe8	/* MX51_PAD_KEY_COL3__KEY_COL3 */
+						>;
+					};
+				};
 			};
 
 			pwm1: pwm@73fb4000 {
-- 
1.7.1


