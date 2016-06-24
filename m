From: Anthony Felice <tony.felice@timesys.com>
Subject: [PATCH 3/4] ARM: dts: vf610-twr: Add crtouch node and pinmux
Date: Fri, 24 Jun 2016 15:44:45 -0400
Message-ID: <1466797486-31558-4-git-send-email-tony.felice@timesys.com>
References: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, shawnguo@kernel.org, tony.felice@timesys.com
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de, stefan@agner.ch, linux@armlinux.org.uk, fabio.estevam@nxp.com, geert@linux-m68k.org, mwelling@ieee.org, sre@kernel.org, damien.riegel@savoirfairelinux.com, maitysanchayan@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

This adds a node for crtouch, the touchscreen controller of the Vybrid
Tower. Pinmux for the gpio irq used by crtouch is also defined in this
commit.

Signed-off-by: Anthony Felice <tony.felice@timesys.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index ad1aff9..5d5cecf 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -217,6 +217,14 @@
 	       VDDIO-supply = <&reg_3p3v>;
 	       clocks = <&clks VF610_CLK_SAI2>;
        };
+
+	touch: crtouch@49 {
+		compatible = "fsl,crtouch_ts";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touchscreen>;
+		reg = <0x49>;
+		irq-gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &iomuxc {
@@ -365,6 +373,12 @@
 			>;
 		};
 
+		pinctrl_touchscreen: touchscreengrp {
+			fsl,pins = <
+				VF610_PAD_PTA31__GPIO_21	0x219d
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				VF610_PAD_PTB4__UART1_TX		0x21a2
-- 
2.7.4
