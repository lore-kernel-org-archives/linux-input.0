From: <Frank.Li@freescale.com>
Subject: [PATCH v2 2/3] document: devicetree: input: imx: i.mx snvs power device tree bindings
Date: Wed, 13 May 2015 22:47:41 +0800
Message-ID: <1431528462-21591-2-git-send-email-Frank.Li@freescale.com>
References: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bbn0106.outbound.protection.outlook.com ([157.56.111.106]:28386
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965055AbbEMP40 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2015 11:56:26 -0400
In-Reply-To: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Frank Li <Frank.Li@freescale.com>, Robin Gong <b38343@freescale.com>

From: Frank Li <Frank.Li@freescale.com>

The snvs-pwrkey is designed to enable POWER key function which controlled
by SNVS ONOFF. the driver can report the status of POWER key and wakeup
system if pressed after system suspend.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
Signed-off-by: Robin Gong <b38343@freescale.com>
---
 .../devicetree/bindings/input/snvs-pwrkey.txt      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt

diff --git a/Documentation/devicetree/bindings/input/snvs-pwrkey.txt b/Documentation/devicetree/bindings/input/snvs-pwrkey.txt
new file mode 100644
index 0000000..9b3b58d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/snvs-pwrkey.txt
@@ -0,0 +1,26 @@
+* Freescale i.MX SNVS powerkey device tree bindings
+
+The snvs-pwrkey is designed to enable POWER key function which controlled
+by SNVS ONOFF, the driver can report the status of POWER key and wakeup
+system if pressed after system suspend.
+
+Required SoC Specific Properties:
+- compatible: Should be "fsl,imx6sx-snvs-pwrkey".
+
+- reg: Physical base address of the SNVS and length of memory mapped
+  region.
+
+- interrupts: The SNVS interrupt number to the CPU(s).
+
+- linux,keycode: Keycode to emit, KEY_POWER by default.
+
+- linux,wakeup: Button can wake-up the system
+
+Example:
+snvs-pwrkey@0x020cc000 {
+	compatible = "fsl,imx6sx-snvs-pwrkey";
+	reg = <0x020cc000 0x4000>;
+	interrupts = <0 4 0x4>;
+	linux,keycode = <116>; /* KEY_POWER */
+	linux,wakeup;
+};
-- 
1.9.1

