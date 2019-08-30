From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 4/5] arm64: dts: imx8qxp-mek: Enable scu power key
Date: Fri, 30 Aug 2019 16:53:48 -0400
Message-ID: <1567198429-27886-4-git-send-email-Anson.Huang@nxp.com>
References: <1567198429-27886-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567198429-27886-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com, leonard.crestez@nxp.com, olof@lixom.net, mripard@kernel.org, arnd@arndb.de, jagan@amarulasolutions.com, bjorn.andersson@linaro.org, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org, hsweeten@visionengravers.com, tglx@linutronix.de, gregkh@linuxfoundation.org, stefan@agner.ch, ronald@innovation.ch, ping.bai@nxp.com, m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-inpu
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

Enable scu power key for i.MX8QXP MEK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 1946805..f3df5c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -234,3 +234,7 @@
 &adma_dsp {
 	status = "okay";
 };
+
+&scu_pwrkey {
+	status = "okay";
+};
-- 
2.7.4
