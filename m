From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V6 4/5] arm64: dts: imx8qxp-mek: Enable scu key
Date: Mon,  7 Oct 2019 09:41:48 +0800
Message-ID: <1570412509-7893-4-git-send-email-Anson.Huang@nxp.com>
References: <1570412509-7893-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570412509-7893-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, peng.fan@nxp.com, fugang.duan@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com, olof@lixom.net, mripard@kernel.org, bjorn.andersson@linaro.org, jagan@amarulasolutions.com, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org, arnd@arndb.de, andriy.shevchenko@linux.intel.com, stefan@agner.ch, enric.balletbo@collabora.com, yuehaibing@huawei.com, ping.bai@nxp.com, m.felsch@pengutronix.de, ronald@innovation.ch, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
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
