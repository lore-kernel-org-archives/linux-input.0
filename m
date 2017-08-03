From: Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH v8 11/12] mfd: rk808: Add RK805 power key support
Date: Thu,  3 Aug 2017 20:26:10 +0800
Message-ID: <1501763170-20636-1-git-send-email-chenjh@rock-chips.com>
References: <1501762841-20262-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501762841-20262-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, tony.xie@rock-chips.com, zhangqing@rock-chips.com, wdc@rock-chips.com, devicetree@vger.kernel.org, w.egorov@phytec.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Joseph Chen <chenjh@rock-chips.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
---
 drivers/mfd/rk808.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index db90471..6d9f96b 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -94,6 +94,19 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 };
 
+static struct resource rk805_key_resources[] = {
+	{
+		.start  = RK805_IRQ_PWRON_FALL,
+		.end    = RK805_IRQ_PWRON_FALL,
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		.start  = RK805_IRQ_PWRON_RISE,
+		.end    = RK805_IRQ_PWRON_RISE,
+		.flags  = IORESOURCE_IRQ,
+	}
+};
+
 static const struct mfd_cell rk805s[] = {
 	{ .name = "rk808-clkout", },
 	{ .name = "rk808-regulator", },
@@ -103,6 +116,10 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = &rtc_resources[0],
 	},
+	{	.name = "rk805-pwrkey",
+		.num_resources = ARRAY_SIZE(rk805_key_resources),
+		.resources = &rk805_key_resources[0],
+	},
 };
 
 static const struct mfd_cell rk808s[] = {
-- 
1.9.1
