From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V4 3/5] arm64: dts: imx8qxp: Add scu key node
Date: Mon, 16 Sep 2019 10:52:51 +0800
Message-ID: <1568602373-14164-3-git-send-email-Anson.Huang@nxp.com>
References: <1568602373-14164-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568602373-14164-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com, olof@lixom.net, mripard@kernel.org, arnd@arndb.de, jagan@amarulasolutions.com, dinguyen@kernel.org, bjorn.andersson@linaro.org, marcin.juszkiewicz@linaro.org, andriy.shevchenko@linux.intel.com, yuehaibing@huawei.com, cw00.choi@samsung.com, enric.balletbo@collabora.com, m.felsch@pengutronix.de, ping.bai@nxp.com, ronald@innovation.ch, stefan@agner.ch, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

Add scu key node for i.MX8QXP, disabled by default as it
depends on board design.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 1133b41..71e38c1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/pads-imx8qxp.h>
 
@@ -174,6 +175,12 @@
 			#power-domain-cells = <1>;
 		};
 
+		scu_key: scu-key {
+			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+			linux,keycode = <KEY_POWER>;
+			status = "disabled";
+		};
+
 		rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
-- 
2.7.4
