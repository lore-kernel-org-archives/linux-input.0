From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v7 1/6] mfd: AXP20x: Add bindings documentation
Date: Sun, 29 Jun 2014 20:23:52 +0200
Message-ID: <1404066237-20234-2-git-send-email-carlo@caione.org>
References: <1404066237-20234-1-git-send-email-carlo@caione.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:50887 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbaF2SYE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jun 2014 14:24:04 -0400
In-Reply-To: <1404066237-20234-1-git-send-email-carlo@caione.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lee.jones@linaro.org, boris.brezillon@free-electrons.com, linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, hdegoede@redhat.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-sunxi@googlegroups.com
Cc: Carlo Caione <carlo@caione.org>

Bindings documentation for the AXP20x driver. In this file also
sub-nodes are documented.

Signed-off-by: Carlo Caione <carlo@caione.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 93 ++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
new file mode 100644
index 0000000..cc9e01b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -0,0 +1,93 @@
+AXP202/AXP209 device tree bindings
+
+The axp20x family current members :-
+axp202 (X-Powers)
+axp209 (X-Powers)
+
+Required properties:
+- compatible: "x-powers,axp202" or "x-powers,axp209"
+- reg: The I2C slave address for the AXP chip
+- interrupt-parent: The parent interrupt controller
+- interrupts: Interrupt specifiers for interrupt sources
+- interrupt-controller: axp20x has its own internal IRQs
+- #interrupt-cells: Should be set to 1
+- acin-supply: The input supply for LDO1
+- vin2-supply: The input supply for DCDC2
+- vin3-supply: The input supply for DCDC3
+- ldo24in-supply: The input supply for LDO2, LDO4
+- ldo3in-supply: The input supply for LDO3
+- ldo5in-supply: The input supply for LDO5
+
+- regulators: A node that houses a sub-node for each regulator. The regulators are
+	      bound using their name as listed here: dcdc2, dcdc3, ldo1, ldo2,
+	      ldo3, ldo4, ldo5.  The bindings details of individual regulator
+	      device can be found in:
+	      Documentation/devicetree/bindings/regulator/regulator.txt with
+	      the exception of x-powers,dcdc-freq
+- x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
+		      (range: 750-1875). Default: 1.5MHz
+
+Optional properties for DCDCs:
+- x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO mode
+			  Default: AUTO mode
+
+Example:
+
+axp209: pmic@34 {
+	compatible = "x-powers,axp209";
+	reg = <0x34>;
+	interrupt-parent = <&nmi_intc>;
+	interrupts = <0 8>;
+
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	acin-supply = <&axp_ipsout_reg>;
+	vin2-supply = <&axp_ipsout_reg>;
+	vin3-supply = <&axp_ipsout_reg>;
+	ldo24in-supply = <&axp_ipsout_reg>;
+	ldo3in-supply = <&axp_ipsout_reg>;
+	ldo5in-supply = <&axp_ipsout_reg>;
+
+	regulators {
+		x-powers,dcdc-freq = <1500>;
+
+		axp_vcore_reg: dcdc2 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <2275000>;
+			regulator-always-on;
+		};
+
+		axp_ddr_reg: dcdc3 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <3500000>;
+			regulator-always-on;
+		};
+
+		axp_rtc_reg: ldo1 {
+			regulator-always-on;
+		};
+
+		axp_analog_reg: ldo2 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		axp_pll_reg: ldo3 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <3500000>;
+		};
+
+		axp_hdmi_reg: ldo4 {
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		axp_mic_reg: ldo5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
+
-- 
1.9.1

