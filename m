From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V5 5/5] arm64: defconfig: Enable CONFIG_KEYBOARD_IMX_SC_KEY as module
Date: Tue, 17 Sep 2019 10:55:39 +0800
Message-ID: <1568688939-13649-5-git-send-email-Anson.Huang@nxp.com>
References: <1568688939-13649-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568688939-13649-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com, olof@lixom.net, mripard@kernel.org, arnd@arndb.de, jagan@amarulasolutions.com, dinguyen@kernel.org, bjorn.andersson@linaro.org, marcin.juszkiewicz@linaro.org, andriy.shevchenko@linux.intel.com, yuehaibing@huawei.com, cw00.choi@samsung.com, enric.balletbo@collabora.com, m.felsch@pengutronix.de, ping.bai@nxp.com, ronald@innovation.ch, stefan@agner.ch, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@
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
index 0a70e10..9c83014 100644
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
