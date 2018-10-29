From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH v5 1/8] dt-bindings: mfd: document stpmic1
Date: Mon, 29 Oct 2018 16:22:04 +0000
Message-ID: <1540830122-2577-2-git-send-email-p.paillet@st.com>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540830122-2577-1-git-send-email-p.paillet@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
Cc: Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
regulators, 3 power switches, a watchdog and an input for a power on key.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
changes in v5:
* removed st properties
* added buck modes definitions in the header

 .../devicetree/bindings/mfd/st,stpmic1.txt         | 61 ++++++++++++++++++++++
 include/dt-bindings/mfd/st,stpmic1.h               | 50 ++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
 create mode 100644 include/dt-bindings/mfd/st,stpmic1.h

diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.txt b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
new file mode 100644
index 0000000..afd45c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
@@ -0,0 +1,61 @@
+* STMicroelectronics STPMIC1 Power Management IC
+
+Required properties:
+- compatible:		: "st,stpmic1"
+- reg:			: The I2C slave address for the STPMIC1 chip.
+- interrupts:		: The interrupt line the device is connected to.
+- #interrupt-cells:	: Should be 1.
+- interrupt-controller:	: Marks the device node as an interrupt controller.
+			    Interrupt numbers are defined at
+			    dt-bindings/mfd/st,stpmic1.h.
+
+STPMIC1 consists in a varied group of sub-devices.
+Each sub-device binding is be described in own documentation file.
+
+Device			 Description
+------			------------
+st,stpmic1-onkey	: Power on key, see ../input/st,stpmic1-onkey.txt
+st,stpmic1-regulators	: Regulators, see ../regulator/st,stpmic1-regulator.txt
+st,stpmic1-wdt		: Watchdog, see ../watchdog/st,stpmic1-wdt.txt
+
+Example:
+
+#include <dt-bindings/mfd/st,stpmic1.h>
+
+pmic: pmic@33 {
+	compatible = "st,stpmic1";
+	reg = <0x33>;
+	interrupt-parent = <&gpioa>;
+	interrupts = <0 2>;
+
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	onkey {
+		compatible = "st,stpmic1-onkey";
+		interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
+		interrupt-names = "onkey-falling", "onkey-rising";
+		power-off-time-sec = <10>;
+	};
+
+	watchdog {
+		compatible = "st,stpmic1-wdt";
+	};
+
+	regulators {
+		compatible = "st,stpmic1-regulators";
+
+		vdd_core: buck1 {
+			regulator-name = "vdd_core";
+			regulator-boot-on;
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		vdd: buck3 {
+			regulator-name = "vdd";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-pull-down;
+		};
+	};
diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindings/mfd/st,stpmic1.h
new file mode 100644
index 0000000..321cd087
--- /dev/null
+++ b/include/dt-bindings/mfd/st,stpmic1.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Philippe Peurichard <philippe.peurichard@st.com>,
+ * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+ */
+
+#ifndef __DT_BINDINGS_STPMIC1_H__
+#define __DT_BINDINGS_STPMIC1_H__
+
+/* IRQ definitions */
+#define IT_PONKEY_F	0
+#define IT_PONKEY_R	1
+#define IT_WAKEUP_F	2
+#define IT_WAKEUP_R	3
+#define IT_VBUS_OTG_F	4
+#define IT_VBUS_OTG_R	5
+#define IT_SWOUT_F	6
+#define IT_SWOUT_R	7
+
+#define IT_CURLIM_BUCK1	8
+#define IT_CURLIM_BUCK2	9
+#define IT_CURLIM_BUCK3	10
+#define IT_CURLIM_BUCK4	11
+#define IT_OCP_OTG	12
+#define IT_OCP_SWOUT	13
+#define IT_OCP_BOOST	14
+#define IT_OVP_BOOST	15
+
+#define IT_CURLIM_LDO1	16
+#define IT_CURLIM_LDO2	17
+#define IT_CURLIM_LDO3	18
+#define IT_CURLIM_LDO4	19
+#define IT_CURLIM_LDO5	20
+#define IT_CURLIM_LDO6	21
+#define IT_SHORT_SWOTG	22
+#define IT_SHORT_SWOUT	23
+
+#define IT_TWARN_F	24
+#define IT_TWARN_R	25
+#define IT_VINLOW_F	26
+#define IT_VINLOW_R	27
+#define IT_SWIN_F	30
+#define IT_SWIN_R	31
+
+/* BUCK MODES definitions */
+#define STPMIC1_BUCK_MODE_NORMAL 0
+#define STPMIC1_BUCK_MODE_LP 2
+
+#endif /* __DT_BINDINGS_STPMIC1_H__ */
-- 
1.9.1
