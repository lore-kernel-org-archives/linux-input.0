From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V1 08/10] Documentation: dt: thermal: da9062/61 TJUNC
 temperature binding
Date: Thu, 6 Oct 2016 09:43:31 +0100
Message-ID: <3a643792408aa4a15cbf89c4ac9e61a63e443981.1475743411.git.stwiss.opensource@diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1475743411.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Device tree binding information for DA9062 and DA9061 thermal junction
temperature monitor.

Binding descriptions for the DA9061 and DA9062 thermal TJUNC supervisor
device driver, using a single THERMAL_TRIP_HOT trip-wire and allowing for a
configurable polling period for over-temperature polling.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

Hi,

This patch depends on the acceptance of the main code for the onkey:
  [PATCH V1 5/10] thermal: da9061: TJUNC temperature driver

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 .../devicetree/bindings/thermal/da9062-thermal.txt | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
new file mode 100644
index 0000000..338de2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
@@ -0,0 +1,30 @@
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
+- compatible: should be one of:
+        dlg,da9061-thermal
+        dlg,da9062-thermal
+
+Optional properties:
+
+- dlg,tjunc-temp-polling-period-ms : Specify the polling period, measured
+    in milliseconds, between thermal zone device update checks.
+
+Example:
+
+	pmic0: da9062@58 {
+
+		thermal {
+			compatible = "dlg,da9062-thermal";
+			dlg,tjunc-temp-polling-period-ms = <3000>;
+		};
+
+	};
+
-- 
end-of-patch for PATCH V1
