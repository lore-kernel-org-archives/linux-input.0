From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V6 5/5] arm64: defconfig: Enable CONFIG_KEYBOARD_IMX_SC_KEY as module
Date: Mon,  7 Oct 2019 09:41:49 +0800
Message-ID: <1570412509-7893-5-git-send-email-Anson.Huang@nxp.com>
References: <1570412509-7893-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570412509-7893-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, peng.fan@nxp.com, fugang.duan@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com, olof@lixom.net, mripard@kernel.org, bjorn.andersson@linaro.org, jagan@amarulasolutions.com, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org, arnd@arndb.de, andriy.shevchenko@linux.intel.com, stefan@agner.ch, enric.balletbo@collabora.com, yuehaibing@huawei.com, ping.bai@nxp.com, m.felsch@pengutronix.de, ronald@innovation.ch, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

Select CONFIG_KEYBOARD_IMX_SC_KEY as module by default to
support i.MX8QXP scu key driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9adae4..9062d57 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -314,6 +314,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_ADC=m
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SNVS_PWRKEY=m
+CONFIG_KEYBOARD_IMX_SC_KEY=m
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
-- 
2.7.4
