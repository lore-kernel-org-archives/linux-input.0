From: <Frank.Li@freescale.com>
Subject: [PATCH 6/7] document: devicetree: input: imx: i.mx snvs power device tree bindings
Date: Fri, 15 May 2015 01:18:52 +0800
Message-ID: <1431623933-3473-7-git-send-email-Frank.Li@freescale.com>
References: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>, Robin Gong <b38343@freescale.com>
List-Id: linux-input@vger.kernel.org

From: Frank Li <Frank.Li@freescale.com>

The snvs-pwrkey is designed to enable POWER key function which controlled
by SNVS ONOFF. the driver can report the status of POWER key and wakeup
system if pressed after system suspend.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
Signed-off-by: Robin Gong <b38343@freescale.com>
---
 .../devicetree/bindings/crypto/fsl-sec4.txt        | 42 ++++++++++++++++++++++
 .../devicetree/bindings/input/snvs-pwrkey.txt      |  1 +
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
index ca04206..99a57b7 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
@@ -394,6 +394,41 @@ EXAMPLE
 };
 
 =====================================================================
+System ON/OFF key driver
+
+  The snvs-pwrkey is designed to enable POWER key function which controlled
+  by SNVS ONOFF, the driver can report the status of POWER key and wakeup
+  system if pressed after system suspend.
+
+  - compatible:
+      Usage: required
+      Value type: <string>
+      Definition: Mush include "fsl,sec-v4.0-pwrkey".
+
+  - interrupts:
+      Usage: required
+      Value type: <prop_encoded-array>
+      Definition: The SNVS ON/OFF interrupt number to the CPU(s).
+
+  - linux,keycode:
+      Usage: option
+      Value type: <int>
+      Definition: Keycode to emit, KEY_POWER by default.
+
+  - wakeup:
+      Usage: option
+      Value type: <boo>
+      Definition: Button can wake-up the system
+
+EXAMPLE:
+	snvs-pwrkey@0x020cc000 {
+		compatible = "fsl,sec-v4.0-pwrkey";
+		interrupts = <0 4 0x4>
+	        linux,keycode = <116>; /* KEY_POWER */
+		wakeup;
+	};
+
+=====================================================================
 FULL EXAMPLE
 
 	crypto: crypto@300000 {
@@ -475,6 +510,13 @@ FULL EXAMPLE
 		snvs_poweroff: snvs-poweroff@38 {
                         compatible = "fsl,sec-v4.0-poweroff";
                 };
+
+		snvs-pwrkey@0x020cc000 {
+			compatible = "fsl,sec-v4.0-pwrkey";
+			interrupts = <0 4 0x4>;
+			linux,keycode = <116>; /* KEY_POWER */
+			wakeup;
+		};
 	};
 
 =====================================================================
diff --git a/Documentation/devicetree/bindings/input/snvs-pwrkey.txt b/Documentation/devicetree/bindings/input/snvs-pwrkey.txt
new file mode 100644
index 0000000..70c1425
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/snvs-pwrkey.txt
@@ -0,0 +1 @@
+See Documentation/devicetree/bindings/crypto/fsl-sec4.txt
-- 
1.9.1

