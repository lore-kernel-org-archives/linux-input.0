From: <Frank.Li@freescale.com>
Subject: [PATCH v3 6/6] arm: dts: imx6sx: enable snvs power key
Date: Fri, 22 May 2015 00:16:52 +0800
Message-ID: <1432225012-20598-7-git-send-email-Frank.Li@freescale.com>
References: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0118.outbound.protection.outlook.com ([65.55.169.118]:27968
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932335AbbEUQSB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 12:18:01 -0400
In-Reply-To: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>

From: Frank Li <Frank.Li@freescale.com>

enable snvs ONOFF power key support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 3cb3b5b..ad38aea 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -677,6 +677,13 @@
 					mask = <0x60>;
 					status = "disabled";
 				};
+
+				snvs_pwrkey: snvs-powerkey {
+					compatible = "fsl,sec-v4.0-pwrkey";
+					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+					linux,keycode = <116>; /* KEY_POWER */
+					wakeup;
+				};
 			};
 
 			epit1: epit@020d0000 {
-- 
1.9.1

