From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v3 5/5] ARM: dts: imx6ul-14x14-evk.dts: add tsc support
Date: Fri, 28 Aug 2015 17:09:36 +0800
Message-ID: <1440752976-9094-6-git-send-email-haibo.chen@freescale.com>
References: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
Cc: mpa@pengutronix.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, haibo.chen@freescale.com
List-Id: linux-input@vger.kernel.org

Add touch screen surpport for i.MX6UL-EVK board.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 25746b1..f7ad467 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -87,6 +87,15 @@
 	};
 };
 
+&tsc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tsc>;
+	xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	measure-delay-time = <0xffff>;
+	pre-charge-time = <0xfff>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -277,6 +286,15 @@
 		>;
 	};
 
+	pinctrl_tsc: tscgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01		0xb0
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02		0xb0
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0xb0
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04		0xb0
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX 0x1b0b1
-- 
1.9.1
