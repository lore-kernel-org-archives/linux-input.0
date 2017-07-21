From: Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH v7 10/12] mfd: rk808: Add RK805 pinctrl support
Date: Fri, 21 Jul 2017 19:18:38 +0800
Message-ID: <1500635918-12829-1-git-send-email-chenjh@rock-chips.com>
References: <1500635681-12477-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500635681-12477-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, tony.xie@rock-chips.com, zhangqing@rock-chips.com, wdc@rock-chips.com, devicetree@vger.kernel.org, w.egorov@phytec.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Joseph Chen <chenjh@rock-chips.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
---
 drivers/mfd/rk808.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 7276555..db90471 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -97,6 +97,7 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 static const struct mfd_cell rk805s[] = {
 	{ .name = "rk808-clkout", },
 	{ .name = "rk808-regulator", },
+	{ .name = "rk805-pinctrl", },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
-- 
1.9.1
