From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v2 2/5] Documentation: Detail permitted DT properties for the imx6ul_tsc
Date: Tue, 28 Jul 2015 17:58:38 +0800
Message-ID: <1438077521-12857-3-git-send-email-haibo.chen@freescale.com>
References: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438077521-12857-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com
Cc: haibo.chen@freescale.com, hans.verkuil@cisco.com, hadess@hadess.net, mchehab@osg.samsung.com, mamlinav@gmail.com, arnd@arndb.de, jonathar@broadcom.com, hdegoede@redhat.com, christian.gmeiner@gmail.com, scott.liu@emc.com.tw, geert@linux-m68k.org, benjamin.tissoires@redhat.com, sebastien.szymanski@armadeus.com, sbranden@broadcom.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Here we apply required documentation for the imx6ul touch screen
controller driver which describe available properties and how to
use them.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 .../bindings/input/touchscreen/imx6ul_tsc.txt      | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
new file mode 100644
index 0000000..ac41c32
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
@@ -0,0 +1,36 @@
+* Freescale i.MX6UL Touch Controller
+
+Required properties:
+- compatible: must be "fsl,imx6ul-tsc".
+- reg: this touch controller address and the ADC2 address.
+- interrupts: the interrupt of this touch controller and ADC2.
+- clocks: the root clock of touch controller and ADC2.
+- clock-names; must be "tsc" and "adc".
+- xnur-gpio: the X- gpio this controller connect to.
+  This xnur-gpio returns to high once the finger leave the touch screen (The
+  last touch event the touch controller capture).
+
+Optional properties:
+- measure-delay-time: the value of measure delay time.
+  Before X-axis or Y-axis measurement, the screen need some time before
+  even potential distribution ready.
+  This value depends on the touch screen.
+- pre-charge-time: the touch screen need some time to precharge.
+  This value depends on the touch screen.
+
+Example:
+	tsc: tsc@02040000 {
+		compatible = "fsl,imx6ul-tsc";
+		reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
+		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks IMX6UL_CLK_IPG>,
+			 <&clks IMX6UL_CLK_ADC2>;
+		clock-names = "tsc", "adc";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc>;
+		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+		measure-delay-time = <0xfff>;
+		pre-charge-time = <0xffff>;
+		status = "okay";
+	};
-- 
1.9.1
