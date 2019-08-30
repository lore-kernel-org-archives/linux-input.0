From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 1/5] dt-bindings: fsl: scu: add scu power key binding
Date: Fri, 30 Aug 2019 16:53:45 -0400
Message-ID: <1567198429-27886-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com, leonard.crestez@nxp.com, olof@lixom.net, mripard@kernel.org, arnd@arndb.de, jagan@amarulasolutions.com, bjorn.andersson@linaro.org, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org, hsweeten@visionengravers.com, tglx@linutronix.de, gregkh@linuxfoundation.org, stefan@agner.ch, ronald@innovation.ch, ping.bai@nxp.com, m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-inpu
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and power key event etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to get power key event, add binding doc for i.MX system
controller power key driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index c149fad..001d0b7 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -157,6 +157,17 @@ Required properties:
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
 
+Power key bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible: should be:
+              "fsl,imx8qxp-sc-pwrkey"
+              followed by "fsl,imx-sc-pwrkey";
+- linux,keycodes: See Documentation/devicetree/bindings/input/keys.txt
+Optional Properties:
+- wakeup-source: See Documentation/devicetree/bindings/power/wakeup-source.txt
+
 Example (imx8qxp):
 -------------
 aliases {
@@ -220,6 +231,13 @@ firmware {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
 
+		scu_pwrkey: scu-pwrkey {
+			compatible = "fsl,imx8qxp-sc-pwrkey", "fsl,imx-sc-pwrkey";
+			linux,keycode = <KEY_POWER>;
+			wakeup-source;
+			status = "disabled";
+		};
+
 		watchdog {
 			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
 			timeout-sec = <60>;
-- 
2.7.4
