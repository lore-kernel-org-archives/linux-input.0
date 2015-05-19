From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V3 4/4] devicetree: da9062: Add bindings for DA9062 driver
Date: Tue, 19 May 2015 14:10:30 +0100
Message-ID: <67231dc85550f233e15fe5e1a823cfa14e023c57.1432041031.git.stwiss.opensource@diasemi.com>
References: <cover.1432041031.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1432041031.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

Add device tree bindings for the DA9062 driver


Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

---
Changes in V3:
 - No change
 
Changes in V2:
 - Dropped the RTC and Onkey binding information in this patch-set
   Those drivers have been dropped from this patch set and the
   binding information has been removed accordingly.

This patch applies against linux-next and v4.1-rc3 



 Documentation/devicetree/bindings/mfd/da9062.txt | 79 ++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
new file mode 100644
index 0000000..5765ed9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -0,0 +1,79 @@
+* Dialog DA9062 Power Management Integrated Circuit (PMIC)
+
+DA9062 consists of a large and varied group of sub-devices:
+
+Device                   Supply Names    Description
+------                   ------------    -----------
+da9062-regulator        :               : LDOs & BUCKs
+da9062-watchdog         :               : Watchdog Timer
+
+======
+
+Required properties:
+
+- compatible : Should be "dlg,da9062".
+- reg : Specifies the I2C slave address (this defaults to 0x58 but it can be
+  modified to match the chip's OTP settings).
+- interrupt-parent : Specifies the reference to the interrupt controller for
+  the DA9062.
+- interrupts : IRQ line information.
+- interrupt-controller
+
+See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
+further information on IRQ bindings.
+
+Sub-nodes:
+
+- regulators : This node defines the settings for the LDOs and BUCKs. The
+  DA9062 regulators are bound using their names listed below:
+
+    buck1    : BUCK_1
+    buck2    : BUCK_2
+    buck3    : BUCK_3
+    buck4    : BUCK_4
+    ldo1     : LDO_1
+    ldo2     : LDO_2
+    ldo3     : LDO_3
+    ldo4     : LDO_4
+
+  The component follows the standard regulator framework and the bindings
+  details of individual regulator device can be found in:
+  Documentation/devicetree/bindings/regulator/regulator.txt
+
+
+- watchdog: This node defines the settings for the watchdog driver associated
+  with the DA9062 PMIC. The compatible = "dlg,da9062-watchdog" should be added
+  if a node is created.
+
+
+Example:
+
+	pmic0: da9062@58 {
+		compatible = "dlg,da9062";
+		reg = <0x58>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		watchdog {
+			compatible = "dlg,da9062-watchdog";
+		};
+
+		regulators {
+			DA9062_BUCK1: buck1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1570000>;
+				regulator-min-microamp = <500000>;
+				regulator-max-microamp = <2000000>;
+				regulator-boot-on;
+			};
+			DA9062_LDO1: ldo1 {
+				regulator-name = "LDO_1";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-boot-on;
+			};
+		};
+	};
+
-- 
end-of-patch for PATCH V3

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
