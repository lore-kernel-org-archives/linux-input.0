From: Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 2/2] arm: dts: imx6qdl: snvs-pwrkey: Change compatible string
Date: Tue, 27 Aug 2019 14:32:16 +0200
Message-ID: <20190827123216.32728-2-robin@protonic.nl>
References: <20190827123216.32728-1-robin@protonic.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827123216.32728-1-robin@protonic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Gong <yibin.gong@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree @ vger . kernel . org" <devicetree@vger.kernel.org>, "linux-arm-kernel @ lists . infradead . org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>, "linux-input @ vger . kernel . org" <linux-input@vger.kernel.org>, Adam Ford <aford173@gmail.com>, Robin van der Gracht <robin@protonic.nl>
List-Id: linux-input@vger.kernel.org

The older imx6 SoCs do not send a power key press interrupt, instead it
sends a power down request interrupt when the key is released between
750ms and 5 seconds. The driver uses a different compatible string to ID
the older SoCs.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b3a77bcf00d5..91b97816881c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -836,7 +836,7 @@
 				};
 
 				snvs_pwrkey: snvs-powerkey {
-					compatible = "fsl,sec-v4.0-pwrkey";
+					compatible = "fsl,imx6qdl-snvs-pwrkey";
 					regmap = <&snvs>;
 					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 					linux,keycode = <KEY_POWER>;
-- 
2.20.1
