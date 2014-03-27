From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v3 07/10] ARM: sunxi: dt: Add x-powers-axp209.dtsi file
Date: Thu, 27 Mar 2014 22:29:21 +0100
Message-ID: <1395955764-18103-8-git-send-email-carlo@caione.org>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1395955764-18103-1-git-send-email-carlo@caione.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: Carlo Caione <carlo@caione.org>
List-Id: linux-input@vger.kernel.org

This dtsi describes the axp209 PMIC, and is to be included from inside
the i2c controller node to which the axp209 is connected.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/x-powers-axp209.dtsi | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 arch/arm/boot/dts/x-powers-axp209.dtsi

diff --git a/arch/arm/boot/dts/x-powers-axp209.dtsi b/arch/arm/boot/dts/x-powers-axp209.dtsi
new file mode 100644
index 0000000..b05e54d
--- /dev/null
+++ b/arch/arm/boot/dts/x-powers-axp209.dtsi
@@ -0,0 +1,54 @@
+/*
+ * x-powers,axp209 common code to be include from inside the axp209 node
+ *
+ * Copyright 2014 - Carlo Caione <carlo@caione.org>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+regulators {
+	dcdc-freq = <1500>;
+
+	axp_dcdc2: dcdc2 {
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <2275000>;
+		regulator-always-on;
+	};
+
+	axp_dcdc3: dcdc3 {
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <3500000>;
+		regulator-always-on;
+	};
+
+	axp_ldo1: ldo1 {
+		regulator-min-microvolt = <1300000>;
+		regulator-max-microvolt = <1300000>;
+	};
+
+	axp_ldo2: ldo2 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	axp_ldo3: ldo3 {
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <3500000>;
+	};
+
+	axp_ldo4: ldo4 {
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	axp_ldo5: ldo5 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
-- 
1.8.3.2

