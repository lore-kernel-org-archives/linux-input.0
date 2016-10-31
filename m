From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V3 3/9] Documentation: devicetree: thermal: da9062/61 TJUNC
 temperature binding
Date: Mon, 31 Oct 2016 16:02:03 +0000
Message-ID: <318faafc8021e6adc683e62d57b8c031b9212e0f.1477929725.git.stwiss.opensource@diasemi.com>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1477929725.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Device tree binding information for DA9062 and DA9061 thermal junction
temperature monitor.

Binding descriptions for the DA9061 and DA9062 thermal TJUNC supervisor
device driver, using a single THERMAL_TRIP_HOT trip-wire and allowing for
a configurable polling period for over-temperature polling.

This patch also adds two examples, one for DA9062 and one for DA9061. The 
DA9061 example uses a fall-back compatible string for the DA9062.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

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

The older [PATCH V1 08/10] was acked-by: Rob Herring, however this has
not been added because changes have been made to add a new binding
example. This describes the use of DA9061.
This addition was made after alterations to the device driver meant that a
fall-back compatible string could reuse the DA9062 device driver.

The device driver from this patch set (associated with this binding) is:
  [PATCH V3 8/9] thermal: da9061: TJUNC temperature driver 

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 .../devicetree/bindings/thermal/da9062-thermal.txt | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
new file mode 100644
index 0000000..460ce68
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
+- dlg,tjunc-temp-polling-period-ms : Specify the polling period, measured
+    in milliseconds, between thermal zone device update checks.
+
+Example: DA9062
+
+	pmic0: da9062@58 {
+		thermal {
+			compatible = "dlg,da9062-thermal";
+			dlg,tjunc-temp-polling-period-ms = <3000>;
+		};
+	};
+
+Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
+
+	pmic0: da9061@58 {
+		thermal {
+			compatible = "dlg,da9061-thermal", "dlg,da9062-thermal";
+			dlg,tjunc-temp-polling-period-ms = <3000>;
+		};
+	};
+
-- 
end-of-patch for PATCH V3
