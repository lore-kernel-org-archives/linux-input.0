From: Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH v9 06/12] rtc: Kconfig: Name RK805 in Kconfig for RTC_DRV_RK808
Date: Wed,  9 Aug 2017 18:06:20 +0800
Message-ID: <1502273181-12430-1-git-send-email-chenjh@rock-chips.com>
References: <1502273060-12201-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502273060-12201-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, wdc@rock-chips.com, tony.xie@rock-chips.com, linux-input@vger.kernel.org, mark.rutland@arm.com, w.egorov@phytec.de, Joseph Chen <chenjh@rock-chips.com>
List-Id: linux-input@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

The RK808 and RK805 PMICs are using a similar register map.
We can reuse the rtc driver for the RK805 PMIC. So let's add
the RK805 in the Kconfig description.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
---
 drivers/rtc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5dc673d..47d6a8d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -352,11 +352,11 @@ config RTC_DRV_MAX77686
 	  will be called rtc-max77686.
 
 config RTC_DRV_RK808
-	tristate "Rockchip RK808/RK818 RTC"
+	tristate "Rockchip RK805/RK808/RK818 RTC"
 	depends on MFD_RK808
 	help
 	  If you say yes here you will get support for the
-	  RTC of RK808 and RK818 PMIC.
+	  RTC of RK805, RK808 and RK818 PMIC.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rk808-rtc.
-- 
1.9.1
