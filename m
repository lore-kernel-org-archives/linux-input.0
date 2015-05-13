From: <Frank.Li@freescale.com>
Subject: [PATCH v2 3/3] arm: dts: imx6sx: enable snvs power key
Date: Wed, 13 May 2015 22:47:42 +0800
Message-ID: <1431528462-21591-3-git-send-email-Frank.Li@freescale.com>
References: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0138.outbound.protection.outlook.com ([65.55.169.138]:11584
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965055AbbEMP42 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 11:56:28 -0400
In-Reply-To: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Frank Li <Frank.Li@freescale.com>

From: Frank Li <Frank.Li@freescale.com>

enable snvs ONOFF power key support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 708175d..f531d18 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -680,6 +680,14 @@
 				};
 			};
 
+			snvs-pwrkey@0x020cc000 {
+				compatible = "fsl,imx6sx-snvs-pwrkey";
+				reg = <0x020cc000 0x4000>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				linux,keycode = <116>; /* KEY_POWER */
+				linux,wakeup;
+			};
+
 			epit1: epit@020d0000 {
 				reg = <0x020d0000 0x4000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1

