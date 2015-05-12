From: <Frank.Li@freescale.com>
Subject: [PATCH 1/3] document: devicetree: input: imx: i.mx snvs power device
 tree bindings
Date: Wed, 13 May 2015 00:50:36 +0800
Message-ID: <1431449438-19460-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com
Cc: Robin Gong <b38343@freescale.com>, Frank Li <Frank.Li@freescale.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

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
index 0000000..8f0826f
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
+- fsl,keycode: Keycode to emit, KEY_POWER by default.
+
+- fsl,wakeup: Button can wake-up the system
+
+Example:
+snvs-pwrkey@0x020cc000 {
+	compatible = "fsl,imx6sx-snvs-pwrkey";
+	reg = <0x020cc000 0x4000>;
+	interrupts = <0 4 0x4>;
+	fsl,keycode = <116>; /* KEY_POWER */
+	fsl,wakeup;
+};
-- 
1.9.1
