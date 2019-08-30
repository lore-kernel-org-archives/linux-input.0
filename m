From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 5/5] arm64: defconfig: Enable CONFIG_KEYBOARD_IMX_SC_PWRKEY as module
Date: Fri, 30 Aug 2019 16:53:49 -0400
Message-ID: <1567198429-27886-5-git-send-email-Anson.Huang@nxp.com>
References: <1567198429-27886-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567198429-27886-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, dmitry.torokhov@gmail.com, aisheng.dong@nxp.com, ulf.hansson@linaro.org, fugang.duan@nxp.com, peng.fan@nxp.com, daniel.baluta@nxp.com, leonard.crestez@nxp.com, olof@lixom.net, mripard@kernel.org, arnd@arndb.de, jagan@amarulasolutions.com, bjorn.andersson@linaro.org, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org, hsweeten@visionengravers.com, tglx@linutronix.de, gregkh@linuxfoundation.org, stefan@agner.ch, ronald@innovation.ch, ping.bai@nxp.com, m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-inpu
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

Select CONFIG_KEYBOARD_IMX_SC_PWRKEY as module by default to
support i.MX8QXP power key driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 49bb3d4..8178737 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -313,6 +313,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_ADC=m
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SNVS_PWRKEY=m
+CONFIG_KEYBOARD_IMX_SC_PWRKEY=m
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
-- 
2.7.4
