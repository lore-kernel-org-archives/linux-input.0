From: Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH v9 12/12] pinctrl: dt-bindings: add bindings for Rockchip RK805 PMIC
Date: Wed,  9 Aug 2017 18:07:53 +0800
Message-ID: <1502273273-12728-1-git-send-email-chenjh@rock-chips.com>
References: <1502273060-12201-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502273060-12201-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, wdc@rock-chips.com, tony.xie@rock-chips.com, linux-input@vger.kernel.org, mark.rutland@arm.com, w.egorov@phytec.de, Joseph Chen <chenjh@rock-chips.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-rk805.txt  | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
new file mode 100644
index 0000000..eee3dc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
@@ -0,0 +1,63 @@
+Pincontrol driver for RK805 Power management IC.
+
+RK805 has 2 pins which can be configured as GPIO output only.
+
+Please refer file <devicetree/bindings/pinctrl/pinctrl-bindings.txt>
+for details of the common pinctrl bindings used by client devices,
+including the meaning of the phrase "pin configuration node".
+
+Optional Pinmux properties:
+--------------------------
+Following properties are required if default setting of pins are required
+at boot.
+- pinctrl-names: A pinctrl state named per <pinctrl-binding.txt>.
+- pinctrl[0...n]: Properties to contain the phandle for pinctrl states per
+		<pinctrl-binding.txt>.
+
+The pin configurations are defined as child of the pinctrl states node. Each
+sub-node have following properties:
+
+Required properties:
+------------------
+- #gpio-cells: Should be two. The first cell is the pin number and the
+  second is the GPIO flags.
+
+- gpio-controller: Marks the device node as a GPIO controller.
+
+- pins: List of pins. Valid values of pins properties are: gpio0, gpio1.
+
+First 2 properties must be added in the RK805 PMIC node, documented in
+Documentation/devicetree/bindings/mfd/rk808.txt
+
+Optional properties:
+-------------------
+Following are optional properties defined as pinmux DT binding document
+<pinctrl-bindings.txt>. Absence of properties will leave the configuration
+on default.
+	function,
+	output-low,
+	output-high.
+
+Valid values for function properties are: gpio.
+
+Theres is also not customised properties for any GPIO.
+
+Example:
+--------
+rk805: rk805@18 {
+	compatible = "rockchip,rk805";
+	...
+	gpio-controller;
+	#gpio-cells = <2>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmic_int_l>, <&rk805_default>;
+
+	rk805_default: pinmux {
+		gpio01 {
+			pins = "gpio0", "gpio1";
+			function = "gpio";
+			output-high;
+		};
+	};
+};
-- 
1.9.1
