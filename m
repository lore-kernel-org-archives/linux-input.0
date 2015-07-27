From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH 5/5] ARM: dts: imx6ul-14x14-evk.dts: add tsc support
Date: Mon, 27 Jul 2015 19:26:47 +0800
Message-ID: <1437996407-27266-6-git-send-email-haibo.chen@freescale.com>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bbn0101.outbound.protection.outlook.com ([157.56.111.101]:31424
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753166AbbG0LY2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 07:24:28 -0400
In-Reply-To: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com
Cc: haibo.chen@freescale.com, hans.verkuil@cisco.com, hadess@hadess.net, mchehab@osg.samsung.com, mamlinav@gmail.com, arnd@arndb.de, jonathar@broadcom.com, hdegoede@redhat.com, christian.gmeiner@gmail.com, scott.liu@emc.com.tw, geert@linux-m68k.org, benjamin.tissoires@redhat.com, sebastien.szymanski@armadeus.com, sbranden@broadcom.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Add touch screen surpport for i.MX6UL-EVK board.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 61b41ee..323d32d 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -44,6 +44,15 @@
 	soc-supply = <&reg_soc>;
 };
 
+&tsc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tsc>;
+	status = "okay";
+	xnur-gpio = <&gpio1 3 0>;
+	measure_delay_time = <0xffff>;
+	pre_charge_time = <0xfff>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -212,6 +221,15 @@
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

