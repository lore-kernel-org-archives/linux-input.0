From: Joseph Chen <chenjh@rock-chips.com>
Subject: [RESEND v9 05/12] clk: Kconfig: Name RK805 in Kconfig for COMMON_CLK_RK808
Date: Wed, 16 Aug 2017 10:00:03 +0800
Message-ID: <1502848803-22954-1-git-send-email-chenjh@rock-chips.com>
References: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1502848628-27757-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-gpio-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, zhangqing@rock-chips.com, robh+dt@kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, wdc@rock-chips.com, tony.xie@rock-chips.com, linux-input@vger.kernel.org, mark.rutland@arm.com, w.egorov@phytec.de, linux-clk@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, rtc-linux@googlegroups.com, Joseph Chen <chenjh@rock-chips.com>
List-Id: linux-input@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

The RK808 and RK805 PMICs are using a similar register map.
We can reuse the clk driver for the RK805 PMIC. So let's add
the RK805 in the Kconfig description.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
---
 drivers/clk/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9356ab4..7ca8f02 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -39,10 +39,10 @@ config COMMON_CLK_MAX77686
 	  clock.
 
 config COMMON_CLK_RK808
-	tristate "Clock driver for RK808/RK818"
+	tristate "Clock driver for RK805/RK808/RK818"
 	depends on MFD_RK808
 	---help---
-	  This driver supports RK808 and RK818 crystal oscillator clock. These
+	  This driver supports RK805, RK808 and RK818 crystal oscillator clock. These
 	  multi-function devices have two fixed-rate oscillators,
 	  clocked at 32KHz each. Clkout1 is always on, Clkout2 can off
 	  by control register.
-- 
1.9.1


