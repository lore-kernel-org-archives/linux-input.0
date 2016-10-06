From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V1 07/10] Documentation: dt: watchdog: da9062/61 Watchdog
 timer binding
Date: Thu, 6 Oct 2016 09:43:31 +0100
Message-ID: <6e2e5600560d0bad024e845221d5e04b93d8cd68.1475743411.git.stwiss.opensource@diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1475743411.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Wim Van Sebroeck <wim@iguana.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Add binding information for DA9062 and DA9061 watchdog.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

Hi,

This patch depends on the acceptance of DA9061 watchdog driver:
  [PATCH V1 4/10] watchdog: da9061: watchdog driver

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
new file mode 100644
index 0000000..eac0062
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
@@ -0,0 +1,11 @@
+* Dialog Semiconductor DA9062/61 Watchdog Timer
+
+Required properties:
+- compatible: "dlg,da9062-watchdog"
+              "dlg,da9061-watchdog"
+
+Example:
+	watchdog {
+		compatible = "dlg,da9062-watchdog";
+	};
+
-- 
end-of-patch for PATCH V1
