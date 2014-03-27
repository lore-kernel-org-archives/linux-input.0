From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 03/10] mfd: AXP20x: Add bindings documentation
Date: Thu, 27 Mar 2014 22:29:17 +0100
Message-ID: <1395955764-18103-4-git-send-email-carlo@caione.org>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBB3FP2KMQKGQEY2TWMKI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1395955764-18103-1-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Bindings documentation for the AXP20x driver. In this file also
sub-nodes are documented.

Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 83 ++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
new file mode 100644
index 0000000..ebc6772
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -0,0 +1,83 @@
+* axp20x device tree bindings
+
+The axp20x family current members :-
+axp202 (X-Powers)
+axp209 (X-Powers)
+
+Required properties:
+- compatible 			: Should be "x-powers,axp202" or "x-powers,axp209"
+- interrupt-controller 		: axp20x has its own internal IRQs
+- #interrupt-cells 		: Should be set to 1
+- interrupt-parent 		: The parent interrupt controller
+- interrupts 			: Interrupt specifiers for interrupt sources
+- reg 				: The I2C slave address for the AXP chip
+
+Sub-nodes:
+* regulators : Contain the regulator nodes. The regulators are bound using
+	       their name as listed here: dcdc2, dcdc3, ldo1, ldo2, ldo3,
+	       ldo4, ldo5.
+	       The bindings details of individual regulator device can be found in:
+	       Documentation/devicetree/bindings/regulator/regulator.txt with the
+	       exception of:
+
+	- x-powers,dcdc-freq	: defines the work frequency of DC-DC in KHz
+				  (range: 750-1875). Default: 1.5MHz
+
+	For each DCDC:
+		- x-powers,dcdc-workmode: Optional. 1 for PWM mode, 0 for AUTO mode
+				  	  Default: AUTO mode
+
+Example:
+
+axp: axp20x@34 {
+	reg = <0x34>;
+	interrupt-parent = <&nmi_intc>;
+	interrupts = <0 8>;
+
+	compatible = "x-powers,axp209";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	regulators {
+		dcdc-freq = <1500>;
+
+		axp_dcdc2: dcdc2 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <2275000>;
+			regulator-always-on;
+		};
+
+		axp_dcdc3: dcdc3 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <3500000>;
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
+};
+
-- 
1.8.3.2
