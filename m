From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V7 2/7] Documentation: devicetree: thermal: da9062/61 TJUNC
 temperature binding
Date: Tue, 28 Mar 2017 15:43:31 +0100
Message-ID: <c9c52a83336ac508789c25849d2a88296b7b4b3a.1490712213.git.stwiss.opensource@diasemi.com>
References: <cover.1490712213.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490712213.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Device tree binding information for DA9062 and DA9061 thermal junction
temperature monitor.

Binding descriptions for the DA9061 and DA9062 thermal TJUNC supervisor
device driver, using a single THERMAL_TRIP_HOT trip-wire and allowing for
a configurable polling period for over-temperature polling.

This patch also adds two examples, one for DA9062 and one for DA9061. The 
DA9061 example uses a fall-back compatible string for the DA9062.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.11-rc3

v6 -> v7
 - NO CODE CHANGE

v5 -> v6
 - NO CODE CHANGE
 - Rebased from v4.9 to v4.11-rc3
 - Added Acked-by Rob Herring

v4 -> v5
 - Rebased from v4.8 to v4.9
 - Updates from comments by Eduardo Valentin
 - Replace vendor defined dlg,tjunc-temp-polling-period-ms with standard
   thermal core polling-delay-passive as part of the device tree
   initialisation
 - Remove Acked-by Rob Herring

v3 -> v4
 - NO CODE CHANGE
 - Patch renamed from [PATCH V3 3/9] to [PATCH V4 2/8]
 - Added Acked-by Rob Herring

v2 -> v3
 - Patch renamed from [PATCH V2 03/10] to [PATCH V3 3/9]
 - Changes suggested from other component reviews by Rob Herring:
 - Each compatible line should be a valid combination of compatible
   strings: alter DA9061 line to include the fall back compatible string
   and update the commit message accordingly
 - Add e-mail information about associated patches from this set without
   describing them as being explicitly dependent on this binding

v1 -> v2
 - Patch renamed from [PATCH V1 08/10] to [PATCH V2 03/10] -- these
   changes were made to fix checkpatch warnings caused by the patch
   set dependency order
 - A second example for DA9061 is provided to highlight the use of a
   fall-back compatible option for the DA9062

Hi,

No code changes for this version PATCH V5.

As previously:
The device driver from this patch set (associated with this binding) is:
  [PATCH V5 7/8] thermal: da9061: TJUNC temperature driver 

Regards,
Steve Twiss, Dialog Semiconductor


 .../devicetree/bindings/thermal/da9062-thermal.txt | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
new file mode 100644
index 0000000..08cc72e
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
@@ -0,0 +1,37 @@
+* Dialog DA9062/61 TJUNC Thermal Module
+
+This module is part of the DA9061/DA9062. For more details about entire
+DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
+
+Junction temperature thermal module uses an interrupt signal to identify
+high THERMAL_TRIP_HOT temperatures for the PMIC device.
+
+Required properties:
+
+- compatible: should be one of the following valid compatible string lines:
+        "dlg,da9061-thermal", "dlg,da9062-thermal"
+        "dlg,da9062-thermal"
+
+Optional properties:
+
+- polling-delay-passive : Specify the polling period, measured in
+    milliseconds, between thermal zone device update checks.
+
+Example: DA9062
+
+	pmic0: da9062@58 {
+		thermal {
+			compatible = "dlg,da9062-thermal";
+			polling-delay-passive = <3000>;
+		};
+	};
+
+Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
+
+	pmic0: da9061@58 {
+		thermal {
+			compatible = "dlg,da9061-thermal", "dlg,da9062-thermal";
+			polling-delay-passive = <3000>;
+		};
+	};
+
-- 
end-of-patch for PATCH V7
