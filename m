From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 2/9] ARM: dts: sunxi: Add dtsi for AXP209 PMIC
Date: Fri,  9 Jan 2015 18:17:49 +0800
Message-ID: <1420798676-22856-3-git-send-email-wens@csie.org>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:47055 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbbAIKSE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2015 05:18:04 -0500
In-Reply-To: <1420798676-22856-1-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

The AXP209 PMIC is used with some Allwinner SoCs. This patch adds
a dtsi file listing all the regulator nodes. The regulators are
initialized based on their device node names.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

changes since v1:

    - Moved interrupt controller properties to this patch
    - Added default names for all the regulators
    - Removed needless comment above regulators section

---
 arch/arm/boot/dts/axp209.dtsi | 97 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 arch/arm/boot/dts/axp209.dtsi

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
new file mode 100644
index 000000000000..c20cf537f5a5
--- /dev/null
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -0,0 +1,97 @@
+/*
+ * Copyright 2015 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/*
+ * AXP202/209 Integrated Power Management Chip
+ * http://www.x-powers.com/product/AXP20X.php
+ * http://dl.linux-sunxi.org/AXP/AXP209%20Datasheet%20v1.0_cn.pdf
+ */
+
+&axp209 {
+	compatible = "x-powers,axp209";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	regulators {
+		/* Default work frequency for buck regulators */
+		x-powers,dcdc-freq = <1500>;
+
+		reg_dcdc2: dcdc2 {
+			regulator-name = "dcdc2";
+		};
+
+		reg_dcdc3: dcdc3 {
+			regulator-name = "dcdc3";
+		};
+
+		reg_ldo1: ldo1 {
+			/* LDO1 is a fixed output regulator */
+			regulator-always-on;
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-name = "ldo1";
+		};
+
+		reg_ldo2: ldo2 {
+			regulator-name = "ldo2";
+		};
+
+		reg_ldo3: ldo3 {
+			regulator-name = "ldo3";
+		};
+
+		reg_ldo4: ldo4 {
+			regulator-name = "ldo4";
+		};
+
+		reg_ldo5: ldo5 {
+			regulator-name = "ldo5";
+		};
+	};
+};
-- 
2.1.4

