From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH v11 2/2] mfd: bd71837: Devicetree bindings for ROHM BD71837
 PMIC
Date: Mon, 30 Jul 2018 13:46:37 +0300
Message-ID: <04328e559dcb38b8722248af5a2de028d4237224.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, eballetbo@gmail.com, linus.walleij@linaro.org, mazziesaccount@gmail.com, dmitry.torokhov@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

Document devicetree bindings for ROHM BD71837 PMIC MFD.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
new file mode 100644
index 000000000000..3ca56fdb5ffe
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -0,0 +1,62 @@
+* ROHM BD71837 Power Management Integrated Circuit bindings
+
+BD71837MWV is a programmable Power Management IC for powering single-core,
+dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for
+low BOM cost and compact solution footprint. It integrates 8 Buck
+egulators and 7 LDOs to provide all the power rails required by the SoC and
+the commonly used peripherals.
+
+Datasheet for PMIC is available at:
+https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
+
+Required properties:
+ - compatible		: Should be "rohm,bd71837".
+ - reg			: I2C slave address.
+ - interrupt-parent	: Phandle to the parent interrupt controller.
+ - interrupts		: The interrupt line the device is connected to.
+ - clocks		: The parent clock connected to PMIC. If this is missing
+			  32768 KHz clock is assumed.
+ - #clock-cells		: Should be 0.
+ - regulators:		: List of child nodes that specify the regulators.
+			  Please see ../regulator/rohm,bd71837-regulator.txt
+
+Optional properties:
+- clock-output-names	: Should contain name for output clock.
+
+Example:
+
+	/* external oscillator node */
+	osc: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <1>;
+		clock-frequency  = <32768>;
+		clock-output-names = "osc";
+	};
+
+	pmic: pmic@4b {
+		compatible = "rohm,bd71837";
+		reg = <0x4b>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <29 GPIO_ACTIVE_LOW>;
+		interrupt-names = "irq";
+		#clock-cells = <0>;
+		clocks = <&osc 0>;
+		clock-output-names = "bd71837-32k-out";
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "buck1";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-ramp-delay = <1250>;
+			};
+		};
+	};
+
+	/* Clock consumer node */
+	rtc@0 {
+		compatible = "company,my-rtc";
+		clock-names = "my-clock";
+		clocks = <&pmic>;
+	};
-- 
2.14.3
