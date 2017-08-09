From: Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH v9 10/12] mfd: rk808: Add RK805 pinctrl support
Date: Wed,  9 Aug 2017 18:07:24 +0800
Message-ID: <1502273244-12633-1-git-send-email-chenjh@rock-chips.com>
References: <1502273060-12201-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.133]:46185 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbdHIKHs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 9 Aug 2017 06:07:48 -0400
In-Reply-To: <1502273060-12201-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, wdc@rock-chips.com, tony.xie@rock-chips.com, linux-input@vger.kernel.org, mark.rutland@arm.com, w.egorov@phytec.de, Joseph Chen <chenjh@rock-chips.com>

Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/rk808.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 18329c8..c803d2d 100644
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


