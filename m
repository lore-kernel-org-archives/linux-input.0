From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH RESEND V5 4/5] arm64: dts: imx8qxp-mek: Enable scu key
Date: Tue, 17 Sep 2019 11:12:18 +0800
Message-ID: <1568689939-8871-4-git-send-email-Anson.Huang@nxp.com>
References: <1568689939-8871-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568689939-8871-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com, olof@lixom.net, mripard@kernel.org, arnd@arndb.de, jagan@amarulasolutions.com, dinguyen@kernel.org, bjorn.andersson@linaro.org, marcin.juszkiewicz@linaro.org, andriy.shevchenko@linux.intel.com, yuehaibing@huawei.com, cw00.choi@samsung.com, enric.balletbo@collabora.com, m.felsch@pengutronix.de, ping.bai@nxp.com, ronald@innovation.ch, stefan@agner.ch, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

Enable scu key for i.MX8QXP MEK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
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
