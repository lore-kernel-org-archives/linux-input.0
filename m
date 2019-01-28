From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/3] input: keyboard: allow to select IMX SNVS Power Key driver for i.MX 7D
Date: Mon, 28 Jan 2019 17:03:05 +0100
Message-ID: <20190128160305.22398-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: arnd@arndb.de, peng.fan@nxp.com, linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-input@vger.kernel.org

The i.MX SNVS Power Key driver supports the i.MX 7D SoC family too.
Allow to enable the i.MX SNVS Power Key driver even if only i.MX 7D
SoC is selected.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4713957b0cbb..a878351f1643 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -420,7 +420,7 @@ config KEYBOARD_MPR121
 
 config KEYBOARD_SNVS_PWRKEY
 	tristate "IMX SNVS Power Key Driver"
-	depends on SOC_IMX6SX
+	depends on SOC_IMX6SX || SOC_IMX7D
 	depends on OF
 	help
 	  This is the snvs powerkey driver for the Freescale i.MX application
-- 
2.20.1
