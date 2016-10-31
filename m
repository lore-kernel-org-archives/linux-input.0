From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V3 4/9] Documentation: devicetree: mfd: da9062/61 MFD binding
Date: Mon, 31 Oct 2016 16:02:03 +0000
Message-ID: <502d13b97c67023f2193abfa235e8884eb0ea02f.1477929725.git.stwiss.opensource@diasemi.com>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1477929725.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

Extend existing DA9062 binding information to include the DA9061 PMIC for
MFD core and regulators.

Add a da9062-onkey link to the existing onkey binding file.

Add a da9062-thermal link to the new temperature monitoring binding file.

Delete the da9062-watchdog section and replace it with a link to the new
DA9061/62 binding information file.

Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

---
This patch applies against linux-next and v4.8

v2 -> v3
 - Patch renamed from [PATCH V2 04/10] to [PATCH V3 4/9]
 - Ensure binding description concentrates on the device not the
   device driver
 - Separate the DA9061 and DA9062 sub-device tables to distinguish
   the difference between the two devices
 - Update the commit message to describe this change
 - Add e-mail information about associated patches from this set
   without describing them as being explicitly dependent on this
   binding

v1 -> v2
 - Patch renamed from [PATCH V1 09/10] to [PATCH V2 04/10] -- these
   changes were made to fix checkpatch warnings caused by the patch
   set dependency order

Hi,

Other information:
The device driver from this patch set (associated with this binding) is

- [PATCH V3 1/9] mfd: da9061: MFD core support

and also the following binding file changes:

- [PATCH V3 1/9] Binding for onkey
- [PATCH V3 2/9] Binding for watchdog
- [PATCH V3 3/9] Binding for thermal

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 Documentation/devicetree/bindings/mfd/da9062.txt | 52 ++++++++++++++++++------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index 38802b5..56491c3 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -1,22 +1,39 @@
 * Dialog DA9062 Power Management Integrated Circuit (PMIC)
 
-DA9062 consists of a large and varied group of sub-devices:
+Product information for the DA9062 and DA9061 devices can be found here:
+- http://www.dialog-semiconductor.com/products/da9062
+- http://www.dialog-semiconductor.com/products/da9061
+
+The DA9062 PMIC consists of:
 
 Device                   Supply Names    Description
 ------                   ------------    -----------
 da9062-regulator        :               : LDOs & BUCKs
 da9062-rtc              :               : Real-Time Clock
+da9062-onkey            :               : On Key
+da9062-watchdog         :               : Watchdog Timer
+da9062-thermal          :               : Thermal
+
+The DA9061 PMIC consists of:
+
+Device                   Supply Names    Description
+------                   ------------    -----------
+da9062-regulator        :               : LDOs & BUCKs
+da9062-onkey            :               : On Key
 da9062-watchdog         :               : Watchdog Timer
+da9062-thermal          :               : Thermal
 
 ======
 
 Required properties:
 
-- compatible : Should be "dlg,da9062".
+- compatible : Should be
+    "dlg,da9062" for DA9062
+    "dlg,da9061" for DA9061
 - reg : Specifies the I2C slave address (this defaults to 0x58 but it can be
   modified to match the chip's OTP settings).
 - interrupt-parent : Specifies the reference to the interrupt controller for
-  the DA9062.
+  the DA9062 or DA9061.
 - interrupts : IRQ line information.
 - interrupt-controller
 
@@ -25,8 +42,8 @@ further information on IRQ bindings.
 
 Sub-nodes:
 
-- regulators : This node defines the settings for the LDOs and BUCKs. The
-  DA9062 regulators are bound using their names listed below:
+- regulators : This node defines the settings for the LDOs and BUCKs.
+  The DA9062 regulators are bound using their names listed below:
 
     buck1    : BUCK_1
     buck2    : BUCK_2
@@ -37,6 +54,16 @@ Sub-nodes:
     ldo3     : LDO_3
     ldo4     : LDO_4
 
+  The DA9061 regulators are bound using their names listed below:
+
+    buck1    : BUCK_1
+    buck2    : BUCK_2
+    buck3    : BUCK_3
+    ldo1     : LDO_1
+    ldo2     : LDO_2
+    ldo3     : LDO_3
+    ldo4     : LDO_4
+
   The component follows the standard regulator framework and the bindings
   details of individual regulator device can be found in:
   Documentation/devicetree/bindings/regulator/regulator.txt
@@ -46,9 +73,14 @@ Sub-nodes:
   with the DA9062. There are currently no entries in this binding, however
   compatible = "dlg,da9062-rtc" should be added if a node is created.
 
-- watchdog: This node defines the settings for the watchdog driver associated
-  with the DA9062 PMIC. The compatible = "dlg,da9062-watchdog" should be added
-  if a node is created.
+
+- onkey : See ../input/da9062-onkey.txt
+
+
+- watchdog: See ../watchdog/da9062-watchdog.txt
+
+
+- thermal : See ../thermal/da9062-thermal.txt
 
 
 Example:
@@ -64,10 +96,6 @@ Example:
 			compatible = "dlg,da9062-rtc";
 		};
 
-		watchdog {
-			compatible = "dlg,da9062-watchdog";
-		};
-
 		regulators {
 			DA9062_BUCK1: buck1 {
 				regulator-name = "BUCK1";
-- 
end-of-patch for PATCH V3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
