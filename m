From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 6/8] ARM: sunxi: dt: Add x-powers-axp209.dtsi file
Date: Sat, 15 Mar 2014 16:43:43 +0100
Message-ID: <1394898225-28452-7-git-send-email-carlo@caione.org>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBB7KSGMQKGQELH3VUAI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1394898225-28452-1-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This dtsi describes the axp209 PMIC, and is to be included from inside
the i2c controller node to which the axp209 is connected.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/x-powers-axp209.dtsi | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/x-powers-axp209.dtsi

diff --git a/arch/arm/boot/dts/x-powers-axp209.dtsi b/arch/arm/boot/dts/x-powers-axp209.dtsi
new file mode 100644
index 0000000..d272e67
--- /dev/null
+++ b/arch/arm/boot/dts/x-powers-axp209.dtsi
@@ -0,0 +1,60 @@
+/*
+ * x-powers,axp209 common code to be include from inside the axp209 node
+ *
+ * Copyright 2014 - Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+	compatible = "x-powers,axp209";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	regulators {
+		dcdc-freq = "1500";
+
+		axp_dcdc2: dcdc2 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <2275000>;
+			dcdc-workmode = <0>;
+			regulator-always-on;
+		};
+
+		axp_dcdc3: dcdc3 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <3500000>;
+			dcdc-workmode = <0>;
+			regulator-always-on;
+		};
+
+		axp_ldo1: ldo1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		axp_ldo2: ldo2 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		axp_ldo3: ldo3 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <3500000>;
+		};
+
+		axp_ldo4: ldo4 {
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		axp_ldo5: ldo5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
-- 
1.8.3.2
