From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v1 4/4] input: Add DT binding documentation for Colibri VF50 touchscreen
Date: Tue, 30 Jun 2015 12:24:48 +0530
Message-ID: <f8b514dc53e5c0e8675bf9afb9040c01558a5386.1435646447.git.maitysanchayan@gmail.com>
References: <cover.1435646447.git.maitysanchayan@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35430 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbbF3G6K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jun 2015 02:58:10 -0400
In-Reply-To: <cover.1435646447.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1435646447.git.maitysanchayan@gmail.com>
References: <cover.1435646447.git.maitysanchayan@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@linaro.org, kernel@pengutronix.de, stefan@agner.ch, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sanchayan Maity <maitysanchayan@gmail.com>

This adds device tree binding documentation for the Colibri VF50
touchscreen driver.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 .../bindings/input/touchscreen/colibri-vf50-ts.txt | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
new file mode 100644
index 0000000..caad52a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
@@ -0,0 +1,34 @@
+* Toradex Colibri VF50 Touchscreen driver
+
+Required Properties:
+- compatible must be toradex,vf50-touchctrl
+- io-channels: adc channels being used by the Colibri VF50 module
+- xp-gpios: FET gate driver for input of X+
+- xm-gpios: FET gate driver for input of X-
+- yp-gpios: FET gate driver for input of Y+
+- ym-gpios: FET gate driver for input of Y-
+- pen-detect-gpios: GPIO for pen detect irq
+- pen-pullup-gpios: GPIO for pen pullup
+- pinctrl-names: "idle", "default", "gpios"
+- pinctrl-0: pinctrl node for idle state gpio pinmux
+- pinctrl-1: pinctrl node for touch detection state pinmux
+- pinctrl-2: pinctrl node for gpios functioning as FET gate drivers
+
+Example:
+
+	touchctrl: vf50_touchctrl {
+		compatible = "toradex,vf50-touchctrl";
+		io-channels = <&adc1 0>,<&adc0 0>,
+				<&adc0 1>,<&adc1 2>;
+		xp-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+		xm-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+		yp-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+		ym-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+		pen-detect-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+		pen-pullup-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "idle","default","gpios";
+		pinctrl-0 = <&pinctrl_touchctrl_idle>;
+		pinctrl-1 = <&pinctrl_touchctrl_default>;
+		pinctrl-2 = <&pinctrl_touchctrl_gpios>;
+		status = "disabled";
+	};
-- 
2.4.5

