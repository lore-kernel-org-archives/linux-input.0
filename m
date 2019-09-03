From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V3 4/5] arm64: dts: imx8qxp-mek: Enable scu key
Date: Tue,  3 Sep 2019 17:36:39 -0400
Message-ID: <1567546600-21566-4-git-send-email-Anson.Huang@nxp.com>
References: <1567546600-21566-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567546600-21566-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com, leonard.crestez@nxp.com, mripard@kernel.org, olof@lixom.net, arnd@arndb.de, jagan@amarulasolutions.com, bjorn.andersson@linaro.org, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org, stefan@agner.ch, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, yuehaibing@huawei.com, tglx@linutronix.de, ronald@innovation.ch, m.felsch@pengutronix.de, ping.bai@nxp.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

Enable scu key for i.MX8QXP MEK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- change node name accordingly.
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 1946805..88dd9132 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -234,3 +234,7 @@
 &adma_dsp {
 	status = "okay";
 };
+
+&scu_key {
+	status = "okay";
+};
-- 
2.7.4
