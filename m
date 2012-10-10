From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v4 RESEND 3/3] ARM: dts: imx6q-sabrelite: add eeti egalax
Date: Wed, 10 Oct 2012 17:12:03 +0800
Message-ID: <1349860323-12786-4-git-send-email-jason77.wang@gmail.com>
References: <1349860323-12786-1-git-send-email-jason77.wang@gmail.com>
 <1349860323-12786-2-git-send-email-jason77.wang@gmail.com>
 <1349860323-12786-3-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:41175 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab2JJJMR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Oct 2012 05:12:17 -0400
In-Reply-To: <1349860323-12786-3-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com, shawn.guo@linaro.org
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

i.MX6Q sabrelite board uses i2c3 to connect an eeti egalax
touchscreen controller, add it as an i2c slave device in the dts.

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |   16 ++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi          |    9 +++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index d152328..99bef81 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -59,6 +59,7 @@
 							1262 0x80000000 /* MX6Q_PAD_SD3_DAT5__GPIO_7_0 */
 							1270 0x1f0b0	/* MX6Q_PAD_SD3_DAT4__GPIO_7_1 */
 							953  0x80000000	/* MX6Q_PAD_GPIO_0__CCM_CLKO */
+							972  0x10	/* MX6Q_PAD_GPIO_9__GPIO_1_9 */
 						>;
 					};
 				};
@@ -130,6 +131,21 @@
 					VDDIO-supply = <&reg_3p3v>;
 				};
 			};
+
+			i2c@021a8000 { /* I2C3 */
+				status = "okay";
+				clock-frequency = <100000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c3_1>;
+
+				egalax_ts@04 {
+					compatible = "eeti,egalax_ts";
+					reg = <0x04>;
+					interrupt-parent = <&gpio1>;
+					interrupts = <9 8>;
+					wakeup-gpios = <&gpio1 9 0>;
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index f3990b0..8c5d8d9 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -639,6 +639,15 @@
 					};
 				};
 
+				i2c3 {
+					pinctrl_i2c3_1: i2c3grp-1 {
+						fsl,pins = <
+							1013 0x4001b8b1	/* MX6Q_PAD_GPIO_5__I2C3_SCL */
+							1037 0x4001b8b1	/* MX6Q_PAD_GPIO_16__I2C3_SDA */
+						>;
+					};
+				};
+
 				uart1 {
 					pinctrl_uart1_1: uart1grp-1 {
 						fsl,pins = <
-- 
1.7.6

