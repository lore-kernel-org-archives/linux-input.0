From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V3 1/5] dt-bindings: fsl: scu: add scu key binding
Date: Tue,  3 Sep 2019 17:36:36 -0400
Message-ID: <1567546600-21566-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com, leonard.crestez@nxp.com, mripard@kernel.org, olof@lixom.net, arnd@arndb.de, jagan@amarulasolutions.com, bjorn.andersson@linaro.org, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org, stefan@agner.ch, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, yuehaibing@huawei.com, tglx@linutronix.de, ronald@innovation.ch, m.felsch@pengutronix.de, ping.bai@nxp.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and scu key event etc. management, Linux kernel has
to communicate with system controller via MU (message unit) IPC
to get scu key event, add binding doc for i.MX system controller
key driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- use "key" instead of "pwrkey" as the key function can be defined in DT.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index c149fad..5eab7d0 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -157,6 +157,15 @@ Required properties:
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
 
+SCU key bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible: should be:
+              "fsl,imx8qxp-sc-key"
+              followed by "fsl,imx-sc-key";
+- linux,keycodes: See Documentation/devicetree/bindings/input/keys.txt
+
 Example (imx8qxp):
 -------------
 aliases {
@@ -220,6 +229,11 @@ firmware {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
 
+		scu_key: scu-key {
+			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+			linux,keycode = <KEY_POWER>;
+		};
+
 		watchdog {
 			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
 			timeout-sec = <60>;
-- 
2.7.4
