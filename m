From: Shridhar Rasal <srasal@nvidia.com>
Subject: [PATCH 1/1] input: keyboard: Set configuration registers
Date: Fri,  9 Dec 2011 12:59:18 +0530
Message-ID: <1323415758-16822-1-git-send-email-srasal@nvidia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:18639 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab1LIH0L (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2011 02:26:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, swarren@nvidia.com, riyer@nvidia.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, Shridhar Rasal <srasal@nvidia.com>

-Set only REQUIRED row and column configuration register to
PROPER values to avoid continuously generating KBC input events.
-Use *en* field in pin_cfg, to check GPIO_x_ROW_EN register
should be set or clear.

Signed-off-by: Shridhar Rasal <srasal@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/kbc.h |    1 +
 drivers/input/keyboard/tegra-kbc.c     |   13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/kbc.h b/arch/arm/mach-tegra/include/mach/kbc.h
index 4f3572a..2212284 100644
--- a/arch/arm/mach-tegra/include/mach/kbc.h
+++ b/arch/arm/mach-tegra/include/mach/kbc.h
@@ -38,6 +38,7 @@
 
 struct tegra_kbc_pin_cfg {
 	bool is_row;
+	bool en;
 	unsigned char num;
 };
 
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index cf3228b..faf4f3e 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -447,11 +447,14 @@ static void tegra_kbc_config_pins(struct tegra_kbc *kbc)
 		row_cfg &= ~r_mask;
 		col_cfg &= ~c_mask;
 
-		if (pdata->pin_cfg[i].is_row)
-			row_cfg |= ((pdata->pin_cfg[i].num << 1) | 1) << r_shft;
-		else
-			col_cfg |= ((pdata->pin_cfg[i].num << 1) | 1) << c_shft;
-
+		if (pdata->pin_cfg[i].en) {
+			if (pdata->pin_cfg[i].is_row)
+				row_cfg |= ((pdata->pin_cfg[i].num << 1) | 1)
+						<< r_shft;
+			else
+				col_cfg |= ((pdata->pin_cfg[i].num << 1) | 1)
+						<< c_shft;
+		}
 		writel(row_cfg, kbc->mmio + r_offs);
 		writel(col_cfg, kbc->mmio + c_offs);
 	}
-- 
1.7.1

