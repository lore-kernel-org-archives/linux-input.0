From: <Frank.Li@freescale.com>
Subject: [PATCH v5 5/6] Document: devicetree: input: imx: i.mx snvs power device tree bindings
Date: Wed, 27 May 2015 00:26:01 +0800
Message-ID: <1432657562-5592-6-git-send-email-Frank.Li@freescale.com>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bbn0103.outbound.protection.outlook.com ([157.56.111.103]:4320
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751913AbbEZQ1X (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 May 2015 12:27:23 -0400
In-Reply-To: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, alexandre.belloni@free-electrons.com
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>, Robin Gong <b38343@freescale.com>

From: Frank Li <Frank.Li@freescale.com>

The snvs-pwrkey is designed to enable POWER key function which controlled
by SNVS ONOFF. the driver can report the status of POWER key and wakeup
system if pressed after system suspend.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
Signed-off-by: Robin Gong <b38343@freescale.com>
---
 .../devicetree/bindings/crypto/fsl-sec4.txt        | 49 ++++++++++++++++++++++
 .../devicetree/bindings/input/snvs-pwrkey.txt      |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
index b21e7c2..71a39c5 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
@@ -387,6 +387,47 @@ EXAMPLE
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
+      Definition: Button can wake-up the system.
+
+ - regmap:
+      Usage: required:
+      Value type: <phandle>
+      Definition: this is phandle to the register map node.
+
+EXAMPLE:
+	snvs-pwrkey@0x020cc000 {
+		compatible = "fsl,sec-v4.0-pwrkey";
+		regmap = <&snvs>;
+		interrupts = <0 4 0x4>
+	        linux,keycode = <116>; /* KEY_POWER */
+		wakeup;
+	};
+
+=====================================================================
 FULL EXAMPLE
 
 	crypto: crypto@300000 {
@@ -466,6 +507,14 @@ FULL EXAMPLE
 			offset = <0x34>;
 			interrupts = <93 2>;
 		};
+
+		snvs-pwrkey@0x020cc000 {
+			compatible = "fsl,sec-v4.0-pwrkey";
+			regmap = <&sec_mon>;
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

