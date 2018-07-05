From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 3/8] dt-bindings: regulator: document stpmu1 pmic regulators
Date: Thu, 5 Jul 2018 15:14:23 +0000
Message-ID: <1530803657-17684-4-git-send-email-p.paillet@st.com>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Cc: Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

The STPMU1 regulators supply power to the application processor as well as
to the external system peripherals such as DDR, Flash memories and system
devices.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 .../bindings/regulator/st,stpmu1-regulator.txt     | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt
new file mode 100644
index 0000000..888e759
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt
@@ -0,0 +1,72 @@
+STMicroelectronics STPMU1 Voltage regulators
+
+Regulator Nodes are optional depending on needs.
+
+Available Regulators in STPMU1 device are:
+  - buck1 for Buck BUCK1
+  - buck2 for Buck BUCK2
+  - buck3 for Buck BUCK3
+  - buck4 for Buck BUCK4
+  - ldo1 for LDO LDO1
+  - ldo2 for LDO LDO2
+  - ldo3 for LDO LDO3
+  - ldo4 for LDO LDO4
+  - ldo5 for LDO LDO5
+  - ldo6 for LDO LDO6
+  - vref_ddr for LDO Vref DDR
+  - boost for Buck BOOST
+  - pwr_sw1 for VBUS_OTG switch
+  - pwr_sw2 for SW_OUT switch
+
+Switches are fixed voltage regulators with only enable/disable capability.
+
+Optional properties:
+- st,mask_reset: stay on during Reset for particular regulator
+- regulator-pull-down: enable high pull down
+  if not specified light pull down is used
+- regulator-over-current-protection:
+    if set, all regulators are switched off in case of over-current detection
+    on this regulator,
+    if not set, the driver only send an over-current event.
+- interrupt-parent: phandle to the parent interrupt controller
+- interrupts: index of current limit detection interrupt
+- <regulator>-supply: phandle to the parent supply/regulator node
+	each regulator supply can be described except vref_ddr.
+
+Example:
+regulators {
+	compatible = "st,stpmu1-regulators";
+
+	ldo6-supply = <&v3v3>;
+
+	vdd_core: regulator@0 {
+		regulator-compatible = "buck1";
+		regulator-name = "vdd_core";
+		interrupts = <IT_CURLIM_BUCK1 0>;
+		interrupt-parent = <&pmic>;
+		st,mask_reset;
+		regulator-pull-down;
+		st,pulldown_config = <2>;
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	v3v3: buck4 {
+		regulator-compatible = "buck4";
+		regulator-name = "v3v3";
+		interrupts = <IT_CURLIM_BUCK4 0>;
+		interrupt-parent = <&mypmic>;
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	v1v8: ldo6 {
+		regulator-compatible = "ldo6";
+		regulator-name = "v1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-over-current-protection;
+	};
+
+};
-- 
1.9.1
