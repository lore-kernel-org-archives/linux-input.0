From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 8/9] ARM: dts: sun4i: Add cpu thermal zones to dtsi
Date: Fri,  9 Jan 2015 18:17:55 +0800
Message-ID: <1420798676-22856-9-git-send-email-wens@csie.org>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1420798676-22856-1-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The core temperature sensor now supports thermal zones. Add a thermal
zone mapping for the cpus with passive cooling (cpufreq throttling).

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

changes since v1:

    - Use thermal dt bindings macros in cooling-device

---
 arch/arm/boot/dts/sun4i-a10.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7fb4e912f510..f0dc246dc69e 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -12,6 +12,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/thermal/thermal.h>
+
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -67,6 +69,38 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&rtp>;
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					/* milliCelsius */
+					temperature = <850000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu_crit {
+					/* milliCelsius */
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	memory {
 		reg = <0x40000000 0x80000000>;
 	};
-- 
2.1.4

