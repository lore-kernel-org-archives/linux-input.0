From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 88/99] Input: snvs_pwrkey - make it depend on ARCH_MXC
Date: Tue,  7 May 2019 01:32:22 -0400
Message-ID: <20190507053235.29900-88-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jacky Bai <ping.bai@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

[ Upstream commit f06eba72274788db6a43012a05a99915c0283aef ]

The SNVS power key is not only used on i.MX6SX and i.MX7D, it is also
used by i.MX6UL and NXP's latest ARMv8 based i.MX8M series SOC. So
update the config dependency to use ARCH_MXC, and add the COMPILE_TEST
too.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a878351f1643..52d7f55fca32 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -420,7 +420,7 @@ config KEYBOARD_MPR121
 
 config KEYBOARD_SNVS_PWRKEY
 	tristate "IMX SNVS Power Key Driver"
-	depends on SOC_IMX6SX || SOC_IMX7D
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on OF
 	help
 	  This is the snvs powerkey driver for the Freescale i.MX application
-- 
2.20.1
